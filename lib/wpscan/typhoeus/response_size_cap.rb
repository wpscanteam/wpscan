# frozen_string_literal: true

module WPScan
  # Bounds how much of a response is kept in memory, for requests carrying a #max_response_size.
  #
  # libcurl's maxfilesize is not enough on its own: it acts on the advertised Content-Length, so it
  # is a no-op against the chunked responses a dynamic site serves. Only an on_body callback can
  # stop a transfer by how much has actually arrived.
  #
  # The callback is installed on the Ethon easy rather than through Typhoeus::Request#on_body: the
  # latter puts the request in streaming mode, where Response#body is left empty, and Typhoeus
  # caches the response before any on_complete could put the body back. Returning :unyielded
  # tells Ethon to accumulate the chunk as it would with no callback, so the body is intact when
  # the response is cached, just shorter.
  module ResponseSizeCap
    # Adds the per request cap, in bytes. nil or 0 disables it.
    module Request
      attr_accessor :max_response_size

      # A capped response may be truncated, so it must not be served from the cache to a request
      # allowing a larger one. Uncapped requests keep the stock key.
      def cache_key
        max_size = max_response_size.to_i

        max_size.zero? ? super : "#{super}-max_response_size:#{max_size}"
      end
    end

    # Installs the cap when the easy is built, i.e. after any on_body a caller has added.
    module EasyFactory
      def set_callback
        super

        max_size = request.max_response_size.to_i
        # A caller doing its own streaming (e.g. Target#log_file?) has its own handling
        return if max_size.zero? || request.streaming?

        easy.on_body do |_chunk, easy_handle|
          easy_handle.response_body.bytesize >= max_size ? :abort : :unyielded
        end
      end
    end
  end
end

Typhoeus::Request.prepend(WPScan::ResponseSizeCap::Request)
Typhoeus::EasyFactory.prepend(WPScan::ResponseSizeCap::EasyFactory)
