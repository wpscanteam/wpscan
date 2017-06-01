# encoding: UTF-8

require 'json'

class WpUsers < WpItems
  module RESTable

    # Enumerate users through unprotected wordpress API
    #
    # @param [ WpTarget ] wp_target
    #
    # @return [ WpUsers ]
    def REST_enumeration(wp_target)
      results = new(wp_target)

      request = getUsers(wp_target.url + '?rest_route=/wp/v2/users')

      request.on_complete do |response|
        if response.response_code == 200
          body = JSON.parse(response.response_body)

          body.each do |user|
            results << WpUser.new(wp_target.uri, id: user['id'], login: user['slug'], display_name: user['name'])
          end
        end
      end

      request.run

      results
    end

    # @param [ String ] url
    #
    # @return [ Typhoeus::Request ]
    def getUsers(url)
      Browser.instance.forge_request(url,
        method: :get,
        cache_ttl: 0
      )
    end

  end
end
