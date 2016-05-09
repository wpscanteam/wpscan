# encoding: UTF-8

require 'common/collections/wp_items/detectable'
require 'common/collections/wp_items/output'

class WpItems < Array
  extend WpItems::Detectable
  include WpItems::Output

  attr_accessor :wp_target

  # @param [ WpTarget ] wp_target
  def initialize(wp_target = nil)
    self.wp_target = wp_target
  end

  # @param [String] args
  #
  # @return [ void ]
  def add(*args)
    index = 0

    until args[index].nil?
      arg = args[index]

      if arg.is_a?(String)
        if (next_arg = args[index + 1]).is_a?(Hash)
          item = create_item(arg, next_arg)
          index += 1
        else
          item = create_item(arg)
        end
      elsif arg.is_a?(Item)
        item = arg
      else
        raise 'Invalid arguments'
      end

      self << item
      index += 1
    end
  end

  # @param [ String ] name
  # @param [ Hash ] attrs
  #
  # @return [ WpItem ]
  def create_item(name, attrs = {})
    raise 'wp_target must be set' unless wp_target

    item_class.new(
      wp_target.uri,
      attrs.merge(
        name: name,
        wp_content_dir: wp_target.wp_content_dir,
        wp_plugins_dir: wp_target.wp_plugins_dir
      ) { |key, oldval, newval| oldval }
    )
  end

  # @param [ WpItems ] other
  #
  # @return [ self ]
  def +(other)
    other.each { |item| self << item }
    self
  end

  protected

  # @return [ Class ]
  def item_class
    Object.const_get(self.class.to_s.gsub(/.$/, ''))
  end
end
