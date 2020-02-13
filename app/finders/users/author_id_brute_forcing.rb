# frozen_string_literal: true

module WPScan
  module Finders
    module Users
      # Author Id Brute Forcing
      class AuthorIdBruteForcing < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        # @return [ Array<Integer> ]
        def valid_response_codes
          @valid_response_codes ||= [200, 301, 302]
        end

        # @param [ Hash ] opts
        # @option opts [ Range ] :range Mandatory
        #
        # @return [ Array<User> ]
        def aggressive(opts = {})
          found = []
          found_by_msg = 'Author Id Brute Forcing - %s (Aggressive Detection)'

          enumerate(target_urls(opts), opts.merge(check_full_response: true)) do |res, id|
            username, found_by, confidence = potential_username(res)

            next unless username

            found << Model::User.new(
              username,
              id: id,
              found_by: format(found_by_msg, found_by),
              confidence: confidence
            )
          end

          found
        end

        # @param [ Hash ] opts
        # @option opts [ Range ] :range
        #
        # @return [ Hash ]
        def target_urls(opts = {})
          urls = {}

          opts[:range].each do |id|
            urls[target.uri.join("?author=#{id}").to_s] = id
          end

          urls
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Brute Forcing Author IDs -'))
        end

        def full_request_params
          { followlocation: true }
        end

        # @param [ Typhoeus::Response ] res
        #
        # @return [ Array<String, String, Integer>, nil ] username, found_by, confidence
        def potential_username(res)
          username = username_from_author_url(res.effective_url) || username_from_response(res)

          return username, 'Author Pattern', 100 if username

          username = display_name_from_body(res.body)

          return username, 'Display Name', 50 if username
        end

        # @param [ String, Addressable::URI ] uri
        #
        # @return [ String, nil ]
        def username_from_author_url(uri)
          uri = Addressable::URI.parse(uri) unless uri.is_a?(Addressable::URI)

          uri.path[%r{/author/([^/\b]+)/?}i, 1]
        end

        # @param [ Typhoeus::Response ] res
        #
        # @return [ String, nil ] The username found
        def username_from_response(res)
          # Permalink enabled
          target.in_scope_uris(res, '//@href[contains(., "author/")]') do |uri|
            username = username_from_author_url(uri)
            return username if username
          end

          # No permalink, TODO Maybe use xpath to extract the classes ?
          res.body[/<body class="archive author author-([^\s]+)[ "]/i, 1]
        end

        # @param [ String ] body
        #
        # @return [ String, nil ]
        def display_name_from_body(body)
          page = Nokogiri::HTML.parse(body)

          # WP >= 3.0
          page.css('h1.page-title span').each do |node|
            text = node.text.to_s.strip

            return text unless text.empty?
          end

          # WP < 3.0
          page.xpath('//link[@rel="alternate" and @type="application/rss+xml"]').each do |node|
            title = node['title']

            next unless title =~ /Posts by (.*) Feed\z/i

            return Regexp.last_match[1] unless Regexp.last_match[1].empty?
          end
          nil
        end
      end
    end
  end
end
