# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Interesting Headers finder
      class Headers < Finder
        # @return [ InterestingFinding ]
        def passive(_opts = {})
          r = WPScan::Model::Headers.new(target.homepage_url, confidence: 100, found_by: found_by)

          r.interesting_entries.empty? ? nil : r
        end
      end
    end
  end
end
