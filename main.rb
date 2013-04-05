#!/usr/bin/env ruby
# encoding: UTF-8

def main
  # delete old logfile, check if it is a symlink first.
  File.delete(LOG_FILE) if File.exist?(LOG_FILE) and !File.symlink?(LOG_FILE)

  banner()

  begin
    wpscan_options = WpscanOptions.load_from_arguments

    unless wpscan_options.has_options?
      raise "No argument supplied\n#{usage()}"
    end

    if wpscan_options.help
      help()
      usage()
      exit
    end

    # Check for updates
    if wpscan_options.update
      if !@updater.nil?
        if @updater.has_local_changes?
          puts "#{red('[!]')} Local file changes detected, an update will override local changes, do you want to continue updating? [y/n]"
          Readline.readline =~ /^y/i ? @updater.reset_head : raise('Update aborted')
        end
        puts @updater.update()
      else
        puts 'Svn / Git not installed, or wpscan has not been installed with one of them.'
        puts 'Update aborted'
      end
      exit(1)
    end

    wp_target = WpTarget.new(wpscan_options.url, wpscan_options.to_h)

    # Remote website up?
    unless wp_target.online?
      raise "The WordPress URL supplied '#{wp_target.uri}' seems to be down."
    end

    if wpscan_options.proxy
      proxy_response = Browser.instance.get(wp_target.url)

      unless WpTarget::valid_response_codes.include?(proxy_response.code)
        raise "Proxy Error :\r\n#{proxy_response.headers}"
      end
    end

    redirection = wp_target.redirection
    if redirection
      if wpscan_options.follow_redirection
        puts "Following redirection #{redirection}"
        puts
      else
        puts "The remote host tried to redirect us to #{redirection}"
        puts 'Do you want follow the redirection ? [y/n]'
      end

      if wpscan_options.follow_redirection or Readline.readline =~ /^y/i
        wpscan_options.url = redirection
        wp_target = WpTarget.new(redirection, wpscan_options.to_h)
      else
        puts 'Scan aborted'
        exit
      end
    end

    if wp_target.has_basic_auth? && wpscan_options.basic_auth.nil?
      raise 'Basic authentication is required, please provide it with --basic-auth <login:password>'
    end

    # Remote website is wordpress?
    unless wpscan_options.force
      unless wp_target.wordpress?
        raise 'The remote website is up, but does not seem to be running WordPress.'
      end
    end

    unless wp_target.wp_content_dir
      raise 'The wp_content_dir has not been found, please supply it with --wp-content-dir'
    end

    unless wp_target.wp_plugins_dir_exists?
      puts "The plugins directory '#{wp_target.wp_plugins_dir}' does not exist."
      puts 'You can specify one per command line option (don\'t forget to include the wp-content directory if needed)'
      puts 'Continue? [y/n]'
      unless Readline.readline =~ /^y/i
        exit
      end
    end

    # Output runtime data
    start_time = Time.now
    puts "| URL: #{wp_target.url}"
    puts "| Started on #{start_time.asctime}"
    puts

    if wp_target.has_robots?
      puts green('[+]') + " robots.txt available under '#{wp_target.robots_url}'"
    end

    if wp_target.has_readme?
      puts red('[!]') + " The WordPress '#{wp_target.readme_url}' file exists"
    end

    if wp_target.has_full_path_disclosure?
      puts red('[!]') + " Full Path Disclosure (FPD) in '#{wp_target.full_path_disclosure_url}'"
    end

    if wp_target.has_debug_log?
      puts red('[!]') + " Debug log file found : #{wp_target.debug_log_url}"
    end

    wp_target.config_backup.each do |file_url|
      puts red("[!] A wp-config.php backup file has been found '#{file_url}'")
    end

    if wp_target.search_replace_db_2_exists?
      puts red("[!] searchreplacedb2.php has been found '#{wp_target.search_replace_db_2_url}'")
    end

    if wp_target.is_multisite?
      puts green('[+]') + ' This site seems to be a multisite (http://codex.wordpress.org/Glossary#Multisite)'
    end

    if wp_target.registration_enabled?
      puts green('[+]') + ' User registration is enabled'
    end

    if wp_target.has_xml_rpc?
      puts green('[+]') + " XML-RPC Interface available under #{wp_target.xml_rpc_url}"
    end

    if wp_target.has_malwares?
      malwares = wp_target.malwares
      puts red('[!]') + " #{malwares.size} malware(s) found :"

      malwares.each do |malware_url|
        puts
        puts ' | ' + red("#{malware_url}")
      end
      puts
    end

    enum_options = {
      show_progression: true,
      exclude_content:  wpscan_options.exclude_content_based
    }

    if wp_version = wp_target.version(WP_VERSIONS_FILE)
      wp_version.output
    end

    if wp_theme = wp_target.theme
      puts
      # Theme version is handled in #to_s
      puts green('[+]') + " The WordPress theme in use is #{wp_theme}"
      wp_theme.output
    end

    if wpscan_options.enumerate_plugins == nil and wpscan_options.enumerate_only_vulnerable_plugins == nil
      puts
      puts green('[+]') + ' Enumerating plugins from passive detection ... '

      wp_plugins = WpPlugins.passive_detection(wp_target)
      if !wp_plugins.empty?
        puts "#{wp_plugins.size} plugins found :"

        wp_plugins.output
      else
        puts 'No plugins found :('
      end
    end

    # Enumerate the installed plugins
    if wpscan_options.enumerate_plugins or wpscan_options.enumerate_only_vulnerable_plugins or wpscan_options.enumerate_all_plugins
      puts
      puts green('[+]') + " Enumerating installed plugins #{'(only vulnerable ones)' if wpscan_options.enumerate_only_vulnerable_plugins} ..."
      puts

      wp_plugins = WpPlugins.aggressive_detection(wp_target,
        enum_options.merge(
          file: wpscan_options.enumerate_all_plugins ? PLUGINS_FULL_FILE : PLUGINS_FILE,
          only_vulnerable: wpscan_options.enumerate_only_vulnerable_plugins || false
        )
      )
      if !wp_plugins.empty?
        puts
        puts
        puts green('[+]') + " We found #{wp_plugins.size} plugins:"

        wp_plugins.output
      else
        puts
        puts 'No plugins found :('
      end
    end

    # Enumerate installed themes
    if wpscan_options.enumerate_themes or wpscan_options.enumerate_only_vulnerable_themes or wpscan_options.enumerate_all_themes
      puts
      puts green('[+]') + " Enumerating installed themes #{'(only vulnerable ones)' if wpscan_options.enumerate_only_vulnerable_themes} ..."
      puts

      wp_themes = WpThemes.aggressive_detection(wp_target,
        enum_options.merge(
          file: wpscan_options.enumerate_all_themes ? THEMES_FULL_FILE : THEMES_FILE,
          only_vulnerable: wpscan_options.enumerate_only_vulnerable_themes || false
        )
      )

      if !wp_themes.empty?
        puts
        puts
        puts green('[+]') + " We found #{wp_themes.size} themes:"

        wp_themes.output
      else
        puts
        puts 'No themes found :('
      end
    end

    if wpscan_options.enumerate_timthumbs
      puts
      puts green('[+]') + ' Enumerating timthumb files ...'
      puts

      wp_timthumbs = WpTimthumbs.aggressive_detection(wp_target,
        enum_options.merge(
          file: DATA_DIR + '/timthumbs.txt',
          theme_name: wp_theme ? wp_theme.name : nil
        )
      )
      if !wp_timthumbs.empty?
        puts
        puts green('[+]') + " We found #{wp_timthumbs.size} timthumb file/s :"
        puts

        wp_timthumbs.output

        puts
        puts red(' * Reference: http://www.exploit-db.com/exploits/17602/')
      else
        puts
        puts 'No timthumb files found :('
      end
    end

    # If we haven't been supplied a username, enumerate them...
    if !wpscan_options.username and wpscan_options.wordlist or wpscan_options.enumerate_usernames
      puts
      puts green('[+]') + ' Enumerating usernames ...'

      wp_users = WpUsers.aggressive_detection(wp_target,
        enum_options.merge(
          range: wpscan_options.enumerate_usernames_range,
          show_progression: false
        )
      )

      if wp_users.empty?
        puts
        puts 'We did not enumerate any usernames :('
        puts 'Try supplying your own username with the --username option'
        puts
        exit(1)
      else
        puts
        puts green('[+]') + " We found the following #{wp_users.size} user/s :"

        wp_users.output(' ' * 4)
      end

    else
      # FIXME : Change the .username to .login (and also the --username in the CLI)
      wp_users = WpUsers.new << WpUser.new(wp_target, login: wpscan_options.username)
    end

    # Start the brute forcer
    bruteforce = true
    if wpscan_options.wordlist
      if wp_target.has_login_protection?

        protection_plugin = wp_target.login_protection_plugin()

        puts
        puts "The plugin #{protection_plugin.name} has been detected. It might record the IP and timestamp of every failed login. Not a good idea for brute forcing !"
        puts '[?] Do you want to start the brute force anyway ? [y/n]'

        bruteforce = false if Readline.readline !~ /^y/i
      end

      if bruteforce
        puts
        puts green('[+]') + ' Starting the password brute forcer'
        puts
        wp_target.brute_force(wp_users, wpscan_options.wordlist, { show_progression: true })
      else
        puts
        puts 'Brute forcing aborted'
      end
    end

    stop_time = Time.now
    puts
    puts green("[+] Finished at #{stop_time.asctime}")
    elapsed = stop_time - start_time
    puts green("[+] Elapsed time: #{Time.at(elapsed).utc.strftime('%H:%M:%S')}")
    exit() # must exit!
  rescue => e
    puts red("[ERROR] #{e.message}")
    puts red('Trace :')
    puts red(e.backtrace.join("\n"))
  end
end
