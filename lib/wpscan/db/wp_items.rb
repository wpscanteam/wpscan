module WPScan
  module DB
    # WP Items
    class WpItems
      # @return [ Array<String> ] The slug of all items
      def self.all_slugs
        db.keys
      end

      # @return [ Array<String> ] The slug of all popular items
      def self.popular_slugs
        db.select { |_key, item| item['popular'] == true }.keys
      end

      # @return [ Array<String> ] The slug of all vulnerable items
      def self.vulnerable_slugs
        db.reject { |_key, item| item['vulnerabilities'].empty? }.keys
      end
    end
  end
end
