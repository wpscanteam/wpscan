# frozen_string_literal: true

module WPScan
  module Finders
    module MainTheme
      # URLs In 404 Page Finder
      class UrlsIn404Page < UrlsInHomepage
        # @return [ Typhoeus::Response ]
        def page_res
          @page_res ||= target.error_404_res
        end
      end
    end
  end
end
