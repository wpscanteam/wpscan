# frozen_string_literal: true

module WPScan
  module Finders
    module Users
      # Users disclosed from the dc:creator field in the RSS
      # The names disclosed are display names, however depending on the configuration of the blog,
      # they can be the same than usernames
      class RSSGenerator < Finders::WpVersion::RSSGenerator
        def process_urls(urls, _opts = {})
          found = []

          urls.each do |url|
            res = Browser.get_and_follow_location(url)

            next unless res.code == 200 && res.body =~ /<dc\:creator>/i

            potential_usernames = []

            begin
              res.xml.xpath('//item/dc:creator').each do |node|
                username = node.text.to_s

                # Ignoring potential username longer than 60 characters and containing accents
                # as they are considered invalid. See https://github.com/wpscanteam/wpscan/issues/1215
                next if username.strip.empty? || username.length > 60 || username =~ /[^\x00-\x7F]/

                potential_usernames << username
              end
            rescue Nokogiri::XML::XPath::SyntaxError
              next
            end

            potential_usernames.uniq.each do |username|
              found << Model::User.new(username, found_by: found_by, confidence: 50)
            end

            break
          end

          found
        end
      end
    end
  end
end
