# frozen_string_literal: true

module WPScan
  module Finders
    # This class is designed to handle independent results
    # which are not related with each others
    # e.g: interesting files
    class IndependentFinders < BaseFinders
      # @param [ Hash ] opts
      # @option opts [ Symbol ] mode :mixed, :passive or :aggressive
      #
      # @return [ Findings ]
      def run(opts = {})
        methods = symbols_from_mode(opts[:mode])

        each do |finder|
          methods.each do |symbol|
            run_finder(finder, symbol, opts)
          end
        end

        filter_findings
      end
    end
  end
end
