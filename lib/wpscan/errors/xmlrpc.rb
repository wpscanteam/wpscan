# frozen_string_literal: true

module WPScan
  module Error
    # XML-RPC Not Detected
    class XMLRPCNotDetected < Standard
      def to_s
        'The XML-RPC Interface was not detected.'
      end
    end
  end
end
