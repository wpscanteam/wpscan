# Log Emails

## Changelog

### 1.3.1, 2018-11-26

* fixed: log date shows as "Last modified"

### 1.3.0, 2018-11-20

* fixed: recursive looping when saving a post triggers an email on publish state (e.g. Notification plugin)
* tested: WordPress 5.0

### 1.2.1, 2016-11-26

* fixed: password obfuscation for the current locale supports non-ascii characters

### 1.2.0, 2016-11-21

* fixed: capture BuddyPress email recipients
* fixed: remove Mine filter on list of email logs
* fixed: stop some post admin plugins messing with the list of email logs
* added: search also looks in From, To, CC, BCC email addresses
* added: sort by subject, recipients
* changed: password obfuscation also for the current locale
* changed: menu item names are now Log Emails, the same as the plugin name

### 1.1.0, 2016-07-02

* SECURITY FIX: any logged-in user could see any email log or other post by guessing a post ID (thanks for responsible disclosure, [Plugin Vulnerabilities](https://www.pluginvulnerabilities.com/))
* fixed: second row of action links for each log in list
* fixed: move Date column back to end of row in list
* changed: don't sanitize email log body / alt-body when saving, to preserve more of actual email for log view (credit: [Hrohh](https://wordpress.org/support/profile/hrohh))
* changed: restrict log view CSS so that it doesn't affect email content display (credit: [Hrohh](https://wordpress.org/support/profile/hrohh))
* changed: improved accessibility in the log view page
* added: warn when an email is missing sender, recipients, subject, or body

### 1.0.6, 2015-12-02

* added: French translation (thanks, [Hugo Catellier](http://www.eticweb.ca/)!)

### 1.0.5, 2014-12-18

* fixed: undefined property `delete_posts` on custom post type capabilities in WordPress 4.1

### 1.0.4, 2014-11-03

* fixed: default sort order is by ID descending, to avoid ordering errors when logs occur in the same second
* added: Czech translation (thanks, [Rudolf Klusal](http://www.klusik.cz/)!)

### 1.0.3, 2014-09-06

* fixed: PHP warning on static call to non-static methods in class LogEmailsCache_WpSuperCache
* fixed: fix WordPress 4.0 box shadow on return-to-list :focus

### 1.0.2, 2014-08-21

* fixed: bulk action checkboxes not appearing on stand-alone WordPress sites

### 1.0.1, 2014-08-20

* fixed: menu link not appearing on stand-alone WordPress sites
* added: uninstall handler to remove logs when plugin is uninstalled

### 1.0.0, 2014-08-16

* initial public release
