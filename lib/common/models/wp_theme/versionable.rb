# encoding: UTF-8

class WpTheme < WpItem
  module Versionable
    def version
      @version ||= Browser.get(style_url).body[%r{Version:\s*([^\s]+)}i, 1]
    end
  end
end
