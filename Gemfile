source 'https://rubygems.org'

gem 'typhoeus', '>=1.0.0'
gem 'nokogiri', '>=1.7.0.1'
gem 'addressable'
gem 'yajl-ruby' # Better JSON parser regarding memory usage
gem 'terminal-table', '>=1.6.0'
gem 'ruby-progressbar', '>=1.6.0'

# needed from ruby 2.4 onwards
install_if -> { Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.4") } do
  gem 'xmlrpc'
end

group :test do
  gem 'webmock', '>=1.17.2'
  gem 'simplecov'
  gem 'rspec', '>=3.3.0'
  gem 'rspec-its'
end
