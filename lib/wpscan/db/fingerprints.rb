# frozen_string_literal: true

module WPScan
  module DB
    # Fingerprints class
    class Fingerprints
      # @param [ Hash ] data
      #
      # @return [ Hash ] the unique fingerprints in the data argument given
      # Format returned:
      # {
      #   file_path_1: {
      #     md5_hash_1: version_1,
      #     md5_hash_2: version_2
      #   },
      #   file_path_2: {
      #     md5_hash_3: version_1,
      #     md5_hash_4: version_3
      #   }
      # }
      def self.unique_fingerprints(data)
        unique_fingerprints = {}

        data.each do |file_path, fingerprints|
          fingerprints.each do |md5sum, versions|
            next unless versions.size == 1

            unique_fingerprints[file_path] ||= {}
            unique_fingerprints[file_path][md5sum] = versions.first
          end
        end

        unique_fingerprints
      end

      # @return [ String ]
      def self.wp_fingerprints_path
        @wp_fingerprints_path ||= DB_DIR.join('wp_fingerprints.json').to_s
      end

      # @return [ Hash ]
      def self.wp_fingerprints
        @wp_fingerprints ||= read_json_file(wp_fingerprints_path)
      end

      # @return [ Hash ]
      def self.wp_unique_fingerprints
        @wp_unique_fingerprints ||= unique_fingerprints(wp_fingerprints)
      end
    end
  end
end
