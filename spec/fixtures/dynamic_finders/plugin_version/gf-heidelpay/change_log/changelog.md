# Gravity Forms heidelpay

## Changelog

### 1.2.0, 2018-12-01

* added: custom merge tag `{date_created}` so that notification resends can show the entry date instead of the current date
* changed: minimum required PHP version is now 5.6; recommended version is PHP 7.2 or higher

### 1.1.2, 2017-09-13

* fixed: Gravity Forms 2.3 compatibility; don't directly access database tables

### 1.1.1, 2017-05-24

* fixed: invalid argument warning in `pre_process_feeds()` when form has no feeds

### 1.1.0, 2017-05-16

* released as a free plugin on wordpress.org

### 1.0.3, 2017-01-09

* fixed: Address line 2 should not be marked as mandatory in the field mappings, because it isn't required

### 1.0.2, 2017-01-01

* fixed: settings and feeds menu items disappear when Members plugin used to set Gravity Forms permissions

### 1.0.1, 2016-12-07

* fixed: undefined index errors on `gform_replace_merge_tags` hook, e.g. with GF User Registration login widget

### 1.0.0, 2016-11-09

* initial stable release
