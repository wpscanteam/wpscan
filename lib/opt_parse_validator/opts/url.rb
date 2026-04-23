# frozen_string_literal: true

module OptParseValidator
  # Implementation of the URL Option
  class OptURL < OptURI
    # @return [ Array ] The allowed protocols
    def allowed_protocols
      %w[http https]
    end
  end
end
