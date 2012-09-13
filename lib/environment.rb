begin
  # Standard libs
  require 'rubygems'
  require 'getoptlong'
  require 'uri'
  require 'time'
  require 'resolv'
  require 'xmlrpc/client'
  require 'digest/md5'
  require 'readline'
  require 'base64'
  require 'cgi'
  require 'rbconfig'
  require 'pp'
  # Third party libs
  require 'typhoeus'
  require 'json'
  require 'nokogiri'
  # Custom libs
  require "#{LIB_DIR}/browser"
  require "#{LIB_DIR}/cache_file_store"
rescue LoadError => e
  puts "[ERROR] #{e}"

  if missing_gem = e.to_s[%r{ -- ([^\s]+)}, 1]
    puts "[TIP] Try to run 'gem install #{missing_gem}' or 'gem install --user-install #{missing_gem}'. If you still get an error, Please see README file or https://github.com/wpscanteam/wpscan"
  end
  exit(1)
end

if Typhoeus::VERSION == "0.4.0"
  puts "Typhoeus 0.4.0 detected, please update the gem otherwise wpscan will not work correctly"
  exit(1)
end
