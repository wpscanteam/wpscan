# encoding: UTF-8

class WpTarget < WebSite
  module InterestingHeaders

    # Checks for interesting headers
    # @return [ Array ] Interesting Headers
    def interesting_headers
      response = Browser.head(@uri.to_s)
      headers = response.headers
      InterestingHeaders.known_headers.each do |h|
          headers.delete(h)
      end
      headers.to_a.compact.sort
    end

    protected

    # @return [ Array ]
    def self.known_headers
      %w{
        Location
        Date
        Content-Type
        Content-Length
        Connection
        Etag
        ETag
        Expires
        Last-Modified
        Pragma
        Vary
        Cache-Control
        X-Pingback
        Accept-Ranges
      }
    end

  end
end
