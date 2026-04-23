# frozen_string_literal: true

module WPScan
  module Finders
    # Finding
    module Finding
      # Fix for "Double/Dynamic Inclusion Problem"
      def self.included(base)
        base.include References
        super
      end

      FINDING_OPTS = %i[confidence confirmed_by references found_by interesting_entries].freeze

      attr_accessor(*FINDING_OPTS)

      # @return [ Array ]
      def confirmed_by
        @confirmed_by ||= []
      end

      # Should be overriden in child classes
      # @return [ Array ]
      def interesting_entries
        @interesting_entries ||= []
      end

      # @return [ Integer ]
      def confidence
        @confidence ||= 0
      end

      # @param [ Integer ] value
      def confidence=(value)
        @confidence = [value, 100].min
      end

      # @param [ Hash ] opts
      def parse_finding_options(opts = {})
        FINDING_OPTS.each { |opt| send("#{opt}=", opts[opt]) if opts.key?(opt) }
      end

      # TODO: maybe also check for interesting_entries and confirmed_by ?
      # So far this is used in specs only
      def eql?(other)
        self == other && confidence == other.confidence && found_by == other.found_by
      end

      def <=>(other)
        to_s.downcase <=> other.to_s.downcase
      end
    end
  end
end
