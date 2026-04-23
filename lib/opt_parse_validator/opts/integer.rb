# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Integer Option
  class OptInteger < OptBase
    # @param [ String ] value
    #
    # @return [ Integer ]
    def validate(value)
      raise Error, "#{value} is not an integer" if value.to_i.to_s != value

      value.to_i
    end
  end
end
