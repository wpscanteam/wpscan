# Changelog

## 1.2 _(2019-03-20)_

### Highlights:

This release mainly adds support for the block editor (aka Gutenberg) via an interim metabox "Prevent Admin Comments". (The block editor does not currently support adding the plugin's checkbox in the "Discussion" panel as expected.) Otherwise, there were a number of behind-the-scenes code and documentation changes.

### Details:

* New: Add `do_meta_box()` for interim metabox for block editor (aka Gutenberg) support
* New: Add `can_show_ui()` to determine if the UI should generally be shown
* New: Add CHANGELOG.md file and move all but most recent changelog entries into it
* New: Add inline documentation for hook
* New: Add .gitignore file
* New: Add screenshot of new block editor metabox
* Change: Modify how the meta field is registered:
    * Use `register_post_meta()` instead of `register_meta()`, if available
    * Explicitly register meta for each post type that supports having comments
    * Set `show_in_rest` to true
    * Set `type` to boolean
    * Add callbacks to `auth_callback` and `sanitize_callback`
    * Register meta on `init` instead of `plugins_loaded`
* Change: Revamp `display_option()` to operate in multiple contexts
    * Make `$post` argument optional, defaulting to global post
    * Improve styling when metabox appears on the right
    * Use `sprintf()` instead of string concatenation to build output strings
    * Move styles into `style` tag instead of being inline styles
* Change: Add README link to plugin's page in Plugin Directory
* Change: Split paragraph in README.md's "Support" section into two
* Change: Initialize plugin on 'plugins_loaded' action instead of on load
* Change: Merge `plugins_loaded()` into constructor
* Change: Tweak plugin description
* Change: Rename readme.txt section from 'Filters' to 'Hooks'
* Change: Modify formatting of hook name in readme to prevent being uppercased when shown in the Plugin Directory
* Change: Note compatibility through WP 5.1+
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS

## 1.1.1 _(2017-11-07)_
* New: Add README.md
* Change: Minor tweak to plugin description
* Change: Minor whitespace changes to unit test bootstrap
* Change: Add GitHub link to readme
* Change: Note compatibility through WP 4.9+
* Change: Update copyright date (2018)

## 1.1 _(2017-01-23)_
* Change: Register meta field via `register_meta()`.
    * Add own `register_meta()`
    * Remove `hide_meta()` in favor of use of `register_meta()`
* Change: Sanitize meta key name when used as input attribute (it's not a user input value so no security issue existed).
* Change: Enable more error output for unit tests.
* Change: Default `WP_TESTS_DIR` to `/tmp/wordpress-tests-lib` rather than erroring out if not defined via environment variable.
* Change: Minor readme.txt documentation tweaks.
* Change: Note compatibility through WP 4.7+.
* Change: Remove support for WordPress older than 4.6 (should still work for earlier versions)
* Change: Minor readme improvements.
* Change: Update copyright date (2017).

## 1.0 _(2016-03-08)_
* Initial public release
