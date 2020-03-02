# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # wp-cron.php finder
      class WPCron < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          res = Browser.get(wp_cron_url)

          return unless res.code == 200

          Model::WPCron.new(wp_cron_url, confidence: 60, found_by: DIRECT_ACCESS)
        end

        def wp_cron_url
          @wp_cron_url ||= target.url('wp-cron.php')
        end
      end
    end
  end
end
