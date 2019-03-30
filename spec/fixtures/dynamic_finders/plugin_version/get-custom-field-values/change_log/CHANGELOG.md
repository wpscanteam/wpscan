# ChangeLog

## 3.9.1 _(2019-03-15)_
* Change: Update shortcode builder widget to 006:
    * Fix: Check that `is_block_editor()` exists before using it, preventing an error when attempting to edit pages in WP older than 5.0
* New: Add changelog for v3.9 to CHANGELOG.md

## 3.9 _(2019-03-08)_
* Fix: Default 'this_post' shortcode attribute to 1 instead of 0, since unlike widgets, shortcodes generally appear within the context of a post
* Fix: Call `wpdb::prepare()` with the proper number of arguments depending on context
* Change: Update shortcode builder widget to 005:
    * Don't show shortcode builder metabox within context of block editor
    * Add `show_metabox()`
* Change: Update widget to 012:
    * Directly load textdomain instead of hooking it to already-fired action
* New: Add README.md
* New: Add CHANGELOG.md and move all but most recent changelog entries into it
* Change: Update docs to reflect that shortcode builder is not compatible with block editor yet
* Change: Use different markdown formatting for shortcode name to avoid capitalization when displayed in Plugin Directory
* Change: Add GitHub link to readme
* Change: Unit tests: Minor whitespace tweaks to bootstrap
* Change: Note compatibility through WP 5.1+
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS

## 3.8 _(2017-03-14)_
* New: Add support for percent-substitution tags
    * Tags can be used in before and/or after text and will be replaced on display with the custom field text
    * Add '%field%' to display custom field name
    * Add '%value%' to display custom field value
    * Add `c2c__gcfv_do_substitutions()` to handle the substitutions
* Fix: Properly handle serialized meta values
* Fix: Properly sanitize field name prior so use as part of a hook name
* Fix: Add missing textdomain for string in shortcode widget
* Change: Update widget to 011:
    * Add `register_widget()` and change to calling it when hooking 'admin_init'
    * Load textdomain
    * Add more substantial unit tests
* Change: Update widget framework:
    * 013:
    * Add `get_config()` as a getter for config array
    * 012:
    * Go back to non-plugin-specific class name of c2c_Widget_012
    * Don't load textdomain
    * Declare class and `load_config()` and `widget_body()` as being abstract
    * Change class variable `$config` from public to protected
    * Discontinue use of `extract()`
    * Apply 'widget_title' filter to widget title
    * Add more inline documentation
    * Minor code reformatting (spacing, bracing, Yoda-ify conditions)
* Change: Update shortcode builder widget to 004:
    * Use `get_config()` to get widget config now that the object variable is protected
    * Add `register()` and change to calling it when hooking 'init'
    * Add more unit tests
* Change: Update unit test bootstrap
    * Default `WP_TESTS_DIR` to `/tmp/wordpress-tests-lib` rather than erroring out if not defined via environment variable
    * Enable more error output for unit tests
* Change: Use officially documented order of arguments for `implode()`
* Change: Rephrase conditions to omit unnecessary use of `empty()`
* Change: Tweak readme.txt (minor content changes, spacing)
* Change: Note compatibility through WP 4.7+
* Change: Update copyright date (2017)
* New: Add LICENSE file

## 3.7 _(2016-01-31)_
* Change: Update widget framework to 011:
    * Change class name to c2c_GetCustomFieldValues_Widget_011 to be plugin-specific.
    * Set textdomain using a string instead of a variable.
    * Remove `load_textdomain()` and textdomain class variable.
    * Formatting improvements to inline docs.
* Change: Add support for language packs:
    * Set textdomain using a string instead of a variable.
    * Don't load textdomain from file.
    * Remove .pot file and /lang subdirectory.
    * Remove 'Domain Path' from plugin header.
    * Add 'Text Domain' to plugin header.
* Change: Reformat plugin settings code (spacing).
* Change: Explicitly declare methods in unit tests as public.
* Change: Minor improvements to inline docs and test docs.
* New: Create empty index.php to prevent files from being listed if web server has enabled directory listings.
* Change: Note compatibility through WP 4.4+.
* Change: Update copyright date (2016).

## 3.6.1 _(2015-08-21)_
* Change: Discontinue use of PHP4-style constructor invocation of WP_Widget to prevent PHP notices in PHP7.
* Change: Use `require_once()` instead of `include()` for including include files.
* Change: Use full path to include files.
* Change: Update widget framework to version 010.
* Change: Update widget to version 009.
* Change: Update shortcode to version 003.
* Change: Note compatibility through WP 4.3+.
* New: Add unit tests for shortcode and widget class versions.
* New: Add `c2c_GetCustomWidget::version()` to get version of the widget class.
* New: Add `c2c_GetCustomFieldValuesShortcode::version()` to get version of the shortcode class.

## 3.6 _(2015-03-04)_
* Update widget framework to 009
* Update widget to 008
* Explicitly declare widget class methods public
* Add more unit tests
* Reformat plugin header
* Minor code reformatting (spacing, bracing)
* Change documentation links to wp.org to be https
* Minor documentation improvements and spacing changes throughout
* Note compatibility through WP 4.1+
* Drop compatibility with version of WP older than 3.6
* Update copyright date (2015)
* Add plugin icon
* Regenerate .pot

## 3.5 _(2014-01-17)_
* Includes a significant number of changes from the unreleased v3.4
* Hide shortcode wizard by default (won't change existing setting for users)
* Show shortcode wizard for new posts as well
* Add unit tests
* Cast all intended integer arguments as `absint()` instead of `intval()`
* Update widget version to 006
* Update widget framework to 008
* Use explicit path for `require_once()`
* Discontinue use of PHP4-style constructor
* Minor documentation improvements
* Minor code reformatting (spacing, bracing)
* Note compatibility through WP 3.8+
* Drop compatibility with version of WP older than 3.6
* Update copyright date (2014)
* Regenerate .pot
* Change donate link
* Update screenshots
* Add banner

## 3.4 _(unreleased)_
* Display shortcode wizard metabox for all post types
* Add filter 'c2c_get_custom_field_values_post_types' to allow override of what post_types should get the shortcode wizard metabox
* Add 'id' and 'class' as shortcode attributes to set same-named HTML attributes on 'span' tag
* Wrap output in 'span' tag if either 'id' or 'class' shortcode attribute is defined
* Shortcode wizard now omits 'between' and 'before_last' values if 'limit' was set to 1
* Update widget version to 005
* Update widget framework to 007
* Return widget body content in `widget_body()` instead of echoing (to facilitate non-display of empty widgets)
* Hook output of JS and creation of metaboxes to 'load-post.php', which eliminates use of pagenow
* For class c2c_GetCustomFieldValuesShortcode, add `register_post_page_hooks()` and `do_meta_box()`
* For class c2c_GetCustomFieldValuesShortcode, remove `admin_menu()`
* Add checks to prevent execution of code if file is directly accessed
* Re-license as GPLv2 or later (from X11)
* Add 'License' and 'License URI' header tags to readme.txt and plugin file
* Discontinue use of explicit pass-by-reference for objects
* Remove ending PHP close tag
* Note compatibility through WP 3.5+
* Update copyright date (2013)
* Move screenshots into repo's assets directory

## 3.3.2
* Fix bugs in widget preventing proper display of custom field for current post (props [Ross Higgins](http://rosshiggins.com))
* Trim and/or intval widget input fields in `validate()`
* For shortcode widget's JS, output via 'admin_print_footer_scripts' instead of 'admin_footer'
* Note compatibility through WP 3.3
* Add 'Domain Path' directive to top of main plugin file
* Add link to plugin directory page to readme.txt
* Update copyright date (2012)

## 3.3.1
* Fix fatal shortcode bug by updating widget framework to v005 to make a protected class variable public
* Update widget version to 003

## 3.3
* Modify `c2c_get_random_custom()` to support returning multiple random values (function now accepts additional arguments)
* Rename widget class from 'GetCustomWidget' to 'c2c_GetCustomWidget'
* Enable shortcode support for custom field values
* Update widget framework to v004
* Document shortcode
* Note compatibility through WP 3.2+
* Minor code formatting changes (spacing)
* Minor readme.txt formatting changes
* Add plugin homepage and author links in description in readme.txt
* Add .pot
* Update copyright date (2011)

## 3.2
* Fix 'Send to Editor' for shortcode builder
* (widget) Full re-implementation using C2C_Widget_002
* (widget) Full localization support
* (widget) Fix bug with saving widget
* (shortcode) Output JS in footer instead of head
* Add `if(!function_exists())` checks around all functions
* Change description
* Add PHPDoc documentation
* Remove docs from top of plugin file (all that and more are in readme.txt)
* Add package info to top of file
* Note compatibility with WP 3.0+
* Drop compatibility with version of WP older than 2.8
* Minor code reformatting (spacing)
* Add Upgrade Notice section to readme.txt
* Remove trailing whitespace
* Update copyright date
* Update screenshots

## 3.1
* (Not publicly released.)

## 3.0.1
* Added additional check to prevent error when running under WP older than 2.8

## 3.0
* Added widget support (widgetized the plugin)
* Added shortcode support (`[custom_field]`)
* Added `c2c_get_post_custom()` : Useful when you know the ID of the post whose custom field value you want.
* Added `c2c_get_random_custom()` : Retrieve the value of a random instance of the specified custom field key, as long as the field is associated with a published posted, non-passworded post
* Added `c2c_get_random_post_custom()` : Retrieve the value of a random instance of the specified custom field key for a given post
* Added `c2c_get_recent_custom()` : Retrieves the most recent (according to the associated post's publish date) value of the specified custom field.
* Used `$wpdb->prepare()` to safeguard queries
* Updated copyright
* Noted compatibility through 2.8+
* Dropped compatibility with versions of WP older than 2.6
* Tweaked description and docs

## 2.5
* Modified SQL query code for `c2c_get_recent_custom()` to explicitly look for post_type of 'post' and then optionally of 'page'
* Per-custom field filter name is now made using a sanitized version of the field key
* Minor code reformatting
* Removed pre-WP2.0 compatibility and compatibility checks
* Changed description
* Updated copyright date and version to 2.5
* Added readme.txt
* Tested compatibility with WP 2.3.3 and 2.5

## 2.1
* Removed the `$filter` argument from `c2c_get_custom()` and `c2c_get_recent_custom()`
* Replaced $filter argument with more robust filtering approach: filter every custom field via the action 'the_meta', filter specific custom fields via 'the_meta_$field'
* Add argument `$include_static` (defaulted to true) to `c2c_get_recent_custom()`; static posts (i.e. "pages") can be optionally excluded from consideration
* Verified to work for WP 1.5 (and should still work for WP 1.2)

## 2.02
* Minor bugfix

## 2.01
* Minor bugfix

## 2.0
* Added the new function `c2c_get_recent_custom()` that allows retrieving custom/meta data from outside "the loop"
* Better filtering (on meta field itself instead of final output string)
* Per-call filtering of meta fields
* Prepended all functions with "c2c_" to avoid potential function name collision with other plugins or future core functions. NOTE: If you are upgrading from an earlier version of the plugin, you'll need to change your calls from `get_custom()` to `c2c_get_custom()`
* Changes to make the plugin WordPress v1.3 ready (as-yet unverified)
* Switched to MIT license

## 1.0
* Added argument of `$before_last` (which, when $between is also defined, will be used to join the next-to-last and last items in a list)
* Added invocation of an action called 'the_meta' so that you can do `add_filter('the_meta', 'some_function')` and get custom field values filtered as they are retrieved
* To faciliate use of this plugin as the argument to another function, this plugin no longer echoes the value(s) it retrieves (user must prepend 'echo' to the call to `get_custom()`)

## 0.91
* Minor bugfix

## 0.9
* Initial release
