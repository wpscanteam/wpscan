# frozen_string_literal: true

module WPScan
  module Controller
    # Main Theme Controller
    class MainTheme < CMSScanner::Controller::Base
      def cli_options
        [
          OptChoice.new(
            ['--main-theme-detection MODE',
             'Use the supplied mode for the Main theme detection, instead of the global (--detection-mode) mode.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          )
        ]
      end

      def run
        output(
          'theme',
          theme: target.main_theme(
            mode: ParsedCli.main_theme_detection || ParsedCli.detection_mode
          ),
          verbose: ParsedCli.verbose
        )
      end
    end
  end
end
