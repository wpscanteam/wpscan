lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'wpscan/version'

Gem::Specification.new do |s|
  s.name                  = 'wpscan'
  s.version               = WPScan::VERSION
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.3'
  s.authors               = ['WPScanTeam']
  s.email                 = ['contact@wpscan.com']
  s.summary               = 'WPScan - WordPress Vulnerability Scanner'
  s.description           = 'WPScan is a black box WordPress vulnerability scanner.'
  s.homepage              = 'https://wpscan.com/wordpress-security-scanner'
  s.license               = 'Dual'

  s.files                 = Dir.glob('lib/**/*') + Dir.glob('app/**/*') + %w[LICENSE README.md]
  s.test_files            = []
  s.executables           = ['wpscan']
  s.require_paths         = ['lib']

  s.add_dependency 'activesupport',        '>= 7.1', '< 8.2'
  s.add_dependency 'addressable',          '~> 2.9'
  s.add_dependency 'ethon',                '>= 0.14', '< 0.19'
  s.add_dependency 'get_process_mem',      '>= 0.2.5', '< 1.1.0'
  s.add_dependency 'nokogiri',             '~> 1.16'
  s.add_dependency 'public_suffix',        '>= 4.0.3', '< 7.1'
  s.add_dependency 'ruby-progressbar',     '>= 1.10', '< 1.14'
  s.add_dependency 'sys-proctable',        '>= 1.2.2', '< 1.4.0'
  s.add_dependency 'typhoeus',             '>= 1.3', '< 1.5'
  s.add_dependency 'xmlrpc',               '~> 0.3'
  s.add_dependency 'yajl-ruby',            '~> 1.4.1'
  s.add_dependency 'ostruct',              '~> 0.6'
  s.add_dependency 'fiddle',               '~> 1.1'

  s.add_development_dependency 'bundler',             '>= 1.6'
  s.add_development_dependency 'memory_profiler',     '~> 1.1.0'
  s.add_development_dependency 'rake',                '~> 13.0'
  s.add_development_dependency 'rspec',               '~> 3.13.0'
  s.add_development_dependency 'rspec-its',           '~> 2.0.0'
  s.add_development_dependency 'rubocop',             '~> 1.82'
  s.add_development_dependency 'rubocop-performance', '~> 1.26'
  s.add_development_dependency 'simplecov',           '~> 0.22.0'
  s.add_development_dependency 'simplecov-lcov',      '~> 0.9.0'
  s.add_development_dependency 'stackprof',           '~> 0.2.12'
  s.add_development_dependency 'webmock',             '~> 3.26.2'
end
