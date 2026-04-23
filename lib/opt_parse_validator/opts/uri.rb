# frozen_string_literal: true

module OptParseValidator
  # Implementation of the URI Option
  class OptURI < OptBase
    # return [ Void ]
    def append_help_messages
      option << "Allowed Protocols: #{allowed_protocols.join(', ')}" unless allowed_protocols.empty?
      option << "Default Protocol if none provided: #{default_protocol}" if default_protocol

      super
    end

    # @return [ Array<String> ]
    def allowed_protocols
      @allowed_protocols ||= Array(attrs[:protocols]).map(&:downcase)
    end

    # The default protocol (or scheme) to use if none was given
    def default_protocol
      @default_protocol ||= attrs[:default_protocol]&.downcase
    end

    # @param [ String ] value
    #
    # @return [ String ]
    def validate(value)
      uri = Addressable::URI.parse(value)

      uri = Addressable::URI.parse("#{default_protocol}://#{value}") if !uri.scheme && default_protocol

      unless allowed_protocols.empty? || allowed_protocols.include?(uri.scheme&.downcase)
        # For future refs: will have to check if the uri.scheme exists,
        # otherwise it means that the value was empty
        raise Addressable::URI::InvalidURIError
      end

      uri.to_s
    end
  end
end
