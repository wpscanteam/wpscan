# encoding: UTF-8

# https://github.com/bblimke/webmock
# https://github.com/colszowka/simplecov

require 'webmock/rspec'
# Code Coverage (only works with ruby >= 1.9)
require 'simplecov' if RUBY_VERSION >= '1.9'

require File.expand_path(File.dirname(__FILE__) + '/../lib/common/common_helper')

SPEC_DIR                      = ROOT_DIR + '/spec'
SPEC_LIB_DIR                  = SPEC_DIR + '/lib'
SPEC_CACHE_DIR                = SPEC_DIR + '/cache'
SPEC_FIXTURES_DIR             = SPEC_DIR + '/samples'
SHARED_EXAMPLES_DIR           = SPEC_DIR + '/shared_examples'
SPEC_FIXTURES_CONF_DIR        = SPEC_FIXTURES_DIR + '/conf'
SPEC_FIXTURES_WP_VERSIONS_DIR = SPEC_FIXTURES_DIR + '/wp_versions'

MODELS_FIXTURES = SPEC_FIXTURES_DIR + '/common/models'
COLLECTIONS_FIXTURES = SPEC_FIXTURES_DIR + '/common/collections'

# Load all the shared examples
require_files_from_directory(SHARED_EXAMPLES_DIR, '**/*.rb')

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
  raise 'No arguments[:url] supplied' if arguments[:url].nil?
  raise 'No arguments[:fixture] supplied' if arguments[:fixture].nil?

  stub_request(arguments[:method], arguments[:url].to_s).
    to_return(
      status: arguments[:status],
      body: File.new(arguments[:fixture])
    )
end

# The object must be given as we will mock the Kernel#` or
# Kernel#system (Kernel is a module)
#
#  system_method :
#  :` for `` or %x
#  :system for system()
def stub_system_command(object, command, return_value, system_method = :`)
  object.should_receive(system_method).with(command).and_return(return_value)
end
