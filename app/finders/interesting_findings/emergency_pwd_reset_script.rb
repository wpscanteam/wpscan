# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Emergency Password Reset Script finder
      class EmergencyPwdResetScript < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'emergency.php'
          res  = target.head_and_get(path)

          return unless res.code == 200 && !target.homepage_or_404?(res)

          Model::EmergencyPwdResetScript.new(
            target.url(path),
            confidence: /password/i.match?(res.body) ? 100 : 40,
            found_by: DIRECT_ACCESS
          )
        end
      end
    end
  end
end
