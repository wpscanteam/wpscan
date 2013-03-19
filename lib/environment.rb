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

require 'rubygems'

version = RUBY_VERSION.dup
if Gem::Version.create(version) < Gem::Version.create(1.9)
  puts "Ruby >= 1.9 required to run wpscan (You have #{version})"
  exit(1)
end

begin
  # Standard libs
  require 'bundler/setup'
  require 'getoptlong'
  require 'optparse' # Will replace getoptlong
  require 'uri'
  require 'time'
  require 'resolv'
  require 'xmlrpc/client'
  require 'digest/md5'
  require 'digest/sha1'
  require 'readline'
  require 'base64'
  require 'rbconfig'
  require 'pp'
  # Third party libs
  require 'typhoeus'
  require 'json'
  require 'nokogiri'
  # Custom libs
  require 'common/browser'
  require 'common/custom_option_parser'
rescue LoadError => e
  puts "[ERROR] #{e}"

  missing_gem = e.to_s[%r{ -- ([^\s]+)}, 1]
  if missing_gem
    if missing_gem =~ /nokogiri/i
      puts
      puts 'Nokogiri needs some packets, please run \'sudo apt-get install libxml2 libxml2-dev libxslt1-dev\' to install them. Then run the command below'
      puts
    end
    puts "[TIP] Try to run 'gem install #{missing_gem}' or 'gem install --user-install #{missing_gem}'. If you still get an error, Please see README file or https://github.com/wpscanteam/wpscan"
  end
  exit(1)
end

if Typhoeus::VERSION == '0.4.0'
  puts 'Typhoeus 0.4.0 detected, please update the gem otherwise wpscan will not work correctly'
  exit(1)
end
