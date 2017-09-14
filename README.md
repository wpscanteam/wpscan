![alt text](https://raw.githubusercontent.com/wpscanteam/wpscan/gh-pages/wpscan_logo_407x80.png "WPScan - WordPress Security Scanner")


[![Build Status](https://travis-ci.org/wpscanteam/wpscan.svg?branch=master)](https://travis-ci.org/wpscanteam/wpscan)
[![Code Climate](https://img.shields.io/codeclimate/github/wpscanteam/wpscan.svg)](https://codeclimate.com/github/wpscanteam/wpscan)
[![Dependency Status](https://img.shields.io/gemnasium/wpscanteam/wpscan.svg)](https://gemnasium.com/wpscanteam/wpscan)
[![Docker Pulls](https://img.shields.io/docker/pulls/wpscanteam/wpscan.svg)](https://hub.docker.com/r/wpscanteam/wpscan/)

# LICENSE

## WPScan Public Source License

The WPScan software (henceforth referred to simply as "WPScan") is dual-licensed - Copyright 2011-2016 WPScan Team.

Cases that include commercialization of WPScan require a commercial, non-free license. Otherwise, WPScan can be used without charge under the terms set out below.

### 1. Definitions

1.1 "License" means this document.

1.2 "Contributor" means each individual or legal entity that creates, contributes to the creation of, or owns WPScan.

1.3 "WPScan Team" means WPScan’s core developers, an updated list of whom can be found within the CREDITS file.

### 2. Commercialization

A commercial use is one intended for commercial advantage or monetary compensation.

Example cases of commercialization are:

 - Using WPScan to provide commercial managed/Software-as-a-Service services.
 - Distributing WPScan as a commercial product or as part of one.
 - Using WPScan as a value added service/product.

Example cases which do not require a commercial license, and thus fall under the terms set out below, include (but are not limited to):

 - Penetration testers (or penetration testing organizations) using WPScan as part of their assessment toolkit.
 - Penetration Testing Linux Distributions including but not limited to Kali Linux, SamuraiWTF, BackBox Linux.
 - Using WPScan to test your own systems.
 - Any non-commercial use of WPScan.

If you need to purchase a commercial license or are unsure whether you need to purchase a commercial license contact us - team@wpscan.org.

We may grant commercial licenses at no monetary cost at our own discretion if the commercial usage is deemed by the WPScan Team to significantly benefit WPScan.

Free-use Terms and Conditions;

### 3. Redistribution

Redistribution is permitted under the following conditions:

 - Unmodified License is provided with WPScan.
 - Unmodified Copyright notices are provided with WPScan.
 - Does not conflict with the commercialization clause.

### 4. Copying

Copying is permitted so long as it does not conflict with the Redistribution clause.

### 5. Modification

Modification is permitted so long as it does not conflict with the Redistribution clause.

### 6. Contributions

Any Contributions assume the Contributor grants the WPScan Team the unlimited, non-exclusive right to reuse, modify and relicense the Contributor's content.

### 7. Support

WPScan is provided under an AS-IS basis and without any support, updates or maintenance. Support, updates and maintenance may be given according to the sole discretion of the WPScan Team.

### 8. Disclaimer of Warranty

WPScan is provided under this License on an “as is” basis, without warranty of any kind, either expressed, implied, or statutory, including, without limitation, warranties that the WPScan is free of defects, merchantable, fit for a particular purpose or non-infringing.

### 9. Limitation of Liability

To the extent permitted under Law, WPScan is provided under an AS-IS basis. The WPScan Team shall never, and without any limit, be liable for any damage, cost, expense or any other payment incurred as a result of WPScan's actions, failure, bugs and/or any other interaction between WPScan and end-equipment, computers, other software or any 3rd party, end-equipment, computer or services.

### 10. Disclaimer

Running WPScan against websites without prior mutual consent may be illegal in your country. The WPScan Team accept no liability and are not responsible for any misuse or damage caused by WPScan.

### 11. Trademark

The "wpscan" term is a registered trademark. This License does not grant the use of the "wpscan" trademark or the use of the WPScan logo.

# INSTALL

WPScan comes pre-installed on the following Linux distributions:

- [BackBox Linux](http://www.backbox.org/)
- [Kali Linux](http://www.kali.org/)
- [Pentoo](http://www.pentoo.ch/)
- [SamuraiWTF](http://samurai.inguardians.com/)
- [BlackArch](http://blackarch.org/)

On macOS WPScan is packaged by [Homebrew](https://brew.sh/) as [`wpscan`](http://braumeister.org/formula/wpscan).

Windows is not supported

We suggest you use our official Docker image from https://hub.docker.com/r/wpscanteam/wpscan/ to avoid installation problems.

# DOCKER
Pull the repo with `docker pull wpscanteam/wpscan`

## Start WPScan

```
docker run -it --rm wpscanteam/wpscan -u https://yourblog.com [options]
```

For the available Options, please see https://github.com/wpscanteam/wpscan#wpscan-arguments

If you run the git version of wpscan we included some binstubs in ./bin for easier start of wpscan.

## Examples

Mount a local wordlist to the docker container and start a bruteforce attack for user admin

```
docker run -it --rm -v ~/wordlists:/wordlists wpscanteam/wpscan --url https://yourblog.com --wordlist /wordlists/crackstation.txt --username admin
```

(This mounts the host directory `~/wordlists` to the container in the path `/wordlists`)

Use logfile option
```
# the file must exist prior to starting the container, otherwise docker will create a directory with the filename
touch ~/FILENAME
docker run -it --rm -v ~/FILENAME:/wpscan/output.txt wpscanteam/wpscan --url https://yourblog.com --log /wpscan/output.txt
```

Published on https://hub.docker.com/r/wpscanteam/wpscan/

# Manual install

## Prerequisites

- Ruby >= 2.1.9 - Recommended: 2.4.2
- Curl >= 7.21  - Recommended: latest - FYI the 7.29 has a segfault
- RubyGems      - Recommended: latest
- Git

### Installing dependencies on Ubuntu

    sudo apt-get install libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev

### Installing dependencies on Debian

    sudo apt-get install gcc git ruby ruby-dev libcurl4-openssl-dev make zlib1g-dev

### Installing dependencies on Fedora

    sudo dnf install gcc ruby-devel libxml2 libxml2-devel libxslt libxslt-devel libcurl-devel patch rpm-build

### Installing dependencies on Arch Linux

    pacman -Syu ruby
    pacman -Syu libyaml

### Installing dependencies on macOS

Apple Xcode, Command Line Tools and the libffi are needed (to be able to install the FFI gem), See [http://stackoverflow.com/questions/17775115/cant-setup-ruby-environment-installing-fii-gem-error](http://stackoverflow.com/questions/17775115/cant-setup-ruby-environment-installing-fii-gem-error)

## Installing with RVM (recommended when doing a manual install)

If you are using GNOME Terminal, there are some steps required before executing the commands. See here for more information:
https://rvm.io/integration/gnome-terminal#integrating-rvm-with-gnome-terminal

    # Install all prerequisites for your OS (look above)
    cd ~
    curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
    rvm install 2.4.2
    rvm use 2.4.2 --default
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    gem install bundler
    bundle install --without test

## Installing manually (not recommended)

    git clone https://github.com/wpscanteam/wpscan.git
    cd wpscan
    sudo gem install bundler && bundle install --without test

# KNOWN ISSUES

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

        cd ~/.rvm/src/ruby-XXXX/ext/readline
        ruby extconf.rb
        make
        make install


      See [http://vvv.tobiassjosten.net/ruby-on-rails/fixing-readline-for-the-ruby-on-rails-console/](http://vvv.tobiassjosten.net/ruby-on-rails/fixing-readline-for-the-ruby-on-rails-console/) for more details

  - no such file to load -- rubygems

      ```update-alternatives --config ruby```

      And select your ruby version

      See [https://github.com/wpscanteam/wpscan/issues/148](https://github.com/wpscanteam/wpscan/issues/148)

# WPSCAN ARGUMENTS

    --update                            Update the database to the latest version.
    --url       | -u <target url>       The WordPress URL/domain to scan.
    --force     | -f                    Forces WPScan to not check if the remote site is running WordPress.
    --enumerate | -e [option(s)]        Enumeration.
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

    --exclude-content-based "<regexp or string>"
                                        Used with the enumeration option, will exclude all occurrences based on the regexp or string supplied.
                                        You do not need to provide the regexp delimiters, but you must write the quotes (simple or double).
    --config-file  | -c <config file>   Use the specified config file, see the example.conf.json.
    --user-agent   | -a <User-Agent>    Use the specified User-Agent.
    --cookie <string>                   String to read cookies from.
    --random-agent | -r                 Use a random User-Agent.
    --follow-redirection                If the target url has a redirection, it will be followed without asking if you wanted to do so or not
    --batch                             Never ask for user input, use the default behaviour.
    --no-color                          Do not use colors in the output.
    --log [filename]                    Creates a log.txt file with WPScan's output if no filename is supplied. Otherwise the filename is used for logging.
    --no-banner                         Prevents the WPScan banner from being displayed.
    --disable-accept-header             Prevents WPScan sending the Accept HTTP header.
    --disable-referer                   Prevents setting the Referer header.
    --disable-tls-checks                Disables SSL/TLS certificate verification.
    --wp-content-dir <wp content dir>   WPScan try to find the content directory (ie wp-content) by scanning the index page, however you can specify it.
                                        Subdirectories are allowed.
    --wp-plugins-dir <wp plugins dir>   Same thing than --wp-content-dir but for the plugins directory.
                                        If not supplied, WPScan will use wp-content-dir/plugins. Subdirectories are allowed
    --proxy <[protocol://]host:port>    Supply a proxy. HTTP, SOCKS4 SOCKS4A and SOCKS5 are supported.
                                        If no protocol is given (format host:port), HTTP will be used.
    --proxy-auth <username:password>    Supply the proxy login credentials.
    --basic-auth <username:password>    Set the HTTP Basic authentication.
    --wordlist | -w <wordlist>          Supply a wordlist for the password brute forcer.
                                        If the "-" option is supplied, the wordlist is expected via STDIN.
    --username | -U <username>          Only brute force the supplied username.
    --usernames     <path-to-file>      Only brute force the usernames from the file.
    --cache-dir       <cache-directory> Set the cache directory.
    --cache-ttl       <cache-ttl>       Typhoeus cache TTL.
    --request-timeout <request-timeout> Request Timeout.
    --connect-timeout <connect-timeout> Connect Timeout.
    --threads  | -t <number of threads> The number of threads to use when multi-threading requests.
    --max-threads     <max-threads>     Maximum Threads.
    --throttle        <milliseconds>    Milliseconds to wait before doing another web request. If used, the --threads should be set to 1.
    --help     | -h                     This help screen.
    --verbose  | -v                     Verbose output.
    --version                           Output the current version and exit.

# WPSCAN EXAMPLES

Do 'non-intrusive' checks...

```ruby wpscan.rb --url www.example.com```

Do wordlist password brute force on enumerated users using 50 threads...

```ruby wpscan.rb --url www.example.com --wordlist darkc0de.lst --threads 50```

Do wordlist password brute force on enumerated users using STDIN as the wordlist...

```crunch 5 13 -f charset.lst mixalpha | ruby wpscan.rb --url www.example.com --wordlist -```

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

# PROJECT HOME

[http://www.wpscan.org](http://www.wpscan.org)

# VULNERABILITY DATABASE

[https://wpvulndb.com](https://wpvulndb.com)

# GIT REPOSITORY

[https://github.com/wpscanteam/wpscan](https://github.com/wpscanteam/wpscan)

# ISSUES

[https://github.com/wpscanteam/wpscan/issues](https://github.com/wpscanteam/wpscan/issues)

# DEVELOPER DOCUMENTATION

[http://rdoc.info/github/wpscanteam/wpscan/frames](http://rdoc.info/github/wpscanteam/wpscan/frames)
