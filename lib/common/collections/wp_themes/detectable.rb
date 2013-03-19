# encoding: UTF-8

class WpThemes < WpItems
  module Detectable

    def vulns_file
      unless @vulns_file
        @vulns_file = THEMES_VULNS_FILE
      end
      @vulns_file
    end

    def item_xpath
      '//theme'
    end

  end
end
