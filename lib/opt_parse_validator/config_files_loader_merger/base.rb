# frozen_string_literal: true

module OptParseValidator
  class ConfigFilesLoaderMerger < Array
    module ConfigFile
      # Base class, #parse should be implemented in child classes
      class Base
        attr_reader :path

        # @param [ String ] path The file path of the option file
        def initialize(path)
          @path = path
        end

        # @return [ Hash ] a { 'key' => value } hash
        def parse
          raise NotImplementedError
        end

        def ==(other)
          path == other.path
        end
      end
    end
  end
end
