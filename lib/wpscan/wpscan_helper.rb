# encoding: UTF-8

require File.expand_path(File.join(__dir__, '..', 'common', 'common_helper'))

require_files_from_directory(WPSCAN_LIB_DIR, '**/*.rb')

# wpscan usage
def usage
  script_name = $0
  puts
  puts 'Examples :'
  puts
  puts '-Further help ...'
  puts "ruby #{script_name} --help"
  puts
  puts "-Do 'non-intrusive' checks ..."
  puts "ruby #{script_name} --url www.example.com"
  puts
  puts '-Do wordlist password brute force on enumerated users using 50 threads ...'
  puts "ruby #{script_name} --url www.example.com --wordlist darkc0de.lst --threads 50"
  puts
  puts "-Do wordlist password brute force on the 'admin' username only ..."
  puts "ruby #{script_name} --url www.example.com --wordlist darkc0de.lst --username admin"
  puts
  puts '-Enumerate installed plugins ...'
  puts "ruby #{script_name} --url www.example.com --enumerate p"
  puts
  puts '-Enumerate installed themes ...'
  puts "ruby #{script_name} --url www.example.com --enumerate t"
  puts
  puts '-Enumerate users ...'
  puts "ruby #{script_name} --url www.example.com --enumerate u"
  puts
  puts '-Enumerate installed timthumbs ...'
  puts "ruby #{script_name} --url www.example.com --enumerate tt"
  puts
  puts '-Use a HTTP proxy ...'
  puts "ruby #{script_name} --url www.example.com --proxy 127.0.0.1:8118"
  puts
  puts '-Use a SOCKS5 proxy ... (cURL >= v7.21.7 needed)'
  puts "ruby #{script_name} --url www.example.com --proxy socks5://127.0.0.1:9000"
  puts
  puts '-Use custom content directory ...'
  puts "ruby #{script_name} -u www.example.com --wp-content-dir custom-content"
  puts
  puts '-Use custom plugins directory ...'
  puts "ruby #{script_name} -u www.example.com --wp-plugins-dir wp-content/custom-plugins"
  puts
  puts '-Update the DB ...'
  puts "ruby #{script_name} --update"
  puts
  puts '-Debug output ...'
  puts "ruby #{script_name} --url www.example.com --debug-output 2>debug.log"
  puts
  puts 'See README for further information.'
  puts
end

# command help
def help
  puts 'Help :'
  puts
  puts 'Some values are settable in a config file, see the example.conf.json'
  puts
  puts '--update                            Update the database to the latest version.'
  puts '--url       | -u <target url>       The WordPress URL/domain to scan.'
  puts '--force     | -f                    Forces WPScan to not check if the remote site is running WordPress.'
  puts '--enumerate | -e [option(s)]        Enumeration.'
  puts '  option :'
  puts '    u        usernames from id 1 to 10'
  puts '    u[10-20] usernames from id 10 to 20 (you must write [] chars)'
  puts '    p        plugins'
  puts '    vp       only vulnerable plugins'
  puts '    ap       all plugins (can take a long time)'
  puts '    tt       timthumbs'
  puts '    t        themes'
  puts '    vt       only vulnerable themes'
  puts '    at       all themes (can take a long time)'
  puts '  Multiple values are allowed : "-e tt,p" will enumerate timthumbs and plugins'
  puts '  If no option is supplied, the default is "vt,tt,u,vp"'
  puts
  puts '--exclude-content-based "<regexp or string>"'
  puts '                                    Used with the enumeration option, will exclude all occurrences based on the regexp or string supplied.'
  puts '                                    You do not need to provide the regexp delimiters, but you must write the quotes (simple or double).'
  puts '--config-file  | -c <config file>   Use the specified config file, see the example.conf.json.'
  puts '--user-agent   | -a <User-Agent>    Use the specified User-Agent.'
  puts '--cookie <string>                   String to read cookies from.'
  puts '--random-agent | -r                 Use a random User-Agent.'
  puts '--follow-redirection                If the target url has a redirection, it will be followed without asking if you wanted to do so or not'
  puts '--batch                             Never ask for user input, use the default behaviour.'
  puts '--no-color                          Do not use colors in the output.'
  puts '--log [filename]                    Creates a log.txt file with WPScan\'s output if no filename is supplied. Otherwise the filename is used for logging.'
  puts '--no-banner                         Prevents the WPScan banner from being displayed.'
  puts '--disable-accept-header             Prevents WPScan sending the Accept HTTP header.'
  puts '--disable-referer                   Prevents setting the Referer header.'
  puts '--disable-tls-checks                Disables SSL/TLS certificate verification.'
  puts '--wp-content-dir <wp content dir>   WPScan try to find the content directory (ie wp-content) by scanning the index page, however you can specify it.'
  puts '                                    Subdirectories are allowed.'
  puts '--wp-plugins-dir <wp plugins dir>   Same thing than --wp-content-dir but for the plugins directory.'
  puts '                                    If not supplied, WPScan will use wp-content-dir/plugins. Subdirectories are allowed'
  puts '--proxy <[protocol://]host:port>    Supply a proxy. HTTP, SOCKS4 SOCKS4A and SOCKS5 are supported.'
  puts '                                    If no protocol is given (format host:port), HTTP will be used.'
  puts '--proxy-auth <username:password>    Supply the proxy login credentials.'
  puts '--basic-auth <username:password>    Set the HTTP Basic authentication.'
  puts '--wordlist | -w <wordlist>          Supply a wordlist for the password brute forcer.'
  puts '--username | -U <username>          Only brute force the supplied username.'
  puts '--usernames     <path-to-file>      Only brute force the usernames from the file.'
  puts '--cache-dir       <cache-directory> Set the cache directory.'
  puts '--cache-ttl       <cache-ttl>       Typhoeus cache TTL.'
  puts '--request-timeout <request-timeout> Request Timeout.'
  puts '--connect-timeout <connect-timeout> Connect Timeout.'
  puts '--threads  | -t <number of threads> The number of threads to use when multi-threading requests.'
  puts '--max-threads     <max-threads>     Maximum Threads.'
  puts '--throttle        <milliseconds>    Milliseconds to wait before doing another web request. If used, the --threads should be set to 1.'
  puts '--help     | -h                     This help screen.'
  puts '--verbose  | -v                     Verbose output.'
  puts '--version                           Output the current version and exit.'
  puts
end

# Hook to check if the target if down during the scan
# And have the number of requests performed to display at the end of the scan
# The target is considered down after 30 requests with status = 0
down                 = 0
@total_requests_done = 0

Typhoeus.on_complete do |response|
  next if response.cached?

  down += 1 if response.code == 0
  @total_requests_done += 1

  fail 'The target seems to be down' if down >= 30

  next unless Browser.instance.throttle > 0

  sleep(Browser.instance.throttle)
end
