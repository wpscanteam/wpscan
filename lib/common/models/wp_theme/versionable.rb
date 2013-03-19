# encoding: UTF-8

class WpTheme < WpItem
  module Versionable

    def version
      unless @version
        @version = Browser.instance.get(style_url).body[%r{Version:\s([^\s]+)}i, 1]

        # Get Version from readme.txt
        unless @version
          @version = super
        end
      end
      @version
    end

  end
end
