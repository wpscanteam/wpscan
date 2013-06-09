![alt text](http://dvwa.co.uk/images/wpscan_logo_407x80.png "WPScan - WordPress Security Scanner")

#### LICENSE

WPScan - WordPress Security Scanner
Copyright (C), 2011-2013 The WPScan Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

ryandewhurst at gmail

#### INSTALL

WPScan comes pre-installed on the following Linux distributions:

- [BackBox Linux](http://www.backbox.org/)
- [BackTrack Linux](http://www.backtrack-linux.org/) (outdated WPScan installed, update needed)
- [Pentoo](http://www.pentoo.ch/)
- [SamuraiWTF](http://samurai.inguardians.com/)

Prerequisites:

- Windows not supported
- Ruby => 1.9
- RubyGems
- Git

*Installing on Debian/Ubuntu:*

```sudo apt-get install libcurl4-gnutls-dev libopenssl-ruby libxml2 libxml2-dev libxslt1-dev ruby-dev```

```git clone https://github.com/wpscanteam/wpscan.git```

```cd wpscan```

```sudo gem install bundler && bundle install --without test development```

*Installing on Fedora:*

```sudo yum install libcurl-devel```

```git clone https://github.com/wpscanteam/wpscan.git```

```cd wpscan```

```sudo gem install bundler && bundle install --without test development```

*Installing on Archlinux:*

```pacman -Syu ruby```

```pacman -Syu libyaml```

```git clone https://github.com/wpscanteam/wpscan.git```

```cd wpscan```

```sudo gem install bundler && bundle install --without test development```

```gem install typhoeus```

```gem install nokogiri```

*Installing on Mac OSX:*

```git clone https://github.com/wpscanteam/wpscan.git```

```cd wpscan```

```sudo gem install bundler && bundle install --without test development```

#### KNOWN ISSUES

  - Typhoeus segmentation fault

      Update cURL to version => 7.21 (may have to install from source)
      See http://code.google.com/p/wpscan/issues/detail?id=81

  - Proxy not working

      Update cURL to version => 7.21.7 (may have to install from source).

      Installation from sources :
      ```
        Grab the sources from http://curl.haxx.se/download.html
        Decompress the archive
        Open the folder with the extracted files
        Run ./configure
        Run make
        Run sudo make install
        Run sudo ldconfig
      ```

  - cannot load such file -- readline:

      ```sudo aptitude install libreadline5-dev libncurses5-dev```

      Then, open the directory of the readline gem (you have to locate it)
      ```
        cd ~/.rvm/src/ruby-1.9.2-p180/ext/readline
        ruby extconf.rb
        make
        make install
      ```

      See http://vvv.tobiassjosten.net/ruby-on-rails/fixing-readline-for-the-ruby-on-rails-console/ for more details

  - no such file to load -- rubygems

      ```update-alternatives --config ruby```

      And select your ruby version

      See https://github.com/wpscanteam/wpscan/issues/148

#### WPSCAN ARGUMENTS

    --update  Update to the latest revision

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
    Multiple values are allowed : '-e tt,p' will enumerate timthumbs and plugins
    If no option is supplied, the default is 'vt,tt,u,vp'

    --exclude-content-based '<regexp or string>'  Used with the enumeration option, will exclude all occurrences based on the regexp or string supplied
                                                  You do not need to provide the regexp delimiters, but you must write the quotes (simple or double)

    --config-file | -c <config file> Use the specified config file

    --follow-redirection  If the target url has a redirection, it will be followed without asking if you wanted to do so or not

    --wp-content-dir <wp content dir>  WPScan try to find the content directory (ie wp-content) by scanning the index page, however you can specified it. Subdirectories are allowed

    --wp-plugins-dir <wp plugins dir>  Same thing than --wp-content-dir but for the plugins directory. If not supplied, WPScan will use wp-content-dir/plugins. Subdirectories are allowed

    --proxy <[protocol://]host:port>  Supply a proxy (will override the one from conf/browser.conf.json).
                                      HTTP, SOCKS4 SOCKS4A and SOCKS5 are supported. If no protocol is given (format host:port), HTTP will be used

    --proxy-auth <username:password>  Supply the proxy login credentials (will override the one from conf/browser.conf.json).

    --basic-auth <username:password>  Set the HTTP Basic authentication

    --wordlist | -w <wordlist>  Supply a wordlist for the password bruter and do the brute.

    --threads  | -t <number of threads>  The number of threads to use when multi-threading requests. (will override the value from conf/browser.conf.json)

    --username | -U <username>  Only brute force the supplied username.

    --help     | -h This help screen.

    --verbose  | -v Verbose output.

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

Update WPScan...

```ruby wpscan.rb --update```

Debug output...

```ruby wpscan.rb --url www.example.com --debug-output 2>debug.log```

#### WPSTOOLS ARGUMENTS

    --help    | -h   This help screen.
    --Verbose | -v   Verbose output.
    --update  | -u   Update to the latest revision.
    --generate_plugin_list [number of pages]  Generate a new data/plugins.txt file. (supply number of *pages* to parse, default : 150)
    --gpl  Alias for --generate_plugin_list
    --check-local-vulnerable-files | --clvf <local directory>  Perform a recursive scan in the <local directory> to find vulnerable files or shells

#### WPSTOOLS EXAMPLES

Generate a new 'most popular' plugin list, up to 150 pages...

```ruby wpstools.rb --generate_plugin_list 150```

Locally scan a wordpress installation for vulnerable files or shells :
```ruby wpstools.rb --check-local-vulnerable-files /var/www/wordpress/```


#### PROJECT HOME

www.wpscan.org

#### GIT REPOSITORY

https://github.com/wpscanteam/wpscan

#### ISSUES

https://github.com/wpscanteam/wpscan/issues

#### SPONSOR

WPScan is sponsored by the [RandomStorm](http://www.randomstorm.com) Open Source Initiative.
