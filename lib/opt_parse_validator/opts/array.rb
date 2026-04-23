# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Array Option
  class OptArray < OptBase
    # @return [ Void ]
    def append_help_messages
      option << "Separator to use between the values: '#{separator}'"

      super
    end

    # @param [ String ] value
    #
    # @return [ Array ]
    def validate(value)
      super.split(separator)
    end

    # @return [ String ] The separator used to split the string into an array
    def separator
      attrs[:separator] || ','
    end

    # See OptBase#normalize
    # @param [ Array ] values
    def normalize(values)
      values.each_with_index do |value, index|
        values[index] = super(value)
      end
      values
    end
  end
end
