source 'https://rubygems.org'

gem 'typhoeus', '~>0.8.0'
gem 'nokogiri', '~>1.6.6.4'
gem 'addressable'
if defined?(JRUBY_VERSION)
  gem 'json'
else
  gem 'yajl-ruby' # Better JSON parser regarding memory usage
end
# TODO: update the below when terminal-table 1.5.3+ is released.
# (and delete the Terminal module in lib/common/hacks.rb)
gem 'terminal-table', '~>1.4.5'
gem 'ruby-progressbar', '>=1.6.0'

group :test do
  gem 'webmock', '>=1.17.2'
  gem 'simplecov'
  gem 'rspec', '>=3.3.0'
  gem 'rspec-its'
end
