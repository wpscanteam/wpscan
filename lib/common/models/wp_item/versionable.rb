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
          @version = extract_version(response.body)
        end
      end
      @version
    end

    # @return [ String ]
    def to_s
      item_version = self.version
      "#{@name}#{' - v' + item_version.strip if item_version}"
    end

    # Extracts the version number from a given string/body
    #
    # @return [ String ] detected version
    def extract_version(body)
      version = body[/\b(?:stable tag|version):\s*(?!trunk)([0-9a-z\.-]+)/i, 1]
      if version.nil? || version !~ /[0-9]+/
        extracted_versions = body.scan(/[=]+\s+(?:v(?:ersion)?\s*)?([0-9\.-]+)[ \ta-z0-9\(\)\.-]*[=]+/i)
        return if extracted_versions.nil? || extracted_versions.length == 0
        extracted_versions.flatten!
        # must contain at least one number
        extracted_versions = extracted_versions.select { |x| x =~ /[0-9]+/ }
        sorted = extracted_versions.sort { |x,y|
          begin
            Gem::Version.new(x) <=> Gem::Version.new(y)
          rescue
            0
          end
        }
        return sorted.last
      else
        return version
      end
    end

  end
end
