# frozen_string_literal: true

require_relative 'config_files_loader_merger/base'
require_relative 'config_files_loader_merger/json'
require_relative 'config_files_loader_merger/yml'

# :nocov:
# @param [ String ] path The path of the file to load
def yaml_safe_load(path)
  if Gem::Version.new(Psych::VERSION) >= Gem::Version.new('3.1.0.pre1') # Ruby 2.6
    YAML.safe_load_file(path, permitted_classes: [Regexp]) || {}
  else
    YAML.safe_load_file(path, [Regexp]) || {}
  end
end
# :nocov:

module OptParseValidator
  # Options Files container
  class ConfigFilesLoaderMerger < Array
    # @return [ Array<String> ] The downcased supported extensions list
    def self.supported_extensions
      extensions = ConfigFile.constants.select do |const|
        name = ConfigFile.const_get(const)
        name.is_a?(Class) && name != ConfigFile::Base
      end

      extensions.map { |sym| sym.to_s.downcase }
    end

    attr_accessor :result_key

    # @param [ String ] file_path
    #
    # @return [ Self ]
    def <<(file_path)
      return self unless File.exist?(file_path)

      ext = File.extname(file_path).delete('.')

      unless self.class.supported_extensions.include?(ext)
        raise Error,
              "The option file's extension '#{ext}' is not supported"
      end

      super(ConfigFile.const_get(ext.upcase).new(file_path))
    end

    # @params [ Hash ] opts
    #
    # @return [ Hash ]
    def parse
      result = {}

      each { |config_file| result.deep_merge!(config_file.parse) }

      result = result[result_key] || {} if result_key

      result.deep_symbolize_keys
    end
  end
end
