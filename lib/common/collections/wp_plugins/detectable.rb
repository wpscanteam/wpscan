# encoding: UTF-8

class WpPlugins < WpItems
  module Detectable

    # @return [ String ]
    def vulns_file
      PLUGINS_VULNS_FILE
    end

    # @return [ String ]
    def item_xpath
      '//plugin'
    end

  end
end
