# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # debug.log finder
      class DebugLog < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'wp-content/debug.log'

          return unless target.debug_log?(path)

          Model::DebugLog.new(
            target.url(path),
            confidence: 100, found_by: DIRECT_ACCESS,
            references: { url: 'https://codex.wordpress.org/Debugging_in_WordPress' }
          )
        end
      end
    end
  end
end
