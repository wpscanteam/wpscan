# encoding: UTF-8

class WebSite
  module Sitemap

    # Checks if a sitemap.txt file exists
    # @return [ Boolean ]
    def has_sitemap?
      # Make the request
      response = Browser.get(sitemap_url)

      # Make sure its HTTP 200
      return false unless response.code == 200

      # Is there a sitemap value?
      result = response.body.scan(/^sitemap\s*:\s*(.*)$/i)
      return true if result[0]
      return false
    end

    # Gets a robots.txt URL
    # @return [ String ]
    def sitemap_url
      @uri.clone.merge('robots.txt').to_s
    end

    # Parse robots.txt
    # @return [ Array ] URLs generated from robots.txt
    def parse_sitemap
      return_object = []

      # Make request
      response = Browser.get(sitemap_url.to_s)
      body = response.body

      # Get all allow and disallow urls
      entries = body.scan(/^sitemap\s*:\s*(.*)$/i)

      # Did we get something?
      if entries
        # Extract elements
        entries.flatten!
        # Remove any leading/trailing spaces
        entries.collect{|x| x.strip || x }
        # End Of Line issues
        entries.collect{|x| x.chomp! || x }
        # Remove nil's and sort
        entries.compact.sort!
        # Unique values only
        entries.uniq!

        # Each value now, try and make it a full URL
        entries.each do |d|
          begin
            temp = @uri.clone
            temp.path = d.strip
          rescue URI::Error
            temp = d.strip
          end
          return_object << temp.to_s
        end

      end
      return_object
    end

  end
end
