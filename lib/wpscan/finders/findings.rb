# frozen_string_literal: true

module WPScan
  module Finders
    # Findings container
    class Findings < Array
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
      end
    end
  end
end
