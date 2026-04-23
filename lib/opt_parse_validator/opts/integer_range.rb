# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Integer Range Option
  class OptIntegerRange < OptBase
    # @return [ Void ]
    def append_help_messages
      option << "Range separator to use: '#{separator}'"

      super
    end

    # @param [ String ] value
    #
    # @return [ Range ]
    def validate(value)
      a = super.split(separator)

      raise Error, "Incorrect number of ranges found: #{a.size}, should be 2" unless a.size == 2

      first_integer = a.first.to_i
      last_integer  = a.last.to_i

      unless first_integer.to_s == a.first && last_integer.to_s == a.last
        raise Error,
              'Argument is not a valid integer range'
      end

      (first_integer..last_integer)
    end

    # @return [ String ]
    def separator
      attrs[:separator] || '-'
    end
  end
end
