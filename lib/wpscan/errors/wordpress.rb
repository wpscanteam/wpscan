module WPScan
  # WordPress hosted (*.wordpress.com)
  class WordPressHostedError < Error
    def to_s
      'Scanning *.wordpress.com hosted blogs is not supported.'
    end
  end

  # Not WordPress Error
  class NotWordPressError < Error
    def to_s
      'The remote website is up, but does not seem to be running WordPress.'
    end
  end

  # Invalid Wp Version (used in the WpVersion#new)
  class InvalidWordPressVersion < Error
    def to_s
      'The WordPress version is invalid'
    end
  end
end
