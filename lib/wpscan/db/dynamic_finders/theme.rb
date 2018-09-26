module WPScan
  module DB
    module DynamicFinders
      class Theme < Plugin
        # @return [ Hash ]
        def self.db_data
          @db_data ||= super['themes'] || {}
        end

        def self.version_finder_module
          Finders::ThemeVersion
        end
      end
    end
  end
end
