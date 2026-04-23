# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # SearchReplaceDB2 finder
      class SearchReplaceDB2 < Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'searchreplacedb2.php'

          return unless /by interconnect/i.match?(target.head_and_get(path).body)

          WPScan::Model::SearchReplaceDB2.new(target.url(path), confidence: 100, found_by: found_by)
        end
      end
    end
  end
end
