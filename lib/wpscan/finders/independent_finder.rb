# frozen_string_literal: true

module WPScan
  module Finders
    # Independent Finder
    module IndependentFinder
      extend ActiveSupport::Concern

      # See ActiveSupport::Concern
      module ClassMethods
        def find(target, opts = {}, &)
          new(target).find(opts, &)
        end
      end

      # @param [ Hash ] opts
      # @option opts [ Symbol ] mode (:mixed, :passive, :aggressive)
      # @yield [ Finding ] Optional block called for each finding the moment
      #                   it is first appended to the result set (used to
      #                   stream enumeration findings as they are discovered).
      #
      # @return [ Findings ]
      def find(opts = {}, &)
        finders.run(opts, &)
      end

      # @return [ Array ]
      def finders
        @finders ||= WPScan::Finders::IndependentFinders.new
      end
    end
  end
end
