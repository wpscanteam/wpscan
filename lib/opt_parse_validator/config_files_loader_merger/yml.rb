# frozen_string_literal: true

require 'yaml'

module OptParseValidator
  class ConfigFilesLoaderMerger < Array
    module ConfigFile
      # Yaml Implementation
      class YML < Base
        # @return [ Hash ] a { 'key' => value } hash
        def parse
          yaml_safe_load(path)
        end
      end
    end
  end
end
