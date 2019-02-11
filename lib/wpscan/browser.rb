module WPScan
  # Custom Browser
  class Browser < CMSScanner::Browser
    extend Actions

    # @return [ String ] The path to the user agents list
    def user_agents_list
      @user_agents_list ||= DB_DIR.join('user-agents.txt').to_s
    end

    # @return [ String ]
    def default_user_agent
      "WPScan v#{VERSION} (https://wpscan.org/)"
    end
  end
end
