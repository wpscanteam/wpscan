# frozen_string_literal: true

module WPScan
  module Controller
    # Controller to handle the API token
    class VulnApi < CMSScanner::Controller::Base
      ENV_KEY = 'WPSCAN_API_TOKEN'

      def cli_options
        [
          OptString.new(['--api-token TOKEN', 'The WPVulnDB API Token to display vulnerability data'])
        ]
      end

      def before_scan
        return unless ParsedCli.api_token || ENV.key?(ENV_KEY)

        DB::VulnApi.token = ParsedCli.api_token || ENV[ENV_KEY]

        api_status = DB::VulnApi.status

        raise Error::InvalidApiToken if api_status['error']
        raise Error::ApiLimitReached if api_status['requests_remaining'] == 0
        raise api_status['http_error'] if api_status['http_error']
      end

      def after_scan
        output('status', status: DB::VulnApi.status, api_requests: WPScan.api_requests)
      end
    end
  end
end
