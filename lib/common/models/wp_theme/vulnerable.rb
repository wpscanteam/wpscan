# encoding: UTF-8

class WpTheme < WpItem
  module Vulnerable

    # @return [ String ] The path to the file containing vulnerabilities
    def vulns_file
      unless @vulns_file
        @vulns_file = THEMES_VULNS_FILE
      end
      @vulns_file
    end

    # @return [ String ]
    def identifier
      @name
    end
  end
end
