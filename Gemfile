source "https://rubygems.org"

# Seg fault in Typhoeus 0.6.3 (and ethon > 0.5.11) with rspec
gem "typhoeus", ">=0.6.3"
gem "nokogiri"
gem "json"
gem "terminal-table"
gem "ruby-progressbar", ">=1.2.0"

group :test do
  gem "webmock", ">=1.9.3"
  gem "simplecov"
  gem "rspec", :require => "spec"
  gem "rspec-mocks", "<=2.14.2" # 2.14.3 just messed around :/
end
