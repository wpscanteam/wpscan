# frozen_string_literal: true

module OptParseValidator
  class Error < RuntimeError
  end

  class NoRequiredOption < Error
  end
end
