# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Registration Enabled checker
      class Registration < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def passive(_opts = {})
          # Maybe check in the homepage if there is the registration url ?
        end

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          res = Browser.get_and_follow_location(target.registration_url)

          return unless res.code == 200
          return if res.html.css('form#setupform').empty? &&
                    res.html.css('form#registerform').empty?

          target.registration_enabled = true

          Model::Registration.new(res.effective_url, confidence: 100, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
