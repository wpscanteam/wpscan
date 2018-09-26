module WPScan
  # Custom Browser
  class Browser < CMSScanner::Browser
    extend Actions

    # @return [ String ] The path to the user agents list
    def user_agents_list
      @user_agents_list ||= File.join(DB_DIR, 'user-agents.txt')
    end

    # @return [ String ]
    def default_user_agent
      "WPScan v#{VERSION} (https://wpscan.org/)"
    end
  end
end
