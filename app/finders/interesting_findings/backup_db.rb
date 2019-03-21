# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # BackupDB finder
      class BackupDB < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'wp-content/backup-db/'
          url  = target.url(path)
          res  = Browser.get(url)

          return unless [200, 403].include?(res.code) && !target.homepage_or_404?(res)

          Model::BackupDB.new(
            url,
            confidence: 70,
            found_by: DIRECT_ACCESS,
            interesting_entries: target.directory_listing_entries(path),
            references: { url: 'https://github.com/wpscanteam/wpscan/issues/422' }
          )
        end
      end
    end
  end
end
