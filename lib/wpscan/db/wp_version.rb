# frozen_string_literal: true

module WPScan
  module DB
    # WP Version
    class Version < WpItem
      # @return [ Hash ]
      def self.metadata
        @metadata ||= super['wordpress'] || {}
      end
    end
  end
end
