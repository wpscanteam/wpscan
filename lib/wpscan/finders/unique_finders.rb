# frozen_string_literal: true

module WPScan
  module Finders
    # This class is designed to return a unique result such as a version
    # Note: Finders contained can return multiple results but the #run will only
    # returned the best finding
    class UniqueFinders < BaseFinders
      # @param [ Hash ] opts
      # @option opts [ Symbol ] :mode :mixed, :passive or :aggressive
      # @option opts [ Int ] :confidence_threshold  If a finding's confidence reaches this value,
      #                                             it will be returned as the best finding.
      #                                             Default is 100.
      #                                             If <= 0, all finders will be ran.
      #
      # @return [ Object, false ] The best finding or false if none
      def run(opts = {})
        opts[:confidence_threshold] ||= 100

        symbols_from_mode(opts[:mode]).each do |symbol|
          each do |finder|
            run_finder(finder, symbol, opts)

            next if opts[:confidence_threshold] <= 0

            findings.each { |f| return f if f.confidence >= opts[:confidence_threshold] }
          end
        end

        filter_findings
      end

      protected

      # @return [ Object, false ] The best finding or false if none
      def filter_findings
        # results are sorted by confidence ASC
        findings.sort_by!(&:confidence)

        # If all findings have the same confidence, false is returned
        return false if findings.size > 1 && findings.first.confidence == findings.last.confidence

        findings.last || false
      end
    end
  end
end
