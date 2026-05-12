# frozen_string_literal: true

module WPScan
  module Finders
    # This class is designed to handle same type results, such as enumeration of plugins,
    # themes etc.
    class SameTypeFinders < BaseFinders
      # @param [ Hash ] opts
      # @option opts [ Symbol ] :mode :mixed, :passive or :aggressive
      # @option opts [ Boolean ] :sort Wether or not to sort the findings
      #
      # @return [ Findings ]
      def run(opts = {}, &block)
        findings.on_append = block if block

        symbols_from_mode(opts[:mode]).each do |symbol|
          each do |finder|
            run_finder(finder, symbol, opts)
          end
        end

        findings.sort! if opts[:sort]

        filter_findings
      end
    end
  end
end
