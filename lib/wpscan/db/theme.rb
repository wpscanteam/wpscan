# frozen_string_literal: true

module WPScan
  module DB
    # Theme DB
    class Theme < WpItem
      # @return [ Hash ]
      def self.metadata
        @metadata ||= super['themes'] || {}
      end
    end
  end
end
