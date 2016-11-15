#!/usr/bin/env ruby
# encoding: UTF-8

require File.expand_path(File.join(__dir__, '..', 'lib', 'wpscan', 'wpscan_helper'))

wordpress_json = json(WORDPRESSES_FILE)
plugins_json = json(PLUGINS_FILE)
themes_json = json(THEMES_FILE)

puts 'WPScan Database Statistics:'
puts "* Total tracked wordpresses: #{wordpress_json.count}"
puts "* Total tracked plugins: #{plugins_json.count}"
puts "* Total tracked themes: #{themes_json.count}"
puts "* Total vulnerable wordpresses: #{wordpress_json.select { |item| !wordpress_json[item]['vulnerabilities'].empty? }.count}"
puts "* Total vulnerable plugins: #{plugins_json.select { |item| !plugins_json[item]['vulnerabilities'].empty? }.count}"
puts "* Total vulnerable themes: #{themes_json.select { |item| !themes_json[item]['vulnerabilities'].empty? }.count}"
puts "* Total wordpress vulnerabilities: #{wordpress_json.map {|k,v| v['vulnerabilities'].count}.inject(:+)}"
puts "* Total plugin vulnerabilities: #{plugins_json.map {|k,v| v['vulnerabilities'].count}.inject(:+)}"
puts "* Total theme vulnerabilities: #{themes_json.map {|k,v| v['vulnerabilities'].count}.inject(:+)}"
