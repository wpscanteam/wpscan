# frozen_string_literal: true

require 'dummy_finding'

module WPScan
  module Finders
    module Independent
      # Dummy Test Finder
      class DummyFinder < Finder
        def passive(_opts = {})
          # the nil is there to ensure such value is ignored
          [DummyFinding.new('test', found_by: found_by), nil]
        end

        def aggressive(_opts = {})
          DummyFinding.new('test', confidence: 100, found_by: 'override')
        end
      end

      # No aggressive result finder
      class NoAggressiveResult < Finder
        def passive(_opts = {})
          DummyFinding.new('spotted', confidence: 10, found_by: found_by)
        end
      end
    end
  end
end
