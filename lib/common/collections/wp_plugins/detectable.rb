# encoding: UTF-8

class WpPlugins < WpItems
  module Detectable

    def vulns_file
      unless @vulns_file
        @vulns_file = PLUGINS_VULNS_FILE
      end
      @vulns_file
    end

    def item_xpath
      '//plugin'
    end

  end
end
