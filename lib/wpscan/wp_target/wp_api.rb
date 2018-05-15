# encoding: UTF-8

class WpTarget < WebSite
  module WpAPI

    # Checks to see if the REST API is enabled
    #
    # This by default in a WordPress installation since 4.5+
    # @return [ Boolean ]
    def has_api?(url)
      # Make the request
      response = Browser.get(url)

      # Able to view the output?
      if valid_json?(response.body)
        # Read in JSON
        data = JSON.parse(response.body)

        # If there is nothing there, return false
        if data.empty?
          return false
        # WAF/API disabled response
        elsif data.include?('message') and data['message'] =~ /Only authenticated users can access the REST API/
          return false
        # Success!
        elsif response.code == 200
          return true
        end
      end

      # Something went wrong
      return false
    end

    # @return [ String ] The API/JSON URL
    def json_url
      @uri.merge('/wp-json/').to_s
    end

    # @return [ String ] The API/JSON URL to show users
    def json_users_url
      @uri.merge('/wp-json/wp/v2/users').to_s
    end

    # @return [ String ] The API/JSON URL to show users
    def json_get_users(url)
      # Variables
      users = []

      # Make the request
      response = Browser.get(url)

      # Able to view the output?
      return false if not valid_json?(response.body)

      # Read in JSON
      data = JSON.parse(response.body)

      # If there is nothing there, return false
      return false if data.empty?

      # If not HTTP 200, return false
      return false if response.code != 200

      # Add to array
      data.each do |child|
        row = [ child['id'], child['name'], child['link'] ]
        users << row
      end

      # Sort and uniq
      users = users.sort.uniq

      if users and users.size > 1
        # Feedback
        grammar = grammar_s(users.size)
        puts warning("#{users.size} user#{grammar} exposed via API: #{json_users_url}")

        # Print results
        table = Terminal::Table.new(headings: ['ID', 'Name', 'URL'],
                                    rows: users)
        puts table
      end
    end
  end
end
