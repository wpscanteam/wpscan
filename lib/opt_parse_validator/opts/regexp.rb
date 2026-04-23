# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Regexp Option
  # See http://ruby-doc.org/core-2.2.1/Regexp.html#method-c-new for expected values in :options
  class OptRegexp < OptBase
    # @param [ String ] value
    #
    # @return [ Regexp ]
    def validate(value)
      Regexp.new(super, attrs[:options])
    end
  end
end
