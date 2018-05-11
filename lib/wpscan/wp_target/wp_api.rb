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
        return false if data.empty?

        # WAF/API disabled response
        return false if data.include?('message') and data['message'] =~ /Only authenticated users can access the REST API/

        # Success!
        return true if response.code == 200
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

      data.each do |child|
        puts notice("ID: #{child['id']}   |   Name: #{child['name']}")
      end
    end

  end
end
