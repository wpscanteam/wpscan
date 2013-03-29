# encoding: UTF-8

require 'common/collections/wp_items/detectable'
require 'common/collections/wp_items/output'

class WpItems < Array
  extend WpItems::Detectable
  include WpItems::Output
end
