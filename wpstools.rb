#!/usr/bin/env ruby
# encoding: UTF-8

#--
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

$: << '.'
require File.dirname(__FILE__) + '/lib/wpstools/wpstools_helper'

begin

  banner()

  option_parser = CustomOptionParser.new('Usage: ./wpstools.rb [options]', 60)
  option_parser.separator ''
  option_parser.add(['-v', '--verbose', 'Verbose output'])

  plugins = Plugins.new(option_parser)
  plugins.register(
    CheckerPlugin.new,
    ListGeneratorPlugin.new,
    StatsPlugin.new
  )

  options = option_parser.results

  if options.empty?
    raise "No option supplied\n\n#{option_parser}"
  end

  plugins.each do |plugin|
    plugin.run(options)
  end

rescue => e
  puts "[ERROR] #{e.message}"
  puts 'Trace :'
  puts e.backtrace.join("\n")
end
