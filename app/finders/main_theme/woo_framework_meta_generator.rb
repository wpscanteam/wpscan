module WPScan
  module Finders
    module MainTheme
      # From the WooFramework meta generators
      class WooFrameworkMetaGenerator < CMSScanner::Finders::Finder
        THEME_PATTERN     = %r{<meta name="generator" content="([^\s"]+)\s?([^"]+)?"\s+/?>}
        FRAMEWORK_PATTERN = %r{<meta name="generator" content="WooFramework\s?([^"]+)?"\s+/?>}
        PATTERN           = /#{THEME_PATTERN}\s+#{FRAMEWORK_PATTERN}/i

        def passive(opts = {})
          return unless target.homepage_res.body =~ PATTERN

          WPScan::Theme.new(
            Regexp.last_match[1],
            target,
            opts.merge(found_by: found_by, confidence: 80)
          )
        end
      end
    end
  end
end
