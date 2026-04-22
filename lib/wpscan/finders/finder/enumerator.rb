# frozen_string_literal: true

module WPScan
  module Finders
    class Finder
      # Module to provide an easy way to enumerate items such as plugins, themes etc
      module Enumerator
        # @return [ Hash ]
        def head_or_get_request_params
          # Disabling the cache, as it causes a 'stack level too deep' exception
          # with a large number of requests.
          # See https://github.com/typhoeus/typhoeus/issues/408
          @head_or_get_request_params ||= target.head_or_get_params.merge(cache_ttl: 0)
        end

        # @return [ Array<Integer> ]
        def valid_response_codes
          @valid_response_codes ||= [200]
        end

        # @param [ Hash ] The target urls
        # @param [ Hash ] opts
        # @option opts [ Boolean ] :show_progression Wether or not to display the progress bar
        # @option opts [ Regexp ] :exclude_content
        # @option opts [ Boolean, Array, String ] :check_full_response
        #
        # @yield [ Typhoeus::Response, String ]
        def enumerate(urls, opts = {})
          create_progress_bar(opts.merge(total: urls.size))

          urls.each do |url, id|
            request = browser.forge_request(url, head_or_get_request_params)

            request.on_complete do |head_res|
              progress_bar.increment

              next unless valid_response_codes.include?(head_res.code)

              next if opts[:exclude_content] && head_res.response_headers&.match(opts[:exclude_content])

              head_or_full_res = maybe_get_full_response(head_res, opts)

              yield head_or_full_res, id if head_or_full_res
            end

            hydra.queue(request)
          end

          hydra.run
        end

        # @param [ Typhoeus::Response ] head_res
        # @param [ Hash ] opts
        #
        # @return [ Typhoeus::Response, nil ]
        def maybe_get_full_response(head_res, opts)
          return head_res unless opts[:check_full_response] == true ||
                                 Array(opts[:check_full_response]).include?(head_res.code)

          full_res = NS::Browser.get(head_res.effective_url, full_request_params)

          return unless valid_response_codes.include?(full_res.code)

          return if target.homepage_or_404?(full_res) ||
                    (opts[:exclude_content] && full_res.body&.match(opts[:exclude_content]))

          full_res
        end

        # @return [ Hash ]
        def full_request_params
          @full_request_params ||= {}
        end
      end
    end
  end
end
