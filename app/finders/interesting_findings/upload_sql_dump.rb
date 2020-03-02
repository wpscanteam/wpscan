# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # UploadSQLDump finder
      class UploadSQLDump < CMSScanner::Finders::Finder
        SQL_PATTERN = /(?:DROP|CREATE|(?:UN)?LOCK) TABLE|INSERT INTO/.freeze

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'wp-content/uploads/dump.sql'
          res  = target.head_and_get(path, [200], get: { headers: { 'Range' => 'bytes=0-3000' } })

          return unless SQL_PATTERN.match?(res.body)

          Model::UploadSQLDump.new(target.url(path), confidence: 100, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
