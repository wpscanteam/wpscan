# Changelog

## 1.2.7 _(2019-02-06)_
* New: Add CHANGELOG.md file and move all but most recent changelog entries into it
* README.md:
    * New: Add instructions for use as a general PHP library
    * New: Add link to plugin's WordPress Plugin Directory page
    * Change: Split paragraph in README.md's "Support" section into two
* Change: Note compatibility through WP 5.1+
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS

## 1.2.6 _(2018-01-02)_
* New: Add README.md
* Change: Remove check that prevented use if `ABSPATH` isn't defined, allowing use of the code outside WordPress
* Change: Unit tests: Minor whitespace changes
* Change: Add GitHub link to readme
* Change: Note compatibility through WP 4.9+
* Change: Update copyright date (2018)
* Change: Unit tests: Add comments to denote groupings of unit tests testing a given function

## 1.2.5 _(2017-01-27)_
* Change: Default `WP_TESTS_DIR` to `/tmp/wordpress-tests-lib` rather than erroring out if not defined via environment variable.
* Change: Enable more error output for unit tests.
* Change: Note compatibility through WP 4.7+.
* Change: Minor inline code documentation reformatting.
* Change: Minor readme.txt improvements.
* Change: Update copyright date (2017).
* Change: Prevent direct invocation of test file.
* Change: Add 'Text Domain' to plugin header.
* New: Add LICENSE file.
* New: Add empty index.php to prevent files from being listed if web server has enabled directory listings.

## 1.2.4 _(2015-12-10)_
* Change: Note compatibility through WP 4.4+
* Change: Explicitly declare methods in unit tests as public or protected.
* Change: Update copyright date (2016)

## 1.2.3 _(2015-08-04)_
* Note compatibility through WP 4.3+

## 1.2.2 _(2015-02-11)_
* Note compatibility through WP 4.1+
* Update copyright date (2015)

## 1.2.1 _(2014-08-25)_
* Die early if script is directly invoked
* Minor plugin header reformatting
* Minor code reformatting (spacing)
* Change documentation links to wp.org to be https
* Note compatibility through WP 4.0+
* Add plugin icon

## 1.2 _(2013-12-19)_
* Add support for full callback usage
* Add `__sfc_is_valid_callback()` to validate callbacks; use it in all functions
* Add unit tests
* Substantial changes to inline documentation
* Substantial changes to documentation
* Minor code formatting tweak (add curly braces)
* Note compatibility through WP 3.8+
* Update copyright date (2014)
* Change donate link
* Add banner

## 1.1.7
* Note compatibility through WP 3.5+
* Update copyright date (2013)

## 1.1.6
* Re-license as GPLv2 or later (from X11)
* Add 'License' and 'License URI' header tags to readme.txt and plugin file
* Remove ending PHP close tag
* Miscellaneous readme.txt changes
* Update copyright date (2012)
* Note compatibility through WP 3.4+

## 1.1.5
* Note compatibility through WP 3.3+
* Minor code documentation reformatting in readme.txt (spacing)

## 1.1.4
* Note compatibility through WP 3.2+
* Minor documentation reformatting in readme.txt
* Fix plugin homepage and author links in description in readme.txt

## 1.1.3
* Add link to plugin homepage to readme.txt

## 1.1.2
* Note compatibility through WP 3.1+
* Update copyright date (2011)

## 1.1.1
* Wrapped functions in `if(function_exists())` checks
* Note compatibility with WP 3.0+
* Change description
* Minor code reformatting (spacing)
* Remove documentation and instructions from top of plugin file (all of that and more are contained in readme.txt)
* Add Upgrade Notice section to readme.txt

## 1.1
* Add new template function `_sfcf()` to allow calling a function when the intended function isn't available
* Add PHPDoc documentation
* Minor formatting tweaks
* Note compatibility with WP 2.9+
* Update copyright date
* Update readme.txt (including adding Changelog)

## 1.0
* Initial release
