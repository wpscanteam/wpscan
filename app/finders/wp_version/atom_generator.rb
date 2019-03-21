# frozen_string_literal: true

module WPScan
  module Finders
    module WpVersion
      # Atom Generator Version Finder
      class AtomGenerator < CMSScanner::Finders::Finder
        include Finder::WpVersion::SmartURLChecker

        def process_urls(urls, _opts = {})
          found = Findings.new

          urls.each do |url|
            res = Browser.get_and_follow_location(url)

            res.html.css('generator').each do |node|
              next unless node.text.to_s.strip.casecmp('wordpress').zero?

              found << create_version(
                node['version'],
                found_by: found_by,
                entries: ["#{res.effective_url}, #{node.to_s.strip}"]
              )
            end
          end

          found
        end

        def passive_urls_xpath
          '//link[@rel="alternate" and @type="application/atom+xml"]/@href'
        end

        def aggressive_urls(_opts = {})
          %w[feed/atom/ ?feed=atom].reduce([]) do |a, uri|
            a << target.url(uri)
          end
        end
      end
    end
  end
end
