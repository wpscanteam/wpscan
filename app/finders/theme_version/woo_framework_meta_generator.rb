# frozen_string_literal: true

module WPScan
  module Finders
    module ThemeVersion
      # Theme Version Finder from the WooFramework generators
      class WooFrameworkMetaGenerator < CMSScanner::Finders::Finder
        # @param [ Hash ] opts
        #
        # @return [ Version ]
        def passive(_opts = {})
          return unless target.blog.homepage_res.body =~ Finders::MainTheme::WooFrameworkMetaGenerator::PATTERN

          return unless Regexp.last_match[1] == target.slug

          Model::Version.new(Regexp.last_match[2], found_by: found_by, confidence: 80)
        end
      end
    end
  end
end
