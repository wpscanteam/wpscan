# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'simplecov' # More config is defined in ./.simplecov
require 'rspec/its'
require 'webmock/rspec'

# See http://betterspecs.org/
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # For --only-failures / --next-failure
  config.example_status_persistence_file_path = '/tmp/rspec_examples.txt'
end

def redefine_constant(constant, value)
  WPScan.send(:remove_const, constant)
  WPScan.const_set(constant, value)
end

# Dynamic Finders Helpers
def df_expected_all
  YAML.safe_load(File.read(DYNAMIC_FINDERS_FIXTURES.join('expected.yml')))
end

def df_tested_class_constant(type, finder_class, slug = nil)
  if slug
    "WPScan::Finders::#{type}::#{classify_slug(slug)}::#{classify_slug(finder_class)}".constantize
  else
    "WPScan::Finders::#{type}::#{classify_slug(finder_class)}".constantize
  end
end

def df_stubbed_response(fixture, finder_super_class)
  if finder_super_class == 'HeaderPattern'
    { headers: JSON.parse(File.read(fixture)) }
  else
    { body: File.read(fixture, mode: 'rb') }
  end
end

def vuln_api_data_for(path)
  JSON.parse(File.read(FIXTURES.join('db', 'vuln_api', "#{path}.json")))
end

require 'wpscan'
require 'shared_examples'

def rspec_parsed_options(args)
  controllers = WPScan::Controller.constants.reject { |c| c == :Base }.reduce(WPScan::Controllers.new) do |a, sym|
    a << WPScan::Controller.const_get(sym).new
  end

  controllers.option_parser.results(args.split(' '))
end

# TODO: remove when https://github.com/bblimke/webmock/issues/552 fixed
#       Also remove from CMSScanner
# rubocop:disable all
module WebMock
  module HttpLibAdapters
    class TyphoeusAdapter < HttpLibAdapter
      def self.effective_url(effective_uri)
        effective_uri.port = nil if effective_uri.scheme == 'http' && effective_uri.port == 80
        effective_uri.port = nil if effective_uri.scheme == 'https' && effective_uri.port == 443

        effective_uri.to_s
      end

      def self.generate_typhoeus_response(request_signature, webmock_response)
        response = if webmock_response.should_timeout
                     ::Typhoeus::Response.new(
                       code: 0,
                       status_message: '',
                       body: '',
                       headers: {},
                       return_code: :operation_timedout
                     )
                   else
                     ::Typhoeus::Response.new(
                       code: webmock_response.status[0],
                       status_message: webmock_response.status[1],
                       body: webmock_response.body,
                       headers: webmock_response.headers,
                       effective_url: effective_url(request_signature.uri)
                     )
        end
        response.mock = :webmock
        response
      end
    end
  end
end
# rubocop:enable all

SPECS                    = Pathname.new(__FILE__).dirname
FIXTURES                 = SPECS.join('fixtures')
FINDERS_FIXTURES         = FIXTURES.join('finders')
DYNAMIC_FINDERS_FIXTURES = FIXTURES.join('dynamic_finders')
ERROR_404_URL_PATTERN    = %r{/[a-z\d]{7}\.html$}.freeze

redefine_constant(:DB_DIR, FIXTURES.join('db'))
