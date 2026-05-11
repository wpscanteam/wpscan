# frozen_string_literal: true

module WPScan
  module Finders
    module Themes
      # Authenticated theme inventory via the WordPress REST API
      # endpoint /wp-json/wp/v2/themes (WP >= 5.7).
      #
      # Requires admin credentials with the switch_themes capability.
      class WpJsonApi < WPScan::Finders::Finder
        FOUND_BY = 'WP REST API (Authenticated)'

        # @param [ Hash ] opts
        # @option opts [ String ] :userpwd "user:password" credentials for Basic Auth
        #
        # @return [ Array<Model::Theme> ]
        def aggressive(opts = {})
          response = Browser.get(api_url, userpwd: opts[:userpwd], headers: { 'Accept' => 'application/json' })

          raise Error::WpAuthFailed.new(response.code, api_url) if [401, 403].include?(response.code)
          raise Error::WpAuthEndpointUnavailable.new(response.code, api_url) unless response.code == 200

          themes_from_response(response)
        rescue JSON::ParserError, TypeError
          []
        end

        # @param [ Typhoeus::Response ] response
        #
        # @return [ Array<Model::Theme> ]
        def themes_from_response(response)
          json = JSON.parse(response.body)
          return [] unless json.is_a?(Enumerable)

          json.filter_map { |entry| build_theme(entry, response.effective_url) }
        end

        # @return [ String ] The REST API URL for the themes endpoint
        def api_url
          @api_url ||= target.url('wp-json/wp/v2/themes')
        end

        private

        # @param [ Hash ] entry
        # @param [ String ] effective_url
        #
        # @return [ Model::Theme, nil ]
        def build_theme(entry, effective_url)
          slug = entry['stylesheet']
          return nil if slug.nil? || slug.to_s.empty?

          theme = Model::Theme.new(
            slug,
            target,
            confidence: 100,
            found_by: FOUND_BY,
            interesting_entries: [effective_url]
          )

          version = entry['version']
          theme.instance_variable_set(
            :@version,
            version && !version.to_s.empty? ? Model::Version.new(version, confidence: 100, found_by: FOUND_BY) : false
          )

          theme.instance_variable_set(:@wp_json_active, entry['status'] == 'active')

          theme
        end
      end
    end
  end
end
