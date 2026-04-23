# frozen_string_literal: true

module OptParseValidator
  # Implementation of the FilePath Option
  class OptFilePath < OptPath
    # @param [ Array ] option See OptBase#new
    # @param [ Hash ] attrs See OptPath#new
    # :extensions [ Array | String ] The allowed extension(s)
    def initialize(option, attrs = {})
      super

      @attrs.merge!(file: true)
    end

    # @param [ Pathname ] path
    def check_create(path)
      return if File.exist?(path.to_s)

      FileUtils.mkdir_p(path.parent.to_s)
      FileUtils.touch(path.to_s)
    end

    def allowed_attrs
      # :extensions is put at the first place
      [:extensions] + super
    end

    def check_extensions(path)
      return if Array(attrs[:extensions]).include?(path.extname.delete('.'))

      raise Error, "The extension of '#{path}' is not allowed"
    end
  end
end
