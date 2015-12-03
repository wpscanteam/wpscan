#!/usr/bin/env ruby
# encoding: UTF-8

$: << '.'

$exit_code = 0

require File.dirname(__FILE__) + '/lib/wpscan/wpscan_helper'

def main
  # delete old logfile, check if it is a symlink first.
  File.delete(LOG_FILE) if File.exist?(LOG_FILE) and !File.symlink?(LOG_FILE)

  begin
    wpscan_options = WpscanOptions.load_from_arguments

    $log = wpscan_options.log

    banner() unless wpscan_options.no_banner # called after $log set

    unless wpscan_options.has_options?
      # first parameter only url?
      if ARGV.length == 1
        wpscan_options.url = ARGV[0]
      else
        usage()
        raise('No argument supplied')
      end
    end

    # Define a global variable
    $COLORSWITCH = wpscan_options.no_color

    if wpscan_options.help
      help()
      usage()
      exit(0)
    end

    if wpscan_options.version
      puts "Current version: #{WPSCAN_VERSION}"
      date = last_update
      puts "Last DB update: #{date.strftime('%Y-%m-%d')}" unless date.nil?
      exit(0)
    end

    # Initialize the browser to allow the db update
    # to be done over a proxy if set
    Browser.instance(
      wpscan_options.to_h.merge(max_threads: wpscan_options.threads)
    )

    # check if db file needs upgrade and we are not running in batch mode
    # also no need to check if the user supplied the --update switch
    if update_required? && !wpscan_options.batch && !wpscan_options.update
      puts notice('It seems like you have not updated the database for some time.')
      print '[?] Do you want to update now? [Y]es [N]o [A]bort, default: [N]'
      if (input = Readline.readline) =~ /^y/i
        wpscan_options.update = true
      elsif input =~ /^a/i
        puts 'Scan aborted'
        exit(1)
      else
        if missing_db_file?
          puts critical('You can not run a scan without any databases.')
          exit(1)
        end
      end
    end

    if wpscan_options.update
      puts notice('Updating the Database ...')
      DbUpdater.new(DATA_DIR).update(wpscan_options.verbose)
      puts notice('Update completed.')
      # Exit program if only option --update is used
      exit(0) unless wpscan_options.url
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
        raise "Proxy Error :\r\nResponse Code: #{proxy_response.code}\r\nResponse Headers: #{proxy_response.headers}"
      end
    end

    # Remote website has a redirection?
    if (redirection = wp_target.redirection)
      if redirection =~ /\/wp-admin\/install\.php$/
        puts critical('The Website is not fully configured and currently in install mode. Call it to create a new admin user.')
      else
        if wpscan_options.follow_redirection
          puts "Following redirection #{redirection}"
        else
          puts notice("The remote host tried to redirect to: #{redirection}")
          print '[?] Do you want follow the redirection ? [Y]es [N]o [A]bort, default: [N]'
        end
        if wpscan_options.follow_redirection || !wpscan_options.batch
          if wpscan_options.follow_redirection || (input = Readline.readline) =~ /^y/i
            wpscan_options.url = redirection
            wp_target = WpTarget.new(redirection, wpscan_options.to_h)
          else
            if input =~ /^a/i
              puts 'Scan aborted'
              exit(1)
            end
          end
        end
      end
    end

    if wp_target.has_basic_auth? && wpscan_options.basic_auth.nil?
      raise 'Basic authentication is required, please provide it with --basic-auth <login:password>'
    end

    # test for valid credentials
    unless wpscan_options.basic_auth.nil?
      res = Browser.get_and_follow_location(wp_target.url)
      raise 'Invalid credentials supplied' if res && res.code == 401
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
      puts '[?] Continue? [Y]es [N]o, default: [N]'
      if wpscan_options.batch || Readline.readline !~ /^y/i
        exit(1)
      end
    end

    # Output runtime data
    start_time   = Time.now
    start_memory = get_memory_usage
    puts info("URL: #{wp_target.url}")
    puts info("Started: #{start_time.asctime}")
    puts

    if wp_target.wordpress_hosted?
      puts critical('We do not support scanning *.wordpress.com hosted blogs')
    end

    if wp_target.has_robots?
      puts info("robots.txt available under: '#{wp_target.robots_url}'")

      wp_target.parse_robots_txt.each do |dir|
        puts info("Interesting entry from robots.txt: #{dir}")
      end
    end

    if wp_target.has_readme?
      puts warning("The WordPress '#{wp_target.readme_url}' file exists exposing a version number")
    end

    if wp_target.has_full_path_disclosure?
      puts warning("Full Path Disclosure (FPD) in '#{wp_target.full_path_disclosure_url}': #{wp_target.full_path_disclosure_data}")
    end

    if wp_target.has_debug_log?
      puts critical("Debug log file found: #{wp_target.debug_log_url}")
    end

    wp_target.config_backup.each do |file_url|
      puts critical("A wp-config.php backup file has been found in: '#{file_url}'")
    end

    if wp_target.search_replace_db_2_exists?
      puts critical("searchreplacedb2.php has been found in: '#{wp_target.search_replace_db_2_url}'")
    end

    wp_target.interesting_headers.each do |header|
      output = info('Interesting header: ')

      if header[1].class == Array
        header[1].each do |value|
          puts output + "#{header[0]}: #{value}"
        end
      else
        puts output + "#{header[0]}: #{header[1]}"
      end
    end

    if wp_target.multisite?
      puts info('This site seems to be a multisite (http://codex.wordpress.org/Glossary#Multisite)')
    end

    if wp_target.has_must_use_plugins?
      puts info("This site has 'Must Use Plugins' (http://codex.wordpress.org/Must_Use_Plugins)")
    end

    if wp_target.registration_enabled?
      puts warning("Registration is enabled: #{wp_target.registration_url}")
    end

    if wp_target.has_xml_rpc?
      puts info("XML-RPC Interface available under: #{wp_target.xml_rpc_url}")
    end

    if wp_target.upload_directory_listing_enabled?
      puts warning("Upload directory has directory listing enabled: #{wp_target.upload_dir_url}")
    end

    enum_options = {
      show_progression: true,
      exclude_content: wpscan_options.exclude_content_based
    }

    if wp_version = wp_target.version(WP_VERSIONS_FILE)
      wp_version.output(wpscan_options.verbose)
    else
      puts
      puts notice('WordPress version can not be detected')
    end

    if wp_theme = wp_target.theme
      puts
      # Theme version is handled in #to_s
      puts info("WordPress theme in use: #{wp_theme}")
      wp_theme.output(wpscan_options.verbose)

      # Check for parent Themes
      parent_theme_count = 0
      while wp_theme.is_child_theme? && parent_theme_count <= wp_theme.parent_theme_limit
        parent_theme_count += 1

        parent = wp_theme.get_parent_theme
        puts
        puts info("Detected parent theme: #{parent}")
        parent.output(wpscan_options.verbose)
        wp_theme = parent
      end

    end

    if wpscan_options.enumerate_plugins == nil and wpscan_options.enumerate_only_vulnerable_plugins == nil
      puts
      puts info('Enumerating plugins from passive detection ...')

      wp_plugins = WpPlugins.passive_detection(wp_target)
      if !wp_plugins.empty?
        if wp_plugins.size == 1
          puts " | #{wp_plugins.size} plugin found:"
        else
          puts " | #{wp_plugins.size} plugins found:"
        end
        wp_plugins.output(wpscan_options.verbose)
      else
        puts info('No plugins found')
      end
    end

    # Enumerate the installed plugins
    if wpscan_options.enumerate_plugins or wpscan_options.enumerate_only_vulnerable_plugins or wpscan_options.enumerate_all_plugins
      puts
      if wpscan_options.enumerate_only_vulnerable_plugins
        puts info('Enumerating installed plugins (only ones with known vulnerabilities) ...')
        plugin_enumeration_type = :vulnerable
      end

      if wpscan_options.enumerate_plugins
        puts info('Enumerating installed plugins (only ones marked as popular) ...')
        plugin_enumeration_type = :popular
      end

      if wpscan_options.enumerate_all_plugins
        puts info('Enumerating all plugins (may take a while and use a lot of system resources) ...')
        plugin_enumeration_type = :all
      end
      puts
      
      if wpscan_options.wp_local_dir
        puts info("Using local WordPress directory for enumeration")
        wp_plugins = WpPlugins.directory_detection(wp_target,
          enum_options.merge(
            file: PLUGINS_FILE,
            type: plugin_enumeration_type
          )
        )
      else
        wp_plugins = WpPlugins.aggressive_detection(wp_target,
          enum_options.merge(
            file: PLUGINS_FILE,
            type: plugin_enumeration_type
          )
        )
      end

      puts
      if !wp_plugins.empty?
        puts info("We found #{wp_plugins.size} plugins:")

        wp_plugins.output(wpscan_options.verbose)
      else
        puts info('No plugins found')
      end
    end

    # Enumerate installed themes
    if wpscan_options.enumerate_themes or wpscan_options.enumerate_only_vulnerable_themes or wpscan_options.enumerate_all_themes
      puts
      if wpscan_options.enumerate_only_vulnerable_themes
        puts info('Enumerating installed themes (only ones with known vulnerabilities) ...')
        theme_enumeration_type = :vulnerable
      end

      if wpscan_options.enumerate_themes
        puts info('Enumerating installed themes (only ones marked as popular) ...')
        theme_enumeration_type = :popular
      end

      if wpscan_options.enumerate_all_themes
        puts info('Enumerating all themes (may take a while and use a lot of system resources) ...')
        theme_enumeration_type = :all
      end
      puts

      wp_themes = WpThemes.aggressive_detection(wp_target,
        enum_options.merge(
          file: THEMES_FILE,
          type: theme_enumeration_type
        )
      )
      puts
      if !wp_themes.empty?
        puts info("We found #{wp_themes.size} themes:")

        wp_themes.output(wpscan_options.verbose)
      else
        puts info('No themes found')
      end
    end

    if wpscan_options.enumerate_timthumbs
      puts
      puts info('Enumerating timthumb files ...')
      puts

      wp_timthumbs = WpTimthumbs.aggressive_detection(wp_target,
        enum_options.merge(
          file: DATA_DIR + '/timthumbs.txt',
          theme_name: wp_theme ? wp_theme.name : nil
        )
      )
      puts
      if !wp_timthumbs.empty?
        puts info("We found #{wp_timthumbs.size} timthumb file/s:")

        wp_timthumbs.output(wpscan_options.verbose)
      else
        puts info('No timthumb files found')
      end
    end

    # If we haven't been supplied a username/usernames list, enumerate them...
    if !wpscan_options.username && !wpscan_options.usernames && wpscan_options.wordlist || wpscan_options.enumerate_usernames
      puts
      puts info('Enumerating usernames ...')

      if wp_target.has_plugin?('stop-user-enumeration')
        puts warning("Stop User Enumeration plugin detected, results might be empty. However a bypass exists for v1.2.8 and below, see stop_user_enumeration_bypass.rb in #{File.expand_path(File.dirname(__FILE__))}")
      end

      wp_users = WpUsers.aggressive_detection(wp_target,
        enum_options.merge(
          range: wpscan_options.enumerate_usernames_range,
          show_progression: false
        )
      )

      if wp_users.empty?
        puts info('We did not enumerate any usernames')

        if wpscan_options.wordlist
          puts 'Try supplying your own username with the --username option'
          puts
          exit(1)
        end
      else
        puts info("Identified the following #{wp_users.size} user/s:")
        wp_users.output(margin_left: ' ' * 4)
        if wp_users[0].login == "admin"
           puts warning("Default first WordPress username 'admin' is still used")
        end
      end

    else
      wp_users = WpUsers.new

      if wpscan_options.usernames
        File.open(wpscan_options.usernames).each do |username|
          wp_users << WpUser.new(wp_target.uri, login: username.chomp)
        end
      else
        wp_users << WpUser.new(wp_target.uri, login: wpscan_options.username)
      end
    end

    # Start the brute forcer
    bruteforce = true
    if wpscan_options.wordlist
      if wp_target.has_login_protection?

        protection_plugin = wp_target.login_protection_plugin()

        puts
        puts warning("The plugin #{protection_plugin.name} has been detected. It might record the IP and timestamp of every failed login and/or prevent brute forcing altogether. Not a good idea for brute forcing!")
        puts '[?] Do you want to start the brute force anyway ? [Y]es [N]o, default: [N]'

        bruteforce = false if wpscan_options.batch || Readline.readline !~ /^y/i
      end

      if bruteforce
        puts info('Starting the password brute forcer')

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
        puts critical('Brute forcing aborted')
      end
    end

    stop_time   = Time.now
    elapsed     = stop_time - start_time
    used_memory = get_memory_usage - start_memory

    puts
    puts info("Finished: #{stop_time.asctime}")
    puts info("Requests Done: #{@total_requests_done}")
    puts info("Memory used: #{used_memory.bytes_to_human}")
    puts info("Elapsed time: #{Time.at(elapsed).utc.strftime('%H:%M:%S')}")

  rescue Interrupt
    # do nothing on interrupt
  rescue => e
    puts
    puts critical(e.message)

    if wpscan_options && wpscan_options.verbose
      puts critical('Trace:')
      puts critical(e.backtrace.join("\n"))
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
exit($exit_code)
