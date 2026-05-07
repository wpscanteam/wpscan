# frozen_string_literal: true

module WPScan
  module Controller
    # Controller to add the aliases in the CLI
    class Aliases < WPScan::Controller::Base
      def cli_options
        [
          OptAlias.new(['--stealthy'],
                       alias_for: '--random-user-agent --detection-mode passive')
        ]
      end
    end
  end
end
