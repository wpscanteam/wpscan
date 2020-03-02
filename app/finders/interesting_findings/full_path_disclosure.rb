# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Full Path Disclosure finder
      class FullPathDisclosure < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path        = 'wp-includes/rss-functions.php'
          fpd_entries = target.full_path_disclosure_entries(path)

          return if fpd_entries.empty?

          Model::FullPathDisclosure.new(
            target.url(path),
            confidence: 100,
            found_by: DIRECT_ACCESS,
            interesting_entries: fpd_entries
          )
        end
      end
    end
  end
end
