module WPScan
  module Finders
    module InterestingFindings
      # UploadSQLDump finder
      class UploadSQLDump < CMSScanner::Finders::Finder
        SQL_PATTERN = /(?:(?:(?:DROP|CREATE) TABLE)|INSERT INTO)/

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          url = dump_url
          res = Browser.get(url)

          return unless res.code == 200 && res.body =~ SQL_PATTERN

          WPScan::InterestingFinding.new(
            url,
            confidence: 100,
            found_by: DIRECT_ACCESS
          )
        end

        def dump_url
          target.url('wp-content/uploads/dump.sql')
        end
      end
    end
  end
end
