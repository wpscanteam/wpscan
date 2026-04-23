# frozen_string_literal: true

module WPScan
  module Model
    # SearchReplaceDB2
    class SearchReplaceDB2 < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= "Search Replace DB script found: #{url}"
      end

      def references
        @references ||= { url: ['https://interconnectit.com/products/search-and-replace-for-wordpress-databases/'] }
      end
    end
  end
end
