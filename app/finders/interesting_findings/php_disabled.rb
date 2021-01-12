# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # See https://github.com/wpscanteam/wpscan/issues/1593
      class PHPDisabled < CMSScanner::Finders::Finder
        PATTERN = /\$wp_version =/.freeze

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'wp-includes/version.php'

          return unless PATTERN.match?(target.head_and_get(path).body)

          Model::PHPDisabled.new(target.url(path), confidence: 100, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
