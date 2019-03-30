# Changelog

## 1.2.6 _(2019-03-13)_
* New: Add CHANGELOG.md and move all but most recent changelog entries into it
* Change: Split paragraph in README.md's "Support" section into two
* Change: Note compatibility through WP 5.1+
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS

## 1.2.5 _(2018-04-11)_
* New: Add README.md
* New: Add 'Text Domain' plugin header
* Fix: Use correct Plugin Directory URL in plugin header comment
* Change: Prevent direct invocation of unit test file
* Change: Minor whitespace changes to unit test bootstrap
* Change: Add GitHub link to readme
* Change: Note compatibility through WP 4.9+
* Change: Update copyright date (2018)
* Change: Update installation instruction to prefer built-in installer over .zip file

## 1.2.4 _(2017-01-22)_
* Change: Enable more error output for unit tests
* Change: Default `WP_TESTS_DIR` to `/tmp/wordpress-tests-lib` rather than erroring out if not defined via environment variable
* Change: Minor inline documentation reformatting
* Change: Note compatibility through WP 4.7+
* Change: Update copyright date (2017)

## 1.2.3 _(2015-12-09)_
* Change: Note compatibility through WP 4.4+
* Change: Fix minor typo in documentation
* Change: Explicitly declare methods in unit tests as public or protected
* Change: Update copyright date (2016)

## 1.2.2 _(2015-02-11)_
* Note compatibility through WP 4.1+
* Update copyright date (2015)

## 1.2.1 _(2014-08-25)_
* Die early if script is directly invoked
* Minor plugin header reformatting
* Change documentation links to wp.org to be https
* Note compatibility through WP 4.0+
* Add plugin icon

## 1.2
* Return an empty array if 0 columns are requested
* Treat `$number_of_columns` as `absint()`, permitting negative and string numerical values to work
* Add unit tests
* Note compatibility through WP 3.8+
* Update copyright date (2014)
* Change description
* Various code and documentation reformatting
* Add banner image

## 1.1.4
* Shortened description and extended description
* Note compatibility through WP 3.5+
* Update copyright date (2013)

## 1.1.3
* Re-license as GPLv2 or later (from X11)
* Add 'License' and 'License URI' header tags to readme.txt and plugin file
* Remove ending PHP close tag
* Minor formatting changes (indentation)
* Note compatibility through WP 3.4+
* Update copyright date (2012)

## 1.1.2
* Note compatibility through WP 3.3+
* Tweak to plugin description
* Minor additional documentation
* Minor documentation reformatting (spacing)

## 1.1.1
* Note compatibility through WP 3.2+
* Minor code formatting changes (spacing)
* Fix plugin homepage and author links in description in readme.txt

## 1.1
* Rename `array_partition()` to `c2c_array_partition()` (but maintain a deprecated version for backwards compatibility)
* Add link to plugin homepage to description in readme.txt

## 1.0.3
* Note compatibility through WP 3.1+
* Update copyright date (2011)

## 1.0.2
* Wrap function in `if (function_exists())` check
* Note compatibility with WP 3.0+
* Remove docs from top of plugin file (all that and more are in readme.txt)
* Remove trailing whitespace in header docs
* Add Upgrade Notice section to readme.txt

## 1.0.1
* Add PHPDoc documentation
* Note compatibility with WP 2.9+
* Update copyright date

## 1.0
* Initial release
