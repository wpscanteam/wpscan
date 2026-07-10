# frozen_string_literal: true

require 'zlib'

module WPScan
  module DB
    # WPVulnDB API
    class VulnApi
      NON_ERROR_CODES = [200, 403].freeze

      # Local (enterprise) vulnerability DB dumps, read instead of the API when local_db is set.
      # Downloaded to DB_DIR by DB::Updater when --enterprise-db-token is supplied.
      ENTERPRISE_DB_FILES = {
        plugins: 'plugins.json.gz',
        themes: 'themes.json.gz',
        wordpresses: 'wordpresses.json.gz'
      }.freeze

      class << self
        # local_db switches vuln lookups from the API to the local dumps above
        attr_accessor :token, :local_db
      end

      # @return [ Addressable::URI ]
      def self.uri
        @uri ||= Addressable::URI.parse('https://wpscan.com/api/v4/')
      end

      # @param [ String ] filename The gzipped JSON dump located in DB_DIR
      #
      # @return [ Hash ] The parsed content of the dump
      def self.load_db(filename)
        JSON.parse(Zlib::GzipReader.open(DB_DIR.join(filename).to_s, &:read))
      end

      # @return [ Hash ]
      def self.plugins_db
        @plugins_db ||= load_db(ENTERPRISE_DB_FILES[:plugins])
      end

      # @return [ Hash ]
      def self.themes_db
        @themes_db ||= load_db(ENTERPRISE_DB_FILES[:themes])
      end

      # @return [ Hash ]
      def self.wordpresses_db
        @wordpresses_db ||= load_db(ENTERPRISE_DB_FILES[:wordpresses])
      end

      # @param [ String ] path
      # @param [ Hash ] params
      #
      # @return [ Hash ]
      def self.get(path, params = {})
        return {} unless token
        # Guard against a slug or WordPress version equal to the literal
        # string "latest": such a value would map to the
        # /{plugins,themes,wordpresses,all}/latest list endpoints, which
        # return a payload the per-entity parser below cannot handle.
        return {} if path.end_with?('/latest')

        # Typhoeus.get is used rather than Browser.get to avoid merging irrelevant params from the CLI
        res = Typhoeus.get(uri.join(path), default_request_params.merge(params))

        return {} if [404, 429].include?(res.code)
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
      rescue JSON::ParserError => e
        # API returned non-JSON response (HTML, plain text, etc.)
        { 'parse_error' => e }
      end

      # @return [ Hash ]
      def self.plugin_data(slug)
        return plugins_db&.dig(slug) || {} if local_db

        get("plugins/#{slug}")&.dig(slug) || {}
      end

      # @return [ Hash ]
      def self.theme_data(slug)
        return themes_db&.dig(slug) || {} if local_db

        get("themes/#{slug}")&.dig(slug) || {}
      end

      # @return [ Hash ]
      def self.wordpress_data(version_number)
        # The dump is keyed by the dotted version; only the API URL strips the dots.
        return wordpresses_db&.dig(version_number) || {} if local_db

        get("wordpresses/#{version_number.tr('.', '')}")&.dig(version_number) || {}
      end

      # @return [ Hash ]
      def self.status
        return { 'plan' => 'enterprise', 'requests_remaining' => 'Unlimited', 'success' => true } if local_db

        json = get('status', params: { version: WPScan::VERSION }, cache_ttl: 0)

        json['requests_remaining'] = 'Unlimited' if json['requests_remaining'] == -1

        json
      end

      # @return [ Hash ]
      # @note Those params can not be overriden by CLI options
      def self.default_request_params
        @default_request_params ||= begin
          params = Browser.instance.default_request_params.merge(
            headers: {
              'User-Agent' => Browser.instance.default_user_agent,
              'Authorization' => "Token token=#{token}"
            }
          )

          if ParsedCli.proxy_target_only
            params.delete(:proxy)
            params.delete(:proxyuserpwd)
          end

          params
        end
      end
    end
  end
end
