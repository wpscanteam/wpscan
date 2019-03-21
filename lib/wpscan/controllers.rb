# frozen_string_literal: true

module WPScan
  # Override to set the OptParser's summary width to 45 (instead of 40 from the CMSScanner)
  class Controllers < CMSScanner::Controllers
    def initialize(option_parser = OptParseValidator::OptParser.new(nil, 45))
      super(option_parser)
    end
  end
end
