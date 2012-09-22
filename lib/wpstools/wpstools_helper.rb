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

require File.expand_path(File.dirname(__FILE__) + '/../common_helper')

require_files_from_directory(WPSTOOLS_LIB_DIR)

def usage()
  script_name = $0
  puts
  puts "-h for further help."
  puts
  puts "Examples:"
  puts
  puts "- Generate a new 'most popular' plugin list, up to 150 pages ..."
  puts "ruby " + script_name + " --generate_plugin_list 150"
  puts
  puts "- Generate a new full plugin list"
  puts "ruby " + script_name + " --generate_full_plugin_list"
  puts
  puts "- Generate a new 'most popular' theme list, up to 150 pages ..."
  puts "ruby " + script_name + " --generate_theme_list 150"
  puts
  puts "- Generate a new full theme list"
  puts "ruby " + script_name + " --generate_full_theme_list"
  puts
  puts "See README for further information."
  puts
end

def help()
  puts "Help :"
  puts
  puts "--help    | -h   This help screen."
  puts "--Verbose | -v   Verbose output."
  puts "--update  | -u   Update to the latest revision."
  puts "--generate_plugin_list [number of pages]  Generate a new data/plugins.txt file. (supply number of *pages* to parse, default : 150)"
  puts "--gpl  Alias for --generate_plugin_list"
  puts "--generate_full_plugin_list  Generate a new full data/plugins.txt file"
  puts "--gfpl  Alias for --generate_full_plugin_list"

  puts "--generate_theme_list [number of pages]  Generate a new data/themes.txt file. (supply number of *pages* to parse, default : 150)"
  puts "--gtl  Alias for --generate_theme_list"
  puts "--generate_full_theme_list  Generate a new full data/themes.txt file"
  puts "--gftl  Alias for --generate_full_theme_list"
  puts
end
