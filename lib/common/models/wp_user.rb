# encoding: UTF-8

require 'wp_user/existable'
require 'wp_user/brute_forcable'

class WpUser < WpItem
  include WpUser::Existable
  include WpUser::BruteForcable

  attr_accessor :id, :login, :display_name, :password

  # @return [ Array<Symbol> ]
  def allowed_options; [:id, :login, :display_name, :password] end

  # @return [ URI ] The uri to the author page
  def uri
    if id
      @uri.merge("?author=#{id}")
    else
      raise 'The id is nil'
    end
  end

  # @return [ String ]
  def login_url
    unless @login_url
      @login_url = @uri.merge('wp-login.php').to_s

      # Let's check if the login url is redirected (to https url for example)
      if redirection = redirection(@login_url)
        @login_url = redirection
      end
    end

    @login_url
  end

  def redirection(url)
    redirection = nil
    response = Browser.get(url)

    if response.code == 301 || response.code == 302
      redirection = response.headers_hash['location']

      # Let's check if there is a redirection in the redirection
      if other_redirection = redirection(redirection)
        redirection = other_redirection
      end
    end

    redirection
  end

  # @return [ String ]
  def to_s
    s  = "#{id}"
    s << " | #{login}" if login
    s << " | #{display_name}" if display_name
    s
  end

  # @param [ WpUser ] other
  def <=>(other)
    id <=> other.id
  end

  # @param [ WpUser ] other
  #
  # @return [ Boolean ]
  def ==(other)
    self === other
  end

  # @param [ WpUser ] other
  #
  # @return [ Boolean ]
  def ===(other)
    id === other.id && login === other.login
  end

end
