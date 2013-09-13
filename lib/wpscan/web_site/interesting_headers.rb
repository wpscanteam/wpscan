# encoding: UTF-8

class WebSite
  module InterestingHeaders

    # Checks for interesting headers
    # @return [ Array ] Interesting Headers
    def interesting_headers
      response = Browser.head(@uri.to_s)
      headers = response.headers
      # Header Names are case insensitve so convert them to upcase
      headers_uppercase = headers.inject({}) do |hash, keys|
        hash[keys[0].upcase] = keys[1]
        hash
      end
      InterestingHeaders.known_headers.each do |h|
        headers_uppercase.delete(h.upcase)
      end
      headers_uppercase.to_a.compact.sort
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
