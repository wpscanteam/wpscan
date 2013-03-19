# encoding: UTF-8

class WpItem
  attr_writer :version

  #def allowed_options; super << :version end

  module Versionable

    # Get the version from the readme.txt
    def version
      unless @version
        response = Browser.instance.get(readme_url)
        @version = response.body[%r{stable tag: #{WpVersion.version_pattern}}i, 1]
      end
      @version
    end

    def to_s
      item_version = self.version
      "#@name#{' v' + item_version.strip if item_version}"
    end

  end
end
