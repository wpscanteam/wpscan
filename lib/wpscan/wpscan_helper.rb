require File.expand_path(File.dirname(__FILE__) + '/../common_helper')

require_files_from_directory(WPSCAN_LIB_DIR, "**/*.rb")

# wpscan usage
def usage()
  script_name = $0
  puts "--help or -h for further help."
  puts
  puts "Examples :"
  puts
  puts "-Do 'non-intrusive' checks ..."
  puts "ruby #{script_name} --url www.example.com"
  puts
  puts "-Do wordlist password brute force on enumerated users using 50 threads ..."
  puts "ruby #{script_name} --url www.example.com --wordlist darkc0de.lst --threads 50"
  puts
  puts "-Do wordlist password brute force on the 'admin' username only ..."
  puts "ruby #{script_name} --url www.example.com --wordlist darkc0de.lst --username admin"
  puts
  puts "-Enumerate instaled plugins ..."
  puts "ruby #{script_name} --url www.example.com --enumerate p"
  puts
  puts "-Use a proxy ..."
  puts "ruby #{script_name} --url www.example.com --proxy 127.0.0.1:8118"
  puts
  puts "-Use custom content directory ..."
  puts "ruby #{script_name} -u www.example.com --wp-content-dir custom-content"
  puts
  puts "-Update ..."
  puts "ruby #{script_name} --update"
  puts
  puts "See README for further information."
  puts
end

# command help
def help()
  puts "Help :"
  puts
  puts "Some values are settable in conf/browser.conf.json :"
  puts "  user-agent, proxy, threads, cache timeout and request timeout"
  puts
  puts "--update   Update to the latest revision"
  puts "--url   | -u <target url>  The WordPress URL/domain to scan."
  puts "--force | -f Forces WPScan to not check if the remote site is running WordPress."
  puts "--enumerate | -e [option(s)]  Enumeration."
  puts "  option :"
  puts "    u        usernames from id 1 to 10"
  puts "    u[10-20] usernames from id 10 to 20 (you must write [] chars)"
  puts "    p        plugins"
  puts "    p!       only vulnerable plugins"
  puts "    t        timthumbs"
  puts "  Multiple values are allowed : '-e tp' will enumerate timthumbs and plugins"
  puts "  If no option is supplied, the default is 'tup!'"
  puts
  puts "--follow-redirection  If the target url has a redirection, it will be followed without asking if you wanted to do so or not"
  puts "--wp-content-dir <wp content dir>  WPScan try to find the content directory (ie wp-content) by scanning the index page, however you can specified it. Subdirectories are allowed"
  puts "--wp-plugins-dir <wp plugins dir>  Same thing than --wp-content-dir but for the plugins directory. If not supplied, WPScan will use wp-content-dir/plugins. Subdirectories are allowed"
  puts "--proxy  Supply a proxy in the format host:port (will override the one from conf/browser.conf.json)"
  puts "--wordlist | -w <wordlist>  Supply a wordlist for the password bruter and do the brute."
  puts "--threads  | -t <number of threads>  The number of threads to use when multi-threading requests. (will override the value from conf/browser.conf.json)"
  puts "--username | -U <username>  Only brute force the supplied username."
  puts "--help     | -h This help screen."
  puts "--verbose  | -v Verbose output."
  puts
end
