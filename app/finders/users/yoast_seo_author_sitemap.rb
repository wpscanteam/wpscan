# frozen_string_literal: true

module WPScan
  module Finders
    module Users
      # The YOAST SEO plugin has an author-sitemap.xml which can leak usernames
      # See https://github.com/wpscanteam/wpscan/issues/1228
      class YoastSeoAuthorSitemap < AuthorSitemap
        # @return [ String ] The URL of the author-sitemap
        def sitemap_url
          @sitemap_url ||= target.url('author-sitemap.xml')
        end
      end
    end
  end
end
