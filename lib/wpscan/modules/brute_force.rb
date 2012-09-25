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

module BruteForce

  # param array of string logins
  # param string wordlist_path
  def brute_force(logins, wordlist_path)
    hydra               = Browser.instance.hydra
    number_of_passwords = BruteForce.lines_in_file(wordlist_path)
    login_url           = login_url()
    found               = []

    logins.each do |login|
      queue_count    = 0
      request_count  = 0
      password_found = false

      File.open(wordlist_path, "r").each do |password|

        # ignore file comments, but will miss passwords if they start with a hash...
        next if password[0,1] == "#"

        # keep a count of the amount of requests to be sent
        request_count += 1
        queue_count   += 1

        # create local vars for on_complete call back, Issue 51.
        username = login.name
        password = password

        # the request object
        request = Browser.instance.forge_request(login_url,
          {
            :method => :post,
            :params => {:log => username, :pwd => password},
            :cache_timeout => 0
          }
        )

        # tell hydra what to do when the request completes
        request.on_complete do |response|

          puts "\n  Trying Username : #{username} Password : #{password}" if @verbose

          if response.body =~ /login_error/i
            puts "\nIncorrect username and/or password." if @verbose
          elsif response.code == 302
            puts "\n  " + green("[SUCCESS]") + " Username : #{username} Password : #{password}\n"
            found << { :name => username, :password => password }
            password_found = true
          elsif response.timed_out?
            puts red("ERROR:") + " Request timed out."
          elsif response.code == 0
            puts red("ERROR:") + " No response from remote server. WAF/IPS?"
          # code is a fixnum, needs a string for regex
          elsif response.code.to_s =~ /^50/
            puts red("ERROR:") + " Server error, try reducing the number of threads."
          else
            puts "\n" + red("ERROR:") + " We recieved an unknown response for #{password}..."
            if @verbose
              puts red("Code: #{response.code.to_s}")
              puts red("Body: #{response.body}")
              puts
            end
          end
        end

        # move onto the next username if we have found a valid password
        break if password_found

        # queue the request to be sent later
        hydra.queue(request)

        # progress indicator
        print "\r  Brute forcing user '#{username}' with #{number_of_passwords} passwords... #{(request_count * 100) / number_of_passwords}% complete."

        # it can take a long time to queue 2 million requests,
        # for that reason, we queue @threads, send @threads, queue @threads and so on.
        # hydra.run only returns when it has recieved all of its,
        # responses. This means that while we are waiting for @threads,
        # responses, we are waiting...
        if queue_count >= Browser.instance.max_threads
          hydra.run
          queue_count = 0
          puts "Sent #{Browser.instance.max_threads} requests ..." if @verbose
        end
      end

      # run all of the remaining requests
      hydra.run
    end
    found
  end

  # Counts the number of lines in the wordlist
  # It can take a couple of minutes on large
  # wordlists, although bareable.
  def self.lines_in_file(file_path)
    lines = 0
    File.open(file_path, 'r').each { || lines += 1 }
    lines
  end
end
