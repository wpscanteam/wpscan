# frozen_string_literal: true

module WPScan
  module Finders
    module Users
      # Since WP 5.5, /wp-sitemap-users-1.xml is generated and contains
      # the usernames of accounts who made a post
      class AuthorSitemap < CMSScanner::Finders::Finder
        # @param [ Hash ] opts
        #
        # @return [ Array<User> ]
        def aggressive(_opts = {})
          found = []

          Browser.get(sitemap_url).html.xpath('//url/loc').each do |user_tag|
            username = user_tag.text.to_s[%r{/author/([^/]+)/}, 1]

            next unless username && !username.strip.empty?

            found << Model::User.new(username,
                                     found_by: found_by,
                                     confidence: 100,
                                     interesting_entries: [sitemap_url])
          end

          found
        end

        # @return [ String ] The URL of the sitemap
        def sitemap_url
          @sitemap_url ||= target.url('wp-sitemap-users-1.xml')
        end
      end
    end
  end
end
