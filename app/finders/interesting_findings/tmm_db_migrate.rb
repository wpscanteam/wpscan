# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Tmm DB Migrate finder
      class TmmDbMigrate < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'wp-content/uploads/tmm_db_migrate/tmm_db_migrate.zip'
          url  = target.url(path)
          res  = browser.forge_request(url, target.head_or_get_request_params).run

          return unless res.code == 200 && res.headers['Content-Type'] =~ %r{\Aapplication/zip}i

          Model::TmmDbMigrate.new(url, confidence: 100, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
