# Delete Expired Transients

## Changelog

### 2.0.7, 2018-11-19

* tested: WordPress 5.0

### 2.0.6, 2016-11-18

* tested to WordPress 4.7

### 2.0.5, 2016-10-09

* added: Hungarian translation (thanks, [Tom Vicces](https://profiles.wordpress.org/theguitarlesson/)!)
* added: manual deletion of obsolete sessions from WooCommerce version 2.4 and earlier

### 2.0.4.1, 2015-12-02

* fixed: "Class 'DelxtransCleaners' not found" when deleting expired transients

### 2.0.4, 2015-12-02

* fixed: bottom bulk-action doesn't work on multisite network admin
* changed: localisation text domain now delete-expired-transients

### 2.0.3, 2015-02-28

* fixed: can delete site transients when there are only never-expire site transients
* added: French translation (thanks, [Mathieu Hays](http://mathieuhays.co.uk/)!)

### 2.0.2, 2014-10-10

* added: Spanish translation (thanks, [David Sandoval](http://BieberNoticias.com/)!)

### 2.0.1, 2014-08-31

* added: Norwegian translations (thanks, [neonnero](http://www.neonnero.com/)!)

### 2.0.0, 2014-08-27

* changed: big refactor for better multisite support
* fixed: site transients not counted properly
* added: also clean up NextGEN Gallery 2.x display_gallery_rendered_* timeout aliases (thanks, Robert Park!)

### 1.1.1, 2013-12-31

* fixed: manual deletion performs nonce check, to prevent unauthorised access

### 1.1.0, 2013-10-19

* fixed: manual delete failed in WordPress multisite installations
* changed: use LIKE instead of REGEXP in SQL statements, so that database index is utilised (better performance)
* added: also clean up the essentially transient display_galleries_* timeout aliases for NextGEN Gallery 2.x

### 1.0.0, 2013-07-27

* initial public release
