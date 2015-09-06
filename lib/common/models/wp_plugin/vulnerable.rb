# encoding: UTF-8

class WpPlugin < WpItem
  module Vulnerable
    # @return [ String ] The path to the file containing vulnerabilities
    def vulns_file
      @vulns_file ||= PLUGINS_FILE
    end

    # @return [ String ]
    def identifier
      @name
    end
  end
end
