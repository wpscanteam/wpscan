# frozen_string_literal: true

module WPScan
  module Finders
    module BackupFolders
      # Known Backup Folders Locations
      class KnownLocations < Finders::Finder
        # List of known backup folder locations from popular backup plugins
        # Starting with a minimal set of the most popular/verified plugins
        # Additional paths can be added in follow-up PRs after validation
        #
        # References:
        # - Duplicator Pro: https://duplicator.com/ (Premium version)
        # - Duplicator: https://wordpress.org/plugins/duplicator/ (1M+ installs)
        # - UpdraftPlus: https://wordpress.org/plugins/updraftplus/ (3M+ installs)
        # - WP-DB-Backup: https://wordpress.org/plugins/wp-db-backup/ (200K+ installs)
        # - WP Database Backup: https://wordpress.org/plugins/wp-database-backup/ (100K+ installs)
        # - BackWPup: https://wordpress.org/plugins/backwpup/ (700K+ installs)
        KNOWN_LOCATIONS = %w[
          wp-content/backups-dup-pro/
          wp-content/backups-dup-lite/
          wp-content/updraft/
          wp-content/backup-db/
          wp-content/uploads/db-backup/
          wp-content/uploads/backwpup/
        ].freeze

        # Valid response codes for backup folder detection
        VALID_RESPONSE_CODES = [200, 403].freeze

        # @return [ Array<BackupFolder> ]
        def aggressive(_opts = {})
          # Check all known locations
          found = KNOWN_LOCATIONS.map do |path|
            check_location(path)
          end

          found.compact
        end

        private

        # @param [ String ] path
        # @return [ Model::BackupFolder, nil ]
        def check_location(path)
          res = target.head_and_get(path, VALID_RESPONSE_CODES)

          return unless VALID_RESPONSE_CODES.include?(res.code) && !target.homepage_or_404?(res)

          Model::BackupFolder.new(
            target.url(path),
            confidence: confidence_for(res.code),
            found_by: DIRECT_ACCESS,
            interesting_entries: res.code == 200 ? target.directory_listing_entries(path) : [],
            response_code: res.code
          )
        end

        # @param [ Integer ] code
        # @return [ Integer ]
        def confidence_for(code)
          case code
          when 200
            100 # Directory listing enabled - definite finding
          when 403
            70  # Forbidden but exists - likely finding
          else
            50
          end
        end
      end
    end
  end
end
