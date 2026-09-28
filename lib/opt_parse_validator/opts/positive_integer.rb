# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Positive Integer Option
  # attrs[:max], when given, is the highest value accepted
  class OptPositiveInteger < OptInteger
    # @param [ String ] value
    #
    # @return [ Integer ]
    def validate(value)
      i = super
      raise Error, "#{i} is not > 0" unless i.positive?
      raise Error, "#{i} is not <= #{attrs[:max]}" if attrs[:max] && i > attrs[:max]

      i
    end
  end
end
