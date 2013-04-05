# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../common/common_helper')

require_files_from_directory(WPSTOOLS_LIB_DIR)
require_files_from_directory(WPSTOOLS_PLUGINS_DIR, '**/*.rb')

def usage
  script_name = $0
  puts
  puts '-h for further help.'
  puts
  puts 'Examples:'
  puts
  puts "- Generate a new 'most popular' plugin list, up to 150 pages ..."
  puts "ruby #{script_name} --generate-plugin-list 150"
  puts
  puts '- Generate a new full plugin list'
  puts "ruby #{script_name} --generate-full-plugin-list"
  puts
  puts "- Generate a new 'most popular' theme list, up to 150 pages ..."
  puts "ruby #{script_name} --generate-theme-list 150"
  puts
  puts '- Generate a new full theme list'
  puts "ruby #{script_name} --generate-full-theme-list"
  puts
  puts '- Generate all list'
  puts "ruby #{script_name} --generate-all"
  puts
  puts 'Locally scan a wordpress installation for vulnerable files or shells'
  puts "ruby #{script_name} --check-local-vulnerable-files /var/www/wordpress/"
  puts
  puts 'See README for further information.'
  puts
end
