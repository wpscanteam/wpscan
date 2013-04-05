# encoding: UTF-8

class WpItem
  attr_writer :version

  module Versionable

    # Get the version from the readme.txt
    #
    # @return [ String ] The version number
    def version
      unless @version
        response = Browser.instance.get(readme_url)
        @version = response.body[%r{stable tag: #{WpVersion.version_pattern}}i, 1]
      end
      @version
    end

    # @return [ String ]
    def to_s
      item_version = self.version
      "#@name#{' v' + item_version.strip if item_version}"
    end

  end
end
