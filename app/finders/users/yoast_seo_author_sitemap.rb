# frozen_string_literal: true

module WPScan
  module Finders
    module Users
      # The YOAST SEO plugin has an author-sitemap.xml which can leak usernames
      # See https://github.com/wpscanteam/wpscan/issues/1228
      class YoastSeoAuthorSitemap < CMSScanner::Finders::Finder
        # @param [ Hash ] opts
        #
        # @return [ Array<User> ]
        def aggressive(_opts = {})
          found = []

          Browser.get(sitemap_url).html.xpath('//url/loc').each do |user_tag|
            username = user_tag.text.to_s[%r{/author/([^\/]+)/}, 1]

            next unless username && !username.strip.empty?

            found << Model::User.new(username,
                                     found_by: found_by,
                                     confidence: 100,
                                     interesting_entries: [sitemap_url])
          end

          found
        end

        # @return [ String ] The URL of the author-sitemap
        def sitemap_url
          @sitemap_url ||= target.url('author-sitemap.xml')
        end
      end
    end
  end
end
