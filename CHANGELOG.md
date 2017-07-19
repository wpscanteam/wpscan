# Changelog
## Master
[Work in progress](https://github.com/wpscanteam/wpscan/compare/2.9.3...master)

## Version 2.9.3
Released: 2017-07-19

* Updated dependencies and required ruby version
* Made some changes so wpscan works in ruby 2.4
* Added a Gemfile.lock to lock all dependencies
* You can now pass a wordlist from stdin via "--wordlist -"
* Improved version detection regexes
* Added an optional paramter to --log to specify a filename

WPScan Database Statistics:
* Total tracked wordpresses: 251
* Total tracked plugins: 68818
* Total tracked themes: 15132
* Total vulnerable wordpresses: 243
* Total vulnerable plugins: 1527
* Total vulnerable themes: 280
* Total wordpress vulnerabilities: 5263
* Total plugin vulnerabilities: 2406
* Total theme vulnerabilities: 349

## Version 2.9.2
Released: 2016-11-15

* Fixed error when detecting plugins with UTF-8 characters
* Use all possible finders to verify a detected version
* Fix error when detecting a WordPress version not in our database
* Added some additional clarification on error messages
* Upgrade terminal-table gem
* Add --cache-dir option
* Add --disable-tls-checks options
* Improve/add additional plugin passive detections
* Remove scripts when calculating page hashes
* Many other small bug fixes.

WPScan Database Statistics:
* Total tracked wordpresses: 194
* Total tracked plugins: 63703
* Total tracked themes: 13835
* Total vulnerable wordpresses: 177
* Total vulnerable plugins: 1382
* Total vulnerable themes: 379
* Total wordpress vulnerabilities: 2617
* Total plugin vulnerabilities: 2190
* Total theme vulnerabilities: 452

## Version 2.9.1
Released: 2016-05-06

* Update to Ruby 2.3.1, drop older ruby support
* New data file location
* Added experimental Windows support
* Display WordPress metadata on the detected version
* Several small fixes

WPScan Database Statistics:
* Total vulnerable versions: 156
* Total vulnerable plugins:  1324
* Total vulnerable themes:   376
* Total version vulnerabilities: 1998
* Total plugin vulnerabilities:  2057
* Total theme vulnerabilities:   449

## Version 2.9
Released: 2015-10-15

New
* GZIP Encoding in updater
* Adds --throttle option to throttle requests
* Uses new API and local database file structure
* Adds last updated and latest version to plugins and themes

Removed
* ArchAssault from README
* APIv1 local databases

General core
* Update to Ruby 2.2.3
* Use yajl-ruby as JSON parser
* New dependancy for Ubuntu 14.04 (libgmp-dev)
* Use Travis container based infra and caching

Fixed issues
* Fix #835 - Readme requests to wp root dir
* Fix #836 - Critical icon output twice when the site is not running WP
* Fix #839 - Terminal-table dependency is broken
* Fix #841 - error: undefined method `cells' for #<Array:0x000000029cc2f8>
* Fix #852 - GZIP Encoding in updater
* Fix #853 - APIv2 integration
* Fix #858 - Detection FP
* Fix #873 - false positive "site has Must Use Plugins"

WPScan Database Statistics:
* Total vulnerable versions: 132
* Total vulnerable plugins:  1170
* Total vulnerable themes:   368
* Total version vulnerabilities: 1476
* Total plugin vulnerabilities:  1913
* Total theme vulnerabilities:   450

## Version 2.8
Released: 2015-06-22

New
* Warn the user to update his DB files
* Added last db update to --version option (see #815)
* Add db checksum to verbose logging during update
* Option to hide banner
* Continue if user chooses not to update + db exists
* Don't update if user chooses default + no DBs exist
* Updates request timeout values to realistic ones (and in seconds)

Removed
* Removed `Time.parse('2000-01-01')` expedient
* Removed unnecessary 'return' and '()'
* Removed debug output
* Removed wpstools

General core
* Update to Ruby 2.2.2
* Switch to mitre
* Install bundler gem README
* Switch from gnutls to openssl

Fixed issues
* Fix #789 - Add blackarch to readme
* Fix #790 - Consider the target down after 30 requests timed out requests instead of 10
* Fix #791 - Rogue character causing the scan of non-wordpress site to crash
* Fix #792 - Adds the HttpError exception
* Fix #795 - Remove GHOST warning
* Fix #796 - Do not swallow exit code
* Fix #797 - Increases the timeout values
* Fix #801 - Forces UTF-8 encoding when enumerating usernames
* Fix #803 - Increases default connect-timeout to 10s
* Fix #804 - Updates the Theme detection pattern
* Fix #816 - Ignores potential non version chars in theme version detection
* Fix #819 - Removes potential spaces in robots.txt entries

WPScan Database Statistics:
* Total vulnerable versions: 98
* Total vulnerable plugins:  1076
* Total vulnerable themes:   361
* Total version vulnerabilities: 1104
* Total plugin vulnerabilities:  1763
* Total theme vulnerabilities:   443

## Version 2.7
Released: 2015-03-16

New
* Detects version in release date format
* Copyrights updated
* WP version detection from stylesheets
* New license
* Global HTTP request counter
* Add security-protection plugin detection
* Add GHOST warning if XMLRPC enabled
* Update databases from wpvulndb.com
* Enumerate usernames from WP <= 3.0 (thanks berotti3)

Removed
* README.txt

General core
* Update to Ruby 2.2.1
* Update to Ruby 2.2.0
* Add addressable gem
* Update Typhoeus gem to 0.7.0
* IDN support: encode non-ascii domain names (thanks dctabuyz)
* Improve page hash calculation (thanks dctabuyz)
* Version detection regex improved

Fixed issues
* Fix #745 - Plugin version pattern in readme.txt file not detected
* Fix #746 - Add a global counter for all active requests to server.
* Fix #747 - Add 'security-protection' plugin to wp_login_protection module
* Fix #753 - undefined method `round' for "10":String for request or connect timeouts
* Fix #760 - typhoeus issue (infinite loop)

WPScan Database Statistics:
* Total vulnerable versions: 89
* Total vulnerable plugins:  953
* Total vulnerable themes:   329
* Total version vulnerabilities: 1070
* Total plugin vulnerabilities:  1451
* Total theme vulnerabilities:   378

## Version 2.6
Released: 2014-12-19

New
* Updates the readmes to reflect the new --usernames option
* Improves plugin/theme version detection by looking at the "Version:"
* Solution to avoid mandatory blank newline at the end of the wordlist
* Add check for valid credentials
* Add Sucuri sponsor to banner
* Add protocol to sucuri url in banner
* Add response code to proxy error output
* Add a statement about mandatory newlines at the end of list
* Give warning if default username 'admin' is still used
* License amendment to make it more clear about value added usage

Removed
* remove malwares
* remove malware folder
* Removes the theme version check from the readme, unrealistic scenario

General core
* Update to Ruby 2.1.5 and travis
* Prevent parent theme infinite loop
* Fixes the progressbar being overriden by next brute forcing attempts

Fixed issues
* Fix UTF-8 encode on security db file download
* Fix #703 - Disable logging by default. Implement log option.
* Fix #705 - Installation instructions for Ubuntu < 14.04 apparently incomplete
* Fix #717 - Expand on readme.html finding output
* Fix #716 - Adds the --version in the help
* Fix #715 - Add new updating info to docs
* Fix #727 - WpItems detection: Perform the passive check and filter only vulnerable results at the end if required
* Fix #737 - Adds some readme files to check for plugin versions
* Fix #739 - Adds the --usernames option

WPScan Database Statistics:
* Total vulnerable versions: 88
* Total vulnerable plugins: 901
* Total vulnerable themes: 313
* Total version vulnerabilities: 1050
* Total plugin vulnerabilities: 1355
* Total theme vulnerabilities: 349

## Version 2.5.1
Released: 2014-09-29

Fixes reference URL to WPVDB

## Version 2.5
Released: 2014-09-26 (@ BruCON 2014)

New
* Exit program after --update
* Detect directory listing in upload folder
* Be more verbose when no version can be detected
* Added detection for Yoast Wordpress SEO plugin
* Also ensure to not process empty Location headers
* Ensures a nil location is not processed when enumerating usernames
* Fix #626 - Detect 'Must_Use_Plugins'
* better username extraction
* Add a --cookie option. Ref #485
* Add a --no-color option
* Output: Give 'Fixed in' an informational tag
* Added ArchAssault distro - WPScan comes pre-installed with this distro
* Layout changes with new colors

Removed
* Removes the source code updaters
* Removes the ListGenerator plugin from WPStools
* Removes all files from data/

General core
* Update docs to reflect new updating logic
* Little output change and coloring
* Adds a missing verbose output
* Re-build redirection url if begin with slash '/'
* Fixes the remove_conditional_comments function
* Ensures to give a string to Typhoeus
* Fix wpstools check-vuln-ref-urls
* Fix rspecs for new json
* Only output if different from style_url
* Add exception so 'ruby wpscan.rb http://domain.com' is detected
* Added make to Debian installation, which is needed in minimal installation.
* Add build-essentials requirement to Ubuntu > 14.04
* Updated installation instr. for GNU/Linux Debian.
* Changes VersionCompare#is_newer_or_same? by lesser_or_equal?
* Fixes the location of the robots.txt check
* Updates the recommended ruby version
* Rspec 3.0 support
* Adds ruby 2.1.2 to Travis
* Updated ruby-progressbar to 1.5.0

WordPress Fingerprints
* Adds WP 4.0 fingerprints
* Adds WP 3.9.2, 3.8.4 & 3.7.4 fingerprints - Ref #652
* Adds 3.9.1 fingerprints

Fixed issues
* Fix #689 - Adds config file to check
* Fix #694 - Output Arrays
* Fix #693 - Adds pathname require statement
* Fix #657 - generate method
* Fix #685 - Potenial fix for 'marshal data too short' error
* Fix #686 - Adds specs for relative URI in Location headers
* Fix #435 - Update license
* Fix #674 - Improves the Plugins & Themes passive detection
* Fix #673 - Problem with the output
* Fix #661 - Don't hash directories named like a file
* Fix #653 - Fix for infinite loop in wpstools
* Fix #625 - Only parse styles when needed
* Fix #481 - Fix for Jetpack plugin false positive
* Fix #480 - Properly removes the colour sequence from log
* Fix #472 - WPScan stops after redirection if not WordPress website
* Fix #464 - Readmes updated to reflect recent changes about the config file & batch mode

Vulnerabilities
* geoplaces4 also uses name GeoPlaces4beta
* Added metasploit module's
* Added some timthumb detections

WPScan Database Statistics:
* Total vulnerable versions: 87
* Total vulnerable plugins: 854
* Total vulnerable themes: 303
* Total version vulnerabilities: 752
* Total plugin vulnerabilities: 1351
* Total theme vulnerabilities: 345

## Version 2.4
Released: 2014-04-17

New
* '--batch' switch option added - Fix #454
* Add random-agent
* Added more CLI options
* Switch over to nist - Fix #301
* New choice added when a redirection is detected - Fix #438

Removed
* Removed 'Total WordPress Sites in the World' counter from stats
* Old wpscan repo links removed - Fix #440
* Fingerprinting Dev script removed
* Useless code removed

General core
* Rspecs update
* Forcing Travis notify the team
* Ruby 2.1.1 added to Travis
* Equal output layout for interaction questions
* Only output error trace if verbose if enabled
* Memory improvements during wp-items enumerations
* Fixed broken link checker, fixed some broken links
* Couple more 404s fixed
* Themes & Plugins list updated

WordPress Fingerprints
* WP 3.8.2 & 3.7.2 Fingerprints added - Fix #448
* WP 3.8.3 & 3.7.3 fingerprints
* WP 3.9 fingerprints

Fixed issues
* Fix #380 - Redirects in WP 3.6-3.0
* Fix #413 - Check the version of the Timthumbs files found
* Fix #429 - Error WpScan Cache Browser
* Fix #431 - Version number comparison between '2.3.3' and '0.42b'
* Fix #439 - Detect if the target goes down during the scan
* Fix #451 - Do not rely only on files in wp-content for fingerprinting
* Fix #453 - Documentation or inplemention of option parameters
* Fix #455 - Fails with a message if the target returns a 403 during the wordpress check

Vulnerabilities
* Update WordPress Vulnerabilities
* Fixed some duplicate vulnerabilities

WPScan Database Statistics:
* Total vulnerable versions: 79; 1 is new
* Total vulnerable plugins: 748; 55 are new
* Total vulnerable themes: 292; 41 are new
* Total version vulnerabilities: 617; 326 are new
* Total plugin vulnerabilities: 1162; 146 are new
* Total theme vulnerabilities: 330; 47 are new

## Version 2.3
Released: 2014-02-11

New
* Brute forcing over https!
* Detect and output parent theme!
* Complete fingerprint script & hash search
* New spell checker!
* Added database modification dates in status report
* Added 'Total WordPress Sites in the World' statistics
* Added separator between Name and Version in Item
* Added a "Work in progress" URL in the CHANGELOG

Removed
* Removed "Exiting!" sentence
* Removed Backtrack Linux. Not maintained anymore.

General core
* Ruby 2.1.0 added to Travis
* Updated the version of WebMock required
* Better string concatenation in code (improves speed)
* Some modifications in the output of an item
* Output cosmetics
* rspec-mocks version constraint released
* Tabs replaced by spaces
* Rspecs update
* Indent code cleanup
* Themes & Plugins lists regenerated

Vulnerabilities
* Update WordPress Vulnerabilities
* Disabled some fake reported vulnerabilities
* Fixed some duplicate vulnerabilities

WPScan Database Statistics:
* Total vulnerable versions: 78; 2 are new
* Total vulnerable plugins: 693; 83 are new
* Total vulnerable themes: 251; 55 are new
* Total version vulnerabilities: 291 17 are new
* Total plugin vulnerabilities: 1016; 236 are new
* Total theme vulnerabilities: 283; 79 are new

WordPress Fingerprints
* Better fingerprints
* WP 3.8.1 Fingerprinting
* WP 3.8 Fingerprinting

Fixed issues
* Fix #404 - Brute forcing issue over https
* Fix #398 - Removed a fake vuln in WP Super Cache
* Fix #393 - sudo added to the bundle install cmd for Mac OSX
* Fix #228, #327 - Infinite loop when self-redirect
* Fix #201 - Incorrect Paramter Parsing when no url was supplied

## Version 2.2
Released: 2013-11-12

New
* Output the vulnerability fix if available
* Added 'WordPress Version Vulnerability' statistics
* Added Kali Linux on the list of pre-installed Linux distributions
* Added hosted wordpress detection. See issue #343.
* Add detection for all-in-one-seo-pack
* Use less memory when brute forcing with a large wordlist
* Memory Usage output
* Added cve tag to xml file
* Add documentation to readme
* Add --version switch
* Parse robots.txt
* Show twitter usernames
* Clean logfile on wpstools too
* Added pingback header
* Request_timeout and connect_timeout implemented
* Output interesting http-headers
* Kali Linux detection
* Ensure that brute forcing results are output even if an error occurs or the user exits
* Added debug output
* Fixed Version compare for issue #179
* Added ruby-progressbar version to Gemfile
* Use the redirect_to parameter on bruteforce
* Readded "junk removal" from usernames before output
* Add license file
* Output the timthumb version if found
* New enumeration system
* More error details for XSD checks
* Added default wp-content dir detection, see Issue #141.
* Added checks for well formed xml

Changed
* Trying a fix for Kali Linux
* Make a seperator between plugin name and vulnerability name
* It's WordPress, not Wordpress
* Changed wordpress.com scanning error to warning. See issue #343.
* Make output lines consistent
* Replace packetstormsecurity.org to packetstormsecurity.com
* Same URL syntax for all Packet Storm Security URL's
* Packet Storm Security URL's don't need the 'friendly part' of the URL. So it can be neglected.
* Use online documentation
* User prompt on same line
* Don't skip passwords that start with a hash. This is fairly common (see RockYou list for example).
* Updated Fedora install instructions as per Issue #92
* Slight update to security plugin warning. Issue #212.
* Ruby-progressbar Gemfile version bump
* Fix error with the -U option (undefined method 'merge' for #WpTarget:)
* Banner artwork
* Fix hacks.rb conflict
* Handle when there are 2 headers of the same name
* Releasing the Typhoeus version constraint
* Amended Arch Linux install instructions. See issue #183.

Updated
* Plugins & Themes updated
* Update README.md
* Updated documentation

Removed
* Removed 'smileys' in output messages
* Removed 'for WordPress' and 'plugin' in title strings.
* Removed reference
* Removed useless code
* Removed duplicate vulnerabilities

General core
* Code cleaning
* Fix typo's
* Clean up rspecs
* Themes & Plugins lists regenerated
* Rspecs update
* Code Factoring
* Added checks for old ruby. Otherwise there will be syntax errors

Vulnerabilities
* Update WordPress Vulnerabilities
* Update timthumb due to Secunia #54801
* Added WP vuln: 3.4 - 3.5.1 wp-admin/users.php FPD

WPScan Database Statistics:
* Total vulnerable versions: 76; 4 are new
* Total vulnerable plugins: 610; 201 are new
* Total vulnerable themes: 196; 47 are new
* Total version vulnerabilities: 274; 53 are new
* Total plugin vulnerabilities: 780; 286 are new
* Total theme vulnerabilities: 204; 52 are new

Add WP Fingerprints
* WP 3.7.1 Fingerprinting
* WP 3.7 Fingerprinting
* Ref #280 WP 3.6.1 fingerprint
* Added WP 3.6 advanced fingerprint hash. See Issue #255.
* Updated MD5 hash of WP 3.6 detection. See Issue #277.
* WP 3.5.2 Fingerprint
* Bug Fix : Wp 3.5 & 3.5.1 not detected from advanced fingerprinting.

Fixed issues
* Fix #249 - [ERROR] "\xF1" on US-ASCII
* Fix #275 - [ERROR] "\xC3" on US-ASCII
* Fix #271 - Further Instructions added to the Mac Install
* Fix #266 - passive detection regex
* Fix #265 - remove base64 images before passive detection
* Fix #262 - [ERROR] bad component(expected absolute path component)
* Fix #260 - Fixes Travis Fail, due to rspec-mock v2.14.3
* Fix #208 - Fixed vulnerable plugins still appear in the results
* Fix #245 - all theme enumeration error
* Fix #241 - Cant convert array to string
* Fix #232 - Crash while enumerating usernames
* Fix #223 - New wordpress urls for most popular plugins & themes
* Fix #177 - Passive Cache plugins detection (no spec)
* Fix #169 - False reports
* Fix #182 - Remove the progress-bar static length (120), and let it to automatic
* Fix #181 - Don't exit if no usernames found during a simple enumeration (but exit if a brute force is asked)
* Fix #200 - Log file not recording the list of username retireved
* Fix #164 - README.txt detection
* Fix #166 - ListGenerator using the old Browser#get method for full generation
* Fix #153 - Disable error trace when it's from the main script
* Fix #163 - in the proper way
* Fix #144 - Use cookie jar to prevent infinite redirections loop
* Fix #158 - Add the solution to 'no such file to load -- rubygems' in the README
* Fix #152 - invalid ssl_certificate - response code 0
* Fix #147 - can't modify frozen string
* Fix #140 - xml_rpc_url in the body
* Fix #153 - No error trace when 'No argument supplied'

## Version 2.1
Released 2013-3-4
