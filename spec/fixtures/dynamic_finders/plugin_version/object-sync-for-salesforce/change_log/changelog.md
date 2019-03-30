Changelog
=========

* 1.8.4 (2019-03-27)
    * Bug fix: Dates used by The Event Calendar plugin were not correctly saved. This could cause TEC events not to appear on the calendar. Thanks to @vajeshrathor for reporting this issue. The fix also improves overall date formatting within this plugin.
    * Bug fix: The edit profile screen for users mapped to Salesforce could incorrectly be changed to a blank value, which did not delete the map. This release adds a delete link for this purpose.
    * Bug fix: When doing error logging for metadata, the plugin was not always correctly checking for success, and could have false positives for errors.

* 1.8.3 (2019-03-17)
    * Bug fix: In what seemed to be rare cases, manual push or pull requests from the WordPress admin were failing to actually save any data.

* 1.8.2 (2019-03-16)
    * Bug fix: 1.8.0 accidentally disabled a developer filter. This re-enables it.

* 1.8.1 (2019-03-16)
    * Bug fix: 1.8.0 introduced a possible issue with checking for updated records.

* 1.8.0 (2019-03-15)
	* New: we can now map multiple WordPress objects to the same Salesforce object. Each WordPress record will update the Salesforce record, and the Salesforce record can update each WordPress record, all according to the fieldmap. Thanks to WordPress forum user @joecanas1 for the initial report some time ago.
	* New: if Soap is enabled in the plugin settings, it is capable of responding to merge events. For example, if two Contacts are merged in Salesforce and a user is mapped to the old one, it will become mapped to the new one.
	* New: WordPress 5.1 changed its new user notification parameters. Thanks to GitHub user @synthetiv for the fix.
	* New: we've added a few additional debug log entries.
	* New: there is better error checking on saving metadata for users, posts, and comments.
	* Bug fix: 1.7.0 introduced an activation issue that this release fixes. There is also improved database versioning that occurs upon activation.
	* Bug fix: a bug existed in fieldmaps that had a Salesforce field like a record ID, which cannot be pushed to Salesforce but can be pulled from Salesforce, but the sync was failing. Thanks to WordPress forum user @walexparadis for the report on this.
	* Developers: we've updated our included version of ActionScheduler to 2.2.1.
	* Developers: the `load_by_wordpress` and `load_by_salesforce` methods on the `salesforce_mapping` class have been deprecated in favor of `load_all_by_wordpress` and `load_all_by_salesforce`, though the deprecated methods have not been removed.

* 1.7.0 (2019-01-31)
    * New: improve handling of custom meta fields that are required by Salesforce. This plugin would fail to create objects if required fields were missing when a record was created. It should handle these situations much better.
    * New: update to version 2.2.0 of the ActionScheduler library.

* 1.6.0 (2019-01-15)
	* New: we have added some basic REST API endpoints to the plugin. They can be used to check for updated/deleted records in Salesforce, pull a specific record from Salesforce by ID, or push a specific record from WordPress by Id and type.
	* Bug fix: pull queries were sometimes skipping records that should have been processed, especially when some records in the group were not allowed by the fieldmap.
	* Bug fix: as of 1.5.0, Salesforce records were not being deleted when a corresponding WordPress record was deleted. This release restorese that functionality.
	* Developers: the `object_sync_for_salesforce_pull_object_allowed` and `object_sync_for_salesforce_push_object_allowed` hooks now require that a value be returned, regardless of whether it is true or false. This was always the better way of handling these hook, but it was possible to use them without, and the documentation was incorrectly written.

* 1.5.2 (2018-11-27)
	* Bug fix: as of 1.5.0, when a Salesforce record is deleted, the corresponding WordPress record is not deleted. This release restores this functionality. Thanks to WordPress user @bswift for the report.
	* Developers: this release allows API calls that return data from Salesforce to return either json, the full PHP array (the default) or both, if the `$options` array is populated. Thanks to WordPress user @yanlep for the request.

* 1.5.1 (2018-11-03)
	* New: update to version 2.1.1 of the ActionScheduler library.
	* Bug fix: when processing more than 2000 records, the offset and limit combination fails due to Salesforce API restrictions. In this release, the plugin changes the date parameter on the API query to the value for the last processed record.

* 1.5.0 (2018-10-26)
	* New: the Mapping Errors tab supports deleting multiple error rows via checkboxes.
	* New: when caching API responses, the plugin caches the full array rather than the full array and the JSON data. This reduces the memory usage for object caches a little.
	* New: this plugin should be usable on WordPress VIP environments; it now checks for `user_attributes` instead of `user_meta` in those cases.
	* Bug fix: this plugin can now be properly deployed on hosts like Pantheon. Thanks to WordPress user @joepahl and GitHub user @BrianBenninger for reporting this.
	* Bug fix: when using meta fields for prematch, the plugin previously could fail to find a match even if the value existed. It now uses different matching for meta fields. **This requires that users resave their fieldmaps, and also that we end support for WordPress 4.5.**. Thanks to WordPress user @nodakjones for the bug report and testing assistance.
	* Bug fix: when using the ActionScheduler library, the plugin fails to process multiple rounds of pull requests. Now it uses the limit setting to page through all possible updated records. Thanks to WordPress user @jonsayer for the report and WordPress user @harmoney for help testing.
	* Developers: this release adds a new developer hook, `object_sync_for_salesforce_pull_query_modify`, which can modify the Salesforce API SOQL query before it pulls data from Salesforce. Thanks to WordPress user @yanlep for the suggestion.

* 1.4.2 (2018-08-29)
	* Bug fix: ensure the queue functionality is present when activating the plugin.

* 1.4.1 (2018-08-29)
	* Bug fix: in some plugin update scenarios, the database version number checker was not running. It runs all the time, now.

* 1.4.0 (2018-08-29)
	* New: this plugin now uses the [Action Scheduler](https://github.com/Prospress/action-scheduler) library for scheduling tasks and queueing data in a more performant and scalable way. This removes the need for some of the administrative settings, but as long as you **resave from the plugin's Schedule tab**, it should not break any existing functionality.
	* Bug fix: this release also stores composer library files in its Git repository. This *should* fix a deployment bug with some web hosts, such as Pantheon.
	* This release also brings plugin JavaScript in line with WordPress code formatting guidelines.
	* Thanks to GitHub user @charmoney for help reviewing this release.

* 1.3.9 (2018-08-10)
	* Bug fix: when Salesforce Key was selected on a fieldmap's field, it was incorrectly being ignored when saving a record's data in WordPress after a Salesforce pull. Thanks to WordPress user @ken-nguyen for reporting this.

* 1.3.8 (2018-08-03)
	* New: basic support for the Ultimate Member plugin. Users created by its registration form can be pushed to Salesforce. Thanks to @atomicjack for the report and assistance testing.

* 1.3.7 (2018-06-29)
	* New: modifications to dropdown fields when creating or editing fieldmaps allow users to pick whether to use the API name from Salesforce, and also allow for searching in a dropdown's contents. A developer hook allows some modification of the search/dropdown combo.
	* Bug fix: non-required date fields in Salesforce, if blank, would set the corresponding WordPress field to today's date. Thanks to GitHub user @synthetiv for the report and the fix.
	* Update some documentation and documentation formatting, including new documentation for importing and exporting.

* 1.3.6 (2018-05-16)
	* Bug fix: this release fixes an issue where the plugin can fail to save setting values in older WordPress versions, which keeps it from ever being activated. Thanks to WordPress user @amstertam for bringing this to our attention.

* 1.3.5 (2018-04-25)
	* Bug fix: this release fixes an issue where the plugin can fail to map certain fields in certain cases when the Salesforce value it is attempting to save in WordPress is empty.

* 1.3.4 (2018-04-14)
	* Bug fix: this release refixes an issue in which a custom post object with custom fields was not sending its custom fields on the first save, causing it to fail if the fields were required in Salesforce. Thanks to WordPress users @rtd2 and @bill5roses for reporting that the previous fix was not sufficient.

* 1.3.3 (2018-03-31)
	* Bug fix: a modified Salesforce Contact, which is not mapped to a user in WordPress but when the fieldmap does exist, would try to create a new user in WordPress but fail to add the email address to the email field. Thanks to GitHub user @mcculloughcm for the report.
	* Bug fix: the key and prematch fields were ignored if their Salesforce status was not updateable, so this broke prematch checking in those cases. Thanks to GitHub user @johnpbloch for the report.
	* New: small tweaks to plugin readme, inline form text.

* 1.3.2 (2018-03-16)
	* Bug fix: this plugin would sometimes conflict with jQuery from other plugins, especially older ones. This puts the object into an enclosure instead.
	* Bug fix: allow mapped date fields to be empty without causing a push error.
	* Bug fix: make sure plugin notices only appear on pages related to this plugin.
	* Bug fix: doing an import with only one object map would fail.

* 1.3.1 (2018-03-11)
	* Bug fix: this release fixes an issue in which a custom post object with custom fields was not sending its custom fields on the first save, causing it to fail if the fields were required in Salesforce. Thanks to WordPress user @rtd2 for reporting this.
	* Bug fix: this release makes the data import preserve the field structure.

* 1.3.0 (2018-03-10)
	* New: this release adds an interface for importing and exporting plugin data. It includes fieldmaps (which map object types to each other), object maps (individual objects mapped to each other) and plugin settings. Data is exported to a single JSON file that can be imported.
	* Bug fix: this release supports a datetime change in MySQL versions newer than 5.7.4 in which default values can no longer be 0000-00-00. See this [StackOverflow page](https://stackoverflow.com/questions/25349126/how-can-i-set-the-default-value-of-a-field-as-0000-00-00-000000) for details.
	* Bug fix: this release fixes an issue where admin notices for this plugin would sometimes be empty.
	* Also fixed a ton of code formatting stuff, including translation spots.
	* This release also fixes the previously broken Travis CI build's issues with older PHP versions.

* 1.2.8 (2018-03-09)
	* New: this release adds a new developer hook, `object_sync_for_salesforce_push_update_params_modify`, which allows the data being pushed to Salesforce to be modified in the event that an existing Salesforce object is being updated.
	* Bug fix: the install script adds `--prefer-dist` to the `composer install` to hopefully prevent issues on Pantheon. Thanks to WordPress user @joepahl for reporting this.
	* This releasse also makes a number of corrections and clarifications to the plugin documentation.

* 1.2.7 (2018-02-23)
	* Bug fix: in some cases, a fieldmap with the Salesforce update trigger checked, but not the Salesforce create trigger, it would still create data in WordPress. This data should, rather, be skipped.
	* New: there are also a number of small tweaks to in-page help, documentation and code comments.

* 1.2.6 (2018-01-30)
	* Bug fix: in some cases, date fields coming from Salesforce were not correctly formatted for use in WordPress. This release causes any core date fields to be formatted as WordPress expects them. Thanks to GitHub user @prowp for the report on this.
	* Note: to apply this fix, you need to clear the plugin cache, and then re-save any the fieldmap(s) that need it.
	* This release also includes a small documentation update about restricted picklist fields.

* 1.2.5 (2018-01-26)
	* Bug fix: trying to save a high number of fields in a single fieldmap was failing. Thanks to GitHub user @prowp for the report.
	* New: some in-page help to users who may be missing meta fields when trying to add them to a fieldmap. This happens if these meta fields are new fields without data, and thus cannot be found in the database by the plugin.
	* New: we now store the plugin version in the database when saving a fieldmap. This allows us to check fieldmaps to make sure they use the most up to date schema.

* 1.2.4 (2018-01-24)
	* This release fixes a rare bug in which Salesforce changes that occur between a query and the completion of the pull operation would not sync to WordPress. Thanks to GitHub user @charmoney for the report and the fix.
	* This release also removes the "weight" field from the screen that adds and edits fieldmaps. This field should have been removed in the past, as it doesn't currently do anything, although in the future we'd like to investigate the ability to map multiple WordPress objects to the same Salesforce object and sync them using the weight field.

* 1.2.3 (2018-01-19)
	* This release fixes a bug in which deleting field pairs from an existing fieldmap, saving, and then adding more field pairs could result in data not being saved. Thanks to WordPress user @pavelwld for reporting this.
	* This release also adds a Settings tab field to choose whether or not the plugin should delete its data when it is deactivated.

* 1.2.2 (2018-01-17)
	* This release fixes a bug in which an object map could not be created if the Salesforce ID was the same, with case insensitivity, as another Salesforce ID. Salesforce, however, is case sensitive with these IDs and can occasionally create IDs like this. Thanks to WordPress user @pavelwld for reporting this.

* 1.2.1 (2017-12-19)
	* This release fixes a bug caused in 1.2.0. Users were unable to sync data without re-saving fieldmaps. This does a version checker and uses previous data structures until users re-save.
	* Make sure you update your plugin fieldmaps.

* 1.2.0 (2017-12-18)
	* This release provides basic support for additional field types in Salesforce, including: multipicklist, picklist, date, datetime, and URL (results may vary depending on how WordPress plugins handle their custom field equivalents). Thanks to WordPress user @ilanabit for reporting this.
	* This release also forces InnoDB on the `field_map` table because MyISAM gets errors on the index length. Hopefully most users are already on InnoDB by default, but this will help any users who are not.

* 1.1.2 (2017-11-20)
	* Clarify the documentation, and the code, for the following developer hooks:
		* `object_sync_for_salesforce_add_more_wordpress_types`
		* `object_sync_for_salesforce_remove_wordpress_types`
		* `object_sync_for_salesforce_wordpress_object_data`
	* Thanks to WordPress user @justanothercoder for asking about this, leading to the fix.

* 1.1.1 (2017-11-17)
	* This release removes the `screen_icon()` method from admin.php. It has been deprecated apparently since 3.8, but in 4.9 it officially throws PHP Notice messages in `WP_DEBUG` mode.

* 1.1.0 (2017-11-10)
	* This release gives users a way to clear the cached data for this plugin only, even if they are using an object cache method. Most importantly this resolves the problem of new fields being available in Salesforce or WordPress and not being visible in the list of mappable fields when creating or updating a fieldmap. This is partly related to GitHub user @prowp's initial report of missing metadata.

* 1.0.11 (2017-11-06)
	* Fixed a bug in which a blank `post` object was created in the event that `pull` calls were blocked, then unblocked. Thanks to GitHub user @charmoney for the report and much of the fix.
	* Fixed a bug in which `post` meta fields were not pushed to Salesforce. Also as part of this, added basic support for WooCommerce `order` post types. Thanks to WordPress user @ratputin and GitHub user @prowp for the report.

* 1.0.10 (2017-10-10)

	* This avoids repeatedly queueing Salesforce objects by initializing rather than aggregating the queue before saving. This reduces memory use and database size significantly.
	* Plugin now updates the pull sync timestamp for the data type after every successful record queue. This provides a correct starting point for the next pull to begin in case of a fatal error.
	* Thanks to GitHub user @charmoney for the report and the pull request.

* 1.0.9 (2017-10-03)

	* This fixes a bug in which upserting a custom post type would incorrectly create a standard post, rather than the desired custom post object. Thanks to GitHub user @prowp for the report.

* 1.0.8 (2017-08-14)

	* This checks a mapping's configured allowed sync triggers before queueing a record for pull processing, rather than as a part of the WordPress record's create or update. This resolves an issue. Thanks to GitHub user @charmoney for the report and the pull request.
	* This release also fixes a bug related to 1.0.7, which after the fix was still incorrectly checking the `post_content` and `post_title` values.

* 1.0.7 (2017-08-01)

	* This sets up admin notices that always show above the plugin's admin tabs if: 1) the plugin is not authorized, 2) there are no fieldmaps, or 3) there is no schedule set up for the plugin. This is so users understand they have to do these things before the plugin can properly work.
	* Fixed a bug where `wp_insert_post` failed if the `post_content` or `post_title` values were not passed, but the map row was still created. This passes empty values for both fields if they aren't present. It also throws a `WP_Errror` object if either `wp_insert_post` or `wp_update_post` fail.
	* Also fixed some code formatting issues

* 1.0.6 (2017-07-05)

	* This builds a basic interface for object map rows that failed to be fully created to map objects between the two systems, and have a temporary ID for either WordPress or Salesforce.
	* If any of these rows are present in the database, it creates a Mapping Errors tab at `/wp-admin/options-general.php?page=object-sync-salesforce-admin&tab=mapping_errors`.
	* For each row, it shows the WordPress ID, WordPress object type, Salesforce ID, and when it was created. Users are able to edit each row's WordPress and/or Salesforce ID, in case the data they need to map does actually exist, and are also able to delete each row individually in case they just want to let the plugin run again.
	* This gives users a non SQL way to manage those error rows if they ever occur, on top of the previous PR on this branch that kept them from preventing further syncing.
	* **Noteworthy change:** in `salesforce_mapping` we now filter the `$posted` array so it only contains the columns in the database table for object maps, plus the `action` parameter that we filter out later. I've verified that the various `create_object_map` methods do not contain other parameters that we need to preserve for similar use to the `action`.

* 1.0.5 (2017-06-29)

	* Fixes an inconsistent scenario in which the plugin created object map rows with a WordPress or Salesforce ID of 0 and then failed to sync new objects because of the database key. Here's how:
		- Change the wordpress_id field on the map table to be a varchar instead of an integer (updating the plugin from the wordpress repo will automatically update this, but users who update manually will need to do it manually)
		- when creating an object map between two items, plugin creates a temporary id value for whichever system does not have the item (ie a temporary wordpress id if we're on a salesforce pull action). This replaces the value of 0 that the plugin previously used before updating the database with the correct id value.
		- This way if the api fails, server goes down, whatever, that tmp id is unique down to the milisecond. The database key can stay, making sure duplicate ids do not get mapped and such, but in a worst case scenario there are rows that keep the temp id because the operation failed. They can be tracked down to when they happened and whether it was a push or pull that failed, by looking up that ID in the database.
	* Also updates documentation to be more clear about how the plugin works with data that exists prior to installation (mostly it doesn't, with some tiny manual exceptions).

* 1.0.4 (2017-06-12)

	* Fix the tested version again, as it was reverted

* 1.0.3 (2017-06-09)

	* Update the deploy file so it keeps .git, .gitignore, etc. items out of the deployed plugin

* 1.0.2 (2017-06-09)

	* Update tested WordPress version to reflect 4.8
	* Some basic preparation work for supporting the Salesforce SOAP API
	* Update dependencies

* 1.0.1 (2017-06-05)

	* made table summaries on API status page into translatable strings

* 1.0.0 (2017-05-30)

	* first stable release
