# frozen_string_literal: true

module WPScan
  module Finders
    # Findings container
    class Findings < Array
      # Optional callable invoked with each newly-appended finding (not invoked
      # when a duplicate is merged into an existing one via confirmed_by). Used
      # by enumeration controllers to stream findings as they are discovered.
      attr_accessor :on_append

      # Override to include the confirmed_by logic
      #
      # @param [ Finding ] finding
      def <<(finding)
        return self unless finding

        each do |found|
          next unless found == finding

          found.confirmed_by << finding
          found.confidence += finding.confidence

          return self
        end

        super
        @on_append&.call(finding)
        self
      end
    end
  end
end
