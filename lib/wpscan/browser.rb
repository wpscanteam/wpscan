# frozen_string_literal: true

module WPScan
  # Custom Browser
  class Browser < CMSScanner::Browser
    extend Actions

    # @return [ String ]
    def default_user_agent
      @default_user_agent ||= "WPScan v#{VERSION} (https://wpscan.org/)"
    end
  end
end
