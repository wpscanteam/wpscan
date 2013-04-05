# encoding: UTF-8

require 'common/collections/wp_users/detectable'
require 'common/collections/wp_users/output'

class WpUsers < WpItems
  extend WpUsers::Detectable
  include WpUsers::Output

end
