# encoding: UTF-8

class WpItem
  attr_reader :found_from

  # Sets the found_from attribute
  #
  # @param [ String ] method The method which found the WpItem
  #
  # @return [ void ]
  def found_from=(method)
    found       = method[%r{find_from_(.*)}, 1]
    @found_from = found.gsub('_', ' ') if found
  end

  module Findable

  end
end
