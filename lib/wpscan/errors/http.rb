# frozen_string_literal: true

module WPScan
  module Error
    # HTTP Error
    class HTTP < Standard
      attr_reader :response

      # @param [ Typhoeus::Response ] res
      def initialize(response)
        @response = response
      end

      def failure_details
        msg = response.effective_url

        msg += if response.code.zero? || response.timed_out?
                 " (#{response.return_message})"
               else
                 " (status: #{response.code})"
               end

        msg
      end

      def to_s
        "HTTP Error: #{failure_details}"
      end
    end

    # Used in the Updater
    class Download < HTTP
      def to_s
        "Unable to get #{failure_details}"
      end
    end
  end
end
