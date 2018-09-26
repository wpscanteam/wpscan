require_relative 'main_theme/css_style'
require_relative 'main_theme/woo_framework_meta_generator'
require_relative 'main_theme/urls_in_homepage'

module WPScan
  module Finders
    module MainTheme
      # Main Theme Finder
      class Base
        include CMSScanner::Finders::UniqueFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders <<
            MainTheme::CssStyle.new(target) <<
            MainTheme::WooFrameworkMetaGenerator.new(target) <<
            MainTheme::UrlsInHomepage.new(target)
        end
      end
    end
  end
end
