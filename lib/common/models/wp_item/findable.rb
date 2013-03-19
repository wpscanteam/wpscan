# encoding: UTF-8

class WpItem
  attr_reader :found_from

  #def allowed_options; super << :found_from end

  def found_from=(method)
    @found_from = method[%r{find_from_(.*)}, 1].gsub('_', ' ')
  end

  module Findable

  end
end
