# frozen_string_literal: true

module WPScan
  module Model
    # Version
    class Version
      include Finders::Finding

      attr_reader :number

      def initialize(number, opts = {})
        @number = number.to_s
        @number = "0#{number}" if @number[0, 1] == '.'

        parse_finding_options(opts)
      end

      # @param [ Version, String ] other
      # rubocop:disable Style/NumericPredicate
      def ==(other)
        (self <=> other) == 0
      end
      # rubocop:enable all

      # @param [ Version, String ] other
      def <(other)
        (self <=> other) == -1
      end

      # @param [ Version, String ] other
      def >(other)
        (self <=> other) == 1
      end

      # @param [ Version, String ] other
      def <=>(other)
        other = self.class.new(other) unless other.is_a?(self.class) # handle potential '.1' version

        Gem::Version.new(number) <=> Gem::Version.new(other.number)
      rescue ArgumentError
        false
      end

      def to_s
        number
      end
    end
  end
end
