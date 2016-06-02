# encoding: UTF-8

class WpItem
  attr_reader :found_from

  # Sets the found_from attribute
  #
  # @param [ String ] method The method which found the WpItem
  #
  # @return [ void ]
  def found_from=(method)
    @found_from = method.to_s.gsub(/find_from_/, '').gsub(/_/, ' ')
  end

  module Findable

  end
end
