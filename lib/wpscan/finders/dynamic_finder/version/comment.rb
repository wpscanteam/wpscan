# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module Version
        # Version finder in Comment, which is basically an Xpath one with a default
        # Xpath of //comment()
        class Comment < Finders::DynamicFinder::Version::Xpath
          # @return [ Hash ]
          def self.child_class_constants
            @child_class_constants ||= super().merge(PATTERN: nil, XPATH: '//comment()')
          end
        end
      end
    end
  end
end
