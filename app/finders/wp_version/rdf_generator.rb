# frozen_string_literal: true

module WPScan
  module Finders
    module WpVersion
      # RDF Generator Version Finder
      class RDFGenerator < CMSScanner::Finders::Finder
        include Finder::WpVersion::SmartURLChecker

        def process_urls(urls, _opts = {})
          found = Findings.new

          urls.each do |url|
            res = Browser.get_and_follow_location(url)

            res.html.xpath('//generatoragent').each do |node|
              next unless node['rdf:resource'] =~ %r{\Ahttps?://wordpress\.(?:[a-z.]+)/\?v=(.*)\z}i

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
          '//a[contains(@href, "/rdf")]/@href'
        end

        def aggressive_urls(_opts = {})
          [target.url('feed/rdf/')]
        end
      end
    end
  end
end
