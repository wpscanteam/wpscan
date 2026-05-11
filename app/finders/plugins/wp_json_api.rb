# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # Authenticated plugin inventory via the WordPress REST API
      # endpoint /wp-json/wp/v2/plugins (WP >= 5.5).
      #
      # Requires admin credentials with the install_plugins / activate_plugins
      # capability. An Application Password (WP >= 5.6) is the recommended
      # secret as it bypasses 2FA and is colon-free by construction.
      class WpJsonApi < WPScan::Finders::Finder
        FOUND_BY = 'WP REST API (Authenticated)'

        # @param [ Hash ] opts
        # @option opts [ String ] :userpwd "user:password" credentials for Basic Auth
        #
        # @return [ Array<Model::Plugin> ]
        def aggressive(opts = {})
          response = Browser.get(api_url, userpwd: opts[:userpwd], headers: { 'Accept' => 'application/json' })

          raise Error::WpAuthFailed.new(response.code, api_url) if [401, 403].include?(response.code)
          raise Error::WpAuthEndpointUnavailable.new(response.code, api_url) unless response.code == 200

          plugins_from_response(response)
        rescue JSON::ParserError, TypeError
          []
        end

        # @param [ Typhoeus::Response ] response
        #
        # @return [ Array<Model::Plugin> ]
        def plugins_from_response(response)
          json = JSON.parse(response.body)
          return [] unless json.is_a?(Enumerable)

          json.filter_map { |entry| build_plugin(entry, response.effective_url) }
        end

        # @return [ String ] The REST API URL for the plugins endpoint
        def api_url
          @api_url ||= target.url('wp-json/wp/v2/plugins')
        end

        private

        # @param [ Hash ] entry
        # @param [ String ] effective_url
        #
        # @return [ Model::Plugin, nil ]
        def build_plugin(entry, effective_url)
          slug = slug_from_entry(entry)
          return nil if slug.nil? || slug.empty?

          plugin = Model::Plugin.new(
            slug,
            target,
            confidence: 100,
            found_by: FOUND_BY,
            interesting_entries: [effective_url]
          )

          version = entry['version']
          plugin.instance_variable_set(
            :@version,
            version && !version.to_s.empty? ? Model::Version.new(version, confidence: 100, found_by: FOUND_BY) : false
          )

          plugin
        end

        # @param [ Hash ] entry
        #
        # @return [ String, nil ]
        # WP REST returns "plugin" as e.g. "akismet/akismet" or just "hello" for the legacy single-file plugin.
        def slug_from_entry(entry)
          raw = entry['plugin'] || entry['textdomain']
          return nil unless raw.is_a?(String)

          raw.split('/').first
        end
      end
    end
  end
end
