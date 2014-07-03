# encoding: UTF-8

class WpItem
  module Vulnerable
    attr_accessor :vulns_file, :vulns_xpath

    # Get the vulnerabilities associated to the WpItem
    # Filters out already fixed vulnerabilities
    #
    # @return [ Vulnerabilities ]
    def vulnerabilities
      xml             = xml(vulns_file)
      vulnerabilities = Vulnerabilities.new

      xml.xpath(vulns_xpath).each do |node|
        vuln = Vulnerability.load_from_xml_node(node)
        if vulnerable_to?(vuln)
          vulnerabilities << vuln
        end
      end
      vulnerabilities
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
