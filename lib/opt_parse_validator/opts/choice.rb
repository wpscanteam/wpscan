# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Choice Option
  class OptChoice < OptBase
    # @param [ Array ] option See OptBase#new
    # @param [ Hash ] attrs
    #   :choices [ Array ] The available choices (mandatory)
    #   :case_sensitive [ Boolean ] Default: false
    def initialize(option, attrs = {})
      raise Error, 'The :choices attribute is mandatory' unless attrs.key?(:choices)
      raise Error, 'The :choices attribute must be an array' unless attrs[:choices].is_a?(Array)

      super
    end

    # @return [ Void ]
    def append_help_messages
      super

      option << "Available choices: #{choices.join(', ')}"
    end

    # @return [ String ]
    # If :case_sensitive if false (or nil), the downcased value of the choice
    # will be returned
    def validate(value)
      value = +value.to_s

      unless attrs[:case_sensitive]
        value.downcase!
        choices.map!(&:downcase)
      end

      unless choices.include?(value)
        raise Error, "'#{value}' is not a valid choice, expected one " \
                     "of the followings: #{choices.join(',')}"
      end

      value
    end
  end
end
