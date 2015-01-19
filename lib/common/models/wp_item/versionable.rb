# encoding: UTF-8

class WpItem
  attr_writer :version

  module Versionable

    # Get the version from the readme.txt
    #
    # @return [ String ] The version number
    def version
      unless @version
        # This check is needed because readme_url can return nil
        if has_readme?
          response = Browser.get(readme_url)
          version = response.body[/(?:stable tag|version):\s*(?!trunk)([0-9a-z.-]+)/i, 1]
          if version.nil?
            extracted_versions = response.body.scan(/[=]+\s*([0-9.-]+)\s*[=]+/i)
            return if extracted_versions.nil? || extracted_versions.length == 0
            sorted = extracted_versions.flatten.sort { |x,y| Gem::Version.new(x) <=> Gem::Version.new(y) }
            @version = sorted.last
          else
            @version = version
          end
        end
      end
      @version
    end

    # @return [ String ]
    def to_s
      item_version = self.version
      "#@name#{' - v' + item_version.strip if item_version}"
    end

  end
end
