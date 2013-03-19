# encoding: UTF-8

class WpUser < WpItem
  module Existable

    def exists_from_response?(response, options = {})
      load_login_from_response(response)

      @login ? true : false
    end

    def load_login_from_response(response)
      if response.code == 301 # login in location?
        location = response.headers_hash['Location']

        @login        = WpUser::Existable.login_from_author_pattern(location)
        @display_name = WpUser::Existable.display_name_from_body(
          Browser.instance.get(location).body
        )
      elsif response.code == 200 # login in body?
        @login        = WpUser::Existable.login_from_body(response.body)
        @display_name = WpUser::Existable.display_name_from_body(response.body)
      end
    end

    def self.login_from_author_pattern(text)
      text[%r{/author/([^/\b]+)/?}i, 1]
    end

    def self.login_from_body(body)
      # Feed URL with Permalinks
      login = WpUser::Existable.login_from_author_pattern(body)

      unless login
        # No Permalinks
        login = body[%r{<body class="archive author author-([^\s]+) author-(\d+)}i, 1]
      end

      login
    end

    def self.display_name_from_body(body)
      if title_tag = body[%r{<title>([^<]+)</title>}i, 1]
        title_tag.sub!('&#124;', '|')

        return title_tag[%r{([^|]+) }, 1]
      end
    end

  end
end
