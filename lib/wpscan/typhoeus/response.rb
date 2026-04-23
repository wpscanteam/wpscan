# frozen_string_literal: true

module Typhoeus
  # Custom Response class
  class Response
    # @return [ Nokogiri::XML ] The response's body parsed by Nokogiri::HTML
    def html
      @html ||= Nokogiri::HTML(body.encode('UTF-8', invalid: :replace, undef: :replace))
    end

    # @return [ Nokogiri::XML ] The response's body parsed by Nokogiri::XML
    def xml
      @xml ||= Nokogiri::XML(body.encode('UTF-8', invalid: :replace, undef: :replace))
    end

    # Override of the original to ensure an integer is returned
    # @return [ Integer ]
    def request_size
      super || 0
    end

    # @return [ Integer ]
    def size
      (body.nil? ? 0 : body.size) + (response_headers.nil? ? 0 : response_headers.size)
    end

    # @note Ignores requests done to the /status endpoint of the WPScan Vuln API.
    #
    # @return [ Boolean ]
    def from_vuln_api?
      effective_url.start_with?(WPScan::DB::VulnApi.uri.to_s) &&
        !effective_url.start_with?(WPScan::DB::VulnApi.uri.join('status').to_s)
    end
  end
end
