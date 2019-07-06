# Change log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [4.13.2] - 2019-05-14
### Added
* A custom Twig extension for WordPress-based i18n.

### Changed
* Now correctly requiring WordPress version 4.8 or later.
* Improved the JS architecture to allow addons to extend the UI.
* The deactivation poll will now be shown only 50% of the time, randomly.

### Fixed
* The time ago format for the list template was not respecting the WordPress timezone setting.
* HTML in log messages were breaking the Debugging page.
* The feed items were not being explicitly sorted, which could lead to unsorted items.

## Removed
* Removed the polyfill for the `gettext()` function.

## [4.13.1] - 2019-04-30
### Changed
* Disabled Twig cache due to tmp permission issues and false-positive suspicious file reporting by hosts.
* The list template's pagination option is now set to disabled by default, matching previous versions.

### Fixed
* Re-added missing HTML classes in the list template that had broken user custom CSS styles.
* Added a polyfill for the `gettext()` function for sites that don't have the PHP `gettext` extension enabled.
* Re-added a function that was removed in v4.13, and marked it as deprecated.
* Fixed feed item dates not using the site's timezone.
* Fixed styles for the legacy rendering system used by the Excerpts & Thumbnails addon.

## [4.13] - 2019-04-24
### Added
* Introduced feed templates.
* Introduced a WP RSS Aggregator Gutenberg block.
* Brand new debug log and logging system that stores logs in the database.
* Items can now be added to the Blacklist manually.

### Changed
* Refactored a lot of legacy code over to the new modular system.
* General display settings have been moved to the "Default" template type.
* Reorganized the general plugin settings. Advanced options are now under an advanced settings section.
* Removed the "Add New" menu item from the RSS Aggregator menu.
* The feed sources page now updates every 1 second.
* Updated the TinyMCE dialog options for inserting a shortcode on a page or post (Classic Editor).
* Updated administrator and editor role capabilities, fixing various permission bugs.
* Updated a lot of setting descriptions and tooltips.
* The help support beacon is now enabled by default.

### Fixed
* Import errors no longer "freeze" feed sources in an infinite importing state.
* Some import errors would not be logged due to script timeout or execution errors.
* Feed to Post was not able to show feed items in the shortcode.
* Deprecation notices on PHP 7.3.
* The "Force feed" option was not properly being applied to feed sources.
* A bug that caused perfectly good RSS feeds to trigger gzip errors.
* The "Delete permanently & blacklist" row action was appearing for non-feed-item post types.

### Removed
* The notice that asks users to leave a review was removed due to various bugs.

## [4.12.3] - 2019-04-01
### Fixed
* Fixed an issue with Feed to Post not being able to show feed items in the shortcode.
* Fixed deprecation notices on PHP 7.3.

## [4.12.2] - 2019-03-26
### Fixed
* Fixed an admin capability bug that disallowed admin users from fetching feed items.

## [4.12.1] - 2019-02-27
### Added
* Added a modal with an optional poll when the plugin is deactivated.

### Changed
* Improved the core plugin's on-boarding process for brand new users.
* The timeout for the truncating posts hook has been extended.

### Fixed
* Fixed the "Sorted" error appearing constantly in the debug log.
* Fixed PHP warnings appearing on WordPress multisite.
* Fixed PHP notice appearing on Feed Items page.
* Fixed strict standards notice appearing on settings import.

## [4.12] - 2019-01-29
### Added
* The plugin now checks if its running on PHP 5.3.9, and deactivates itself when not.
* Added message informing users that v4.13 will drop support for PHP 5.3.
* Added an introduction page for new plugin users.

### Changed
* Changed protocol for all links to HTTPS wherever necessary or applicable.

### Removed
* Disabled the welcome page on activation and updates.

## [4.11.4] - 2018-12-11
### Added
* Added handling of lifetime licenses.

### Changed
* License renewal link and expiry are not shown if they are not applicable.

## [4.11.3] - 2018-05-23
### Changed
* Updated Help & Support page.

## [4.11.2] - 2017-09-18
### Added
* Added 2 new general settings for item import order and per-import limit.

### Changed
* Cosmetic and documentation improvements.

## [4.11.1] - 2017-03-07
### Fixed
* Fixed bug that caused minor publishing controls to be hidden on unrelated Edit screens.

## [4.11] - 2017-03-06
### Changed
* Enhanced Licenses page so as to make the [Enter] key toggle license activation.
* Enhanced architecture by using a DI container.
* Enhanced admin notifications by refactoring them to use the same mechanism.
* Enhanced admin notifications by making all of them dismissible.

### Fixed
* Fixed bug with lifetime licenses showing expiry notices.
* Fixed bug with being able to submit form on Licenses page.
* Fixed bug with empty saved license key causing PHP notice, and not triggering reminder notification.
* Fixed bug with saved but inactive licenses not triggering reminder notification.
* Fixed bug with minified assets not being served by default.
* Fixed bug with cached admin assets being served even after update.
* Fixed bug with admin notifications displayed on unrelated pages not being dismissible.

## [4.10] - 2016-12-29
### Added
* Added a per-feed-source "Link Source" option.
* Added a per-feed-source "Feed Request User Agent" option.
* Now using Composer!
* Now using Phing!
* Added RegEx HTML Encodifier.
* Added integration with Diagnostics plugin, and tests.
* Added "Leave a Review" notification.

### Changed
* The "Add New" button no longer appears for feed items.
* Logs are now created in `wp-content/log/wprss`, and are named more descriptively.

### Fixed
* Fixed bug with feed error output breaking tooltips on "Feed Sources" page.
* Fixed bug with nonces on the "Feed Sources" page that broke some source actions.
* Fixed problem with image cache filenames being too long.
* Fixed problem with permalink URLs sometimes being URL-encoded.
* Fixed problem with large logs causing OOM errors and breaking Debugging page.
* Fixed conflict with function `unparse_url()`.
* Fixed bug with `_getDataOrConst()` not retrieving single value.
* Fixed future incompatibility with `class-feed.php` for WP 4.7+.
* Fixed conflicts with many JS scripts by only adding JS on our admin pages.
* Fixed conflicts with some classes by loading only valid root namespace components.
* Fixed PHP warning related to retrieving unique titles.

## [4.9.1] - 2016-08-01
### Changed
* Changed copyright and other info in plugin header.

## [4.9] - 2016-06-14
### Changed
* Enhanced: Visual improvements.

### Fixed
* Fixed bug: Potential security vulnerability related to triggering feed update.
* Fixed bug: Error output on Feed Sources list is trimmed and cannot break the page layout.
* Fixed bug: Certain notices could not be dismissed.
* Fixed bug: Word trimming didn't always trim correctly with HTML.

## [4.8.2] - 2016-02-22
### Changed
* Enhanced: Users can now override useragent sent with feed requests.
* Enhanced: Improvements to plugin updating system.
* Enhanced: Readme updated.
* Enhanced: "Open link behaviour" option's internal handling has been improved.

### Fixed
* Fixed bug: Interface methods used to conflict, causing fatal error on activation.
* Fixed bug: Empty feed response used to cause misleading error message in log.

## [4.8.1] - 2016-02-02
### Changed
* Enhanced: Visual improvements.
* Enhanced: Included new Object Oriented code.

### Fixed
* Fixed bug: Some exceptions used to cause fatal errors.
* Fixed bug: Requests made by image caching used to always have an infinite timeout.
* Fixed bug: Licensing algorithm used to use constants of inactive plugins, causing fatal error.

## [4.8] - 2015-12-30
### Changed
* Enhanced: Major licensing system improvements.

### Fixed
* Fixed bug: Licensing notices will now be displayed again.

## [4.7.8] - 2015-11-18
### Changed
* Enhanced: Added autoloading and refactored licensing.
* Enhanced: Added button to download error log.
* Enhanced: Cosmetic changes and fixes.

### Fixed
* Fixed bug: Sticky posts no longer get deleted when truncating, unless imported from a feed source.

## [4.7.7] - 2015-10-19
### Changed
* Enhanced: Optimized checking for plugin updates.

## [4.7.6] - 2015-10-07
### Changed
* Enhanced: Feeds that fail to validate due to whitespace at the beginning are now supported by the plugin.

### Fixed
* Fixed bug: Undefined variables in the System Info section in the Debugging page.
* Fixed bug: Add-on license expiration notices could not be dismissed.

## [4.7.5] - 2015-09-02
### Changed
* Enhanced: Licensing errors will be output to debug log.
* Enhanced: Improved compatibility with plugins that allow AJAX searching in the backend.

### Fixed
* Fixed bug: error related to undefined `ajaxurl` JS variable gone from frontend.

### Removed
* Usage tracking now disabled.

## [4.7.4] - 2015-08-20
### Changed
* Requirement: WordPress 4.0 or greater now required.

### Fixed
* Fixed bug in image caching
* Fixed bug in admin interface due to incorrectly translated IDs

## [4.7.3] - 2015-08-04
### Added
* Core now implements an image cache logic.
* Russian translation added.
* Google Alerts permalinks are now normalized.

### Changed
* Enhanced: Add-ons on the "Add-ons" page now have an installed-but-inactive status.

### Fixed
* Fixed bug: Inline help (tooltips) translations now work.
* Fixed bug: Link to the Feed to Post add-on on the welcome page is no longer broken.

## [4.7.2] - 2015-06-30
### Changed
* Enhanced: Copyright updated.

### Fixed
* Fixed bug: Word trimming no longer adds extra closing tags at the end.
* Fixed bug: Presence of `idna_convert` class no longer causes infinite redirects on some servers.
* Fixed bug: Warning of unterminated comment no longer thrown in PHP 5.5.
* Fixed bug: Added default value for "Unique Titles" option.
* Fixed bug: Having a the port number specified with the database host no longer causes issues with the `mysqli` adapter in System Info on some servers.
* Fixed bug: Nested options of inline help controller no longer cause a fatal error.
* Fixed bug: Notices will no longer be displayed during rendering of feed items due to absence of required default values.

## [4.7.1] - 2015-04-23
### Fixed
* Fixed bug: No warning will be thrown when fetching feeds.

## [4.7] - 2015-04-21
### Added
* Optionally import only items with titles that don't already exist.
* Added support for multibyte strings in some places.

### Changed
* Enhanced: Accessing feeds over HTTPS is now possible.
* Enhanced: Increased JS compatibility with other plugins.
* Enhanced: Increased UI support for mobile devices.

### Fixed
* Fixed bug: Having no mysqli extension no longer causes an error to appear in the debug info.
* Fixed bug: Saving an empty license key no longer results in a warning.

## [4.6.13] - 2015-03-20
### Fixed
* Fixed bug: The "Force feed" option wasn't being correctly used.

## [4.6.12] - 2015-03-09
### Fixed
* Fixed bug: The "Force feed" option was being removed by the Feed to Post add-on.

## [4.6.11] - 2015-03-04
### Changed
* Enhanced: The Help page now includes a support form if a premium add-on is detected.
* Enhanced: Updated some translations for admin options.

### Fixed
* Fixed bug: Help tooltips are now optimized for iPad screens.
* Fixed bug: Errors on the licensing page when a license code has not yet been entered.

## [4.6.10] - 2015-02-10
### Added
* Markdown library added. Changelog now read from readme.

### Changed
* Enhanced: AJAX license activation.
* Enhanced: License form more reliable.
* Enhanced: license-related UI improvements

### Fixed
* Fixed bug: Saving license keys not longer triggers error in some cases.

## [4.6.9] - 2015-01-21
### Changed
* Enhanced: Admin user will now be warned about invalid or expiring licenses.
* Enhanced: Admin notices logic centralized in this plugin.

### Fixed
* Fixed: Multiple small-scale security vulnerabilities.
* Fixed: Ampersand in feed URL no longer causes the product of generated feeds to be invalidated by W3C Validator.

## [4.6.8] - 2015-01-07
### Changed
* Enhanced: Added more logging during feed importing.
* Enhanced: Irrelevent metaboxes added by other plugins are now removed from the Add/Edit Feed Source page.

### Fixed
* Fixed bug: Valid feed URLS were being invalidated.
* Fixed bug: The Blacklist feature was being hidden when the Feed to Post add-on was enabled.
* Fixed bug: Patched a vulnerability where any user on the site can issue a feed fetch.
* Fixed bug: The "Activate" and "Pause" actions are not shown in the bulk actions dropdown in WordPress v4.1.

## [4.6.7] - 2014-12-17
### Changed
* Enhanced: Some minor interface updates.
* Enhanced: Added filters for use by the premium add-ons.

## [4.6.6] - 2014-12-06
### Added
* Added output layouts for feed sources and feed items.
* Added time limit extending to prevent script from exhausting its execution time limit while importing.

### Changed
* Enhanced: Updated EDD updater class to version 1.5.

### Fixed
* Fixed bug: The "Delete and Re-import" button was deleting items but not re-importing.
* Fixed bug: Non-object errors when a feed source is deleted while importing.

## [4.6.5] - 2014-11-17
### Changed
* Enhanced: Improved the logging.
* Enhanced: Improved the licensing fields.
* Enhanced: Updated the EDD updater class to the latest version.

### Fixed
* Fixed bug: Small random error when viewing the licenses page.

## [4.6.4] - 2014-11-10
### Changed
* Enhanced: Added filters to the custom feed.
* Enhanced: Updated some styles to improve the user interface.

### Fixed
* Fixed bug: The "Remove selected from Blacklist" button had no nonce associated with it.
* Fixed bug: The Blacklist menu entry was not always being shown.

## [4.6.3] - 2014-11-3
### Changed
* Enhanced: Re-added the "Add New" link in the plugin's menu.
* Enhanced: Improved error logging.
* Enhanced: Bulk actions in the Feed Sources page are now also included in the bottom dropdown menu.

### Fixed
* Fixed bug: Add-on updater was prone to conflicts. Now enclosed in an action.
* Fixed bug: The Full Text RSS Feeds add-on was not showing as active in the "Add-ons" page.
* Fixed bug: Broken links in the "Add-ons" page, to add-on pages on our site.

## [4.6.2] - 2014-10-15
### Added
* Added a new filter to modify the text shown before author names.
* Added better debug logging.

### Changed
* Enhanced: Improved plugin responsiveness.
* Enhanced: Updated some help text in tooltips with better explainations and added clarity.
* Enhanced: Optimized some old SQL queries.

### Changed
* Fixed bug: Licenses were not showing as active, even though they were activated.

## [4.6.1] - 2014-10-06
### Changed
* Enhanced: Improved internationalization in the plugin, for better translations.

### Fixed
* Fixed bug: If the feed source age limit was left empty, the global setting was used instead of ignoring the limit.

## [4.6] - 2014-09-22
### Changed
* Enhanced: Improved the user interface, with better responsiveness and tooltips.
* Enhanced: Removes the ID column. The ID is now shown fixed in row actions.
* Enhanced: Feed Preview indicates if feed items have no dates.

### Fixed
* Fixed bug: If a feed item has no date, the date and time it was imported is used.

## [4.5.3] - 2014-09-15
### Changed
* Added filter to allow adding RSS feeds to the head of your site's pages for CPTs.

### Changed
* Enhanced: Columns in the feed sources table are now sortable.
* Enhanced: Removed the ID column in the feed sources table. The ID has been moved as a row action.
* Enhanced: Improved various interface elements.
* Enhanced: Better responsiveness for smaller screen.

### Fixed
* Fixed bug: The importing spinning icon would get stuck and spin for a very long time.
* Fixed bug: Removed an old description meta field.
* Fixed bug: Plugin was not removing all scheduled cron jobs when deactivated.

## [4.5.2] - 2014-09-09
### Changed
* Enhanced: Optimized plugin for WordPress 4.0.
* Enhanced: Improved template and added filters for add-on hooking.

### Fixed
* Fixed bug: Editor toolbar visible over the WP RSS shortcode dialog.

## [4.5.1] - 2014-08-26
### Fixed
* Fixed bug: Last import feed item count stays at zero.
* Fixed bug: Datetime::setTimestamp error when using PHP 5.2 or earlier.
* Fixed bug: The display limit was not working.
* Fixed bug: Minor bug in licensing.

## [4.5] - 2014-08-25
### Added
* New Feature: Bulk importer allows you to create multiple feed sources at once.

### Changed
* Enhanced: Improved OPML importer with added hooks.
* Enhanced: Centralized add-on licensing, fixing multiple bugs.

### Fixed
* Fixed bug: Undefined `feed_limit` errors when using the shortcode.

## [4.4.4] - 2014-08-19
### Fixed
* Fixed bug: Errors when using older PHP versions 5.3 or lower.

## [4.4.3] - 2014-08-19
### Fixed
* Fixed bug: Errors when using older PHP versions 5.3 or lower.

## [4.4.2] - 2014-08-19
### Fixed
* Fixed bug: Errors when using older PHP versions 5.3 or lower.

## [4.4.1] - 2014-08-18
### Changed
* Enhanced: Various improvements to the plugin interface and texts.
* Enhanced: Moved the restore default settings button farther down the Debugging page, to avoid confusion with the delete button.

### Fixed
* Fixed bug: Feed item dates were not being adjusted to the timezone when using a GMT offset.
* Fixed bug: Feed item dates are now adjusted according to daylight savings time.

## [4.4] - 2014-08-11
### Added
* Blacklist - delete items and blacklist them to never import them again.

### Changed
* Enhanced: Added a button in the Debugging page to reset the plugin settings to default.
* Enhanced: WordPress Yoast SEO metaboxes and custom columns will no longer appear.

## [4.3.1] - 2014-08-08
### Changed
* Enhanced: Better wording on settings page.

### Fixed
* Fixed bug: The Links Behaviour option in the settings was not working.
* Fixed bug: The wrong feed items were being shown for some sources when using the "View Items" row action.

## [4.3] - 2014-08-04
### Added
* New Feature: Feed items now also import authors.

### Changed
* Enhanced: Custom feed is now in RSS 2.0 format.
* Enhanced: Improved the display template for feed items.

### Fixed
* Fixed bug: Custom feed was not working in Firefox.
* Fixed bug: Some feed items were showing items from another feed source.
* Fixed bug: The feed limit in the global settings was not working.

## [4.2.3] - 2014-07-29
### Changed
* Enhanced: Added an option to choose between the current pagination type, and numbered pagination.
* Enhanced: The Feed Preview now also shows the total number of items in the feed.

### Fixed
* Fixed bug: A PHP warning error was being shown in the System Info.
* Fixed bug: Language files were not always being referenced correctly.
* Fixed bug: Manually fetching a feed fails if the feed is scheduled to update in the next 10 minutes.
* Fixed bug: Bing RSS feeds were importing duplicates on every update.

## [4.2.2] - 2014-07-23
### Changed
* Enhanced: Facebook page feeds are now changed into RSS 2.0 feeds, rather than Atom 1.0 feeds.
* Enhanced: Improved live updating performace on the Feed Sources page.

## [4.2.1] - 2014-07-17
### Changed
* Enhanced: Feed Sources page is now more responsive.

## [4.2] - 2014-07-17
### Added
* Can now view each feed source's imported feed items separate from other feed sources' feed items.

### Changed
* Enhanced: Major visual update to the Feed Sources page with new live updates.
* Enhanced: The custom feed now includes the feed source.

### Fixed
* Fixed bug: Google News feeds were importing duplicate items on every update.
* Fixed bug: Multiple minor bug fixes with old filters.

## [4.1.6] - 2014-06-28
### Fixed
* Fixed bug: Results returned by wprss_get_feed_items_for_source() will no longer be affected by filters.
* Fixed bug: Charset issue in titles

## [4.1.5] - 2014-06-19
### Changed
* Enhanced: The Feed Sources table now indicates which feed sources encountered errors during the last import.

### Fixed
* Fixed bug: Feed titles were not being decoded for HTML entities.

## [4.1.4] - 2014-05-16
### Changed
* Enhanced: Minor improvements to feed importing and handling.

### Fixed
* Fixed bug: HTML entities were not being decoded in feed item titles.

## [4.1.3] - 2014-04-28
### Changed
* Enhanced: Added a force feed option, for valid RSS feeds with incorrect header content types.

### Fixed
* Fixed bug: HTML entities in feed item titles are now being decoded.

## [4.1.2] - 2014-04-22
### Changed
* Enhanced: Improved the custom feed, by allowing a custom title.
* Enhanced: Improved shortcode, by adding the "pagination" parameter.
* Enhanced: Modified a filter to fix some bugs in the add-ons.

## [4.1.1] - 2014-04-09
### Changed
* Enhanced: Tracking notices only appear for admin users.

### Fixed
* Fixed bug: Auto Feed Discovery was not working.

## [4.1] - 2014-04-03
### Added
* New Feature: Feed items can now link to enclosure links in the feed.

### Changed
* Enhanced: Added a filter to allow add-ons to modify feed item queries.

## [4.0.9] - 2014-03-27
### Changed
* Enhanced: Added a filter to modify the feeds template.

### Fixed
* Fixed bug: Nested lists in feeds template.

## [4.0.8] - 2014-03-20
### Fixed
* Fixed bug: Using the shortcode makes the comments section always open.

## [4.0.7] - 2014-03-08
### Fixed
* Fixed bug: The plugin prevented uploading of header images.

## [4.0.6] - 2014-03-05
### Fixed
* Fixed bug: Hook change in last version suspected reason for some installations having non-updated feed items.

## [4.0.5] - 2014-03-03
### Added
* New Feature: Time ago added as an option.

### Changed
* Enhanced: The plugin now allows the use of RSS and Atom feeds that do not specify the correct MIME type.
* Enhanced: Better performance due to better hook usage.

### Fixed
* Fixed bug: Facebook page feed URL conversion was not being triggered for new feed sources.
* Fixed bug: Styles fix for pagination.
* Fixed bug: Removed empty spaces in logging.

## [4.0.4] - 2014-02-17
### Changed
* Enhanced: Added Activate/Pause bulk actions in the Feed Sources page.
* Enhanced: Feed Sources page table has been re-designed.
* Enhanced: Logging is now site dependant on multisite.

### Fixed
* Fixed bug: Undefined display settings where appearing on the front end.

## [4.0.3] - 2014-02-12
### Fixed
* Fixed bug: The general setting for deleting feed items by age was not working.

## [4.0.2] - 2014-02-10
### Changed
* Enhanced: Added a filter to change the html tags allowed in feed item content.

## [4.0.1] - 2014-02-08
### Changed
* Fixed bug: Empty array of feed items bug caused importing problems.

## [4.0] - 2014-02-04
### Changed
* Enhanced: Improved some internal queries, for better performance.

### Fixed
* Fixed bug: Feed limits were not working properly.

## [3.9.9] - 2014-02-03
### Changed
* Enhanced: The custom feed can now be extended by add-ons.

## [3.9.8] - 2014-01-20
### Fixed
* Fixed bug: Removed excessive logging from Debugging Error Log.

## [3.9.7] - 2014-01-17
### Fixed
* Fixed bug: Bug in admin-debugging.php causing trouble with admin login

## [3.9.6] - 2014-01-17
### Changed
* Enhanced: Added error logging.

## [3.9.5] - 2014-01-02
### Changed
* Enhanced: Added a feed validator link in the New/Edit Feed Sources page.
* Enhanced: The Next Update column also shows the time remaining for next update, for feed source on the global update interval.
* Enhanced: The custom feed has been improved, and is now identical to the feeds displayed with the shortcode.
* Enhanced: License notifications only appear on the main site when using WordPress multisite.
* Enhanced: Updated Colorbox script to 1.4.33

### Fixed
* Fixed bug: The Imported Items column was always showing zero.
* Fixed bug: Feed items not being imported with limit set to zero. Should be unlimited.
* Fixed bug: Fat header in Feed Sources page

## [3.9.4] - 2013-12-24
### Changed
* Enhanced: Added a column in the Feed Sources page that shows the number of feed items imported for each feed source.

### Fixed
* Fixed bug: Leaving the delete old feed items empty did not ignore the delete.

## [3.9.3] - 2013-12-23
### Fixed
* Fixed bug: Fixed tracking pointer appearing on saving settings.

## [3.9.2] - 2013-12-21
### Fixed
* Fixed bug: Incorrect file include call.

## [3.9.1] - 2013-12-12
### Changed
* Enhanced: Improved date and time handling for imported feed items.

### Fixed
* Fixed bug: Incorrect values being shown in the Feed Processing metabox.
* Fixed bug: Feed limits set to zero were causing feeds to not be imported.

## [3.9] - 2013-12-12
### Added
* New Feature: Feed sources can have their own update interval.
* New Feature: The time remaining until the next update has been added to the Feed Source table.

## [3.8] - 2013-12-05
### Added
* New Feature: Feed items can be limited and deleted by their age.

### Changed
* Enhanced: Added utility functions for shorter filters.

### Fixed
* Fixed bug: License codes were being erased when add-ons were deactivated.
* Fixed bug: Some feed sources could not be set to active from the table controls.
* Fixed bug: str_pos errors appear when custom feed url is left empty.
* Fixed bug: Some options were producing undefined index errors.

## [3.7] - 2013-11-28
### Added
* New Feature: State system - Feed sources can be activated/paused.
* New Feature: State system - Feed sources can be set to activate or pause themselves at a specific date and time.

### Changed
* Enhanced: Added compatibility with nested outline elements in OPML files.
* Enhanced: Admin menu icon image will change into a Dashicon, when WordPress is updated to 3.8 (Decemeber 2013).

### Fixed
* Fixed bug: Custom Post types were breaking when the plugin is activated.

## [3.6.1] - 2013-11-17
### Fixed
* Fixed bug: Missing 2nd argument for wprss_shorten_title()

## [3.6] - 2013-11-16
### Added
* New Feature: Can set the maximum length for titles. Long titles get trimmed.

### Fixed
* Fixed bug: Fixed errors with undefined indexes for unchecked checkboxes in the settings page.
* Fixed bug: Pagination on front static page was not working.

## [3.5.2] - 2013-11-11
### Fixed
* Fixed bug: Invalid feed source url was producing an Undefined method notice.
* Fixed bug: Custom feed was producing a 404 page.
* Fixed bug: Presstrends code firing on admin_init, opt-in implementation coming soon

## [3.5.1] - 2013-11-09
### Changed
* Enhanced: Increased compatibility with RSS sources.

### Fixed
* Fixed bug: Pagination not working on home page

## [3.5] - 2013-11-6
### Added
* New Feature: Can delete feed items for a particular source

### Changed
* Enhanced: the 'Fetch feed items' row action for feed sources resets itself after 3.5 seconds.
* Enhanced: The feed image is saved for each url.

### Fixed
* Fixed bug: Link to source now links to correct url. Previously linked to site's feed.

## [3.4.6] - 2013-11-1
### Changed
* Enhanced: Added more hooks to debugging page for the Feed to Post add-on.

### Fixed
* Fixed bug: Uninitialized loop index

## [3.4.5] - 2013-10-30
### Fixed
* Bug Fix: Feed items were not being imported while the WPML plugin was active.

## [3.4.4] - 2013-10-26
### Added
* New feature: Pagination
* New feature: First implementation of editor button for easy shortcode creation

### Changed
* Enhanced: Feed items and sources don't show up in link manager
* Enhanced: Included Presstrends code for plugin usage monitoring

## [3.4.3] - 2013-10-20
### Added
* Added suppress_filters in feed-display.php to prevent a user reported error

### Fixed
* Removed anonymous functions for backwards PHP compatibility
* Missing <li> in certain feed displays

## [3.4.2] - 2013-9-19
### Changed
* Enhanced: Added some hooks for Feed to Post compatibility
* Enhanced: Moved date settings to a more appropriate location

## [3.4.1] - 2013-9-16
### Fixed
* Fixed Bug: Minor issue with options page - PHP notice

## [3.4] - 2013-9-15
### Added
* New Feature: Saving/Updating a feed source triggers an update for that source's feed items.
* New Feature: Option to change Youtube, Vimeo and Dailymotion feed item URLs to embedded video players URLs
* New Feature: Facebook Pages URLs are automatically detected and changed into Atom Feed URLs using FB's Graph

### Changed
* Enhanced: Updated jQuery Colorbox library to 1.4.29

### Fixed
* Fixed Bug: Some settings did not have a default value set, and were throwing an 'Undefined Index' error
* Fixed Bug: Admin notices do not disappear immediately when dismissed.

## [3.3.3] - 2013-09-08
### Fixed
* Fixed bug: Better function handling on uninstall, should remove uninstall issues

## [3.3.2] - 2013-09-07
### Added
* New feature: Added exclude parameter to shortcode

### Changed
* Enhanced: Added metabox links to documentation and add-ons

### Fixed
* Fixed bug: Custom feed linking to post on user site rather than original source
* Fixed bug: Custom post types issues when activitating the plugin

## [3.3.1] - 2013-08-09
### Fixed
* Fixed Bug: Roles and Capabilities file had not been included
* Fixed Bug: Error on install, function not found

## [3.3] - 2013-08-08
### Added
* New feature: OPML importer
* New feature: Feed item limits for individual Feed Sources
* New feature: Custom feed URL
* New feature: Feed limit on custom feed
* New feature: New 'Fetch feed items' action for each Feed Source in listing display
* New feature: Option to enable link to source

### Changed
* Enhanced: Date strings now change according to locale being used (i.e. compatible with WPML)
* Enhanced: Capabilities implemented
* Enhanced: Feed Sources row action 'View' removed

### Fixed
* Fixed Bug: Proxy feed URLs resulting in the permalink: example.com/url

## [3.2] - 2013-07-06
### Fixed
* New feature: Parameter to limit number of feeds displayed
* New feature: Paramter to limit feeds displayed to particular sources (via ID)

### Changed
* Enhanced: Better feed import handling to handle large number of feed sources

## [3.1.1] - 2013-06-06
### Fixed
* Fixed bug: Incompatibility with some other plugins due to function missing namespace

## [3.1] - 2013-06-06
### Added
* New feature: Option to set the number of feed items imported from every feed (default 5)
* New feature: Import and Export aggregator settings and feed sources
* New feature: Debugging page allowing manual feed refresh and feed reset

### Changed
* Enhanced: Faster handling of restoring sources from trash when feed limit is 0

### Fixed
* Fixed bug: Limiter on number of overall feeds stored not working
* Fixed bug: Incompatibility issue with Foobox plugin fixed
* Fixed bug: Duplicate feeds sometimes imported

## [3.0] - 2013-03-16
### Added
* New feature: Option to select cron frequency
* New feature: Code extensibility added to be compatible with add-ons
* New feature: Option to set a limit to the number of feeds stored (previously 50, hard coded)
* New feature: Option to define the format of the date shown below each feed item
* New feature: Option to show or hide source of feed item
* New feature: Option to show or hide publish date of feed item
* New feature: Option to set text preceding publish date
* New feature: Option to set text preceding source of feed item
* New feature: Option to link title or not
* New feature: Limit of 5 items imported for each source instead of 10

### Changed
* Requires: WordPress 3.3
* Enhanced: Performance improvement when publishing * New feeds in admin
* Enhanced: Query tuning for better performance
* Enhanced: Major code rewrite, refactoring and inclusion of hooks
* Enhanced: Updated Colorbox to v1.4.1
* Enhanced: Better security implementations
* Enhanced: Better feed preview display

### Fixed
* Fixed bug: Deletion of items upon source deletion not working properly

## [2.2.3] - 2012-11-01
### Fixed
* Tab navigation preventing typing in input boxes
* Feeds showing up in internal linking pop up

## [2.2.2] - 2012-10-30
### Changed
* Feeds showing up in site search results
* Enhanced: Better tab button navigation when adding a new feed
* Enhanced: Better guidance when a feed URL is invalid

## [2.2.1] - 2012-10-17
### Fixed
* Fixed bug: wprss_feed_source_order assumes everyone is an admin

## [2.2] - 2012-10-01
### Added
* Italian translation added

### Changed
* Feed source order changed to alphabetical

### Fixed
* Fixed bug - repeated entries when having a non-valid feed source
* Fixed bug - all imported feeds deleted upon trashing a single feed source

## [2.1] - 2012-09-27* Now localised for translations
* Fixed bug with date string
* Fixed $link_before and $link_after, now working
* Added backwards compatibility for wp_rss_aggregator() function

## [2.0] - 2012-09-21
### Added
* Limit of 15 items max imported for each source
* Added install and upgrade functions
* Added DB version setting
* Feeds now fetched via Cron
* Cron job to delete old feed items, keeps max of 50 items in DB
* Ability to limit total number of feeds displayed
* Feed source list sortable ascending or descending by name

### Changed
* Now requires WordPress 3.2
* Bulk of code rewritten and refactored
* Updated colorbox to v1.3.20.1
* Feed sources now stored as Custom Post Types

### Removed
* Removed days subsections in feed display

### Fixed
* Fixed issue of page content displaying incorrectly after feeds

## [1.1] - 2012-08-13
### Added
* Added top level menu
* Added settings section
* Ability to open in lightbox, new window or default browser behaviour
* Ability to set links as follow or no follow

### Changed
* Now requires WordPress 3.0
* More flexible fetching of images directory
* Code refactoring
* Changes in file and folder structure
* Using constants for oftenly used locations

## [1.0] - 2012-01-06
* Initial release.
