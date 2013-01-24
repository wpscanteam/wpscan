# encoding: UTF-8
#
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

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
