Changelog
=========

1.7.1 (2019-02-07)
- Reinstall settings page for multisites.

1.7 (2019-01-21)
- Remove settings page for multisites.
- Simplify admin notifications.
- Test plugin with PHP 7.2.
- Test plugin up to WordPress 5.0.3.

1.6.1 (2018-10-08)
- Restore Settings page form for all install types.

1.6 (2018-9-21)
- Refactor admin notifications
- Enable Settings page for all WordPress install types
- Enable Test Configuration for all WordPress install types
- Test plugin up to WordPress 4.9.8.

1.5.14 (2018-09-11)
- Force SSL-secured SMTP connections to use port 465 (SMTPS) to connect, 587 for plain and TLS
- Support region endpoint switching for SMTP

1.5.13.1 (2018-08-15)
- Fix line breaks in Test Configuration email

1.5.13 (2018-08-14)
- Default to US region if no region is configured in settings
- Add admin notification about region configuration
- Log an error message when an email is sent with no explicit region configured

1.5.12.3 (2018-08-09)
- Fix Region select menu default when wp-config.php variable is set
- Fix front end email input validation

1.5.12.2 (2018-08-09)
- Fix plugin not saving after update

1.5.12.1 (2018-08-06)
- Fix for backwards compatibility

1.5.12 (2018-08-02)
- Add EU endpoint for Mailgun HTTP API
- Fix broken logo image on Lists page
- Test plugin up to Wordpress 4.9.7

1.5.11 (2018-05-30):
- Fix an issue with authentication failing for newer API keys
- Test plugin up to Wordpress 4.9.6

1.5.10 (2017-11-22):
- Fix back to settings link on lists page (https://github.com/mailgun/wordpress-plugin/pull/65)
- Fix a bug causing `text/html` emails to send as both `text/plain` *and* `text/html` parts

1.5.9 (2017-09-13):
- Add a configuration option to allow setting security type for SMTP connection (SSL / TLS)

1.5.8.5 (2017-09-05):
- Change default click tracking setting to `htmlonly` (https://github.com/mailgun/wordpress-plugin/pull/58)
- Change PHPMailer set-up stanza to use TLS

1.5.8.4 (2017-06-28):
- Packaging fix which takes care of an odd filtering issue (https://wordpress.org/support/topic/1-5-8-3-broke-the-mg_mutate_message_body-filter)

1.5.8.3 (2017-06-13):
- Fix a bug causing only the last header value to be used when multiple headers of the same type are specified (https://wordpress.org/support/topic/bug-with-mg_parse_headers/)
- Added `pt_BR` translations (thanks @emersonbroga)

1.5.8.2 (2017-02-27):
- Fix a bug causing empty tags to be sent with messages (#51)
- Add `mg_mutate_message_body` hook to allow other plugins to modify the message body before send
- Add `mg_mutate_attachments` hook to allow other plugins to modify the message attachments before send
- Fix a bug causing the AJAX test to fail incorrectly.

1.5.8.1 (2017-02-06):
- Fix "Undefined property: MailgunAdmin::$hook_suffix" (#48)
- Fix "Undefined variable: from_name on every email process" (API and SMTP) (#49)
- Admin code now loads only on admin user access

1.5.8 (2017-01-23):
* Rewrite a large chunk of old SMTP code
* Fix a bug with SMTP + "override from" that was introduced in 1.5.7
* SMTP debug logging is now controlled by `MG_DEBUG_SMTP` constant

1.5.7.1 (2017-01-18):
* Fix an odd `Undefined property: MailgunAdmin::$defaults` when saving config
* Fix strict mode notice for using `$mailgun['override-from']` without checking `isset`

1.5.7 (2017-01-04):
* Add better support for using recipient variables for batch mailing.
* Clarify wording on `From Address` note
* Detect from name and address for `phpmailer_init` / SMTP now will honour Mailgun "From Name / From Addr" settings
* SMTP configuration test will now provide the error message, if the send fails
* Fix `undefined variable: content_type` error in `wp-mail.php` (https://wordpress.org/support/topic/minor-bug-on-version-version-1-5-6/#post-8634762)
* Fix `undefined index: override-from` error in `wp-mail.php` (https://wordpress.org/support/topic/php-notice-undefined-index-override-from/)

1.5.6 (2016-12-30):
* Fix a very subtle bug causing fatal errors with older PHP versions < 5.5
* Respect `wp_mail_content_type` (#37 - @FPCSJames)

1.5.5 (2016-12-27):
* Restructure the `admin_notices` code
* Restructure the "From Name" / "From Address" code
* Add option to override "From Name" / "From Address" setting set by other plugins
* Fix a bug causing default "From Name" / "From Address" to be always applied in some cases
* Moved plugin header up in entrypoint file (https://wordpress.org/support/topic/plugin-activation-due-to-header/#post-8598062)
* Fixed a bug causing "Override From" to be set to "yes" after upgrades

1.5.4 (2016-12-23):
* Changed some missed bracketed array usages to `array()` syntax
* Fix `wp_mail_from` / `wp_mail_from_name` not working on old PHP / WP versions
* Add a wrapper for using `mime_content_type` / `finfo_file`

1.5.3 (2016-12-22):
* Changed all bracketed array usages to `array()` syntax for older PHP support
* Redesigned `Content-Type` processing code to not make such large assumptions
* Mailgun logo is now loaded over HTTPS
* Fixed undefined variable issue with from email / from name code

1.5.2 (2016-12-22):
* Added option fields for setting a From name and address

1.5.1 (2016-12-21):
* Fixed an issue causing plugin upgrades from <1.5 -> >=1.5 to deactivate

1.5 (2016-12-19):
* Added Catalan language support (@DavidGarciaCat)
* Added Spanish language support (@DavidGarciaCat)
* Added German language support (@lsinger)
* Fixed incorrect SMTP hostname
* Applied PSR standards across codebase
* Applied open tracking bugfix
* Applied tags bugfix
* Applied `Mailgun Lists` admin panel bugfix
* Fixed click tracking dropdown
* Fixed click tracking and open tracking
* Now try to process *all* sent mails as HTML, see L201 wp-mail.php for details
* Mailgun logo now loads on both admin pages ;)
* Now using the Mailgun API v3 endpoint!
* Configuration test will now present either an error from the API or the HTTP response code + message

1.4.1 (2015-12-01):
* Clarify compatibility with WordPress 4.3

1.4 (2015-11-15):
* Added shortcode and widget support for list subscription

1.3.1 (2014-11-19):
* Switched to Semantic Versioning
* Fixed issue with campaigns and tags

1.3 (2014-08-25):
* Added check to ignore empty attachments

1.2 (2014-08-19):
* Fixed errors related to undefined variable. https://github.com/mailgun/wordpress-plugin/pull/3

1.1 (2013-12-09):
* Attachments are now handled properly.
* Added ability to customize tags and campaigns.
* Added ability to toggle URL and open tracking.

1.0 (2012-11-27):
* Re-release to update versioning to start at 1.0 instead of 0.1

0.1 (2012-11-21):
* Initial Release

