# frozen_string_literal: true

module WPScan
  module Finders
    module WpVersion
      # RSS Generator Version Finder
      class RSSGenerator < CMSScanner::Finders::Finder
        include Finder::WpVersion::SmartURLChecker

        def process_urls(urls, _opts = {})
          found = Findings.new

          urls.each do |url|
            res = Browser.get_and_follow_location(url)

            res.html.xpath('//comment()[contains(., "wordpress")] | //generator').each do |node|
              node_text = node.text.to_s.strip

              next unless node_text =~ %r{\Ahttps?://wordpress\.(?:[a-z]+)/\?v=(.*)\z}i ||
                          node_text =~ %r{\Agenerator="wordpress/([^"]+)"\z}i

              found << create_version(
                Regexp.last_match[1],
                found_by: found_by,
                entries: ["#{res.effective_url}, #{node.to_s.strip}"]
              )
            end
          end

          found
        end

        def passive_urls_xpath
          '//link[@rel="alternate" and @type="application/rss+xml"]/@href'
        end

        def aggressive_urls(_opts = {})
          %w[feed/ comments/feed/ feed/rss/ feed/rss2/].reduce([]) do |a, uri|
            a << target.url(uri)
          end
        end
      end
    end
  end
end
