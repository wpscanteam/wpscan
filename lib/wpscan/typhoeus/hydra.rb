# frozen_string_literal: true

module Typhoeus
  # Ensure a clean abort of hydra
  # See https://github.com/typhoeus/typhoeus/issues/439
  class Hydra
    def abort
      super
      run
    end
  end
end
