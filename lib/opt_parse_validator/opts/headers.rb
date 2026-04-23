# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Headers Option
  class OptHeaders < OptBase
    # @return [ Void ]
    def append_help_messages
      super

      option << "Separator to use between the headers: '; '"
      option << "Examples: 'X-Forwarded-For: 127.0.0.1', 'X-Forwarded-For: 127.0.0.1; Another: aaa'"
    end

    # @param [ String ] value
    #
    # @return [ Hash ] The parsed headers in a hash, with { 'key' => 'value' } format
    def validate(value)
      values = super.chomp(';').split('; ')

      headers = {}

      values.each do |header|
        raise Error, "Malformed header: '#{header}'" unless header.index(':')

        val = header.split(':', 2)

        headers[val[0].strip] = val[1].strip
      end

      headers
    end
  end
end
