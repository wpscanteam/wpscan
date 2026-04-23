# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Boolean Option
  class OptBoolean < OptBase
    TRUE_PATTERN  = /\A(true|t|yes|y|1)\z/i
    FALSE_PATTERN = /\A(false|f|no|n|0)\z/i

    # @return [ Boolean ]
    def validate(value)
      value = value.to_s

      return true if value.match(TRUE_PATTERN)
      return false if value.match(FALSE_PATTERN)

      raise Error, 'Invalid boolean value, expected true|t|yes|y|1|false|f|no|n|0'
    end
  end
end
