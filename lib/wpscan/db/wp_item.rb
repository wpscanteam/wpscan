# frozen_string_literal: true

module WPScan
  module DB
    # WpItem - super DB class for Plugin, Theme and Version
    class WpItem
      # @param [ String ] identifier The plugin/theme slug or version number
      #
      # @return [ Hash ] The JSON data from the metadata associated to the identifier
      def self.metadata_at(identifier)
        metadata[identifier] || {}
      end

      # @return [ JSON ]
      def self.metadata
        @metadata ||= read_json_file(metadata_file)
      end

      # @return [ String ]
      def self.metadata_file
        @metadata_file ||= DB_DIR.join('metadata.json').to_s
      end
    end
  end
end
