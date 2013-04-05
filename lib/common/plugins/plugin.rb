# encoding: UTF-8

class Plugin

  attr_reader :author, :registered_options

  def initialize(infos = {})
    @author  = infos[:author]
  end

  def run(options = {})
    raise NotImplementedError
  end

  # param Array options
  def register_options(*options)
    options.each do |option|
      unless option.is_a?(Array)
        raise "Each option must be an array, #{option.class} supplied"
      end
    end
    @registered_options = options
  end

end
