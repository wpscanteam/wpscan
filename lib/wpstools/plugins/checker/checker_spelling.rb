# encoding: UTF-8

class CheckerSpelling < Plugin

  def initialize
    super(author: 'WPScanTeam - @ethicalhack3r')

    register_options(['--spellcheck', '--sc', 'Check all files for common spelling mistakes.'])
  end

  def run(options = {})
    spellcheck if options[:spellcheck]
  end

  def spellcheck
    mistakes = 0

    puts '[+] Checking for spelling mistakes'
    puts

    files.each do |file_name|
      if File.exists?(file_name)
        file = File.open(file_name, 'r')

        misspellings.each_key do |misspelling|
          begin
            file.read.scan(/#{misspelling}/).each do |match|
              mistakes += 1
              puts "[MISSPELLING] File: #{file_name} Bad: #{match} Good: #{misspellings[misspelling]}"
            end
          rescue => e
            puts "Error in #{file_name} #{e}"
            next
          end
        end

        file.close
      end
    end

    puts
    puts "[+] Found #{mistakes} spelling mistakes"

    mistakes
  end

  def misspellings
    {
      /databse/i    => 'database',
      /whith/i      => 'with',
      /wich/i       => 'which',
      /verions/i    => 'versions',
      /vulnerabilitiy/i => 'vulnerability',
      /unkown/i     => 'unknown',
      /recieved/i   => 'received',
      /acheive/i    => 'achieve',
      /wierd/i      => 'weird',
      /untill/i     => 'until',
      /alot/i       => 'a lot',
      /randomstorm/ => 'RandomStorm',
      /wpscan/      => 'WPScan',
      /Wordpress/   => 'WordPress'
    }
  end

  def files
    files = Dir['**/*'].reject {|fn| File.directory?(fn) }

    ignore.each do |ignore|
      files.delete_if { |data| data.match(ignore) }
    end

    files
  end

  def ignore
    ignore = []

    ignore << File.basename(__FILE__)
    ignore << 'spec/cache/'
    ignore << 'spec/spec_session/'
    ignore << 'cache/'
    ignore << 'coverage/'
    ignore << 'wordlist-iso-8859-1'
    ignore << 'log.txt'
    ignore << 'debug.log'
    ignore << 'wordlist.txt'

    ignore
  end
end