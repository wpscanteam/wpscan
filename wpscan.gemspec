lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'wpscan/version'

Gem::Specification.new do |s|
  s.name                  = 'wpscan'
  s.version               = WPScan::VERSION
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.7'
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

  s.add_dependency 'cms_scanner', '~> 0.13.9'

  s.add_development_dependency 'bundler',             '>= 1.6'
  s.add_development_dependency 'memory_profiler',     '~> 1.0.0'
  s.add_development_dependency 'rake',                '~> 13.0'
  s.add_development_dependency 'rspec',               '~> 3.12.0'
  s.add_development_dependency 'rspec-its',           '~> 1.3.0'
  s.add_development_dependency 'rubocop',             '~> 1.59.0'
  s.add_development_dependency 'rubocop-performance', '~> 1.13.0'
  s.add_development_dependency 'simplecov',           '~> 0.21.0'
  s.add_development_dependency 'simplecov-lcov',      '~> 0.8.0'
  s.add_development_dependency 'stackprof',           '~> 0.2.12'
  s.add_development_dependency 'webmock',             '~> 3.19.1'
end
