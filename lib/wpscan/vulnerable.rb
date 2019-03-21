# frozen_string_literal: true

module WPScan
  # Module to include in vulnerable WP item such as WpVersion.
  # the vulnerabilities method should be implemented
  module Vulnerable
    # @return [ Boolean ]
    def vulnerable?
      !vulnerabilities.empty?
    end
  end
end
