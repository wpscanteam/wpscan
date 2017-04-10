# encoding: UTF-8

require 'common/collections/wp_users/detectable'
require 'common/collections/wp_users/output'
require 'common/collections/wp_users/brute_forcable'
require 'common/collections/wp_users/RESTable'

class WpUsers < WpItems
  extend WpUsers::Detectable
  extend WpUsers::RESTable
  include WpUsers::Output
  include WpUsers::BruteForcable
end
