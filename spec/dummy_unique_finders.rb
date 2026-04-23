# frozen_string_literal: true

require 'dummy_finding'

module WPScan
  module Finders
    module Unique
      # Dummy Test Finder
      class Dummy < Finder
        def passive(_opts = {})
          # the nil is there to ensure such value is ignored
          [DummyFinding.new('v1', found_by: found_by), nil]
        end

        def aggressive(_opts = {})
          DummyFinding.new('v1', confidence: 100, found_by: 'override')
        end
      end

      # No aggressive result
      class NoAggressive < Finder
        def passive(_opts = {})
          DummyFinding.new('v2', confidence: 10, found_by: found_by)
        end
      end

      # Dummy2
      class Dummy2 < Finder
        def aggressive(_opts = {})
          DummyFinding.new('v1', confidence: 90)
        end
      end
    end
  end
end
