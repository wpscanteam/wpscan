# encoding: UTF-8

require 'wp_user/existable'

class WpUser < WpItem
  include WpUser::Existable

  attr_accessor :id, :login, :display_name, :password

  def allowed_options; [:id, :login, :display_name, :password] end

  def uri
    if id
      return @uri.merge("?author=#{id}")
    else
      raise 'The id is nil'
    end
  end

  def <=>(other)
    id <=> other.id
  end

  def ==(other)
    self === other
  end

  def ===(other)
    id === other.id && login === other.login
  end

end
