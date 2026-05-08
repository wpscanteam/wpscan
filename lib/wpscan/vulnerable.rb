# frozen_string_literal: true

module WPScan
  # Module to include in vulnerable WP item such as WpVersion.
  # the vulnerabilities method should be implemented
  module Vulnerable
    # @return [ VulnerabilityFilter, nil ]
    def vulnerability_filter
      @vulnerability_filter ||= VulnerabilityFilter.new(ParsedCli.exclude_vulns) if ParsedCli.exclude_vulns
    end

    # @return [ Array<Vulnerability> ] Filtered vulnerabilities
    def filtered_vulnerabilities
      return vulnerabilities unless vulnerability_filter

      vulnerability_filter.filter(vulnerabilities)
    end

    # @return [ Boolean ]
    def vulnerable?
      !filtered_vulnerabilities.empty?
    end
  end
end
