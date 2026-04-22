# frozen_string_literal: true

module WPScan
  module Finders
    # Same Type Finder
    module SameTypeFinder
      def self.included(klass)
        klass.class_eval do
          include IndependentFinder

          # @return [ Array ]
          def finders
            @finders ||= NS::Finders::SameTypeFinders.new
          end
        end
      end
    end
  end
end
