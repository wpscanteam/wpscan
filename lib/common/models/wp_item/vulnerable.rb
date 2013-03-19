# encoding: UTF-8

class WpItem

  # moved this into the module ?
  def vulns_file=(file)
    if File.exists?(file)
      @vulns_file = file
    else
      raise "The file #{file} does not exist"
    end
  end

  module Vulnerable
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
