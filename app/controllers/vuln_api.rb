# frozen_string_literal: true

module WPScan
  module Controller
    # Controller to handle the API token
    class VulnApi < WPScan::Controller::Base
      ENV_KEY = 'WPSCAN_API_TOKEN'

      def cli_options
        [
          OptString.new(
            ['--api-token TOKEN',
             'The WPScan API Token to display vulnerability data, available at https://wpscan.com/profile']
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
        return unless ParsedCli.api_token || ENV.key?(ENV_KEY)

        DB::VulnApi.token = ParsedCli.api_token || ENV.fetch(ENV_KEY, nil)

        api_status = DB::VulnApi.status

        raise Error::InvalidApiToken if api_status['status'] == 'forbidden'
        raise Error::ApiLimitReached if api_status['requests_remaining'] == 0
        raise Error::ApiConnectionError, api_status['http_error'] if api_status['http_error']
      end

      def after_scan
        output('status', status: DB::VulnApi.status, api_requests: WPScan.api_requests)
      end
    end
  end
end
