# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Positive Integer Option
  class OptPositiveInteger < OptInteger
    # @param [ String ] value
    #
    # @return [ Integer ]
    def validate(value)
      i = super
      raise Error, "#{i} is not > 0" unless i.positive?

      i
    end
  end
end
