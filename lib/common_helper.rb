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

LIB_DIR           = File.dirname(__FILE__)
ROOT_DIR          = File.expand_path(LIB_DIR + '/..') # expand_path is used to get "wpscan/" instead of "wpscan/lib/../"
DATA_DIR          = ROOT_DIR + "/data"
CONF_DIR          = ROOT_DIR + "/conf"
CACHE_DIR         = ROOT_DIR + "/cache"
WPSCAN_LIB_DIR    = LIB_DIR + "/wpscan"
WPSTOOLS_LIB_DIR  = LIB_DIR + "/wpstools"
UPDATER_LIB_DIR   = LIB_DIR + "/updater"

WPSCAN_VERSION = "2.0"

require "#{LIB_DIR}/environment"

# TODO : add an exclude pattern ?
def require_files_from_directory(absolute_dir_path, files_pattern = "*.rb")
  Dir[File.join(absolute_dir_path, files_pattern)].sort.each do |f|
    f = File.expand_path(f)
    require f
    #puts "require #{f}" # Used for debug
  end
end

# Add protocol
def add_http_protocol(url)
  if url !~ /^https?:/
    url = "http://#{url}"
  end
  url
end

def add_trailing_slash(url)
  url = "#{url}/" if url !~ /\/$/
  url
end

# Gets the string all elements in stringarray ends with
def get_equal_string_end(stringarray = [""])
  already_found = ""
  looping = true
  counter = -1
  if stringarray.kind_of? Array and stringarray.length > 1
    base = stringarray[0]
    while looping
      character = base[counter, 1]
      stringarray.each do |s|
        if s[counter, 1] != character
          looping = false
          break
        end
      end
      if looping == false or (counter * -1) > base.length
        break
      end
      already_found = "#{character if character}#{already_found}"
      counter -= 1
    end
  end
  already_found
end

if RUBY_VERSION < "1.9"
  class Array
    # Fix for grep with symbols in ruby <= 1.8.7
    def _grep_(regexp)
      matches = []
      self.each do |value|
        value = value.to_s
        matches << value if value.match(regexp)
      end
      matches
    end

    alias_method :grep, :_grep_
  end
end

# loading the updater
require_files_from_directory(UPDATER_LIB_DIR)
@updater = UpdaterFactory.get_updater(ROOT_DIR)

if @updater
  REVISION = @updater.local_revision_number()
else
  REVISION = "NA"
end

# our 1337 banner
def banner()
  puts '____________________________________________________'
  puts " __          _______   _____                  "
  puts " \\ \\        / /  __ \\ / ____|                 "
  puts "  \\ \\  /\\  / /| |__) | (___   ___  __ _ _ __  "
  puts "   \\ \\/  \\/ / |  ___/ \\___ \\ / __|/ _` | '_ \\ "
  puts "    \\  /\\  /  | |     ____) | (__| (_| | | | |"
  puts "     \\/  \\/   |_|    |_____/ \\___|\\__,_|_| |_| v#{WPSCAN_VERSION}r#{REVISION}"
  puts
  puts "    WordPress Security Scanner by the WPScan Team"
  puts " Sponsored by the RandomStorm Open Source Initiative"
  puts '_____________________________________________________'
  puts
  if RUBY_VERSION < "1.9"
    puts "[WARNING] Ruby < 1.9 not officially supported, please upgrade."
    puts
  end
end

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text)
  colorize(text, 31)
end

def green(text)
  colorize(text, 32)
end
