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

# https://github.com/bblimke/webmock
# https://github.com/colszowka/simplecov

# Code Coverage (only works with ruby >= 1.9)
if RUBY_VERSION >= "1.9"
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
    add_filter "_helper.rb"
    add_filter "environment.rb"

    # Unused files at this time
    add_filter "exploit.rb"
    add_filter "msfrpc_client.rb"
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../lib/common_helper')

require 'webmock/rspec'

SPEC_DIR = ROOT_DIR + '/spec'
SPEC_LIB_DIR = SPEC_DIR + '/lib'
SPEC_CACHE_DIR = SPEC_DIR + '/cache'
SPEC_FIXTURES_DIR = SPEC_DIR + '/fixtures'
SPEC_FIXTURES_CONF_DIR = SPEC_FIXTURES_DIR + '/conf'
SPEC_FIXTURES_WP_VERSIONS_DIR = SPEC_FIXTURES_DIR + '/wp_versions'

def count_files_in_dir(absolute_dir_path, files_pattern = '*')
  Dir.glob(File.join(absolute_dir_path, files_pattern)).count
end

# a trick to be able to test command line arguments
# argv must be an array or a string
def set_argv(argv)
  if argv.is_a?(Array)
    Object.send(:remove_const, :ARGV)
    Object.const_set(:ARGV, argv)
  elsif argv.is_a?(String)
    set_argv(argv.split(' '))
  end
end

# arguments :
#  :url - mandatory
#  :fixture - mandatory
#  :method - optional (:get, :post, :any), default :get
#  :status - optional, default 200
def stub_request_to_fixture(arguments = {})
  arguments[:method] ||= :get
  arguments[:status] ||= 200
  raise "No arguments[:url] supplied" if arguments[:url].nil?
  raise "No arguments[:fixture] supplied" if arguments[:fixture].nil?

  stub_request(arguments[:method], arguments[:url].to_s).
      to_return(:status => arguments[:status], :body => File.new(arguments[:fixture]))
end

# The object must be given as we will mock the Kernel#` or Kernel#system (Kernel is a module)
# system_method :
#  :` for `` or %x
#  :system for system()
def stub_system_command(object, command, return_value, system_method = :`)
  object.should_receive(system_method).with(command).and_return(return_value)
end
