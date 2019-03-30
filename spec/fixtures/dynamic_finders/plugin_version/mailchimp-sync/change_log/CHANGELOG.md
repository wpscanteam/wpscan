Changelog
===========

### 1.7.6 - Dec 3, 2018

**Improvements**

- Add warning text to settings that may cause subscribers to be removed from the connected MailChimp list.


### 1.7.5 - July 4, 2018

**Improvements**

- Get rid of status indicator on settings page as it's not important nor accurate.

**Additions**

- Add button to settings page to immediately process all pending background jobs.



### 1.7.4 - May 28, 2018

**Additions**

- Added mailchimp_sync_delete_subscribers filter, will [delete subscribers from the MailChimp list](https://github.com/ibericode/mc4wp-snippets/blob/master/add-ons/user-sync/really-delete-subscribers-from-list.php) if filter returns true (instead of updating their status).


### 1.7.3 - April 30, 2018

**Improvements**

- Allow users that unsubscribed to be re-subscribed, but only if users can manage their sign-up status from their profile page.
- Better (more privacy friendly) default settings.
- Add warning text to settings that may affect GDPR compliance.
- CLI commands shows a list of errors now (if any).
- More detailed error messages when MailChimp API returns an error.


### 1.7.2 - March 14, 2018

**Fixes**

- Fatal error because of unexisting function on WooCommerce my account page.


### 1.7.1 - March 13, 2018

**Fixes**

- Manual synchronization would not stop running if errors occurred.
- Fix hooks like `mailchimp_sync_handle_user`.

**Additions**

- Allow users to subscribe/unsubscribe from their WooCommerce account page too.


#### 1.7 - February 16, 2018

**Fixes**

- Incorrect total user count when running the plugin on WP Multsite.

**Improvements**

- Do not hard-delete subscribers, update status instead.


#### 1.6.4 - December 12, 2017

**Improvements**

- Transactional (e-commerce) subscribers would not be subscribed when synchronising.


#### 1.6.3 - December 4, 2017

**Fixes**

- Last few users were always skipped when performing a manual sync (via browser).

**Improvements**

- Allow processing pending background jobs by visiting any admin page with `?_mc4wp_action=process_user_sync_queue` as an administrator.
- Get rid of PHP notice on user profile page.


#### 1.6.2 - November 22, 2017

**Fixes**

- CLI command would not find any users when synchronising all user roles.

**Improvements**

- Improved success messages in CLI commands.


#### 1.6.1 - November 21, 2017

**Fixes**

- Invalid class reference in WP CLI command.


#### 1.6 - November 2, 2017

**Additions**

- Added setting that allows users to opt-out from selected MailChimp list via their profile page.

**Improvements**

- Minor refactoring & improvements to log messages.


#### 1.5.4 - May 23, 2017

**Fixes**

- Interest groupings not coming through when using `mailchimp_sync_subscriber_data` filter hook.

**Improvements**

- Queued background jobs are now only processed at the hourly schedule.

**Additions**

- Added `mc4wp-sync process-queue` command to WP CLI.


#### 1.5.3 - January 18, 2017

**Fixes**

- Pending subscribers (when double opt-in is enabled) would be subscribed again on every profile change.

**Improvements**

- Plugin can now update email addresses in MailChimp without creating a separate (new) subscriber. Thanks to [Maymay](https://maymay.net/) for the great help.
- Now showing pending background jobs on settings page.
- Background queue improvements for long-lived processes
- Errors in background jobs will now be logged to the [debug log](https://mc4wp.com/kb/how-to-enable-log-debugging/).
- Reschedule event whenever options are saved.

#### 1.5.2 - September 28, 2016

**Fixes**

- Interest groups were always being replaced, instead of added to the existing subscriber's interest groups.

**Improvements**

- Always write to debug log when webhook receives request for user.

**Additions**

- Added `mailchimp_sync_webhook_data` filter to manipulate data received by webhook before it is processed.


#### 1.5.1 - September 7, 2016

**Fixes**

- Don't delay other cron jobs when an error occurs.

**Improvements**

- Only send user fields to MailChimp when not empty, to prevent overriding existing data when webhook is not configured.
- Ask for confirmation before changing webhook secret.


#### 1.5 - August 4, 2016

**Improvements**

- Forward compatibility with upcoming [MailChimp for WordPress 4.0 release](https://mc4wp.com/kb/upgrading-to-4-0/).
- Use correct WP function for updating user email address from webhook.


#### 1.4.7 - July 8, 2016

**Fixes**

- Incorrect user count resulting in lots of duplicate "Fetched 0 users" statements in Manual Synchronization wizard.

**Improvements**

- Various improvements to Manual Synchronization wizard, including more verbose feedback.
- Add link to KB article for [synchronizing additional fields](https://mc4wp.com/kb/syncing-custom-user-fields-mailchimp/).


#### 1.4.6 - June 14, 2016

**Fixes**

- Webhook not updating user fields because it couldn't find an associated user.

**Additions**

- Added webhook settings to settings page.
- Added "secret key" option to webhook, to further secure webhook endpoint.
- Preparations for MailChimp API v3.


#### 1.4.5 - May 25, 2016

**Fixes**

- Error on PHP 5.3. Square bracket array assignment is a PHP 5.4 feature.


#### 1.4.4 - May 25, 2016

**Fixes**

- Only add MailChimp status to user profile when user matches criteria.
- CLI command now defaults to role selected on settings page when no role argument given.

**Improvements**

- Show success notice when manually subscribing or updating a user.
- Show "skipped" message when wizard attempts to synchronize a user that is excluded by the `mailchimp_sync_should_sync_user` filter.
- Show notice that numbers are off when using `mailchimp_sync_should_sync_user` filter.
- Various UX improvements to settings page & manual synchronization wizard.
- Various performance improvements.


#### 1.4.3 - April 13, 2016

**Improvements**

- When user switches role or no longer matches custom conditions (using the `mailchimp_sync_should_sync_user` filter) he will now be unsubscribed from the selected MailChimp list.
- User fields which are an array of values are now automatically converted to a comma-separated string before they are sent to MailChimp.

#### 1.4.2 - March 14, 2016

**Fixes**

- Re-run subscribe method if email isn't found on MailChimp list (because of an invalid email, for example)

**Improvements**

- Setup schedule to run sync process at least once an hour, to prevent long delays.
- Strip `EMAIL` from available field map fields to prevent invalid configurations.
- Webhook updating a user will now write to [the debug log](https://mc4wp.com/kb/how-to-enable-log-debugging/).


#### 1.4.1 - February 10, 2016

**Fixes**

- Webhook verification not working when setting up webhook in MailChimp.

**Improvements**

- Remove JS sourcemaps from admin scripts.

#### 1.4 - January 26, 2016

This update requires you to update [MailChimp for WordPress](https://wordpress.org/plugins/mailchimp-for-wp/) to version 3.1 first.

**Fixes**

- Deleted users were no longer unsubscribed in some cases.

**Improvements**

- Use new Queue class from MailChimp for WordPress 3.1 for improved background processing.
- [Use new debug log for easier debugging](https://mc4wp.com/kb/how-to-enable-log-debugging/).
- Add HTTP status codes to Webhook listener.
- Miscellaneous code improvements

**Changes**

- WP CLI commands are now named `wp mailchimp-sync all` and `wp mailchimp-sync user <user_id>` (backwards compatible)

**Additions**

- WP CLI command `wp mailchimp-sync all` is now showing a progress bar


#### 1.3.3 - January 14, 2016

**Fixes**

- Fatal error on settings page on lower PHP versions because of missing space between `<?php` and translation call. This gets Forced Sync to work again.

#### 1.3.2 - January 13, 2016

**Fixes**

- Subscription status wasn't showing on user profile.

**Improvements**

- Check for correct request parameters before processing [MailChimp webhook](https://mc4wp.com/kb/configure-webhook-for-2-way-synchronizing/).
- Change plugin name to "MailChimp User Sync"
- Document all WP CLI commands.
- Better mobile responsiveness for settings pages.
- Use Browserify to handle script dependencies.
- Improved compatibility with [MailChimp for WordPress v3.0](https://mc4wp.com/blog/the-big-three-o-release/)

#### 1.3.1 - November 13, 2015

**Improvements**

- Compatibility fixes for [the upcoming MailChimp for WordPress 3.0 release](https://mc4wp.com/blog/breaking-backwards-compatibility-in-version-3-0/).

**Additions**

- Added `mailchimp_sync_get_user_field` filter to get user fields from a custom source and sync those to MailChimp.

#### 1.3 - October 17, 2015

**Fixes**

- Webhook not picking up on custom fields, it was only updating default user fields.
- When creating user via `mailchimp_sync_webhook_user` filter, it was not staying in sync.

**Improvements**

- Changes are now sent to MailChimp **after** all changes are applied, at the end of the request.
- Individual changes in `user_meta` will now be taken into account as well.

#### 1.2.3 - October 12, 2015

**Fixes**

- Webhook listener not working since version 1.2.2.
- Fields in additional fields section were stripped on settings save (when using "+ Add Line" button).

**Improvements**

- Various defensive coding improvements to the webhook listener


#### 1.2.2 - October 7, 2015

**Additions**

- Introduced 2 new filters (`mailchimp_sync_webhook_user` and `mailchimp_sync_webhook_no_user`) which allow you to hook into the MailChimp webhook listener to specify the WP user or do something when there is no user for the MailChimp subscriber. [Here is a code example that creates a new user when the subscriber has no user account](https://gist.github.com/dannyvankooten/79fe429daaef611b6aa5).

#### 1.2.1 - October 1, 2015

**Improvements**

- For mapping user fields, you can now manually type the "meta key" value of the field. Comes with autocomplete if you have users with that field already.
- For WooCommerce checkout: run after custom fields have been added

**Fixes**

- Newly added rows could not be removed unless page was refreshed again.

#### 1.2 - September 24, 2015

**Additions**

- Added support for MailChimp webhooks, so data can be synchronized from MailChimp to WordPress as well.  To enable this, you need to [configure a webhook in your MailChimp account](https://mc4wp.com/kb/configure-webhook-for-2-way-synchronizing/).

#### 1.1.3 - September 9, 2015

**Fixes**

- Status indicator was not working for installations with a custom database prefix.

**Improvements**

- You can now view & clear the log file from the settings page.
- Nothing will be logged unless `WP_DEBUG` is enabled.

#### 1.1.2 - September 8, 2015

**Fixes**

- Status indicator (in sync / out of sync) is now showing the correct # of users when a role is set.

**Improvements**

- Field rules will now clear when changing the MailChimp list to subscribe to.
- Make it more clear that settings should be saved after choosing a MailChimp list.

#### 1.1.1 - August 28, 2015

**Additions**

- Allows you to send the user role as well.

#### 1.1 - August 28, 2015

**Additions**

- You can now send additional user fields.
- You can now subscribe individual users from their "edit user" page.

#### 1.0.2 - August 18, 2015

**Improvements**

- Errors are now written to dedicated log file, usually located in `/wp-content/uploads/mailchimp-sync.log`.
- Added `mailchimp_sync_should_sync_user` filter, which lets you set your own criteria for subscribing a user.

#### 1.0.1 - July 14, 2015

**Improvements**

- More detailed error message are now shown in the log.
- Force Sync will now start with unsynced users.

#### 1.0 - May 29, 2015

**Fixes**

- Force synchronization would not work on large data sets (> 10.000). The process is now batched.

**Improvements**

- Pause & resume the forced synchronization process

**Additions**

- Enable & disable auto-syncing
- Choose a user role to synchronize.
- [WP CLI](https://wp-cli.org/) commands: `wp mailchimp-sync sync-all` and `wp mailchimp-sync sync-user $user_id`.
- Filter: `mailchimp_sync_user_data` to modify user data before it's sent to MailChimp.

For more detailed usage info on the introduced features, have a look at the [MailChimp User Sync FAQ](https://wordpress.org/plugins/mailchimp-sync/faq/).

#### 0.1.2 - March 17, 2015

**Fixes**

- Synchronising would stop if a synchronize request failed
- Conflict with other plugins bundling old versions of Composer, throwing a fatal error on plugin activation
- Users who were deleted from a list would cause issues, they're now re-subscribed.

**Improvements**

- Added some feedback to Log whether a synchronization request succeeded or not.

#### 0.1.1 - February 17, 2015

**Fixes**

- Force Sync got stuck on users without a valid email address. ([#10](https://github.com/ibericode/mailchimp-user-sync/issues/10), thanks [girandovoy](https://github.com/girandovoy))
- JSON response was malformed when any plugin threw a PHP notice

**Improvements**

- Progress log now auto-scrolls to bottom
- Progress log now shows time
- Progress log now shows more actions
- Add settings link to Plugin overview
- Various JavaScript improvements

#### 0.1 - January 23, 2015

Initial release.
