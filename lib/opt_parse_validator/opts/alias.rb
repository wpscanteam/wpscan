# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Alias Option
  class OptAlias < OptBase
    def initialize(option, attrs = {})
      raise Error, 'The :alias_for attribute is required' unless attrs.key?(:alias_for)

      super
    end

    def append_help_messages
      super

      option << "Alias for #{alias_for}"
    end

    # @return [ String ]
    def alias_for
      @alias_for ||= attrs[:alias_for]
    end

    # @return [ Boolean ]
    def alias?
      true
    end
  end
end
