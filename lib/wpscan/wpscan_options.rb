#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

class WpscanOptions

  ACCESSOR_OPTIONS = [
      :enumerate_plugins,
      :enumerate_only_vulnerable_plugins,
      :enumerate_themes,
      :enumerate_only_vulnerable_themes,
      :enumerate_timthumbs,
      :enumerate_usernames,
      :enumerate_usernames_range,
      :proxy,
      :threads,
      :url,
      :wordlist,
      :force,
      :update,
      :verbose,
      :username,
      :password,
      :follow_redirection,
      :wp_content_dir,
      :wp_plugins_dir,
      :help,
      :config_file
  ]

  attr_accessor *ACCESSOR_OPTIONS

  def initialize

  end

  def url=(url)
    raise "Empty URL given" if !url

    @url = URI.parse(add_http_protocol(url)).to_s
  end

  def threads=(threads)
    @threads = threads.is_a?(Integer) ? threads : threads.to_i
  end

  def wordlist=(wordlist)
    if File.exists?(wordlist)
      @wordlist = wordlist
    else
      raise "The file #{wordlist} does not exist"
    end
  end

  def proxy=(proxy)
    if proxy.index(':') == nil
      raise "Invalid proxy format. Should be host:port."
    else
      @proxy = proxy
    end
  end

  def enumerate_plugins=(enumerate_plugins)
    if enumerate_plugins === true and @enumerate_only_vulnerable_plugins === true
      raise "You can't enumerate plugins and only vulnerable plugins at the same time, please choose only one"
    else
      @enumerate_plugins = enumerate_plugins
    end
  end

  def enumerate_only_vulnerable_plugins=(enumerate_only_vulnerable_plugins)
    if enumerate_only_vulnerable_plugins === true and @enumerate_plugins === true
      raise "You can't enumerate plugins and only vulnerable plugins at the same time, please choose only one"
    else
      @enumerate_only_vulnerable_plugins = enumerate_only_vulnerable_plugins
    end
  end

  def enumerate_themes=(enumerate_themes)
    if enumerate_themes === true and @enumerate_only_vulnerable_themes === true
      raise "You can't enumerate themes and only vulnerable themes at the same time, please choose only one"
    else
      @enumerate_themes = enumerate_themes
    end
  end

  def enumerate_only_vulnerable_themes=(enumerate_only_vulnerable_themes)
    if enumerate_only_vulnerable_themes === true and @enumerate_themes === true
      raise "You can't enumerate themes and only vulnerable themes at the same time, please choose only one"
    else
      @enumerate_only_vulnerable_themes = enumerate_only_vulnerable_themes
    end
  end

  def has_options?
    !to_h.empty?
  end

  # return Hash
  def to_h
    options = {}

    ACCESSOR_OPTIONS.each do |option|
      instance_variable = instance_variable_get("@#{option}")

      unless instance_variable.nil?
        options[:"#{option}"] = instance_variable
      end
    end
    options
  end

  # Will load the options from ARGV
  # return WpscanOptions
  def self.load_from_arguments
    wpscan_options = WpscanOptions.new

    if ARGV.length > 0
      WpscanOptions.get_opt_long.each do |opt, arg|
        wpscan_options.set_option_from_cli(opt, arg)
      end
    end

    wpscan_options
  end

  # string cli_option : --url, -u, --proxy etc
  # string cli_value : the option value
  def set_option_from_cli(cli_option, cli_value)

    if WpscanOptions.is_long_option?(cli_option)
      self.send(
          WpscanOptions.option_to_instance_variable_setter(cli_option),
          cli_value
      )
    elsif cli_option === "--enumerate" # Special cases
                                       # Default value if no argument is given
      cli_value = "T!tup!" if cli_value.length == 0

      enumerate_options_from_string(cli_value)
    else
      raise "Unknow option : #{cli_option} with value #{cli_value}"
    end
  end

  # Will set enumerate_* from the string value
  # IE : if value = p! => :enumerate_only_vulnerable_plugins will be set to true
  # multiple enumeration are possible : 'up' => :enumerate_usernames and :enumerate_plugins
  # Special case for usernames, a range is possible : u[1-10] will enumerate usernames from 1 to 10
  def enumerate_options_from_string(value)
    # Usage of self is mandatory because there are overridden setters
    self.enumerate_only_vulnerable_plugins = true if value =~ /p!/

    self.enumerate_plugins = true if value =~ /p(?!!)/

    @enumerate_timthumbs = true if value =~ /t/

    self.enumerate_only_vulnerable_themes = true if value =~ /T!/

    self.enumerate_themes = true if value =~ /T(?!!)/

    if value =~ /u/
      @enumerate_usernames = true
      # Check for usernames range
      matches = %r{\[([\d]+)-([\d]+)\]}.match(value)
      if matches
        @enumerate_usernames_range = (matches[1].to_i..matches[2].to_i)
      end
    end

  end

  protected
  # Even if a short option is given (IE : -u), the long one will be returned (IE : --url)
  def self.get_opt_long
    GetoptLong.new(
        ["--url", "-u", GetoptLong::REQUIRED_ARGUMENT],
        ["--enumerate", "-e", GetoptLong::OPTIONAL_ARGUMENT],
        ["--username", "-U", GetoptLong::REQUIRED_ARGUMENT],
        ["--wordlist", "-w", GetoptLong::REQUIRED_ARGUMENT],
        ["--threads", "-t", GetoptLong::REQUIRED_ARGUMENT],
        ["--force", "-f", GetoptLong::NO_ARGUMENT],
        ["--help", "-h", GetoptLong::NO_ARGUMENT],
        ["--verbose", "-v", GetoptLong::NO_ARGUMENT],
        ["--proxy", GetoptLong::OPTIONAL_ARGUMENT],
        ["--update", GetoptLong::NO_ARGUMENT],
        ["--follow-redirection", GetoptLong::NO_ARGUMENT],
        ["--wp-content-dir", GetoptLong::REQUIRED_ARGUMENT],
        ["--wp-plugins-dir", GetoptLong::REQUIRED_ARGUMENT],
        ["--config-file", "-c", GetoptLong::REQUIRED_ARGUMENT]
    )
  end

  def self.is_long_option?(option)
    ACCESSOR_OPTIONS.include?(:"#{WpscanOptions.clean_option(option)}")
  end

  # Will removed the '-' or '--' chars at the beginning of option
  # and replace any remaining '-' by '_'
  #
  # param string option
  # return string
  def self.clean_option(option)
    cleaned_option = option.gsub(/^--?/, '')
    cleaned_option.gsub(/-/, '_')
  end

  def self.option_to_instance_variable_setter(option)
    cleaned_option = WpscanOptions.clean_option(option)
    option_syms = ACCESSOR_OPTIONS.grep(%r{^#{cleaned_option}})

    option_syms.length == 1 ? :"#{option_syms.at(0)}=" : nil
  end

end
