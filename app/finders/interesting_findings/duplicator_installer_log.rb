# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # DuplicatorInstallerLog finder
      class DuplicatorInstallerLog < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'installer-log.txt'

          return unless /DUPLICATOR(-|\s)?(PRO|LITE)?:? INSTALL-LOG/i.match?(target.head_and_get(path).body)

          Model::DuplicatorInstallerLog.new(target.url(path), confidence: 100, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
