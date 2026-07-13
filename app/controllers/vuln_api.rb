# frozen_string_literal: true

module WPScan
  module Controller
    # Controller to handle the API token
    class VulnApi < WPScan::Controller::Base
      ENV_KEY            = 'WPSCAN_API_TOKEN'
      ENTERPRISE_ENV_KEY = 'WPSCAN_ENTERPRISE_DB_TOKEN'

      def cli_options
        [
          OptString.new(
            ['--api-token TOKEN',
             'The WPScan API Token to display vulnerability data, available at https://wpscan.com/profile']
          ),
          OptString.new(
            ['--enterprise-db-token TOKEN',
             'Use a local enterprise vulnerability database dump instead of the WPScan API. The ' \
             'plugins/themes/wordpresses dumps are downloaded from enterprise-data.wpscan.org using ' \
             'this token during the database update, then read locally (no per-finding API calls). Mutually ' \
             "exclusive with --api-token. Can also be set via the #{ENTERPRISE_ENV_KEY} environment variable."],
            { advanced: true }
          ),
          OptBoolean.new(
            ['--proxy-target-only',
             'When used with --proxy, the proxy is only applied to requests made to the target, ' \
             'not to requests made to the WPScan API or database repository (data.wpscan.org). ' \
             'Has no effect unless --proxy is also set.']
          )
        ]
      end

      def before_scan
        raise Error::ConflictingApiTokens if enterprise_db_token && api_token

        return setup_enterprise_db if enterprise_db_token

        return unless api_token

        DB::VulnApi.token = api_token

        api_status = DB::VulnApi.status

        raise Error::InvalidApiToken if api_status['status'] == 'forbidden'
        raise Error::ApiLimitReached if api_status['requests_remaining'] == 0
        raise Error::ApiConnectionError, api_status['http_error'] if api_status['http_error']
      end

      def after_scan
        output('status', status: DB::VulnApi.status, api_requests: WPScan.api_requests)
      end

      private

      # @return [ String, nil ] The enterprise DB token (CLI or ENV). Must match DB::Updater's resolution.
      def enterprise_db_token
        ParsedCli.enterprise_db_token || ENV.fetch(ENTERPRISE_ENV_KEY, nil)
      end

      # @return [ String, nil ] The API token (CLI or ENV var)
      def api_token
        ParsedCli.api_token || ENV.fetch(ENV_KEY, nil)
      end

      # Switches DB::VulnApi to local-dump mode and ensures the dumps are present. Core's DB
      # update normally downloads them before this controller runs (VulnApi is chained after Core).
      def setup_enterprise_db
        DB::VulnApi.local_db = true

        missing = DB::VulnApi::ENTERPRISE_DB_FILES.values.reject { |file| File.exist?(DB_DIR.join(file)) }

        raise Error::MissingEnterpriseDatabaseFile, missing unless missing.empty?
      end
    end
  end
end
