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

      # Get all allow and disallow urls
      entries = response.body.scan(/^sitemap\s*:\s*(.*)$/i)

      # Did we get something?
      if entries
        # Remove any rubbish
        entries = clean_uri(entries)

        # Sort
        entries.sort!

        # Convert to full URIs
        return_object = full_uri(entries)
      end
      return return_object
    end

  end
end
