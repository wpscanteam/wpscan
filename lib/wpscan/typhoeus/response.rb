# frozen_string_literal: true

module Typhoeus
  # Custom Response class
  class Response
    # @note: Ignores requests done to the /status endpoint of the API
    #
    # @return [ Boolean ]
    def from_vuln_api?
      effective_url.start_with?(WPScan::DB::VulnApi.uri.to_s) && !effective_url.include?('/status')
    end
  end
end
