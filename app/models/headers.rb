# frozen_string_literal: true

module WPScan
  module Model
    # Interesting Headers
    class Headers < InterestingFinding
      # @return [ Hash ] The headers
      def entries
        res = NS::Browser.get(url)
        return [] unless res&.headers

        res.headers
      end

      # @return [ Array<String> ] The interesting headers detected
      def interesting_entries
        results = []

        entries.each do |header, value|
          next if known_headers.include?(header.downcase)

          results << "#{header}: #{Array(value).join(', ')}"
        end
        results
      end

      # @return [ Array<String> ] Downcased known headers
      def known_headers
        %w[
          age accept-ranges cache-control content-encoding content-length content-type connection date
          etag expires keep-alive location last-modified link pragma set-cookie strict-transport-security
          transfer-encoding vary x-cache x-content-security-policy x-content-type-options
          x-frame-options x-language x-permitted-cross-domain-policies x-pingback x-varnish
          x-webkit-csp x-xss-protection
        ]
      end

      # @return [ String ]
      def to_s
        @to_s ||= 'Headers'
      end
    end
  end
end
