# encoding: UTF-8

class WpTheme < WpItem
  module Vulnerable
    def vulns_file
      unless @vulns_file
        @vulns_file = THEMES_VULNS_FILE
      end
      @vulns_file
    end

    def vulns_xpath
      "//theme[@name='#{@name}']/vulnerability"
    end
  end
end
