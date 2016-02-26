# encoding: UTF-8

class WpItem
  module Vulnerable
    attr_accessor :db_file, :identifier

    # Get the vulnerabilities associated to the WpItem
    # Filters out already fixed vulnerabilities
    #
    # @return [ Vulnerabilities ]
    def vulnerabilities
      return @vulnerabilities if @vulnerabilities

      @vulnerabilities = Vulnerabilities.new

      [*db_data['vulnerabilities']].each do |vulnerability|
        vulnerability = Vulnerability.load_from_json_item(vulnerability)
        @vulnerabilities << vulnerability if vulnerable_to?(vulnerability)
      end

      @vulnerabilities
    end

    def vulnerable?
      vulnerabilities.empty? ? false : true
    end

    # Checks if a item is vulnerable to a specific vulnerability
    #
    # @param [ Vulnerability ] vuln Vulnerability to check the item against
    #
    # @return [ Boolean ]
    def vulnerable_to?(vuln)
      if version && vuln && vuln.fixed_in && !vuln.fixed_in.empty?
        unless VersionCompare::lesser_or_equal?(vuln.fixed_in, version)
          return true
        end
      else
        return true
      end
      return false
    end
  end
end
