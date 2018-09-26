module WPScan
  module Finders
    module InterestingFindings
      # Emergency Password Reset Script finder
      class EmergencyPwdResetScript < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          url  = target.url('/emergency.php')
          res  = Browser.get(url)

          return unless res.code == 200 && !target.homepage_or_404?(res)

          WPScan::InterestingFinding.new(
            url,
            confidence: res.body =~ /password/i ? 100 : 40,
            found_by: DIRECT_ACCESS,
            references: {
              url: 'https://codex.wordpress.org/Resetting_Your_Password#Using_the_Emergency_Password_Reset_Script'
            }
          )
        end
      end
    end
  end
end
