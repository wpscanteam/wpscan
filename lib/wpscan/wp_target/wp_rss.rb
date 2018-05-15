# encoding: UTF-8

class WpTarget < WebSite
  module WpRSS

    # Checks to see if there is an rss feed
    # Will try to find the rss url in the homepage
    # Only the first one found is returned
    #
    # This file comes by default in a WordPress installation
    #
    # @return [ Boolean ]
    def rss_url
      homepage_body = Browser.get(@uri.to_s).body
      # Format: <link rel="alternate" type="application/rss+xml" title=".*" href=".*" />
      homepage_body[%r{<link\s*.*\s*type=['|"]application\/rss\+xml['|"]\s*.*\stitle=".*" href=['|"]([^"]+)['|"]\s*\/?>}i, 1]
    end


    # Gets all the authors from the RSS feed
    #
    # @return [ string ]
    def rss_authors(url)
      # Variables
      users = []

      # Make the request
      response = Browser.get(url, followlocation: true)

      # Valid repose to view? HTTP 200?
      return false unless response.code == 200

      # Get output
      data = response.body

      # Read in RSS/XML
      xml = Nokogiri::XML(data)

      begin
        # Look for <dc:creator> item
        xml.xpath('//item/dc:creator').each do |node|
          #Format: <dc:creator><![CDATA[.*]]></dc:creator>
          users << [%r{.*}i.match(node).to_s]
        end
      rescue
      end

      # Sort and uniq
      users = users.sort_by { |user| user.to_s.downcase }.uniq

      if users and users.size > 1
        # Feedback
        grammar = grammar_s(users.size)
        puts warning("Detected #{users.size} user#{grammar} from RSS feed:")

        # Print results
        table = Terminal::Table.new(headings: ['Name'],
                                    rows: users)
        puts table
      end
    end
  end
end
