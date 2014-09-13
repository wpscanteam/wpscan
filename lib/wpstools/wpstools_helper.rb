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
  puts 'Locally scan a wordpress installation for vulnerable files or shells'
  puts "ruby #{script_name} --check-local-vulnerable-files /var/www/wordpress/"
  puts
  puts 'See README for further information.'
  puts
end
