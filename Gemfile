source 'https://rubygems.org'

gem 'typhoeus', '>=1.1.2'
gem 'nokogiri', '>=1.7.0.1'
gem 'addressable', '>=2.5.0'
gem 'yajl-ruby', '>=1.3.0' # Better JSON parser regarding memory usage
gem 'terminal-table', '>=1.6.0'
gem 'ruby-progressbar', '>=1.8.1'

# needed from ruby 2.4 onwards
install_if -> { Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.4") } do
  gem 'xmlrpc', :require => false
end

group :test do
  gem 'webmock'
  gem 'simplecov'
  gem 'rspec'
  gem 'rspec-its'
end
