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

          load_specific_finders(theme)
        end

        # Load the finders associated with the theme
        #
        # @param [ Model::Theme ] theme
        def load_specific_finders(theme)
          module_name = theme.classify

          return unless Finders::ThemeVersion.constants.include?(module_name)

          mod = Finders::ThemeVersion.const_get(module_name)

          mod.constants.each do |constant|
            c = mod.const_get(constant)

            next unless c.is_a?(Class)

            finders << c.new(theme)
          end
        end
      end
    end
  end
end
