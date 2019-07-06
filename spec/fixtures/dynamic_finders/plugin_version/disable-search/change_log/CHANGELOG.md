# Changelog

## 1.7.1 _(2019-06-17)_
* Unit tests:
    * Change: Update unit test install script and bootstrap to use latest WP unit test repo
    * New: Test that the plugin hooks `plugins_loaded` for initialization
* Change: Note compatibility through WP 5.2+
* Change: Add link to CHANGELOG.md in README.md

## 1.7 _(2019-03-27)_
* New: Add CHANGELOG.md file and move all but most recent changelog entries into it
* Change: Initialize plugin on 'plugins_loaded' action instead of on load
* Change: Merge `do_init()` into `init()`
* Unit tests:
    * Fix: Discontinue testing deprecated `is_comments_popup` condition
    * Fix: Use `file_exists()` instead of `locate_template()` to verify presence of file in theme (the latter is unreliable since it is based on constants)
* Change: Note compatibility through WP 5.1+
* Change: Add README.md link to plugin's page in Plugin Directory
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS
* Change: Split paragraph in README.md's "Support" section into two

## 1.6.1 _(2018-05-19)_
* New: Add README.md
* New: Add FAQ indicating that the plugin is GDPR-compliant
* Unit tests:
    * Change: Make local copy of `assertQueryTrue()`; apparently it's (now?) a test-specific assertion and not a globally aware assertion
    * Change: Enable and update `test_no_search_form_appears_even_if_searchform_php_exists()` to use TwentySeventeen theme, since it has searchform.php
    * Change: Minor whitespace tweaks to bootstrap
* Change: Add GitHub link to readme
* Change: Note compatibility through WP 4.9+
* Change: Update copyright date (2018)
* Change: Update installation instruction to prefer built-in installer over .zip file

## 1.6 _(2017-02-21)_
* New: Disable search item from front-end admin bar
* Change: Prevent object instantiation
    * Add private `__construct()`
    * Add private `__wakeup()`
* Change: Update unit test bootstrap
    * Default `WP_TESTS_DIR` to `/tmp/wordpress-tests-lib` rather than erroring out if not defined via environment variable
    * Enable more error output for unit tests
* Change: Note compatibility through WP 4.7+
* Change: Remove support for WordPress older than 4.6 (should still work for earlier versions back to WP 3.6)
* Change: Update copyright date (2017)
* New: Add LICENSE file

## 1.5.1 _(2016-01-15)_
* Bugfix: Declare `do_init()` as public.

## 1.5 _(2016-01-14)_
* Add: Set 404 HTTP status header for disabled search requests.
* Add: Define 'Text Domain' in plugin header and load it.
* Add: Create empty index.php to prevent files from being listed if web server has enabled directory listings.
* Change: Perform all hook registering during plugins_loaded action.
* Change: Explicitly declare methods in unit tests as public.
* Change: Note compatibility through WP 4.4+.
* Change: Update copyright date (2016).

## 1.4.2 _(2015-08-23)_
* Change: Note compatibility through WP 4.3+.
* Change: Minor inline docs changes.

## 1.4.1 _(2015-02-15)_
* Add trivial unit tests for plugin version and class name
* Note compatibility through WP 4.1+
* Update copyright date (2015)
* Add plugin icon

## 1.4 _(2013-12-15)_
* Change to hook `get_search_form` at lower priority so it runs after anything else also using the filter
* Change to only affect main query
* Remove admin nag for alerting about the presence of searchform.php in a theme since this no longer matters
* Add unit tests
* Note compatibility through WP 3.8+
* Change minimum required compatibility to WP 3.6
* Update copyright date (2014)
* Add banner
* Many changes to readme.txt documentation (namely to pare out a lot of stuff relating to suppression of searchform.php which has since been made possible in WP core)
* Change description
* Change donate link

## 1.3.1 _(unreleased)_
* Don't show searchform.php admin nag if user doesn't have `edit_themes` cap
* Add check to prevent execution of code if file is directly accessed
* Re-license as GPLv2 or later (from X11)
* Add 'License' and 'License URI' header tags to readme.txt and plugin file
* Remove ending PHP close tag
* Note compatibility through WP 3.5+
* Update copyright date (2013)

## 1.3
* Add notice to main themes and plugins admin pages if active theme has searchform.php template
* Note compatibility through WP 3.3+
* Add `version()` to return plugin version
* Add more documentation and FAQ questions to readme.txt
* Add link to plugin directory page to readme.txt
* Update copyright date (2012)

## 1.2.1
* Note compatibility through WP 3.2+
* Tiny code formatting change (spacing)
* Fix plugin homepage and author links in description in readme.txt

## 1.2
* Switch from object instantiation to direct class function invocation
* Explicitly declare all functions public static
* Add development note
* Add additional FAQ question
* Note compatibility through WP 3.1+
* Update copyright date (2011)

## 1.1.1
* Fix disabling of search widget
* Move class instantiation inside of `if(!class_exists())` check
* Rename class from `DisableSearch` to `c2c_DisableSearch`
* Store object instance in global variable `c2c_disable_search` for possible external manipulation
* Note compatibility with WP 3.0+
* Minor code reformatting (spacing)
* Remove documentation and instructions from top of plugin file (all of that and more are contained in readme.txt)
* Add Upgrade Notice section to readme.txt

## 1.1
* Disable/unregister search widget
* Add PHPDoc documentation
* Minor formatting tweaks
* Note compatibility with WP 2.9+
* Drop compatibility with WP older than 2.8
* Update copyright date
* Update readme.txt (including adding Changelog)

## 1.0
* Initial release
