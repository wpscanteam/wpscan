module WPScan
  module Error
    # WordPress hosted (*.wordpress.com)
    class WordPressHosted < Standard
      def to_s
        'Scanning *.wordpress.com hosted blogs is not supported.'
      end
    end

    # Not WordPress Error
    class NotWordPress < Standard
      def to_s
        'The remote website is up, but does not seem to be running WordPress.'
      end
    end

    # Invalid Wp Version (used in the WpVersion#new)
    class InvalidWordPressVersion < Standard
      def to_s
        'The WordPress version is invalid'
      end
    end

    class WpContentDirNotDetected < Standard
      def to_s
        'Unable to identify the wp-content dir, please supply it with --wp-content-dir'
      end
    end
  end
end
