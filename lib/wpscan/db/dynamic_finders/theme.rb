# frozen_string_literal: true

module WPScan
  module DB
    module DynamicFinders
      class Theme < Plugin
        # @return [ Hash ]
        def self.db_data
          @db_data ||= raw_db_data['themes'] || {}
        end

        def self.version_finder_module
          Finders::ThemeVersion
        end
      end
    end
  end
end
