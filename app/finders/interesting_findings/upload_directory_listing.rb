# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # UploadDirectoryListing finder
      class UploadDirectoryListing < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'wp-content/uploads/'

          return unless target.directory_listing?(path)

          url = target.url(path)

          Model::UploadDirectoryListing.new(url, confidence: 100, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
