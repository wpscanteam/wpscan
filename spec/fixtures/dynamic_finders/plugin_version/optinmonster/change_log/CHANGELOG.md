# Changelog
All notable changes to the OptinMonster plugin will be documented in this file.

### 1.9.9
* Fix issue where if multiple post tags were selected, popups and other campaigns would only appear on the first tag selected.
* Fix campaign shortcode suggestion in admin being incorrect.
* Full security audit to patch any potential issues.

### 1.9.8
* Fix compatibility with AMP.
* Update compatibility with popular caching plugins.
* Update to make all strings translatable.
* Fix bug where phone numbers wouldn't save when using MailPoet.
* Remove old jQuery dependencies.
* Update internal notices to be more friendly with other plugins.

### 1.9.7
* Update the OptinMonster API JS URL.
* Update trustpulse menu title.

### 1.9.6
* You can now use Gravity Forms AJAX submissions and form validation with your OptinMonster campaigns.
* Update admin notices to use the recommended classes

### 1.9.5
* Add support for www domains in Api.js embed code.
* Improve MailPoet error outputs.

### 1.9.4
* Fix issue where site settings were not being retrieved properly.

### 1.9.3
* Additional improvements to output of Api.js URL in embed code.

### 1.9.2
* Improve output of Api.js URL in embed code.

### 1.9.1
* Fix issue where closing Cyber Monday notification would not prevent it from showing again.

### 1.9.0
* Improves compatibility when WordPress is installed in a subdirectory or uses multisite with paths.
* Bump the minimum, required, version of WooCommerce to 3.2. Any installs below this version will not have WooCommerce support.
* Address some incompatibilities with the MailPoet plugin.
* Includes some notifications regarding holiday/sale promotions.

### 1.8.4
* Minor update: Added a new filter for action links.

### 1.8.3
* Improved logic to prevent welcome screen from showing in the wrong context.

### 1.8.2
* Fix issue where the WooCommerce cart object wasn't always available.
* Fix issue where top floating bars would cover the WP admin bar for logged in users.

### 1.8.1
* Fix issue with backwards compatibility with PHP 5.4 or lower, and WordPress 4.0 or lower.

### 1.8.0
* New campaigns that are fetched from OptinMonster will be enabled by default.
* API Keys can now be added with a click-based authentication flow
* Add a REST API endpoint that can be used to refresh campaigns
* Fix issues where the OptinMonster campaign preview wouldn't load if the campaign was not already active.

### 1.7.0
* Add additional WooCommerce support.

### 1.6.9
* Fixed an issue where saving to MailPoet may fail on pages where only shortcodes are used to embed campaigns.

### 1.6.8
* Fix issue with backwards compatibility with PHP 5.3 or lower.

### 1.6.7
* Fix issue with backwards compatibility with PHP 5.4 or lower, and WordPress 4.0 or lower.

### 1.6.6
* Fixed an issue where campaign refresh would deactivate live campaigns, and remove their settings

### 1.6.5
* Users who have not entered an API key into will now be redirected to the OptinMonster welcome page instead of the OptinMonster settings page
* Added a pointer to the Admin Dashboard if an API Key is not entered
* Added pagination to the API requests when refreshing campaigns
* Additional fixes for future improvements to OptinMonster

### 1.6.4
* Updated the API domain URL.

### 1.6.3
* Improved searching when adding advanced rules for posts/pages/tags.
* Add `optin_monster_pre_store_options` filter to allow users to override which campaigns are imported.

### 1.6.2
* Fix issue where the "Automatically add after post setting" was not working properly after changes in 1.6.0.

### 1.6.1
* Fix dashboard notice showing at incorrect times.

### 1.6.0
* Add widget option, "Apply Advanced Output Settings?". If checked, widget will follow the advanced settings rules for the campaign (found in the Output Settings for the campaign).
* Fix bug where advanced settings would not apply to inline after-post campaigns.
* Update the inline/automatic setting language to make the new behavior more explicit.

### 1.5.3
* "Display the campaign automatically after blog posts" setting no longer selected by default for inline campaigns.
* Fix inline campaigns showing in some scenarios, even when "Display the campaign automatically after blog posts" is NOT checked.

### 1.5.2
* Fixed potential privilege escalation bug.
* Bumped for 5.0.

### 1.5.1
* Fixed a possible security issue with admin notices.
* Updated outdated URLs in the admin.

### 1.5.0
* Refactored WordPress rules system, and a new `[optin-monster]` shortcode parameter, `followrules=true`. This means if you have specific WordPress display rules (e.g. which categories/posts/pages to display the campaign), and use the shortcode to output the campaign, you can have the shortcode follow the rules you have setup. Example shortcode usage: `[optin-monster slug="XXXXXXXXXXXXXXXXXXXX" followrules=true]`

### 1.4.2
* Fixed a bug that caused issues with PHP versions under 5.6.

### 1.4.1
* Include a file that was missing in 1.4.0. Sorry!

### 1.4.0
* Updated to work with OptinMonster 5.0 campaigns.
* Fix PHP notices.

### 1.3.5
* Fix issue where shortcodes in campaigns would not be parsed until the campaigns were refreshed a second time.

### 1.3.4
* Updated the API url to reflect the new endpoint.

### 1.3.3
* Fixed an issue that prevented campaigns from showing on some custom taxonomy terms.
* Performance improvements when retrieving, and determining when to display, campaigns.
* All URLs updated to use HTTPS.
* Updated notifications.

### 1.3.2
* Fixed issue where campaigns of an "advanced age" may not work in the plugin.

### 1.3.1
* Fixed missing files in WordPress.org repository.

### 1.3.0
* Is it "campaign"? Or "optin"? No, it's definitely "campaign".
* OptinMonster now works with the shiny new MailPoet 3.
* We're feeling a little lighter after removing some deprecated code.

### 1.2.2
* Updated API calls to always be done over HTTPS.
* Updated error responses from the OptinMonster API to be more informative.

### 1.2.1
* Added additional checks during save routines for user capabilities.

### 1.2.0
* Added additional support for WooCommerce display settings.
* Updated language for legacy migrations.
* Fixed a multisite activation issue.

### 1.1.9
* Updated version numbers to prevent possible asset caching errors.

### 1.1.8
* Fixed possible undefined errors for API credentials.

### 1.1.7
* Updated the API script domain for adblock.
* Added new authentication method for the new OptinMonster REST API.

### 1.1.6.2
* Fixed undefined index errors when API responses returned an error.

### 1.1.6.1
* General plugin enhancements and bug fixes.

### 1.1.6
* Compatibility updates for WordPress 4.7.

### 1.1.5.9
* Added the async attribute to the OptinMonster API script output for improved performance.
* Fixed a bug that caused the debugging report to not properly grab shortcodes.
* Added helper to remove faulty admin scripts from the OptinMonster settings area that would cause things to fail in some cases.

### 1.1.5.8
* Fixed bug that caused the MailPoet integration to fail in some scenarios.

### 1.1.5.7
* Improved checks for when to output and localize the OptinMonster API script.

### 1.1.5.6
* Fixed bug that caused people to have to define two constants to set the OptinMonster license key in config files.

### 1.1.5.5
* Fixed bug that redirected people already using the plugin to the Welcome screen on update.

### 1.1.5.4
* Fixed bug that caused issues with viewing the Welcome screen.

### 1.1.5.3
* Fixed issue with notices appearing oddly on OM screens.
* Updated support video.

### 1.1.5.2
* Fixed bug with post category selections causing campaigns to load globally.

### 1.1.5.1
* Improved welcome screen for new installs.
* Bug fixes and enhancements.

### 1.1.5
* Campaigns will now load on the archive pages of individual taxonomies (if selected) by default.
* Clarified language regarding how the "load exclusively on" and "never load optin on" settings work.
* Removed after post optins from RSS feeds.
* Removed the test mode setting in favor of using the "show only to logged-in users" setting for testing campaign output.
* When going live, campaigns will load globally by default unless other advanced output settings are specified.
* Automatically adding an after post optin after a post is now checked on by default for new after post campaigns.
* Added a new "Support" tab with a helpful video, links to documentation and ability to send support details when submitting a ticket.
* Migration tab is now only shown if the old plugin exists on the site.
* Added helpful tooltips in various areas of the admin.
* Moved all advanced output rules into a toggle field to make working with output settings easier.
* Fixed the clear local cookies function (it actually works now!).
* Removed the confusing Delete button - campaigns should be deleted from the app.
* Added an inline shortcode "copy to clipboard" button for after post campaigns.
* Improved shortcode processing - it is now automated (no longer need to enter in a setting) and supports non self-closing shortcodes!
* Improved individual campaign action links by always making them visible.

### 1.1.4.7
* Updated compatibility for WordPress 4.6.

### 1.1.4.6
* Removed shortcode ajax method that could possibly be exploited by other plugins to run malicious shortcode.

### 1.1.4.5
* Added new feature to allow reviews to be given for OptinMonster.

### 1.1.4.4
* Allow API credentials to be force resaved to clean out stale messages about accounts being expired or invalid.

### 1.1.4.3
* Fixed API script getting cached by CloudFlare Rocket Loader.
* Fixed omhide=true conflicting with MonsterLinks in some cases.
* Fixed pre 4.1 installs getting incorrect API ID.
* Updated Readme so OptinMonster App and account requirement is clearly stated.

### 1.1.4.2
* Added Welcome page on first install.
* Updated error messages.
* Updated debug code for better error handling.

### 1.1.4.1
* Added No-Cache headers on API requests.

### 1.1.4
* Fixed bug with adblock.
* Added new API script with easier updates.

### 1.1.3.9
* Fixed conflict with jQuery and Modernizr when the optin object was not set properly.

### 1.1.3.8
* Fixed bug with canvas slide-in not being able to be closed.

### 1.1.3.7
* Fixed issue with contact forms not displaying properly in optins. [See this doc on how to update shortcode support in your optins.](https://optinmonster.com/docs/how-to-use-wordpress-shortcodes-with-optinmonster/ "How to use WordPress shortcodes with OptinMonster" )

### 1.1.3.6
* Fixed possible issue with sending empty names that caused bugs with provider integrations.

### 1.1.3.5
* Fixed JS error with analytics if GA was not yet defined.

### 1.1.3.4
* Fixed bug with analytics tracking causing user sessions to be skewed.
* Fixed bug with fullscreen optins and mobile optins conflicting.
* Mobile optins now work for both mobile and tablet devices. Desktop optins work exclusively for desktop.
* Various bug fixes and improvements.

### 1.1.3.3
* Fixed bug where fullscreen wouldn't work on mobile if exit intent setting was checked.
* Fixed bug with analytics not tracking if multiple spaces were contained in a campaign name.
* Fixed bug with clearing local cookies not working in some instances.

### 1.1.3.2
* Fixed bug where shortcode would not parse for optins inserted via widget, shortcode or template tag.
* Fixed bug where Mailpoet helper would not output for optins inserted via widget, shortcode or template tag.

### 1.1.3.1
* Fixed issues revolving around split tests not loading properly for mobile devices.

### 1.1.3
* Fixed bug with freezing and not working in IE10/11.

### 1.1.2.7
* Fixed erroneous alert on screen.

### 1.1.2.6
* Fixed bug with lightbox and mobile optins in API script.

### 1.1.2.5
* Fixed bug with GA not tracking data.
* Added 13 new mobile themes!

### 1.1.2.4
* Fixed bug with cookies and split tests.
* Fixed bug with allowing split tests to be made primary.

### 1.1.2.3
* Added support for a new optin type - fullscreen optins!
* Fixed a bug with embedded HubSpot forms.
* Fixed bug where dropdown options would not show on Safari for post targeting.

### 1.1.2.2
* Fixed issue with API script not grabbing checkbox and radio fields properly inside an optin.

### 1.1.2.1
* Fixed issue for defining API url with function before filters can be applied to it.

### 1.1.2
* Fixed display error when multiple taxonomy terms were selected for an optin.
* Added selection of scheduled posts in optin output settings.

### 1.1.1
* Added option to move floating bar to top of the page. No custom CSS needed!
* Added option for a privacy statement below optin form.
* Added option to exclude by page slug
* Shortcode parsing now available for all optin types.
* Various bug fixes

### 1.1.0.5
* Added ability to pause parent campaigns from the app.

### 1.1.0.4
* Fixed bug that caused paused split tests to continue to run.
* Fixed bug with passing optin data to a redirect URL with query args.
* Added ability to submit lightbox optin forms with the enter button.

### 1.1.0.3
* Fixed bug that caused site verification to fail.

### 1.1.0.2
* Added support for assigning multiple domains to a single optin.
* Added unique optin slug on Overview screen to make life easier.

### 1.1.0.1
* Fixed fixed bug with bounce rate in GA.

### 1.1.0
* Fixed focus bug.

### 1.0.0.9
* Fixed analytics bug that caused bounce rates to go whacky in GA.
* Fixed "powered by" link placement when using display effects.
* Added focus effect for input fields when an optin is loaded.

### 1.0.0.8
* Clear out global cookie when clearing local cookies.
* Fixed bug with not loading in IE7-9.
* Fixed bug with placeholder shims not working in IE7-9.
* Fixed bug with GA clashes when using multiple tracking scripts on a page.

### 1.0.0.7
* Fixed bug with possible duplicate submissions in some configurations.
* Added enhanced conversion tracking with GA.

### 1.0.0.6
* Added a dedicated edit output settings link for each optin.

### 1.0.0.5
* Fixed bug with passing lead data to redirect URLs.
* Added improved UX by being able to create and edit optins from the plugin itself.

### 1.0.0.4
* Fixed another error with plugin update deploy.

### 1.0.0.3
* Fixed error with deploy.

### 1.0.0.2
* Fixed bug with API script.

### 1.0.0.1
* The "Go Live" link now enables an optin and sets the global/automatic loading setting as well.
* Fixed bug with not being able to uncheck clearing local cookies on optin save.
* Added extra XSS security checks with `esc_url_raw`.
* Added version number beside plugin header title for easy version checking.

### 1.0.0
* Fixed bug with exclusive/never settings not showing previously selected pages.
* Fixed bug with API script and loading social services for specific popup types.
* Removed unused updater class reference and code.

### 0.9.9
* Fix error with loading old API script.

### 0.9.8
* Initial release.
