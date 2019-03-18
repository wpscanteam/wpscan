require 'wpscan/finders/finder/wp_version/smart_url_checker'

require 'wpscan/finders/dynamic_finder/finder'
require 'wpscan/finders/dynamic_finder/wp_items/finder'
require 'wpscan/finders/dynamic_finder/version/finder'
require 'wpscan/finders/dynamic_finder/version/xpath'
require 'wpscan/finders/dynamic_finder/version/comment'
require 'wpscan/finders/dynamic_finder/version/header_pattern'
require 'wpscan/finders/dynamic_finder/version/body_pattern'
require 'wpscan/finders/dynamic_finder/version/javascript_var'
require 'wpscan/finders/dynamic_finder/version/query_parameter'
require 'wpscan/finders/dynamic_finder/version/config_parser'
require 'wpscan/finders/dynamic_finder/wp_item_version'
require 'wpscan/finders/dynamic_finder/wp_version'

module WPScan
  # Custom Finders
  module Finders
    include CMSScanner::Finders

    # Custom InterestingFindings
    module InterestingFindings
      include CMSScanner::Finders::InterestingFindings
    end
  end
end

# Better version of the CMSScanner Enumerator for plugins, themes and timthumbs,
# put here as temporary until implemented in it (and considering other finders using it, such as
# the config backups etc)
module WPScan
  module Finders
    class Finder
      module Enumerator
        # @param [ Hash ] The target urls
        # @param [ Hash ] opts
        # @option opts [ Boolean ] :show_progression Wether or not to display the progress bar
        # @option opts [ Regexp ] :exclude_content
        #
        # @yield [ Typhoeus::Response, String ]
        def enumerate(urls, opts = {})
          determine_request_params(urls, opts)
          # determine_valid_response_codes(opts)

          create_progress_bar(opts.merge(total: urls.size))

          urls.each do |url, slug|
            request = browser.forge_request(url, request_params)

            request.on_complete do |res|
              progress_bar.increment

              yield res, slug if valid_response?(res, opts[:exclude_content])
            end

            hydra.queue(request)
          end

          hydra.run
        end

        # @param [ Typhoeus::Response ] res
        # @param [ Regexp,nil ] exclude_content
        #
        # @return [ Boolean ]
        # rubocop:disable Metrics/PerceivedComplexity
        def valid_response?(res, exclude_content = nil)
          return false unless valid_response_codes.include?(res.code)

          return false if exclude_content && res.response_headers&.match(exclude_content)

          # Perform a full get to check if homepage or custom 404
          if res.code == 200
            full_res = Browser.get(res.effective_url, cache_ttl: 0)

            return false if target.homepage_or_404?(full_res) ||
                            exclude_content && full_res.body.match(exclude_content)
          end

          true
        end
        # rubocop:enable Metrics/PerceivedComplexity

        # @return [ Hash ]
        def request_params
          @request_params ||= { cache_ttl: 0 }
        end

        # @param [ Hash ] urls
        # @param [ Hash ] opts
        def determine_request_params(urls, _opts)
          head_res = Browser.head(urls.first[0], cache_ttl: 0)

          @request_params = if head_res.code == 405
                              { method: :get, maxfilesize: 1, cache_ttl: 0 }
                            else
                              { method: :head, cache_ttl: 0 }
                            end
        end

        # @return [ Array<Integer> ]
        def valid_response_codes
          @valid_response_codes ||= [200, 401, 403, 301]
        end

        # Idea here would be to check the opts[:found] which
        # contains items (such as plugins) found via other techniques,
        # and see their responses to refine the #response_codes
        def determine_valid_response_codes(opts)
          return if opts[:found].empty?

          # TODO
        end
      end
    end
  end
end
