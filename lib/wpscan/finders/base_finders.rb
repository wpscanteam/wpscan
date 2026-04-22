# frozen_string_literal: true

module WPScan
  module Finders
    # Base class container for the Finders (i.e IndependentFinders etc)
    class BaseFinders < Array
      # @return [ Findings ]
      def findings
        @findings ||= NS::Finders::Findings.new
      end

      # Should be implemented in child classes
      def run; end

      protected

      # @param [ Symbol ] mode :mixed, :passive or :aggressive
      # @return [ Array<Symbol> ] The symbols to call for the mode
      def symbols_from_mode(mode)
        symbols = %i[passive aggressive]

        return symbols if mode.nil? || mode == :mixed

        symbols.include?(mode) ? Array(mode) : []
      end

      # @param [ WPScan::Finders::Finder ] finder
      # @param [ Symbol ] symbol See return values of #symbols_from_mode
      # @param [ Hash ] opts
      def run_finder(finder, symbol, opts)
        Array(finder.send(symbol, opts.merge(found: findings))).compact.each do |found|
          findings << found
        end
      end

      # Allow child classes to filter the findings, such as return the best one
      # or remove the low confidence ones.
      #
      # @return [ Findings ]
      def filter_findings
        findings
      end
    end
  end
end
