# Changelog

## 1.3 _(2019-03-17)_
* New: Add and use `get_formatted_date_string()` to format the date string used when referring to a given day
* New: Add unit tests for untested hooks
* New: Add CHANGELOG.md file and move all but most recent changelog entries into it
* New: Add "Hooks" section to readme.txt to document hooks provided by the plugin
* New: Add inline documentation for all hooks
* Change: Initialize plugin on 'plugins_loaded' action instead of on load
* Change: Merge `do_init()` into `init()`
* Change: Do placeholder substitutions of site name and day strings after `c2c_years_ago_today-email-body-no-posts` filter is run, so those using the hook have those values available
* Change: Reformat conditional logic handling in `get_email_body()` for improved readability
* Change: Allow date strings to be translated in a plugin-specific way
* CHange: Cast return value of `c2c_years_ago_today-email-if-no-posts` filter as boolean
* Change: Split paragraph in README.md's "Support" section into two
* Change: Note compatibility through WP 5.1+
* Change: Update copyright date (2019)
* Change: Update License URI to be HTTPS

## 1.2.2 _(2017-11-08)_
* New: Add README.md
* Change: Add GitHub link to readme
* Change: Note compatibility through WP 4.9+
* Change: Update copyright date (2018)
* Change: Minor whitespace tweaks in unit test bootstrap

## 1.2.1 _(2017-05-09)_
* Fix: Properly constrain CSS `li` styling to apply only to plugin's dashboard widget and not any other dashboard widgets

## 1.2 _(2017-02-20)_
* New: Add footer to daily emails to provide context about what the email is, why it is being sent, and where to go to discontinue it
* Change: Make prefatory post listing text (in widget and email) more informative
    * Include month and day of the month instead of saying "this day"
    * Include count of the number of posts being listed
    * Use separate singular and plural strings
* Change: Use built-in WP date query syntax for finding older posts
    * Delete `add_year_clause_to_query()`
    * Move some of the date handling code from `add_year_clause_to_query()` into `get_posts()` for use in date_query
* Change: Split out functionality from `cron_email()` into single-purpose functions
    * Add `get_email_subject()` for getting email subject
    * Add `get_email_body()` for getting email body
    * Bail if either return empty string
* Change: Prevent object instantiation
    * Add private `__construct()`
    * Add private `__wakeup()`
* Change: Update unit test bootstrap
    * Default `WP_TESTS_DIR` to `/tmp/wordpress-tests-lib` rather than erroring out if not defined via environment variable
    * Enable more error output for unit tests
* Change: Note compatibility through WP 4.7+
* Change: Remove support for WordPress older than WP 4.6 (should still work for earlier versions back to WP 4.1)
* Change: Minor inline code documnetation tweaks (fix typos, spacing)
* Change: Update copyright date (2017)
* New: Add LICENSE file
* Change: Update screenshots

## 1.1 _(2016-01-21)_
* Bugfix: Fix for bug when posts across two days were returned for today by using site's time and not GMT.
* New: Add filter `c2c_years_ago_ago-email_cron_time`.
* Change: Change incorrectly named filter from `c2c_years_ago_ago-first_published_year` to `c2c_years_ago_today-first_published_year`.
* Change: Add support for language packs:
    * Don't load textdomain from file.
    * Remove .pot file and /lang subdirectory.
    * Fix an incorrectly defined textdomain.
* Change: Note compatibility through WP 4.4+.
* Change: Explicitly declare methods in unit tests as public.
* Change: Update copyright date (2016).
* New: Create empty index.php to prevent files from being listed if web server has enabled directory listings.

## 1.0.1 _(2015-08-03)_
* Bugfix: Change default value for `c2c_years_ago_today-email-if-no-posts` filter from true to false. The original intent was by default not to send the email on days without past posts.
* Bugfix: Load language files from the 'lang' sub-directory.
* Change: Use `dirname(__FILE__)` instead of `__DIR__` since the latter is only available on PHP 5.3+
* Update: Note compatibility through WP 4.3+

## 1.0
* Initial public release
