# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Known Backup Folders from Plugin finder
      class PluginBackupFolders < CMSScanner::Finders::Finder
        PATHS = %w[wp-content/backup-db/ wp-content/backups-dup-pro/ wp-content/updraft/].freeze

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          found = []

          PATHS.each do |path|
            res = target.head_and_get(path, [200, 403])

            next unless [200, 403].include?(res.code) && !target.homepage_or_404?(res)

            found << Model::PluginBackupFolder.new(
              target.url(path),
              confidence: 70,
              found_by: DIRECT_ACCESS,
              interesting_entries: target.directory_listing_entries(path),
              references: { url: ['https://github.com/wpscanteam/wpscan/issues/422',
                                  'https://github.com/wpscanteam/wpscan/issues/1342'] }
            )
          end

          found
        end
      end
    end
  end
end
