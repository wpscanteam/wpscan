# frozen_string_literal: true

class OptionParser
  # Hack to suppress the completion (except for the -h/--help) which was leading to
  # unwanted behaviours
  # See https://github.com/wpscanteam/CMSScanner/issues/2
  module Completion
    class << self
      alias original_candidate candidate

      # rubocop:disable Style/OptionalBooleanParameter
      def candidate(key, icase = false, pat = nil, &)
        # Maybe also do this for -v/--version ?
        key == 'h' ? original_candidate('help', icase, pat, &) : []
      end
      # rubocop:enable Style/OptionalBooleanParameter
    end
  end
end
