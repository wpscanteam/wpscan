# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 3.1.0
* Fix post targeting when called recursively

## 3.0.0
* Improved Quick-Edit and Bulk-Edit support
* Remove `attachment` type support for now, as there is no way to switch back
* Fix bug causing some post-types to switch unexpectedly

## 2.0.1
* Ensure quick-edit works with new procedure
* Quick-edit "Type" column works again!

## 2.0.0
* Improved plugin compatibility with WooThemes Sensei
* Filter post arguments vs. hook to save_post
* Add "post_type_switcher" action

## 1.7.0
* Add support for network activation

## 1.6
* Add textdomains for localization
* Load translation strings using load_plugin_textdomain()
* Before saving data chack if it's not an autosave using wp_is_post_autosave()
* Before saving data chack if it's not a revision using wp_is_post_revision()
* Security: Prevent direct access to directories
* Security: Translation strings escaping
* Add screenshots

## 1.5 - norcross
* Fix multiple quickedit dropdowns

## 1.4
* Improve handling of non-public post types

## 1.3
* Fix saving of autodrafts

## 1.2.1
* Improved WordPress 3.9 integration (added dashicon to publish metabox)

## 1.2
* Add bulk editing to supported post types
* Props Matthew Gerring for bulk edit contribution

## 1.1.1
* Add is_admin() check to prevent theme-side interference
* Change save_post priority to 999 to avoid plugin compatibility issues
* Remove ending closing php tag
* HTML and PHPDoc improvements

## 1.1
* Fix revisions being nooped
* Fix malformed HTML for some user roles
* Classificationate

## 1.0
* Fix JS bugs
* Audit post save bail conditions
* Tweak UI for WordPress 3.3

## 0.3
* Use the API to change the post type, fixing a conflict with persistent object caches
* No longer requires JavaScript

## 0.2
* Disallow post types that are not public and do not have a visible UI

## 0.1
* Release
