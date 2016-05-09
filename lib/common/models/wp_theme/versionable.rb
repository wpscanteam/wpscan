# encoding: UTF-8

class WpTheme < WpItem
  module Versionable
    def version
      @version ||= Browser.get(style_url).body[%r{Version:\s*(?!trunk)([0-9a-z\.-]+)}i, 1]
    end
  end
end
