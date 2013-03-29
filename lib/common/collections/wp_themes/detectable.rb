# encoding: UTF-8

class WpThemes < WpItems
  module Detectable

    # @return [ String ]
    def vulns_file
      THEMES_VULNS_FILE
    end

    # @return [ String ]
    def item_xpath
      '//theme'
    end

  end
end
