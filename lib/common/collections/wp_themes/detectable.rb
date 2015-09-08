# encoding: UTF-8

class WpThemes < WpItems
  module Detectable

    # @return [ String ]
    def vulns_file
      THEMES_FILE
    end
  end
end
