#!/usr/bin/env ruby
# encoding: UTF-8

$: << '.'

$exit_code = 0

require File.join(__dir__, 'lib', 'wpscan', 'wpscan_helper')

def main
  begin
    wpscan_options = WpscanOptions.load_from_arguments
    date = last_update

    $log = wpscan_options.log

    # some sanity checks
    if $log
      if $log.empty?
        $log = DEFAULT_LOG_FILE
      end

      # translate to full path if no starting / detected
      if $log !~ /^#{File::SEPARATOR}/
        $log = File.join(ROOT_DIR, $log)
      end

      # check if file exists and has a size greater zero
      if File.exist?($log) && File.size?($log)
        puts notice("The supplied log file #{$log} already exists. If you continue the new output will be appended.")
        print '[?] Do you want to continue? [Y]es [N]o, default: [N] >'
        if Readline.readline !~ /^y/i
          # unset logging so puts will try to log to the file
          $log = nil
          puts notice('Scan aborted')
          exit(1)
        end
      end

      # check if we can write the file
      begin
        File.open($log, 'a')
      rescue SystemCallError => e
        # unset logging so puts will try to log to the file
        temp = $log
        $log = nil
        puts critical("Error with logfile #{temp}:")
        puts critical(e)
        exit(1)
      end
    end

    banner() unless wpscan_options.no_banner # called after $log set

    unless wpscan_options.has_options?
      # first parameter only url?
      if ARGV.length == 1
        puts
        puts notice("Please use '-u #{ARGV[0]}' next time")
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
      puts "Last database update: #{date.strftime('%Y-%m-%d')}" unless date.nil?
      exit(0)
    end

    # Initialize the browser to allow the db update
    # to be done over a proxy if set
    Browser.instance(
      wpscan_options.to_h.merge(max_threads: wpscan_options.threads)
    )

    # Check if database needs upgrade (if its older than 5 days) and we are not running in --batch mode
    # Also no need to check if the user supplied the --update switch
    if update_required? and not wpscan_options.batch and not wpscan_options.update
      # Banner
      puts
      puts notice('It seems like you have not updated the database for some time')
      puts notice("Last database update: #{date.strftime('%Y-%m-%d')}") unless date.nil?

      # User prompt
      print '[?] Do you want to update now? [Y]es  [N]o  [A]bort update, default: [N] > '
      if (input = Readline.readline) =~ /^a/i
        puts 'Update aborted'
      elsif input =~ /^y/i
        wpscan_options.update = true
      end

      # Is there a database to go on with?
      if missing_db_files? and not wpscan_options.update
        # Check for data.zip
        if has_db_zip?
          puts notice('Extracting the Database ...')
          # Extract data.zip
          extract_db_zip
          puts notice('Extraction completed')
        # Missing, so can't go on!
        else
          puts critical('You can not run a scan without any databases')
          exit(1)
        end
      end
    end

    # Should we update?
    if wpscan_options.update
      puts notice('Updating the Database ...')
      DbUpdater.new(DATA_DIR).update(wpscan_options.verbose)
      puts notice('Update completed')

      # Exit program if only option --update is used
      exit(0) unless wpscan_options.url
    end

    unless wpscan_options.url
      raise 'The URL is mandatory, please supply it with --url or -u'
    end

    wp_target = WpTarget.new(wpscan_options.url, wpscan_options.to_h)

    if wp_target.wordpress_hosted?
      raise 'We do not support scanning *.wordpress.com hosted blogs'
    end

    if wp_target.ssl_error?
      raise "The target site returned an SSL/TLS error. You can try again using --disable-tls-checks\nError: #{wp_target.get_root_path_return_code}\nSee here for a detailed explanation of the error: http://www.rubydoc.info/github/typhoeus/ethon/Ethon/Easy:return_code"
    end

    # Remote website up?
    unless wp_target.online?
      if wpscan_options.user_agent
        puts info("User-Agent: #{wpscan_options.user_agent}")
        raise "The WordPress URL supplied '#{wp_target.uri}' seems to be down. Maybe the site is blocking the user-agent?"
      else
        raise "The WordPress URL supplied '#{wp_target.uri}' seems to be down. Maybe the site is blocking the wpscan user-agent, so you can try --random-agent"
      end

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
          print '[?] Do you want follow the redirection ? [Y]es [N]o [A]bort, default: [N] >'
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
        raise 'The remote website is up, but does not seem to be running WordPress. If you are sure, use --force'
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
    start_memory = get_memory_usage unless windows?
    puts info("URL: #{wp_target.url}")
    puts info("Started: #{start_time.asctime}")
    puts info("User-Agent: #{wpscan_options.user_agent}") if wpscan_options.verbose and wpscan_options.user_agent
    puts

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

    if wp_target.has_robots?
      code = get_http_status(wp_target.robots_url)
      puts info("robots.txt available under: #{wp_target.robots_url}   [HTTP #{code}]")

      wp_target.parse_robots_txt.each do |dir|
        code = get_http_status(dir)
        puts info("Interesting entry from robots.txt: #{dir}   [HTTP #{code}]")
      end
    end

    if wp_target.has_sitemap?
      code = get_http_status(wp_target.sitemap_url)
      puts info("Sitemap found: #{wp_target.sitemap_url}   [HTTP #{code}]")

      wp_target.parse_sitemap.each do |dir|
        code = get_http_status(dir)
        puts info("Sitemap entry: #{dir}   [HTTP #{code}]")
      end
    end

    code = get_http_status(wp_target.humans_url)
    if code == 200
      puts info("humans.txt available under: #{wp_target.humans_url}   [HTTP #{code}]")

      parse_txt(wp_target.humans_url).each do |dir|
        puts info("Entry from humans.txt: #{dir}")
      end
    end

    code = get_http_status(wp_target.security_url)
    if code == 200
      puts info("security.txt available under: #{wp_target.security_url}   [HTTP #{code}]")

      parse_txt(wp_target.security_url).each do |dir|
        puts info("Entry from security.txt: #{dir}")
      end
    end

    unless wp_target.sql_file_export.empty?
      wp_target.sql_file_export.each do |file|
        puts critical("SQL export file found: #{file}")
      end
    end

    if wp_target.has_debug_log?
      puts critical("Debug log file found: #{wp_target.debug_log_url}")
    end

    wp_target.config_backup.each do |file_url|
      puts critical("A wp-config.php backup file has been found in: #{file_url}")
    end

    if wp_target.search_replace_db_2_exists?
      puts critical("searchreplacedb2.php has been found in: #{wp_target.search_replace_db_2_url}")
    end

    if wp_target.emergency_exists?
      puts critical("emergency.php has been found in: #{wp_target.emergency_url}")
    end

    if wp_target.multisite?
      puts info('This site seems to be a multisite (http://codex.wordpress.org/Glossary#Multisite)')
    end

    if wp_target.has_must_use_plugins?
      puts info("This site has 'Must Use Plugins' (http://codex.wordpress.org/Must_Use_Plugins)")
    end

    if wp_target.has_xml_rpc?
      code = get_http_status(wp_target.xml_rpc_url)
      puts info("XML-RPC Interface available under: #{wp_target.xml_rpc_url}   [HTTP #{code}]")
    end

    # Test to see if MAIN API URL gives anything back
    if wp_target.has_api?(wp_target.json_url)
      code = get_http_status(wp_target.json_url)
      puts info("API exposed: #{wp_target.json_url}   [HTTP #{code}]")

      # Test to see if USER API URL gives anything back
      if wp_target.has_api?(wp_target.json_users_url)
        # Print users from JSON
        wp_target.json_get_users(wp_target.json_users_url)
      end
    end

    # Get RSS
    rss = wp_target.rss_url
    if rss
      code = get_http_status(rss)
      puts info("Found an RSS Feed: #{rss}   [HTTP #{code}]")

      # Print users from RSS feed
      wp_target.rss_authors(rss)
    end

    if wp_target.has_full_path_disclosure?
      puts warning("Full Path Disclosure (FPD) in '#{wp_target.full_path_disclosure_url}': #{wp_target.full_path_disclosure_data}")
    end

    if wp_target.upload_directory_listing_enabled?
      puts warning("Upload directory has directory listing enabled: #{wp_target.upload_dir_url}")
    end

    if wp_target.include_directory_listing_enabled?
      puts warning("Includes directory has directory listing enabled: #{wp_target.includes_dir_url}")
    end

    enum_options = {
      show_progression: true,
      exclude_content: wpscan_options.exclude_content_based
    }
    
    puts
    puts info('Enumerating WordPress version ...')
    if (wp_version = wp_target.version(WP_VERSIONS_FILE))
      if wp_target.has_readme? && VersionCompare::lesser?(wp_version.identifier, '4.7')
        puts warning("The WordPress '#{wp_target.readme_url}' file exists exposing a version number")
      end

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
        grammar = grammar_s(wp_plugins.size)
        puts " | #{wp_plugins.size} plugin#{grammar} found:"
        wp_plugins.output(wpscan_options.verbose)
      else
        puts info('No plugins found passively')
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

      wp_plugins = WpPlugins.aggressive_detection(wp_target,
        enum_options.merge(
          file: PLUGINS_FILE,
          type: plugin_enumeration_type
        )
      )

      puts
      if !wp_plugins.empty?
        grammar = grammar_s(wp_plugins.size)
        puts info("We found #{wp_plugins.size} plugin#{grammar}:")

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
        grammar = grammar_s(wp_themes.size)
        puts info("We found #{wp_themes.size} theme#{grammar}:")

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
          file: TIMTHUMBS_FILE,
          theme_name: wp_theme ? wp_theme.name : nil
        )
      )
      puts
      if !wp_timthumbs.empty?
        grammar = grammar_s(wp_timthumbs.size)
        puts info("We found #{wp_timthumbs.size} timthumb file#{grammar}:")

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
        puts warning("Stop User Enumeration plugin detected, results might be empty. However a bypass exists for v1.2.8 and below, see stop_user_enumeration_bypass.rb in #{__dir__}")
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
        grammar = grammar_s(wp_users.size)
        puts info("We identified the following #{wp_users.size} user#{grammar}:")
        wp_users.output(margin_left: ' ' * 4)
        if wp_users[0].login == "admin"
           puts warning("Default first WordPress username 'admin' is still used")
        end
      end

    else
      wp_users = WpUsers.new

      # Username file?
      if wpscan_options.usernames
        File.open(wpscan_options.usernames).each do |username|
          wp_users << WpUser.new(wp_target.uri, login: username.chomp)
        end
      # Single username?
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
    used_memory = get_memory_usage - start_memory unless windows?

    puts
    puts info("Finished: #{stop_time.asctime}")
    puts info("Elapsed time: #{Time.at(elapsed).utc.strftime('%H:%M:%S')}")
    puts info("Requests made: #{@total_requests_done}")
    puts info("Memory used: #{used_memory.bytes_to_human}") unless windows?

  # do nothing on interrupt
  rescue Interrupt
    exit(1)
  # Error on Updating
  rescue ChecksumError => e
    puts critical(e.message)

    if e.file
      puts critical("Current Version: #{WPSCAN_VERSION}")
      puts critical('Downloaded File Content:')
      puts e.file[0..500] # print first 500 chars
      puts '.........'
      puts e.file[-500..-1] || e.file # print last 500 chars or the whole file if it's < 500
      puts
    end

    puts critical('Some hints to help you with this issue:')
    puts critical('-) Try updating again using --verbose')
    puts critical('-) If you see SSL/TLS related error messages you have to fix your local TLS setup')
    puts critical('-) Windows is still not supported')
    exit(1)
  rescue => e
    puts
    puts critical(e.message)

    if wpscan_options && wpscan_options.verbose
      puts critical('Trace:')
      puts critical(e.backtrace.join("\n"))
    end
    exit(1)
  ensure
    # Make sure there was an argument
    if ARGV.length != 0
      # Ensure a clean abort of Hydra
      # See https://github.com/wpscanteam/wpscan/issues/461#issuecomment-42735615
      Browser.instance.hydra.abort
      Browser.instance.hydra.run
    end
  end
end

main()
exit($exit_code)
