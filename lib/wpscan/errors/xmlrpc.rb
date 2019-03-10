module WPScan
  # XML-RPC Not Detected
  class XMLRPCNotDetected < Error
    def to_s
      'The XML-RPC Interface was not detected.'
    end
  end
end
