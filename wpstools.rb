#!/usr/bin/env ruby

#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
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
      ["--generate_full_plugin_list", GetoptLong::NO_ARGUMENT],
      ["--generate_theme_list", GetoptLong::OPTIONAL_ARGUMENT],
      ["--generate_full_theme_list", GetoptLong::NO_ARGUMENT],
      ["--gpl", GetoptLong::OPTIONAL_ARGUMENT],
      ["--gfpl", GetoptLong::OPTIONAL_ARGUMENT],
      ["--gtl", GetoptLong::OPTIONAL_ARGUMENT],
      ["--gftl", GetoptLong::OPTIONAL_ARGUMENT],
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
      when "--generate_theme_list", "--gtl"
        if argument == ''
          puts "Number of pages not supplied, defaulting to 150 pages ..."
          @number_of_pages = 150
        else
          @number_of_pages = argument.to_i
        end

        @generate_theme_list = true
      when "--update"
        @update = true
      when "--generate_full_plugin_list", "--gfpl"
        @generate_full_plugin_list = true
      when "--generate_full_theme_list", "--gftl"
        @generate_full_theme_list = true
    end
  end

  if @generate_plugin_list
    puts "[+] Generating new most popular plugin list"
    puts
    Generate_List.new('plugins', @verbose).generate_popular_list(@number_of_pages)
  end

  if @generate_full_plugin_list
    puts "[+] Generating new full plugin list"
    puts
    Generate_List.new('plugins', @verbose).generate_full_list
  end

  if @generate_theme_list
    puts "[+] Generating new most popular theme list"
    puts
    Generate_List.new('themes', @verbose).generate_popular_list(@number_of_pages)
  end

  if @generate_full_theme_list
    puts "[+] Generating new full theme list"
    puts
    Generate_List.new('themes', @verbose).generate_full_list
  end

  if @update
    unless @updater.nil?
      puts @updater.update()
    else
      puts "Svn / Git not installed, or wpscan has not been installed with one of them."
      puts "Update aborted"
    end
  end

rescue => e
  puts "[ERROR] #{e.message}"
  puts "Trace :"
  puts e.backtrace.join("\n")
end
