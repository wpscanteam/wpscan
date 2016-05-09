# encoding: UTF-8

class WpTimthumb < WpItem
  module Versionable

    # Get the version from the body of an invalid request
    # See https://code.google.com/p/timthumb/source/browse/trunk/timthumb.php#426
    #
    # @return [ String ] The version
    def version
      unless @version
        response = Browser.get(url)
        @version = response.body[%r{TimThumb version\s*: ([^<]+)} , 1]
      end
      @version
    end

    # @return [ String ]
    def to_s
      "#{url}#{ ' v' + version if version}"
    end

  end
end
