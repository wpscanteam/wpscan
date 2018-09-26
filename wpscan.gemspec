lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'wpscan/version'

Gem::Specification.new do |s|
  s.name                  = 'wpscan'
  s.version               = WPScan::VERSION
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3'
  s.authors               = ['WPScanTeam']
  s.date                  = Time.now.utc.strftime('%Y-%m-%d')
  s.email                 = ['team@wpscan.org']
  s.summary               = 'WPScan - WordPress Vulnerability Scanner'
  s.description           = 'WPScan is a black box WordPress vulnerability scanner.'
  s.homepage              = 'https://wpscan.org/'
  s.license               = 'Dual'

  s.files                 = Dir.glob('**/*').reject do |file|
    file =~ %r{^(?:
      spec\/.*
      |Gemfile
      |Rakefile
      |Dockerfile
      |coverage\/.*
      |.+\.gem
      |.+\.rbc
      |\.bundle
      |\.config
      |pkg\/.*
      |rdoc\/.*
      |Gemfile\.lock
      |.yardoc\/.*
      |_yardoc\/.*
      |doc\/.*
      |wpscan\.gemspec
      |\.rspec
      |\.gitignore
      |\.gitlab-ci.yml
      |\.rubocop.yml
      |\.travis.yml
      |\.ruby-gemset
      |\.ruby-version
      |\.dockerignore
      |.*\.sublime\-.*
      |bin\/wpscan-docker.*
      )$}x
  end
  s.test_files            = []
  s.executables           = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_path          = 'lib'

  s.add_dependency 'cms_scanner', '~> 0.0.40'

  # Already required by CMSScanner, so version restrictions loosen
  s.add_dependency 'activesupport', '~> 5.2'
  s.add_dependency 'yajl-ruby', '~> 1.3'

  s.add_development_dependency 'bundler',   '~> 1.6'
  s.add_development_dependency 'coveralls', '~> 0.8.0'
  s.add_development_dependency 'rake', '~> 12.3'
  s.add_development_dependency 'rspec', '~> 3.8.0'
  s.add_development_dependency 'rspec-its', '~> 1.2.0'
  s.add_development_dependency 'rubocop', '~> 0.59.2'
  s.add_development_dependency 'simplecov', '~> 0.16.1'
  s.add_development_dependency 'webmock', '~> 3.4.2'
end
