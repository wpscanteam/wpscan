#!/usr/bin/env ruby
# encoding: UTF-8

$: << '.'
require File.dirname(__FILE__) + '/lib/wpscan/wpscan_helper'

def main
  # delete old logfile, check if it is a symlink first.
  File.delete(LOG_FILE) if File.exist?(LOG_FILE) and !File.symlink?(LOG_FILE)

  banner()

  begin
    wpscan_options = WpscanOptions.load_from_arguments

    unless wpscan_options.has_options?
      usage()
      raise('No argument supplied')
    end

    # Define a global variable
    $COLORSWITCH = wpscan_options.no_color

    if wpscan_options.help
      help()
      usage()
      exit(0)
    end

    if wpscan_options.version
      puts "Current version: #{version}"
      exit(0)
    end

    # Check for updates
    if wpscan_options.update
      if !@updater.nil?
        if @updater.has_local_changes?
          print "#{red('[!]')} Local file changes detected, an update will override local changes, do you want to continue updating? [y/n] "
          Readline.readline =~ /^y/i ? @updater.reset_head : raise('Update aborted')
        end
        puts @updater.update()
      else
        puts '[i] Svn / Git not installed, or wpscan has not been installed with one of them.'
        puts "#{red('[!]')} Update aborted"
      end
      exit(0)
    end

    unless wpscan_options.url
      raise 'The URL is mandatory, please supply it with --url or -u'
    end

    wp_target = WpTarget.new(wpscan_options.url, wpscan_options.to_h)

    # Remote website up?
    unless wp_target.online?
      raise "The WordPress URL supplied '#{wp_target.uri}' seems to be down."
    end

    if wpscan_options.proxy
      proxy_response = Browser.get(wp_target.url)

      unless WpTarget::valid_response_codes.include?(proxy_response.code)
        raise "Proxy Error :\r\n#{proxy_response.headers}"
      end
    end

    # Remote website has a redirection?
    if (redirection = wp_target.redirection)
      if wpscan_options.follow_redirection
        puts "Following redirection #{redirection}"
      else
        puts "#{blue('[i]')} The remote host tried to redirect to: #{redirection}"
        print '[?] Do you want follow the redirection ? [Y]es [N]o [A]bort, default: [N]'
      end
      if wpscan_options.follow_redirection || !wpscan_options.batch
        if wpscan_options.follow_redirection || (input = Readline.readline) =~ /^y/i
          wpscan_options.url = redirection
          wp_target = WpTarget.new(redirection, wpscan_options.to_h)
        else
          if input =~ /^a/i
            puts 'Scan aborted'
            exit(0)
          end
        end
      end
    end

    if wp_target.has_basic_auth? && wpscan_options.basic_auth.nil?
      raise 'Basic authentication is required, please provide it with --basic-auth <login:password>'
    end

    # Remote website is wordpress?
    unless wpscan_options.force
      unless wp_target.wordpress?
        raise "#{red('[!]')} The remote website is up, but does not seem to be running WordPress."
      end
    end

    unless wp_target.wp_content_dir
      raise 'The wp_content_dir has not been found, please supply it with --wp-content-dir'
    end

    unless wp_target.wp_plugins_dir_exists?
      puts "The plugins directory '#{wp_target.wp_plugins_dir}' does not exist."
      puts 'You can specify one per command line option (don\'t forget to include the wp-content directory if needed)'
      puts '[?] Continue? [Y]es [N]o, default: [N]'
      if wpscan_options.batch || Readline.readline !~ /^y/i
        exit(0)
      end
    end

    # Output runtime data
    start_time   = Time.now
    start_memory = get_memory_usage
    puts "#{green('[+]')} URL: #{wp_target.url}"
    puts "#{green('[+]')} Started: #{start_time.asctime}"
    puts

    if wp_target.wordpress_hosted?
      puts "#{red('[!]')} We do not support scanning *.wordpress.com hosted blogs"
    end

    if wp_target.has_robots?
      puts "#{green('[+]')} robots.txt available under: '#{wp_target.robots_url}'"

      wp_target.parse_robots_txt.each do |dir|
        puts "#{green('[+]')} Interesting entry from robots.txt: #{dir}"
      end
    end

    if wp_target.has_readme?
      puts "#{red('[!]')} The WordPress '#{wp_target.readme_url}' file exists"
    end

    has_full_path_disclosure = wp_target.has_full_path_disclosure
    if has_full_path_disclosure
      puts "#{red('[!]')} Full Path Disclosure (FPD): '#{has_full_path_disclosure}'"
    end

    if wp_target.has_debug_log?
      puts "#{red('[!]')} Debug log file found: #{wp_target.debug_log_url}"
    end

    wp_target.config_backup.each do |file_url|
      puts "#{red('[!]')} A wp-config.php backup file has been found in: '#{file_url}'"
    end

    if wp_target.search_replace_db_2_exists?
      puts red("[!] searchreplacedb2.php has been found in: '#{wp_target.search_replace_db_2_url}'")
    end

    wp_target.interesting_headers.each do |header|
      output = "#{green('[+]')} Interesting header: "

      if header[1].class == Array
        header[1].each do |value|
          puts output + "#{header[0]}: #{value}"
        end
      else
        puts output + "#{header[0]}: #{header[1]}"
      end
    end

    if wp_target.multisite?
      puts "#{green('[+]')} This site seems to be a multisite (http://codex.wordpress.org/Glossary#Multisite)"
    end

    if wp_target.registration_enabled?
      puts "#{amber('[+]')} Registration is enabled: #{wp_target.registration_url}"
    end

    if wp_target.has_xml_rpc?
      puts "#{green('[+]')} XML-RPC Interface available under: #{wp_target.xml_rpc_url}"
    end

    if wp_target.has_malwares?
      malwares = wp_target.malwares
      puts "#{red('[!]')} #{malwares.size} malware(s) found:"

      malwares.each do |malware_url|
        puts
        puts ' | ' + red("#{malware_url}")
      end
      puts
    end

    enum_options = {
      show_progression: true,
      exclude_content: wpscan_options.exclude_content_based
    }

    if wp_version = wp_target.version(WP_VERSIONS_FILE)
      wp_version.output(wpscan_options.verbose)
    end

    if wp_theme = wp_target.theme
      puts
      # Theme version is handled in #to_s
      puts "#{green('[+]')} WordPress theme in use: #{wp_theme}"
      wp_theme.output(wpscan_options.verbose)

      # Check for parent Themes
      while wp_theme.is_child_theme?
        parent = wp_theme.get_parent_theme
        puts
        puts "#{green('[+]')} Detected parent theme: #{parent}"
        parent.output(wpscan_options.verbose)
        wp_theme = parent
      end

    end

    if wpscan_options.enumerate_plugins == nil and wpscan_options.enumerate_only_vulnerable_plugins == nil
      puts
      puts "#{green('[+]')} Enumerating plugins from passive detection ..."

      wp_plugins = WpPlugins.passive_detection(wp_target)
      if !wp_plugins.empty?
        puts " | #{wp_plugins.size} plugins found:"

        wp_plugins.output(wpscan_options.verbose)
      else
        puts "#{green('[+]')} No plugins found"
      end
    end

    # Enumerate the installed plugins
    if wpscan_options.enumerate_plugins or wpscan_options.enumerate_only_vulnerable_plugins or wpscan_options.enumerate_all_plugins
      puts
      puts "#{green('[+]')} Enumerating installed plugins #{'(only vulnerable ones)' if wpscan_options.enumerate_only_vulnerable_plugins} ..."
      puts

      wp_plugins = WpPlugins.aggressive_detection(wp_target,
        enum_options.merge(
          file: wpscan_options.enumerate_all_plugins ? PLUGINS_FULL_FILE : PLUGINS_FILE,
          only_vulnerable: wpscan_options.enumerate_only_vulnerable_plugins || false
        )
      )
      puts
      if !wp_plugins.empty?
        puts "#{green('[+]')} We found #{wp_plugins.size} plugins:"

        wp_plugins.output(wpscan_options.verbose)
      else
        puts "#{green('[+]')} No plugins found"
      end
    end

    # Enumerate installed themes
    if wpscan_options.enumerate_themes or wpscan_options.enumerate_only_vulnerable_themes or wpscan_options.enumerate_all_themes
      puts
      puts "#{green('[+]')} Enumerating installed themes #{'(only vulnerable ones)' if wpscan_options.enumerate_only_vulnerable_themes} ..."
      puts

      wp_themes = WpThemes.aggressive_detection(wp_target,
        enum_options.merge(
          file: wpscan_options.enumerate_all_themes ? THEMES_FULL_FILE : THEMES_FILE,
          only_vulnerable: wpscan_options.enumerate_only_vulnerable_themes || false
        )
      )
      puts
      if !wp_themes.empty?
        puts "#{green('[+]')} We found #{wp_themes.size} themes:"

        wp_themes.output(wpscan_options.verbose)
      else
        puts "#{green('[+]')} No themes found"
      end
    end

    if wpscan_options.enumerate_timthumbs
      puts
      puts "#{green('[+]')} Enumerating timthumb files ..."
      puts

      wp_timthumbs = WpTimthumbs.aggressive_detection(wp_target,
        enum_options.merge(
          file: DATA_DIR + '/timthumbs.txt',
          theme_name: wp_theme ? wp_theme.name : nil
        )
      )
      puts
      if !wp_timthumbs.empty?
        puts "#{green('[+]')} We found #{wp_timthumbs.size} timthumb file/s:"

        wp_timthumbs.output(wpscan_options.verbose)
      else
        puts "#{green('[+]')} No timthumb files found"
      end
    end

    # If we haven't been supplied a username, enumerate them...
    if !wpscan_options.username and wpscan_options.wordlist or wpscan_options.enumerate_usernames
      puts
      puts "#{green('[+]')} Enumerating usernames ..."

      if wp_target.has_plugin?('stop-user-enumeration')
        puts "#{red('[!]')} Stop User Enumeration plugin detected, results might be empty. " \
             "However a bypass exists, see stop_user_enumeration_bypass.rb in #{File.expand_path(File.dirname(__FILE__))}"
      end

      wp_users = WpUsers.aggressive_detection(wp_target,
        enum_options.merge(
          range: wpscan_options.enumerate_usernames_range,
          show_progression: false
        )
      )

      if wp_users.empty?
        puts "#{green('[+]')} We did not enumerate any usernames"

        if wpscan_options.wordlist
          puts 'Try supplying your own username with the --username option'
          puts
          exit(1)
        end
      else
        puts "#{green('[+]')} Identified the following #{wp_users.size} user/s:"
        wp_users.output(margin_left: ' ' * 4)
      end

    else
      # FIXME : Change the .username to .login (and also the --username in the CLI)
      wp_users = WpUsers.new << WpUser.new(wp_target.uri, login: wpscan_options.username)
    end

    # Start the brute forcer
    bruteforce = true
    if wpscan_options.wordlist
      if wp_target.has_login_protection?

        protection_plugin = wp_target.login_protection_plugin()

        puts
        puts "#{red('[!]')} The plugin #{protection_plugin.name} has been detected. It might record the IP and timestamp of every failed login and/or prevent brute forcing altogether. Not a good idea for brute forcing!"
        puts '[?] Do you want to start the brute force anyway ? [Y]es [N]o, default: [N]'

        bruteforce = false if wpscan_options.batch || Readline.readline !~ /^y/i
      end

      if bruteforce
        puts "#{green('[+]')} Starting the password brute forcer"

        begin
          wp_users.brute_force(
            wpscan_options.wordlist,
            show_progression: true,
            verbose: wpscan_options.verbose
          )
        ensure
          puts
          wp_users.output(show_password: true, margin_left: ' ' * 2)
        end
      else
        puts "#{red('[!]')} Brute forcing aborted"
      end
    end

    stop_time   = Time.now
    elapsed     = stop_time - start_time
    used_memory = get_memory_usage - start_memory

    puts
    puts green("[+] Finished: #{stop_time.asctime}")
    puts green("[+] Memory used: #{used_memory.bytes_to_human}")
    puts green("[+] Elapsed time: #{Time.at(elapsed).utc.strftime('%H:%M:%S')}")
    exit(0) # must exit!

  rescue SystemExit, Interrupt

  rescue => e
    puts
    puts red(e.message)

    if wpscan_options && wpscan_options.verbose
      puts red('Trace:')
      puts red(e.backtrace.join("\n"))
    end
    exit(1)
  ensure
    # Ensure a clean abort of Hydra
    # See https://github.com/wpscanteam/wpscan/issues/461#issuecomment-42735615
    Browser.instance.hydra.abort
    Browser.instance.hydra.run
  end
end

main()
