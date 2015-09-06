# encoding: UTF-8

class WpVersion < WpItem
  module Vulnerable
    # @return [ String ] The path to the file containing vulnerabilities
    def vulns_file
      @vulns_file ||= WORDPRESSES_FILE
    end

    # @return [ String ]
    def identifier
      @number
    end
  end
end
