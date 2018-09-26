module WPScan
  module Finders
    module Users
      # Since WP 4.4, the oembed API can disclose a user
      # https://github.com/wpscanteam/wpscan/issues/1049
      class OembedApi < CMSScanner::Finders::Finder
        # @param [ Hash ] opts
        #
        # @return [ Array<User> ]
        def passive(_opts = {})
          # TODO: get the api_url from the Homepage and query it if present,
          # then discard the aggressive check if same/similar URL
        end

        # @param [ Hash ] opts
        #
        # TODO: make this code pretty :x
        #
        # @return [ Array<User> ]
        def aggressive(_opts = {})
          found        = []
          found_by_msg = 'Oembed API - %s (Aggressive Detection)'

          oembed_data = JSON.parse(Browser.get(api_url).body)

          if oembed_data['author_url'] =~ %r{/author/([^/]+)/?\z}
            details = [Regexp.last_match[1], 'Author URL', 90]
          elsif oembed_data['author_name'] && !oembed_data['author_name'].empty?
            details = [oembed_data['author_name'].delete(' '), 'Author Name', 70]
          end

          return unless details

          found << CMSScanner::User.new(details[0],
                                        found_by: format(found_by_msg, details[1]),
                                        confidence: details[2],
                                        interesting_entries: [api_url])
        rescue JSON::ParserError
          found
        end

        # @return [ String ] The URL of the API listing the Users
        def api_url
          @api_url ||= target.url("wp-json/oembed/1.0/embed?url=#{target.url}&format=json")
        end
      end
    end
  end
end
