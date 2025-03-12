# frozen_string_literal: true

module WPScan
  module DB
    # WPVulnDB API
    class VulnApi
      NON_ERROR_CODES = [200, 403].freeze

      class << self
        attr_accessor :token
      end

      # @return [ Addressable::URI ]
      def self.uri
        @uri ||= Addressable::URI.parse('https://wpscan.com/api/v3/')
      end

      # @param [ String ] path
      # @param [ Hash ] params
      #
      # @return [ Hash ]
      def self.get(path, params = {})
        return {} unless token
        return {} if path.end_with?('/latest') # Remove this when api/v4 is up

        # Typhoeus.get is used rather than Browser.get to avoid merging irrelevant params from the CLI
        res = Typhoeus.get(uri.join(path), default_request_params.merge(params))

        return {} if res.code == 404 || res.code == 429
        return JSON.parse(res.body) if NON_ERROR_CODES.include?(res.code)

        raise Error::HTTP, res
      rescue Error::HTTP => e
        retries ||= 0

        if (retries += 1) <= 3
          @default_request_params[:headers]['X-Retry'] = retries

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
      # @note Those params can not be overriden by CLI options
      def self.default_request_params
        @default_request_params ||= Browser.instance.default_request_params.merge(
          headers: {
            'User-Agent' => Browser.instance.default_user_agent,
            'Authorization' => "Token token=#{token}"
          }
        )
      end
    end
  end
end
