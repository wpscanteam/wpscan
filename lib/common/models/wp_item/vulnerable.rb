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
        if vuln
          if version && vuln.fixed_in && !vuln.fixed_in.empty?
            unless VersionCompare::is_newer_or_same?(vuln.fixed_in, version)
              vulnerabilities << vuln
            end
          else
            vulnerabilities << vuln
          end
        end
      end
      vulnerabilities
    end
  end

end
