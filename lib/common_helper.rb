
LIB_DIR = File.dirname(__FILE__)
ROOT_DIR = File.expand_path(LIB_DIR + '/..') # expand_path is used to get "wpscan/" instead of "wpscan/lib/../"
DATA_DIR = ROOT_DIR + "/data"
CONF_DIR = ROOT_DIR + "/conf"
CACHE_DIR = ROOT_DIR + "/cache"
WPSCAN_LIB_DIR = LIB_DIR + "/wpscan"
WPSTOOLS_LIB_DIR = LIB_DIR + "/wpstools"
UPDATER_LIB_DIR = LIB_DIR + "/updater"

WPSCAN_VERSION = "2.0"

require "#{LIB_DIR}/environment"

# TODO : add an exclude pattern ?
def require_files_from_directory(absolute_dir_path, files_pattern = "*.rb")
  Dir[File.join(absolute_dir_path, files_pattern)].sort.each do |f|
    f = File.expand_path(f)
    require f
    #puts "require #{f}" # Used for debug
  end
end

# Add protocol
def add_http_protocol(url)
  if url !~ /^https?:/
    url = "http://#{url}"
  end
  url
end

def add_trailing_slash(url)
  url = "#{url}/" if url !~ /\/$/
  url
end

if RUBY_VERSION < "1.9"
  class Array
    # Fix for grep with symbols in ruby <= 1.8.7
    def _grep_(regexp)
      matches = []
      self.each do |value|
        value = value.to_s
        matches << value if value.match(regexp)
      end
      matches
    end
    alias_method :grep, :_grep_
  end
end

# loading the updater
require_files_from_directory(UPDATER_LIB_DIR)
@updater = UpdaterFactory.get_updater(ROOT_DIR)

if @updater
  REVISION = @updater.local_revision_number()
else
  REVISION = "NA"
end

# our 1337 banner
def banner()
  puts '____________________________________________________'
  puts " __          _______   _____                  "
  puts " \\ \\        / /  __ \\ / ____|                 "
  puts "  \\ \\  /\\  / /| |__) | (___   ___  __ _ _ __  "
  puts "   \\ \\/  \\/ / |  ___/ \\___ \\ / __|/ _` | '_ \\ "
  puts "    \\  /\\  /  | |     ____) | (__| (_| | | | |"
  puts "     \\/  \\/   |_|    |_____/ \\___|\\__,_|_| |_| v#{WPSCAN_VERSION}r#{REVISION}"
  puts
  puts "    WordPress Security Scanner by the WPScan Team"
  puts " Sponsored by the RandomStorm Open Source Initiative"
  puts '_____________________________________________________'
  puts
  if RUBY_VERSION < "1.9"
    puts "[WARNING] Ruby < 1.9 not officially supported, please upgrade."
    puts
  end
  if @updater.is_a? SvnUpdater
    # Uncomment the following lines when the git repo is up
    #puts "[WARNING] The SVN repository is DEPRECATED, use the GIT one"
    #puts
  end
end
