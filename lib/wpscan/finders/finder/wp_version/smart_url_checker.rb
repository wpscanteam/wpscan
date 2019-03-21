# frozen_string_literal: true

module WPScan
  module Finders
    class Finder
      module WpVersion
        # SmartURLChecker specific for the WP Version
        module SmartURLChecker
          include CMSScanner::Finders::Finder::SmartURLChecker

          def create_version(number, opts = {})
            Model::WpVersion.new(
              number,
              found_by: opts[:found_by] || found_by,
              confidence: opts[:confidence] || 80,
              interesting_entries: opts[:entries]
            )
          rescue WPScan::Error::InvalidWordPressVersion
            nil # Invalid Version returned as nil and will be ignored by Finders
          end
        end
      end
    end
  end
end
