# Changelog

## 1.3.7 _(2019-02-05)_
* New: Add CHANGELOG.md and move all but most recent changelog entries into it
* New: Add inline documentation for hook
* Change: Rename readme.txt section from 'Filters' to 'Hooks'
* Change: Add inline documentation to example in readme.txt
* Change: Split paragraph in README.md's "Support" section into two
* Change: Note compatibility through WP 5.1+
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS

## 1.3.6 _(2018-04-14)_
* New: Add README.md
* Change: Minor whitespace tweaks to unit test bootstrap
* Change: Add GitHub link to readme
* Change: Modify formatting of hook name in readme to prevent being uppercased when shown in the Plugin Directory
* Change: Note compatibility through WP 4.9+
* Change: Update copyright date (2018)

## 1.3.5 _(2017-01-30)_
* Change: Default `WP_TESTS_DIR` to `/tmp/wordpress-tests-lib` rather than erroring out if not defined via environment variable.
* Change: Enable more error output for unit tests.
* Change: Prevent direct loading of test file.
* Change: Note compatibility through WP 4.7+.
* Change: Minor inline code documentation reformatting.
* Change: Minor readme.txt improvements.
* New: Add LICENSE file.
* Change: Update copyright date (2017).

## 1.3.4 _(2015-12-15)_
* Change: Note compatibility through WP 4.4+.
* Change: Explicitly declare methods in unit tests as public.
* Change: Update copyright date (2016).
* Add: Define 'Text Domain' header attribute.
* Add: Create empty index.php to prevent files from being listed if web server has enabled directory listings.

## 1.3.3 _(2015-08-16)_
* Update: Note compatibility through WP 4.3+
* Update: Minor documentation tweaks (spacing)

## 1.3.2 _(2015-02-11)_
* Note compatibility through WP 4.1+
* Update copyright date (2015)

## 1.3.1 _(2014-08-25)_
* Fix minor error in tests
* Minor plugin header reformatting
* Minor code reformatting (spacing)
* Change documentation links to wp.org to be https
* Note compatibility through WP 4.0+
* Add plugin icon

## 1.3 _(2013-12-14)_
* Fix bug if using '/' as custom-defined punctuation
* Add unit tests
* Note compatibility through WP 3.8+
* Update copyright date (2014)
* Add banner
* Minor readme.txt formatting tweaks
* Change donate link

## 1.2.6
* Add check to prevent execution of code if file is directly accessed
* Note compatibility through WP 3.5+
* Update copyright date (2013)

## 1.2.5
* Re-license as GPLv2 or later (from X11)
* Add 'License' and 'License URI' header tags to readme.txt and plugin file
* Remove ending PHP close tag
* Note compatibility through WP 3.4+
* Minor code reformatting (indentation)
* Update copyright date (2012)

## 1.2.4
* Note compatibility through WP 3.3+

## 1.2.3
* Note compatibility through WP 3.2+
* Tiny code formatting change (spacing)
* Fix plugin homepage and author links in description in readme.txt

## 1.2.2
* Add link to plugin homepage to description in readme.txt

## 1.2.1
* Note compatibility with WP 3.1+
* Update copyright date (2011)

## 1.2
* Add filter `c2c_extra_sentence_space_punctuation` to allow customization of the punctuation after which double-spacing (when present) is preserved. Default is '.!?'
* Add filter `c2c_extra_sentence_space` to respond to the function of the same name so that users can use the `apply_filters('c2c_extra_sentence_space')` notation for invoking function
* Wrap function in `if (function_exists())` check
* Note compatibility with WP 3.0+
* Minor code reformatting (spacing)
* Remove docs from top of plugin file (all that and more are in readme.txt)
* Remove trailing whitespace in header docs
* Add Filters and Upgrade Notice sections to readme.txt

## 1.1
* Also filter 'widget_text'
* Now also filter widget_text
* Add PHPDoc documentation
* Note compatibility with WP 2.8+ and 2.9+
* Update readme.txt (including adding Changelog)

## 1.0.1
* Note compatibility with WP 2.6+ and 2.7+
* Update copyright date
* Tweak description and extended description
* Remove commented out line of code that could be used to insert a second space if two aren't present
* Update and fix some mis-worded sentences in readme.txt

## 1.0
* Initial release
