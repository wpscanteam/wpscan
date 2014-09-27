![alt text](https://raw.githubusercontent.com/wpscanteam/wpscan/gh-pages/wpscan_logo_407x80.png "WPScan - WordPress Security Scanner")

[![Build Status](https://travis-ci.org/wpscanteam/wpscan.png?branch=master)](https://travis-ci.org/wpscanteam/wpscan)

#### LICENSE

The WPScan software and its data (henceforth both referred to simply as "WPScan") is dual-licensed - copyright 2011-2014 The WPScan Team.

Cases that include commercialization of WPScan require a commercial, non-free license. Otherwise, the system can be used under the terms of the GNU General Public License.

Cases of commercialization are:

- Using WPScan to provide commercial managed/Software-as-a-Service services.
- Distributing WPScan as a commercial product or as part of one.

Cases which do not require a commercial license, and thus fall under the terms of GNU General Public License, include (but are not limited to):

- Penetration testers (or penetration testing organizations) using WPScan as part of their assessment toolkit. So long as that does not conflict with the commercialization clause.
- Using WPScan to test your own systems.
- Any non-commercial use of WPScan.

If you need to acquire a commercial license or are unsure about whether you need to acquire a commercial license, please get in touch, we will be happy to clarify things for you and work with you to accommodate your requirements.

wpscanteam at gmail.com

You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

#### INSTALL

WPScan comes pre-installed on the following Linux distributions:

- [BackBox Linux](http://www.backbox.org/)
- [Kali Linux](http://www.kali.org/)
- [Pentoo](http://www.pentoo.ch/)
- [SamuraiWTF](http://samurai.inguardians.com/)
- [ArchAssault](https://archassault.org/)

Prerequisites:

- Ruby >= 1.9.2 - Recommended: 2.1.2
- Curl >= 7.21  - Recommended: latest - FYI the 7.29 has a segfault
- RubyGems      - Recommended: latest
- Git

Windows is not supported.

####Installing on Ubuntu:

Before Ubuntu 14.04:

    sudo apt-get install libcurl4-gnutls-dev libopenssl-ruby libxml2 libxml2-dev libxslt1-dev ruby-dev

From Ubuntu 14.04:

    sudo apt-get install libcurl4-gnutls-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential
    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    sudo gem install bundler && bundle install --without test

####Installing on Debian:

    sudo apt-get install git ruby ruby-dev libcurl4-gnutls-dev make
    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    sudo gem install bundler
    bundle install --without test --path vendor/bundle

####Installing on Fedora:

    sudo yum install gcc ruby-devel libxml2 libxml2-devel libxslt libxslt-devel libcurl-devel
    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    sudo gem install bundler && bundle install --without test

####Installing on Archlinux:

    pacman -Syu ruby
    pacman -Syu libyaml
    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    sudo gem install bundler && bundle install --without test
    gem install typhoeus
    gem install nokogiri

####Installing on Mac OSX:

Apple Xcode, Command Line Tools and the libffi are needed (to be able to install the FFI gem), See [http://stackoverflow.com/questions/17775115/cant-setup-ruby-environment-installing-fii-gem-error](http://stackoverflow.com/questions/17775115/cant-setup-ruby-environment-installing-fii-gem-error)

    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    sudo gem install bundler && sudo bundle install --without test

####Installing with RVM:

    cd ~
    curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
    rvm install 2.1.2
    rvm use 2.1.2 --default
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
    gem install bundler
    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    bundle install --without test

#### KNOWN ISSUES

  - Typhoeus segmentation fault

      Update cURL to version => 7.21 (may have to install from source)

  - Proxy not working

      Update cURL to version => 7.21.7 (may have to install from source).

      Installation from sources :
      
        Grab the sources from http://curl.haxx.se/download.html
        Decompress the archive
        Open the folder with the extracted files
        Run ./configure
        Run make
        Run sudo make install
        Run sudo ldconfig
      

  - cannot load such file -- readline:

        sudo aptitude install libreadline5-dev libncurses5-dev

      Then, open the directory of the readline gem (you have to locate it)
      
        cd ~/.rvm/src/ruby-1.9.2-p180/ext/readline
        ruby extconf.rb
        make
        make install
      

      See [http://vvv.tobiassjosten.net/ruby-on-rails/fixing-readline-for-the-ruby-on-rails-console/](http://vvv.tobiassjosten.net/ruby-on-rails/fixing-readline-for-the-ruby-on-rails-console/) for more details

  - no such file to load -- rubygems

      ```update-alternatives --config ruby```

      And select your ruby version

      See [https://github.com/wpscanteam/wpscan/issues/148](https://github.com/wpscanteam/wpscan/issues/148)

#### WPSCAN ARGUMENTS

    --update   Update the databases.

    --url   | -u <target url>  The WordPress URL/domain to scan.

    --force | -f Forces WPScan to not check if the remote site is running WordPress.

    --enumerate | -e [option(s)]  Enumeration.
      option :
        u        usernames from id 1 to 10
        u[10-20] usernames from id 10 to 20 (you must write [] chars)
        p        plugins
        vp       only vulnerable plugins
        ap       all plugins (can take a long time)
        tt       timthumbs
        t        themes
        vt       only vulnerable themes
        at       all themes (can take a long time)
      Multiple values are allowed : "-e tt,p" will enumerate timthumbs and plugins
      If no option is supplied, the default is "vt,tt,u,vp"

    --exclude-content-based "<regexp or string>" Used with the enumeration option, will exclude all occurrences based on the regexp or string supplied
                                                 You do not need to provide the regexp delimiters, but you must write the quotes (simple or double)

    --config-file | -c <config file> Use the specified config file, see the example.conf.json

    --user-agent | -a <User-Agent> Use the specified User-Agent

    --random-agent | -r Use a random User-Agent

    --follow-redirection  If the target url has a redirection, it will be followed without asking if you wanted to do so or not

    --wp-content-dir <wp content dir>  WPScan try to find the content directory (ie wp-content) by scanning the index page, however you can specified it. Subdirectories are allowed

    --wp-plugins-dir <wp plugins dir>  Same thing than --wp-content-dir but for the plugins directory. If not supplied, WPScan will use wp-content-dir/plugins. Subdirectories are allowed

    --proxy <[protocol://]host:port> Supply a proxy (will override the one from conf/browser.conf.json).
                                     HTTP, SOCKS4 SOCKS4A and SOCKS5 are supported. If no protocol is given (format host:port), HTTP will be used

    --proxy-auth <username:password>  Supply the proxy login credentials.

    --basic-auth <username:password>  Set the HTTP Basic authentication.

    --wordlist | -w <wordlist>  Supply a wordlist for the password bruter and do the brute.

    --threads  | -t <number of threads>  The number of threads to use when multi-threading requests.

    --username | -U <username>  Only brute force the supplied username.

    --cache-ttl <cache-ttl>  Typhoeus cache TTL.

    --request-timeout <request-timeout>  Request Timeout.

    --connect-timeout <connect-timeout>  Connect Timeout.

    --max-threads <max-threads>  Maximum Threads.

    --help     | -h This help screen.

    --verbose  | -v Verbose output.

    --batch Never ask for user input, use the default behaviour.

    --no-color Do not use colors in the output.

#### WPSCAN EXAMPLES

Do 'non-intrusive' checks...

```ruby wpscan.rb --url www.example.com```

Do wordlist password brute force on enumerated users using 50 threads...

```ruby wpscan.rb --url www.example.com --wordlist darkc0de.lst --threads 50```

Do wordlist password brute force on the 'admin' username only...

```ruby wpscan.rb --url www.example.com --wordlist darkc0de.lst --username admin```

Enumerate installed plugins...

```ruby wpscan.rb --url www.example.com --enumerate p```

Run all enumeration tools...

```ruby wpscan.rb --url www.example.com --enumerate```

Use custom content directory...

```ruby wpscan.rb -u www.example.com --wp-content-dir custom-content```

Update WPScan's databases...

```ruby wpscan.rb --update```

Debug output...

```ruby wpscan.rb --url www.example.com --debug-output 2>debug.log```

#### WPSTOOLS ARGUMENTS

    -v, --verbose                                                Verbose output
        --check-vuln-ref-urls, --cvru                            Check all the vulnerabilities reference urls for 404
        --check-local-vulnerable-files, --clvf LOCAL_DIRECTORY   Perform a recursive scan in the LOCAL_DIRECTORY to find vulnerable files or shells
    -s, --stats                                                  Show WpScan Database statistics.
        --spellcheck, --sc                                       Check all files for common spelling mistakes.


#### WPSTOOLS EXAMPLES

Locally scan a wordpress installation for vulnerable files or shells:

```ruby wpstools.rb --check-local-vulnerable-files /var/www/wordpress/```

Or check [pyfiscan](https://github.com/fgeek/pyfiscan) project.

#### PROJECT HOME

[http://www.wpscan.org](http://www.wpscan.org)

#### VULNERABILITY DATABASE

[https://www.wpvulndb.com](https://www.wpvulndb.com)

#### GIT REPOSITORY

[https://github.com/wpscanteam/wpscan](https://github.com/wpscanteam/wpscan)

#### ISSUES

[https://github.com/wpscanteam/wpscan/issues](https://github.com/wpscanteam/wpscan/issues)

#### DEVELOPER DOCUMENTATION

[http://rdoc.info/github/wpscanteam/wpscan/frames](http://rdoc.info/github/wpscanteam/wpscan/frames)

#### SPONSOR

WPScan is sponsored by the [RandomStorm](http://www.randomstorm.com) Open Source Initiative.
