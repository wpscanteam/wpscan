module WPScan
  module Finders
    module Users
      # Users disclosed from the dc:creator field in the RSS
      # The names disclosed are display names, however depending on the configuration of the blog,
      # they can be the same than usernames
      class RSSGenerator < WPScan::Finders::WpVersion::RSSGenerator
        def process_urls(urls, _opts = {})
          found = []

          urls.each do |url|
            res = Browser.get_and_follow_location(url)

            next unless res.code == 200 && res.body =~ /<dc\:creator>/i

            potential_usernames = []

            begin
              res.xml.xpath('//item/dc:creator').each do |node|
                potential_usernames << node.text.to_s unless node.text.to_s.length > 40
              end
            rescue Nokogiri::XML::XPath::SyntaxError
              next
            end

            potential_usernames.uniq.each do |potential_username|
              found << CMSScanner::User.new(potential_username, found_by: found_by, confidence: 50)
            end

            break
          end

          found
        end
      end
    end
  end
end
