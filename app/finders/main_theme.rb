# frozen_string_literal: true

require_relative 'main_theme/css_style_in_homepage'
require_relative 'main_theme/css_style_in_404_page'
require_relative 'main_theme/woo_framework_meta_generator'
require_relative 'main_theme/urls_in_homepage'
require_relative 'main_theme/urls_in_404_page'

module WPScan
  module Finders
    module MainTheme
      # Main Theme Finder
      class Base
        include CMSScanner::Finders::UniqueFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders <<
            MainTheme::CssStyleInHomepage.new(target) <<
            MainTheme::CssStyleIn404Page.new(target) <<
            MainTheme::WooFrameworkMetaGenerator.new(target) <<
            MainTheme::UrlsInHomepage.new(target) <<
            MainTheme::UrlsIn404Page.new(target)
        end
      end
    end
  end
end
