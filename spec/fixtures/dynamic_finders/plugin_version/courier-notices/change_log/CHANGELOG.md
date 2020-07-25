# Changelog #

## 1.2.3 ##
* Fixed - issue with notice placement (whoops)

## 1.2.1 ##

* Updated sanitization to match wordpress.org audit.

## 1.2.0 ##

* Updated - Namespace changed from courier to courier-notices due to plugin conflict on wordpress.org
* Fixed   - Duplicate modal/popup issue
* Submission to wordpress.org

## 1.1.4 ##

* Fixed - Fatal error when assigning data to a template view

## 1.1.3 ##

* Fixed - Icon font specificity

## 1.1.2 ##

* Remove - Notice font styles, allow styling to inherit from theme

## 1.1.1 ##

* Fixed - Issue with default styles not being created on install
* Fixed - Security updates provided by github audit

## 1.1.0 ##

* Fixed - Minor security updates
* Fixed - Minor code cleanup
* Fixed - Link to Types/Design was broken
* Fixed - Link to Settings was broken
* Fixed - Minor updates to strings to allow for translation
* Fixed - Modal notice was not working properly (dismissible)
* Fixed - Error log was being utilized and should not have been
* Fixed - Cron was running hourly and not every 5 minutes
* Fixed - Various typos (We talk pretty one day)
* Fixed - utilizing iris wpColorPicker (For the time being)
* Fixed - Fixed an issue with color changes in the design panel did not show until page refresh
* Added - New UI/UX for creating and styling "Types" of notices
* Added - Courier actually has some branding now
* Added - Default data on plugin activation
* Added - Utility method to sanitize kses content
* Added - Cleaned up CSS across the entire plugin
* Added - New cron schedule (Every 5 minutes)
* Added - New taxonomy for "Style of Notice". This will allow for all different kinds of notices in the future
* Added - Base for CRUD in the future. Mainly just R right now.
* Improved - Added more flexibility to how tabs and subtabs can extend the plugin
* Improved - CSS is only generated and output if CSS is not disabled
* Improved - Placement logic is more flexible now
* Improved - UI/UX to show different notice options depending on other selections
* Improved - How css and javascript is enqueued based on context of admin
* Improved - Code Organization
* Improved - Templates
* Improved - Updated the expiration of notices to increment every 5 minutes for better accuracy and less stress on servers

## 1.0.4 ##

* Cleaned up deployment process further.

## 1.0.2 ##

* Migrated to using composer as our autoloader instead of a proprietary one
* Added Parsedown dependency for Markdown display within the plugin
* Added a changelog.md display to the settings page as a tab
* Added more automation for release to get releases out the door quicker
* Minor code formatting changes

## 1.0.1 ##

* Updated dependencies based on github security notification

## 1.0.0 ##

Initial Release

* Cleaned up UI for date and time selection.
* You can no longer select an expiration date from the past.
* Implemented datetimepicker so time selection is easier.
* Minor typo fix in admin area.
* Minor data sanitization/security hardening.
