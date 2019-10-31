# frozen_string_literal: true

module WPScan
  module Finders
    module MainTheme
      # From the CSS style in the 404 page
      class CssStyleIn404Page < CssStyleInHomepage
        def passive(opts = {})
          passive_from_css_href(target.error_404_res, opts) || passive_from_style_code(target.error_404_res, opts)
        end
      end
    end
  end
end
