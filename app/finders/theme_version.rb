# frozen_string_literal: true

require_relative 'theme_version/style'
require_relative 'theme_version/woo_framework_meta_generator'

module WPScan
  module Finders
    module ThemeVersion
      # Theme Version Finder
      class Base
        include CMSScanner::Finders::UniqueFinder

        # @param [ Model::Theme ] theme
        def initialize(theme)
          finders <<
            ThemeVersion::Style.new(theme) <<
            ThemeVersion::WooFrameworkMetaGenerator.new(theme)

          create_and_load_dynamic_versions_finders(theme)
        end

        # Create the dynamic version finders related to the theme and register them
        #
        # @param [ Model::Theme ] theme
        def create_and_load_dynamic_versions_finders(theme)
          DB::DynamicFinders::Theme.create_versions_finders(theme.slug).each do |finder|
            finders << finder.new(theme)
          end
        end
      end
    end
  end
end
