# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Multisite checker
      class Multisite < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          url      = target.url('wp-signup.php')
          res      = Browser.get(url)
          location = res.headers_hash['location']

          return unless [200, 302].include?(res.code)
          return if res.code == 302 && location&.include?('wp-login.php?action=register')
          return unless res.code == 200 || (res.code == 302 && location&.include?('wp-signup.php'))

          target.multisite = true

          Model::Multisite.new(url, confidence: 100, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
