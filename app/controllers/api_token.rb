# frozen_string_literal: true

module WPScan
  module Controller
    # Controller to handle the API token
    class ApiToken < CMSScanner::Controller::Base
      def cli_options
        [
          OptString.new(['--api-token TOKEN', 'The API Token to display vulnerability data'])
        ]
      end

      def before_scan(opts = {})
        # TODO, validate the token
        # res = browser.get()
      end
    end
  end
end
