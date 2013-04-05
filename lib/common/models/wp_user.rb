# encoding: UTF-8

require 'wp_user/existable'

class WpUser < WpItem
  include WpUser::Existable

  attr_accessor :id, :login, :display_name, :password

  # @return [ Array<Symbol> ]
  def allowed_options; [:id, :login, :display_name, :password] end

  # @return [ URI ] The uri to the auhor page
  def uri
    if id
      return @uri.merge("?author=#{id}")
    else
      raise 'The id is nil'
    end
  end

  # @return [ String ]
  def to_s
    s  = "#{id}"
    s += " | #{login}" if login
    s += " | #{display_name}" if display_name
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
