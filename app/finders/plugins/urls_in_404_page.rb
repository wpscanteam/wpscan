# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # URLs In 404 Page Finder
      # Typically, the items detected from URLs like /wp-content/plugins/<slug>/
      class UrlsIn404Page < UrlsInHomepage
        # @return [ Typhoeus::Response ]
        def page_res
          @page_res ||= target.error_404_res
        end
      end
    end
  end
end
