# encoding: UTF-8

require 'wp_timthumb/versionable'
require 'wp_timthumb/existable'
require 'wp_timthumb/output'
require 'wp_timthumb/vulnerable'

class WpTimthumb < WpItem
  include WpTimthumb::Versionable
  include WpTimthumb::Existable
  include WpTimthumb::Output
  include WpTimthumb::Vulnerable

  # @param [ WpTimthumb ] other
  #
  # @return [ Boolean ]
  def ==(other)
    url == other.url
  end
end
