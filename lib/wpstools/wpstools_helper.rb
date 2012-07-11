require File.expand_path(File.dirname(__FILE__) + '/../common_helper')

require_files_from_directory(WPSTOOLS_LIB_DIR)

def usage()
  script_name = $0
  puts
  puts "-h for further help."
  puts
  puts "Examples:"
  puts
  puts "- Generate a new 'most popular' plugin list, up to 150 pages ..."
  puts "ruby " + script_name + " --generate_plugin_list 150"
  puts
  puts "See README for further information."
  puts
end

def help()
  puts "Help :"
  puts
  puts "--help    | -h   This help screen."
  puts "--Verbose | -v   Verbose output."
  puts "--update  | -u   Update to the latest revision."
  puts "--generate_plugin_list [number of pages]  Generate a new data/plugins.txt file. (supply number of *pages* to parse, default : 150)"
  puts "--gpl  Alias for --generate_plugin_list"
  puts
end
