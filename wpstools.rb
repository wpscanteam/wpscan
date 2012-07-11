#!/usr/bin/env ruby

#
# WPScan - WordPress Security Scanner
# Copyright (C) 2011  Ryan Dewhurst AKA ethicalhack3r
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
#
# ryandewhurst at gmail
#

$: << '.'
require File.dirname(__FILE__) +'/lib/wpstools/wpstools_helper'

begin

  banner()

  if ARGV.length == 0
    raise "No argument supplied\n#{usage()}"
  end

  # A better way to do that should be to create a wpstools_options.rb file like wpscan_options.rb
  # and a wps_options.rb with common options code
  options = GetoptLong.new(
    ["--help", "-h", GetoptLong::NO_ARGUMENT],
    ["--verbose", "-v", GetoptLong::NO_ARGUMENT],
    ["--generate_plugin_list", GetoptLong::OPTIONAL_ARGUMENT],
    ["--gpl", GetoptLong::OPTIONAL_ARGUMENT],
    ["--update", "-u", GetoptLong::NO_ARGUMENT]
  )

  options.each do |option, argument|
    case option
    when "--help"
      help()
      exit
    when "--verbose"
      @verbose = true
    when "--generate_plugin_list", "--gpl"
      if argument == ''
        puts "Number of pages not supplied, defaulting to 150 pages ..."
        @number_of_pages = 150
      else
        @number_of_pages = argument.to_i
      end

      @generate_plugin_list = true
    when "--update"
      @update = true
    end
  end

  if @generate_plugin_list
    puts "[+] Generating new most popular plugin list"
    puts
    Generate_Plugin_List.new(@number_of_pages, @verbose).save_file
  end

  if @update
    unless @updater.nil?
      @updater.update()
    else
      puts "Svn / Git not installed, or wpscan has not been installed with one of them."
      puts "Update aborted"
    end
  end

rescue => e
  puts "[ERROR] #{e}"
  puts "Trace : #{e.backtrace}"
end
