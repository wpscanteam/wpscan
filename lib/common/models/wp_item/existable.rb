# encoding: UTF-8

class WpItem
  module Existable

    # Check the existence of the WpItem
    # If the response is supplied, it's used for the verification
    # Otherwise a new request is done
    #
    # @param [ Hash ] options See exists_from_response?
    # @param [ Typhoeus::Response ] response
    #
    # @return [ Boolean ]
    def exists?(options = {}, response = nil)
      unless response
        response = Browser.get(url)
      end
      exists_from_response?(response, options)
    end

    protected

    # @param [ Typhoeus::Response ] response
    # @param [ options ] options
    #
    # @option options [ Hash ] :error_404_hash  The hash of the error 404 page
    # @option options [ Hash ] :homepage_hash   The hash of the homepage
    # @option options [ Hash ] :exclude_content A regexp with the pattern to exclude from the body of the response
    #
    # @return [ Boolean ]
    def exists_from_response?(response, options = {})
      # 301 included as some items do a self-redirect
      # Redirects to the 404 and homepage should be ignored (unless dynamic content is used)
      # by the page hashes (error_404_hash & homepage_hash)
      if [200, 401, 403, 301].include?(response.code)
        if response.has_valid_hash?(options[:error_404_hash], options[:homepage_hash])
          if options[:exclude_content]
            unless response.body.match(options[:exclude_content])
              return true
            end
          else
            return true
          end
        end
      end
      false
    end

  end
end
