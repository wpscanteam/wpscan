# frozen_string_literal: true

module WPScan
  module Controller
    # Controller to ensure that the wp-content and wp-plugins
    # directories are found
    class CustomDirectories < CMSScanner::Controller::Base
      def cli_options
        [
          OptString.new(['--wp-content-dir DIR']),
          OptString.new(['--wp-plugins-dir DIR'])
        ]
      end

      def before_scan
        target.content_dir = ParsedCli.wp_content_dir if ParsedCli.wp_content_dir
        target.plugins_dir = ParsedCli.wp_plugins_dir if ParsedCli.wp_plugins_dir

        return if target.content_dir

        raise Error::WpContentDirNotDetected
      end
    end
  end
end
