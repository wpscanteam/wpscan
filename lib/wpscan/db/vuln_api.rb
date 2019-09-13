# frozen_string_literal: true

module WPScan
  module DB
    # WPVulnDB API
    class VulnApi
      NON_ERROR_CODES = [200, 401].freeze

      class << self
        attr_accessor :token
      end

      # @return [ Addressable::URI ]
      def self.uri
        @uri ||= Addressable::URI.parse('https://wpvulndb.com/api/v3/')
      end

      # @param [ String ] path
      # @param [ Hash ] params
      #
      # @return [ Hash ]
      def self.get(path, params = {})
        return {} unless token

        res = Browser.get(uri.join(path), params.merge(request_params))

        return {} if res.code == 404 # This is for API inconsistencies when dots in path
        return JSON.parse(res.body) if NON_ERROR_CODES.include?(res.code)

        raise Error::HTTP, res
      rescue Error::HTTP => e
        retries ||= 0

        if (retries += 1) <= 3
          sleep(1)
          retry
        end

        { 'http_error' => e }
      end

      # @return [ Hash ]
      def self.plugin_data(slug)
        get("plugins/#{slug}")&.dig(slug) || {}
      end

      # @return [ Hash ]
      def self.theme_data(slug)
        get("themes/#{slug}")&.dig(slug) || {}
      end

      # @return [ Hash ]
      def self.wordpress_data(version_number)
        get("wordpresses/#{version_number.tr('.', '')}")&.dig(version_number) || {}
      end

      # @return [ Hash ]
      def self.status
        json = get('status', params: { version: WPScan::VERSION }, cache_ttl: 0)

        json['requests_remaining'] = 'Unlimited' if json['requests_remaining'] == -1

        json
      end

      # @return [ Hash ]
      def self.request_params
        {
          headers: {
            'Host' => uri.host, # Reset in case user provided a --vhost for the target
            'Referer' => nil, # Removes referer set by the cmsscanner to the target url
            'User-Agent' => Browser.instance.default_user_agent,
            'Authorization' => "Token token=#{token}"
          }
        }
      end
    end
  end
end
