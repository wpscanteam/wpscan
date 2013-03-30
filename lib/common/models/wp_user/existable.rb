# encoding: UTF-8

class WpUser < WpItem
  module Existable

    # @param [ Typhoeus::Response ] response
    # @param [ Hash ] options
    #
    # @return [ Boolean ]
    def exists_from_response?(response, options = {})
      load_from_response(response)

      @login ? true : false
    end

    # Load the login and display_name from the response
    #
    # @param [ Typhoeus::Response ] response
    #
    # @return [ void ]
    def load_from_response(response)
      if response.code == 301 # login in location?
        location = response.headers_hash['Location']

        @login        = Existable.login_from_author_pattern(location)
        @display_name = Existable.display_name_from_body(
          Browser.instance.get(location).body
        )
      elsif response.code == 200 # login in body?
        @login        = Existable.login_from_body(response.body)
        @display_name = Existable.display_name_from_body(response.body)
      end
    end
    private :load_from_response

    # @param [ String ] text
    #
    # @return [ String ] The login
    def self.login_from_author_pattern(text)
      text[%r{/author/([^/\b]+)/?}i, 1]
    end

    # @param [ String ] body
    #
    # @return [ String ] The login
    def self.login_from_body(body)
      # Feed URL with Permalinks
      login = WpUser::Existable.login_from_author_pattern(body)

      unless login
        # No Permalinks
        login = body[%r{<body class="archive author author-([^\s]+) author-(\d+)}i, 1]
      end

      login
    end

    # @note Some bodies are encoded in ASCII-8BIT, and Nokogiri doesn't support it
    #   So it's forced to UTF-8 when this encoding is detected
    #
    # @param [ String ] body
    #
    # @return [ String ] The display_name
    def self.display_name_from_body(body)
      if title_tag = body[%r{<title>([^<]+)</title>}i, 1]
        title_tag.force_encoding('UTF-8') if title_tag.encoding == Encoding::ASCII_8BIT
        title_tag = Nokogiri::HTML::DocumentFragment.parse(title_tag).to_s
        # &amp; are not decoded with Nokogiri
        title_tag.sub!('&amp;', '&')

        name = title_tag[%r{([^|«]+) }, 1]

        return name.strip if name
      end
    end

  end
end
