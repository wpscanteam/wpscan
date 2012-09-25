#!/usr/bin/env ruby

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

$: << '.'
require File.dirname(__FILE__) +'/lib/wpscan/wpscan_helper'

banner()

begin
  wpscan_options = WpscanOptions.load_from_arguments

  unless wpscan_options.has_options?
    raise "No argument supplied\n#{usage()}"
  end

  if wpscan_options.help
    help()
    exit
  end

  # Check for updates
  if wpscan_options.update
    unless @updater.nil?
      puts @updater.update()
    else
      puts "Svn / Git not installed, or wpscan has not been installed with one of them."
      puts "Update aborted"
    end
    exit(1)
  end

  wp_target = WpTarget.new(wpscan_options.url, wpscan_options.to_h)

  # Remote website up?
  unless wp_target.is_online?
    raise "The WordPress URL supplied '#{wp_target.uri}' seems to be down."
  end

  redirection = wp_target.redirection
  if redirection
    if wpscan_options.follow_redirection
      puts "Following redirection #{redirection}"
      puts
    else
      puts "The remote host tried to redirect us to #{redirection}"
      puts "Do you want follow the redirection ? [y/n]"
    end

    if wpscan_options.follow_redirection or Readline.readline =~ /^y/i
      wpscan_options.url = redirection
      wp_target = WpTarget.new(redirection, wpscan_options.to_h)
    else
      puts "Scan aborted"
      exit
    end
  end

  # Remote website is wordpress?
  unless wpscan_options.force
    unless wp_target.is_wordpress?
      raise "The remote website is up, but does not seem to be running WordPress."
    end
  end

  unless wp_target.wp_content_dir
    raise "The wp_content_dir has not been found, please supply it with --wp-content-dir"
  end

  unless wp_target.wp_plugins_dir_exists?
    puts "The plugins directory '#{wp_target.wp_plugins_dir}' does not exist."
    puts "You can specify one per command line option (don't forget to include the wp-content directory if needed)"
    puts "Continue? [y/n]"
    unless Readline.readline =~ /^y/i
      exit
    end
  end

  # Output runtime data
  start_time = Time.now
  puts "| URL: #{wp_target.url}"
  puts "| Started on #{start_time.asctime}"
  puts

  wp_theme = wp_target.theme
  if wp_theme
    # Theme version is handled in wp_item.to_s
    puts green("[+]") + " The WordPress theme in use is #{wp_theme}"

    theme_vulnerabilities = wp_theme.vulnerabilities
    unless theme_vulnerabilities.empty?
      puts red("[!]") + " We have identified #{theme_vulnerabilities.size} vulnerabilities for this theme :"
      theme_vulnerabilities.each do |vulnerability|
        puts
        puts " | " + red("* Title: #{vulnerability.title}")
        puts " | " + red("* Reference: #{vulnerability.reference}")
      end
      puts
    end
  end

  if wp_target.has_readme?
    puts red("[!]") + " The WordPress '#{wp_target.readme_url}' file exists"
  end

  if wp_target.has_full_path_disclosure?
    puts red("[!]") + " Full Path Disclosure (FPD) in '#{wp_target.full_path_disclosure_url}'"
  end

  if wp_target.has_debug_log?
    puts red("[!]") + " Debug log file found : #{wp_target.debug_log_url}"
  end

  wp_target.config_backup.each do |file_url|
    puts red("[!] A wp-config.php backup file has been found '#{file_url}'")
  end

  if wp_target.search_replace_db_2_exists?
    puts red("[!] searchreplacedb2.php has been found '#{wp_target.search_replace_db_2_url}'")
  end

  if wp_target.is_multisite?
    puts green("[+]") + " This site seems to be a multisite (http://codex.wordpress.org/Glossary#Multisite)"
  end

  if wp_target.registration_enabled?
    puts green("[+]") + " User registration is enabled"
  end

  if wp_target.has_malwares?
    malwares = wp_target.malwares
    puts red("[!]") + " #{malwares.size} malware(s) found :"

    malwares.each do |malware_url|
      puts
      puts " | " + red("#{malware_url}")
    end
    puts
  end

  wp_version = wp_target.version
  if wp_version
    puts green("[+]") + " WordPress version #{wp_version.number} identified from #{wp_version.discovery_method}"

    version_vulnerabilities = wp_version.vulnerabilities

    unless version_vulnerabilities.empty?
      puts
      puts red("[!]") + " We have identified #{version_vulnerabilities.size} vulnerabilities from the version number :"
      version_vulnerabilities.each do |vulnerability|
        puts
        puts " | " + red("* Title: #{vulnerability.title}")
        puts " | " + red("* Reference: #{vulnerability.reference}")
      end
    end
  end

  if wpscan_options.enumerate_plugins == nil and wpscan_options.enumerate_only_vulnerable_plugins == nil
    puts
    puts green("[+]") + " Enumerating plugins from passive detection ... "

    plugins = wp_target.plugins_from_passive_detection(:base_url => wp_target.uri, :wp_content_dir => wp_target.wp_content_dir)
    unless plugins.empty?
      puts "#{plugins.size} found :"

      plugins.each do |plugin|
        puts
        puts " | Name: #{plugin.name}"
        puts " | Location: #{plugin.get_full_url}"

        plugin.vulnerabilities.each do |vulnerability|
          puts " |"
          puts " | " + red("[!] #{vulnerability.title}")
          puts " | " + red("* Reference: #{vulnerability.reference}")
        end
      end
    else
      puts "No plugins found :("
    end
  end

  # Enumerate the installed plugins
  if wpscan_options.enumerate_plugins or wpscan_options.enumerate_only_vulnerable_plugins
    puts
    puts green("[+]") + " Enumerating installed plugins #{'(only vulnerable ones)' if wpscan_options.enumerate_only_vulnerable_plugins} ..."
    puts

    options = {}
    options[:base_url]              = wp_target.uri
    options[:only_vulnerable_ones]  = wpscan_options.enumerate_only_vulnerable_plugins || false
    options[:show_progress_bar]     = true
    options[:wp_content_dir]        = wp_target.wp_content_dir
    options[:error_404_hash]        = wp_target.error_404_hash
    options[:wp_plugins_dir]        = wp_target.wp_plugins_dir

    plugins = wp_target.plugins_from_aggressive_detection(options)
    unless plugins.empty?
      puts
      puts
      puts green("[+]") + " We found #{plugins.size.to_s} plugins:"

      plugins.each do |plugin|
        puts
        puts " | Name: #{plugin}" #this will also output the version number if detected
        puts " | Location: #{plugin.get_url_without_filename}"
        puts " | Directory listing enabled: Yes" if plugin.directory_listing?
        puts " | Readme: #{plugin.readme_url}" if plugin.has_readme?
        puts " | Changelog: #{plugin.changelog_url}" if plugin.has_changelog?

        plugin.vulnerabilities.each do |vulnerability|
          #vulnerability['vulnerability'][0]['uri'] == nil ? "" : uri = vulnerability['vulnerability'][0]['uri'] # uri
          #vulnerability['vulnerability'][0]['postdata'] == nil ? "" : postdata = CGI.unescapeHTML(vulnerability['vulnerability'][0]['postdata']) # postdata

          puts " |"
          puts " | " + red("[!] #{vulnerability.title}")
          puts " | " + red("* Reference: #{vulnerability.reference}")

          # This has been commented out as MSF are moving from
          # XML-RPC to MessagePack.
          # I need to get to grips with the new way of communicating
          # with MSF and implement new code.

          # check if vuln is exploitable
          #Exploit.new(url, type, uri, postdata.to_s, use_proxy, proxy_addr, proxy_port)
        end

        if plugin.error_log?
          puts " | " + red("[!]") + " A WordPress error_log file has been found : #{plugin.error_log_url}"
        end
      end
    else
      puts
      puts "No plugins found :("
    end
  end

  # Enumerate installed themes
  if wpscan_options.enumerate_themes or wpscan_options.enumerate_only_vulnerable_themes
    puts
    puts green("[+]") + " Enumerating installed themes #{'(only vulnerable ones)' if wpscan_options.enumerate_only_vulnerable_themes} ..."
    puts

    options = {}
    options[:base_url]              = wp_target.uri
    options[:only_vulnerable_ones]  = wpscan_options.enumerate_only_vulnerable_themes || false
    options[:show_progress_bar]     = true
    options[:wp_content_dir]        = wp_target.wp_content_dir
    options[:error_404_hash]        = wp_target.error_404_hash

    themes = wp_target.themes_from_aggressive_detection(options)
    unless themes.empty?
      puts
      puts
      puts green("[+]") + " We found #{themes.size.to_s} themes:"

      themes.each do |theme|
        puts
        puts " | Name: #{theme}" #this will also output the version number if detected
        puts " | Location: #{theme.get_url_without_filename}"
        puts " | Directory listing enabled: Yes" if theme.directory_listing?
        puts " | Readme: #{theme.readme_url}" if theme.has_readme?
        puts " | Changelog: #{theme.changelog_url}" if theme.has_changelog?

        theme.vulnerabilities.each do |vulnerability|
          puts " |"
          puts " | " + red("[!] #{vulnerability.title}")
          puts " | " + red("* Reference: #{vulnerability.reference}")

          # This has been commented out as MSF are moving from
          # XML-RPC to MessagePack.
          # I need to get to grips with the new way of communicating
          # with MSF and implement new code.

          # check if vuln is exploitable
          #Exploit.new(url, type, uri, postdata.to_s, use_proxy, proxy_addr, proxy_port)
        end
      end
    else
      puts
      puts "No themes found :("
    end
  end

  if wpscan_options.enumerate_timthumbs
    puts
    puts green("[+]") + " Enumerating timthumb files ..."
    puts

    options = {}
    options[:base_url]          = wp_target.uri
    options[:show_progress_bar] = true
    options[:wp_content_dir]    = wp_target.wp_content_dir
    options[:error_404_hash]    = wp_target.error_404_hash

    theme_name = wp_theme ? wp_theme.name : nil
    if wp_target.has_timthumbs?(theme_name, options)
      timthumbs = wp_target.timthumbs

      puts
      puts green("[+]") + " We found #{timthumbs.size.to_s} timthumb file/s :"
      puts

      timthumbs.each do |t|
        puts " | " + red("[!]") + " #{t.get_full_url.to_s}"
      end
      puts
      puts red(" * Reference: http://www.exploit-db.com/exploits/17602/")
    else
      puts
      puts "No timthumb files found :("
    end
  end

  # If we haven't been supplied a username, enumerate them...
  if !wpscan_options.username and wpscan_options.wordlist or wpscan_options.enumerate_usernames
    puts
    puts green("[+]") + " Enumerating usernames ..."

    usernames = wp_target.usernames(:range => wpscan_options.enumerate_usernames_range)

    if usernames.empty?
      puts
      puts "We did not enumerate any usernames :("
      puts "Try supplying your own username with the --username option"
      puts
      exit(1)
    else
      puts
      puts green("[+]") + " We found the following #{usernames.length.to_s} username/s :"
      puts

      max_id_length = usernames.sort { |a, b| a.id.to_s.length <=> b.id.to_s.length }.last.id.to_s.length
      max_name_length = usernames.sort { |a, b| a.name.length <=> b.name.length }.last.name.length
      max_nickname_length = usernames.sort { |a, b| a.nickname.length <=> b.nickname.length }.last.nickname.length

      space = 1
      usernames.each do |u|
        id_string = "id: #{u.id.to_s.ljust(max_id_length + space)}"
        name_string = "name: #{u.name.ljust(max_name_length + space)}"
        nickname_string = "nickname: #{u.nickname.ljust(max_nickname_length + space)}"
        puts " | #{id_string}| #{name_string}| #{nickname_string}"
      end
    end

  else
    usernames = [WpUser.new(wpscan_options.username, -1, "empty")]
  end

  # Start the brute forcer
  bruteforce = true
  if wpscan_options.wordlist
    if wp_target.has_login_protection?

      protection_plugin = wp_target.login_protection_plugin()

      puts
      puts "The plugin #{protection_plugin.name} has been detected. It might record the IP and timestamp of every failed login. Not a good idea for brute forcing !"
      puts "[?] Do you want to start the brute force anyway ? [y/n]"

      if Readline.readline !~ /^y/i
        bruteforce = false
      end
    end

    if bruteforce === false
      puts
      puts "Brute forcing aborted"
    else
      puts
      puts green("[+]") + " Starting the password brute forcer"
      puts
      wp_target.brute_force(usernames, wpscan_options.wordlist)
    end
  end

  stop_time = Time.now
  puts
  puts green("[+] Finished at #{stop_time.asctime}")
  elapsed = stop_time - start_time
  puts green("[+] Elapsed time: #{Time.at(elapsed).utc.strftime("%H:%M:%S")}")
  exit() # must exit!
rescue => e
  puts red("[ERROR] #{e.message}")
  puts red("Trace :")
  puts red(e.backtrace.join("\n"))
end
