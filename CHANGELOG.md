# Changelog

## Version 2.2 
Released: 2013-11-12

Added
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

WPScan Databse Statistics:
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

