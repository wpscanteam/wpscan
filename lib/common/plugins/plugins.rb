# encoding: UTF-8

class Plugins < Array

  attr_reader :option_parser

  def initialize(option_parser = nil)
    if option_parser
      if option_parser.is_a?(CustomOptionParser)
        @option_parser = option_parser
      else
        raise "The parser must be an instance of CustomOptionParser, #{option_parser.class} supplied"
      end
    else
      @option_parser = CustomOptionParser.new
    end
  end

  # param Array(Plugin) plugins
  def register(*plugins)
    plugins.each do |plugin|
      register_plugin(plugin)
    end
  end

  # param Plugin plugin
  def register_plugin(plugin)
    if plugin.is_a?(Plugin)
      self << plugin

      # A plugin may not have options
      if plugin_options = plugin.registered_options
        @option_parser.add(plugin_options)
      end
    else
      raise "The argument must be an instance of Plugin, #{plugin.class} supplied"
    end
  end

end
