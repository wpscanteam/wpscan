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
      progress_bar = self.progress_bar(passwords.size, options)

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

    # @param [ Integer ] targets_size
    # @param [ Hash ] options
    #
    # @return [ ProgressBar ]
    # :nocov:
    def progress_bar(passwords_size, options)
      if options[:show_progression]
        ProgressBar.create(
          format: '%t %a <%B> (%c / %C) %P%% %e',
          title: "  Brute Forcing '#{login}'",
          total: passwords_size
        )
      end
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
        progression = "#{green('[SUCCESS]')} Login : #{login} Password : #{password}\n\n"
        valid       = true
      elsif response.body =~ /login_error/i
        verbose = "\n  Incorrect login and/or password."
      elsif response.timed_out?
        progression = "#{red('ERROR:')} Request timed out."
      elsif response.code == 0
        progression = "#{red('ERROR:')} No response from remote server. WAF/IPS?"
      elsif response.code.to_s =~ /^50/
        progression = "#{red('ERROR:')} Server error, try reducing the number of threads."
      else
        progression = "#{red('ERROR:')} We received an unknown response for #{password}..."
        verbose     = red("    Code: #{response.code}\n    Body: #{response.body}\n")
      end

      puts "\n  " + progression if progression && options[:show_progression]
      puts verbose if verbose && options[:verbose]

      valid || false
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
