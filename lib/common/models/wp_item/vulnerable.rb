# encoding: UTF-8

class WpItem
  module Vulnerable
    attr_accessor :vulns_file, :vulns_xpath

    # Get the vulnerabilities associated to the WpItem
    #
    # @return [ Vulnerabilities ]
    def vulnerabilities
      xml             = xml(vulns_file)
      vulnerabilities = Vulnerabilities.new

      xml.xpath(vulns_xpath).each do |node|
        vulnerabilities << Vulnerability.load_from_xml_node(node)
      end
      vulnerabilities
    end
  end

end
