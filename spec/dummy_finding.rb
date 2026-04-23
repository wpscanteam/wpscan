# frozen_string_literal: true

module WPScan
  # Dummy Finding
  class DummyFinding
    include Finders::Finding

    attr_reader :r

    def initialize(finding, opts = {})
      @r = finding
      parse_finding_options(opts)
    end

    def ==(other)
      r == other.r
    end

    def eql?(other)
      r == other.r && confidence == other.confidence && found_by == other.found_by
    end

    def to_s
      r
    end
  end
end
