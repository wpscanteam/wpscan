# frozen_string_literal: true

module OptParseValidator
  # Implementation of the Credentials Option
  class OptCredentials < OptBase
    # @return [ Hash ] A hash containing the :username and :password
    def validate(value)
      raise Error, 'Incorrect credentials format, username:password expected' unless value.index(':')

      creds = value.split(':', 2)

      { username: creds[0], password: creds[1] }
    end
  end
end
