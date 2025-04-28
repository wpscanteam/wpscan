# frozen_string_literal: true

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
        # @return [ Array<User> ]
        def aggressive(_opts = {})
          oembed_data = JSON.parse(Browser.get(api_url).body)
          details     = user_details_from_oembed_data(oembed_data)

          return [] unless details

          [Model::User.new(details[0],
                           found_by: format(found_by_msg, details[1]),
                           confidence: details[2],
                           interesting_entries: [api_url])]
        rescue JSON::ParserError
          []
        end

        def user_details_from_oembed_data(oembed_data)
          return unless oembed_data

          oembed_data = oembed_data.first if oembed_data.is_a?(Array)

          oembed_data = {} unless oembed_data.is_a?(Hash)

          if oembed_data['author_url'] =~ %r{/author/([^/]+)/?\z}
            details = [Regexp.last_match[1], 'Author URL', 90]
          elsif oembed_data['author_name'] && !oembed_data['author_name'].empty?
            details = [oembed_data['author_name'], 'Author Name', 70]
          end

          details
        end

        def found_by_msg
          'Oembed API - %s (Aggressive Detection)'
        end

        # @return [ String ] The URL of the API listing the Users
        def api_url
          @api_url ||= target.url("wp-json/oembed/1.0/embed?url=#{target.url}&format=json")
        end
      end
    end
  end
end
