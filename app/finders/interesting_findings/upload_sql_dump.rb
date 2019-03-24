# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # UploadSQLDump finder
      class UploadSQLDump < CMSScanner::Finders::Finder
        SQL_PATTERN = /(?:DROP|CREATE|(?:UN)?LOCK) TABLE|INSERT INTO/.freeze

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          head_res = browser.forge_request(dump_url, target.head_or_get_request_params).run

          return unless head_res.code == 200

          return unless Browser.get(dump_url, headers: { 'Range' => 'bytes=0-3000' }).body =~ SQL_PATTERN

          Model::UploadSQLDump.new(
            dump_url,
            confidence: 100,
            found_by: DIRECT_ACCESS
          )
        end

        def dump_url
          @dump_url ||= target.url('wp-content/uploads/dump.sql')
        end
      end
    end
  end
end
