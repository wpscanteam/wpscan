# frozen_string_literal: true

module WPScan
  module DB
    # WP Items
    class WpItems
      # @return [ Array<String> ] The slug of all items
      def self.all_slugs
        metadata.keys
      end

      # @return [ Array<String> ] The slug of all popular items
      def self.popular_slugs
        metadata.select { |_key, item| item['popular'] == true }.keys
      end

      # @return [ Array<String> ] The slug of all vulnerable items
      def self.vulnerable_slugs
        metadata.select { |_key, item| item['vulnerabilities'] == true }.keys
      end
    end
  end
end
