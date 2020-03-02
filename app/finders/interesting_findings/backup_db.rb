# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # BackupDB finder
      class BackupDB < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'wp-content/backup-db/'
          res  = target.head_and_get(path, [200, 403])

          return unless [200, 403].include?(res.code) && !target.homepage_or_404?(res)

          Model::BackupDB.new(
            target.url(path),
            confidence: 70,
            found_by: DIRECT_ACCESS,
            interesting_entries: target.directory_listing_entries(path)
          )
        end
      end
    end
  end
end
