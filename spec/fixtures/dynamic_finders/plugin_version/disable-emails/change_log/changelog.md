# Disable Emails

## Changelog

### 1.4.0, 2018-11-21

* added: setting to force Events Manager to use `wp_mail()` so that its emails can be disabled
* tested: WordPress 5.0

### 1.3.0, 2016-11-21

* added: setting to force BuddyPress to use `wp_mail()` so that its emails can be disabled

### 1.2.5, 2015-12-02

* added: Chinese translation (thanks, [Cai_Miao](https://profiles.wordpress.org/cai_miao)!)
* added: Japanese translation (thanks, [Cai_Miao](https://profiles.wordpress.org/cai_miao)!)
* added: status message on At A Glance dashboard metabox when emails are disabled

### 1.2.4, 2015-02-28

* added: German translation (thanks, [Peter Harlacher](http://helvetian.io/)!)

### 1.2.3, 2014-11-03

* added: Czech translation (thanks, [Rudolf Klusal](http://www.klusik.cz/)!)

### 1.2.2, 2014-08-31

* added: Norwegian translations (thanks, [neonnero](http://www.neonnero.com/)!)

### 1.2.1, 2014-06-22

* added: warn when wp_mail() can't be replaced, so admin knows that emails cannot be disabled

### 1.2.0, 2014-04-19

* changed: refactored to fully support filter and action hooks that other plugins might use to listen to and modify emails, e.g. so that email loggers can properly record what would have been sent

### 1.1.0, 2014-02-25

* fixed: `wp_mail()` now returns true, simulating a successful email attempt
* added: support filter hook `wp_mail` so that listeners can act, e.g. log emails (even though they will not be sent); can be turned off in settings

### 1.0.0, 2014-02-18

* initial release
