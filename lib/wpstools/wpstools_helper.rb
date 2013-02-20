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

require File.expand_path(File.dirname(__FILE__) + '/../common/common_helper')

require_files_from_directory(WPSTOOLS_LIB_DIR)
require_files_from_directory(WPSTOOLS_PLUGINS_DIR, '**/*.rb')

def usage
  script_name = $0
  puts
  puts '-h for further help.'
  puts
  puts 'Examples:'
  puts
  puts "- Generate a new 'most popular' plugin list, up to 150 pages ..."
  puts "ruby #{script_name} --generate-plugin-list 150"
  puts
  puts '- Generate a new full plugin list'
  puts "ruby #{script_name} --generate-full-plugin-list"
  puts
  puts "- Generate a new 'most popular' theme list, up to 150 pages ..."
  puts "ruby #{script_name} --generate-theme-list 150"
  puts
  puts '- Generate a new full theme list'
  puts "ruby #{script_name} --generate-full-theme-list"
  puts
  puts '- Generate all list'
  puts "ruby #{script_name} --generate-all"
  puts
  puts 'Locally scan a wordpress installation for vulnerable files or shells'
  puts "ruby #{script_name} --check-local-vulnerable-files /var/www/wordpress/"
  puts
  puts 'See README for further information.'
  puts
end
