# frozen_string_literal: true

module WPScan
  module DB
    # WpItem - super DB class for Plugin, Theme and Version
    class WpItem
      # @param [ String ] identifier The plugin/theme slug or version number
      #
      # @return [ Hash ] The JSON data from the DB associated to the identifier
      def self.db_data(identifier)
        db[identifier] || {}
      end

      # @return [ JSON ]
      def self.db
        @db ||= read_json_file(db_file)
      end
    end
  end
end
