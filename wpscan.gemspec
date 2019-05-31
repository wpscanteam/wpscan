lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'wpscan/version'

Gem::Specification.new do |s|
  s.name                  = 'wpscan'
  s.version               = WPScan::VERSION
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4'
  s.authors               = ['WPScanTeam']
  s.date                  = Time.now.utc.strftime('%Y-%m-%d')
  s.email                 = ['team@wpscan.org']
  s.summary               = 'WPScan - WordPress Vulnerability Scanner'
  s.description           = 'WPScan is a black box WordPress vulnerability scanner.'
  s.homepage              = 'https://wpscan.org/'
  s.license               = 'Dual'

  s.files                 = Dir.glob('lib/**/*') + Dir.glob('app/**/*') + %w[LICENSE README.md]
  s.test_files            = []
  s.executables           = ['wpscan']
  s.require_paths         = ['lib']

  s.add_dependency 'cms_scanner', '~> 0.5.1'

  s.add_development_dependency 'bundler',             '>= 1.6'
  s.add_development_dependency 'coveralls',           '~> 0.8.0'
  s.add_development_dependency 'memory_profiler',     '~> 0.9.13'
  s.add_development_dependency 'rake',                '~> 12.3'
  s.add_development_dependency 'rspec',               '~> 3.8.0'
  s.add_development_dependency 'rspec-its',           '~> 1.3.0'
  s.add_development_dependency 'rubocop',             '~> 0.71.0'
  s.add_development_dependency 'rubocop-performance', '~> 1.3.0'
  s.add_development_dependency 'simplecov',           '~> 0.16.1'
  s.add_development_dependency 'stackprof',           '~> 0.2.12'
  s.add_development_dependency 'webmock',             '~> 3.5.1'
end
