# Changelog

## 2.6 _(2019-03-22)_
* New: Add support for using dashicons for the click character
* Change: Replace the bullet character (solid circle) with comment bubble dashicon as column icon for one-click link
* New: Add CHANGELOG.md file and move all but most recent changelog entries into it
* New: Add inline documentation for hook
* Change: Initialize plugin on 'plugins_loaded' action instead of on load
* Change: Use `apply_filters_deprecated()` when using the deprecated filter
* Change: Use `wp_doing_ajax()` for official detection of use of AJAX
* Change: Tweak plugin description
* Change: Split paragraph in README.md's "Support" section into two
* Change: Note compatibility through WP 5.1+
* Change: Remove support for versions of WordPress older than 4.7
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS
* Change: Update screenshot, icon, and banner for Plugin Directory

## 2.5 _(2018-08-03)_
* Change: Improve display of control toggle (and label) on smaller viewports
* Change: Include plugin version number when registering styles
* New: Add README.md
* Change: Add explicit curly braces to JS 'if' statement
* Change: Add GitHub link to readme
* Change: Note compatibility through WP 4.9+
* Change: Update copyright date (2018)
* Change: Rename readme.txt section from 'Filters' to 'Hooks'
* Change: Modify formatting of hook name in readme to prevent being uppercased when shown in the Plugin Directory

## 2.4 _(2017-02-04)_
* Change: Improve accessbility (a11y)
    * Add descriptive text for close/open link to display instead of the indicator character for screen readers
    * Change colors to be WCAG AA compliant
* Change: Use `printf()` to format output markup rather than concatenating strings, variables, and function calls.
* Change: Escape variables used as markup attributes (hardening; none of the instances are user input).
* Change: Note compatibility through WP 4.7+.
* Change: Remove support for WordPress older than 4.6 (should still work for earlier versions back to WP 3.1)
* Change: Minor code reformatting (add spacing between sections of code).
* Change: Minor readme.txt improvements.
* Change: Update copyright date (2017).
* Change: Update screenshot.

## 2.3.5 _(2016-03-16)_
* Change: Add support for language packs:
    * Don't load textdomain from file.
    * Remove .pot file and /lang subdirectory.
    * Remove 'Domain Path' from plugin header.
* New: Add LICENSE file.
* New: Add empty index.php to prevent files from being listed if web server has enabled directory listings.
* Change: Note compatibility through WP 4.4+.
* Change: Update copyright date (2016).

## 2.3.4 _(2015-09-15)_
* Bugfix: Really revert back to using `dirname(__FILE__)`; `__DIR__` is only PHP 5.3+
* Change: Note compatibility through WP 4.3+.

## 2.3.3 _(2015-03-12)_
* Revert back to using `dirname(__FILE__)`; `__DIR__` is only PHP 5.3+

## 2.3.2 _(2015-02-18)_
* Reformat plugin header
* Use `__DIR__` instead of `dirname(__FILE__)`
* Minor code reformatting (spacing, bracing)
* Minor documentation spacing changes throughout
* Change documentation links to wp.org to be https
* Note compatibility through WP 4.1+
* Update copyright date (2015)
* Add plugin icon
* Rengenerate .pot

## 2.3.1
* Minor code tweaks (spacing)
* Note compatibility through WP 3.8+
* Update copyright date (2014)
* Change donate link
* Update banner image to reflect WP 3.8 admin refresh
* Update screenshot to reflect WP 3.8 admin refresh

## 2.3
* Use string instead of variable to specify translation textdomain
* Remove `load_config()` and merge its contents into `do_init()`
* Add check to prevent execution of code if file is directly accessed
* Note compatibility through WP 3.5+
* Update copyright date (2013)
* Move screenshot into repo's assets directory

## 2.2.1
* Re-license as GPLv2 or later (from X11)
* Add 'License' and 'License URI' header tags to readme.txt and plugin file
* Add banner image for plugin page
* Remove ending PHP close tag
* Note compatibility through WP 3.4+

## 2.2
* Increase font size for click character to make it a larger click target
* Fix for one-click character not being clickable for quick-edited post rows
* Enqueue CSS and JavaScript rather than defining in, and outputting via, PHP
* Create 'assets' subdirectory and add admin.js and admin.css to it
* Add `enqueue_scripts_and_styles()`, `register_styles()`, `enqueue_admin_css()`, `enqueue_admin_js()`
* Remove `add_css()`, `add_js()`
* Hook `load-edit.php` action to initialize plugin rather than using pagenow
* Add `version()` to return plugin version
* Create 'lang' subdirectory and move .pot file into it
* Regenerate .pot
* Note compatibility through WP 3.3+
* Add 'Domain Path' directive to top of main plugin file
* Add link to plugin directory page to readme.txt
* Update screenshot for WP 3.3
* Update copyright date (2012)

## 2.1.1
* Note compatibility through WP 3.2+
* Minor code formatting changes (spacing)
* Fix plugin homepage and author links in description in readme.txt

## 2.1
* Switch from object instantiation to direct class function invocation
* Rename the class from `OneClickCloseComments` to `c2c_OneClickCloseComments`
* Declare all class methods public static and class variables private static
* Output JS via `admin_print_footer_scripts` action instead of `admin_footer` action
* Rename filter from `one-click-close-comments-click-char` to `c2c_one_click_close_comments_click_char`
* Add Filters section to readme.txt
* Note compatibility through WP 3.1+
* Update copyright date (2011)

## 2.0.1
* Don't even define class unless in the admin section of site
* Store plugin instance in global variable, `$c2c_one_click_close_comments`, to allow for external manipulation
* Move registering actions and filters into init()
* Remove docs from top of plugin file (all that and more are in readme.txt)
* Note compatibility with WP 3.0+
* Minor tweaks to code formatting (spacing)
* Add Upgrade Notice section to readme.txt
* Remove trailing whitespace

## 2.0
* Display commenting status even if JS is disabled
* Render commenting status as a 'span' instead of an 'a' and use unobtrusive JS to make it clickable
* Insert column into desired position using PHP instead of JS
* Fix issue related to disappearance of button for a post after using Quick Edit
* Fix issue of 'Allow Comments' checkbox in 'Quick Edit' getting out of sync with actual comment status
* Allow filtering of character used as click link, via `one-click-close-comments-click-char`
* Move initialization of config array out of constructor and into new function `load_config()`
* Create `init()` to handle calling `load_textdomain()` and `load_config()` (textdomain must be loaded before initializing config)
* Add support for localization
* Add PHPDoc documentation
* Add .pot file
* Note compatibility with WP 2.9+
* Drop compatibility with versions of WP older than 2.8
* Update documentation (descriptions, FAQs, etc) to reflect behavior changes
* Update copyright date

## 1.1
* Bail out early if not on pertinent admin pages
* Make use of `admin_url()` for path to admin section
* Note WP 2.8 compatibility

## 1.0
* Initial release
