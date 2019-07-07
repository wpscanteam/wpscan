# frozen_string_literal: true

module WPScan
  module DB
    module DynamicFinders
      class Theme < Plugin
        # @return [ Hash ]
        def self.df_data
          @df_data ||= all_df_data['themes'] || {}
        end

        def self.version_finder_module
          Finders::ThemeVersion
        end
      end
    end
  end
end
