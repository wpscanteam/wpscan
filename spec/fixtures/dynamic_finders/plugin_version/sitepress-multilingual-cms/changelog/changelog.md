Note: This changelog is weird, as multiple format were used over time it seems.

(Note: Latest format is)

# 3.6.3

## Fixes

* [wpmlcore-3411] Fixed some glitches for dropdown language switchers
* [wpmlcore-3853] Fixed `SitePress::get_term_adjust_id` to retain the `object_id` if needed. Fixes missing WC product variations

(Note: Another format can be)

#3.3.4

#Fixes
* [wpmlcore-2465] Fixed AJAX loading of Media in WP-Admin when domains per languages are used
* [wpmlcore-2433] Fixed compatibility issues with W3 Total Cache when Object caching is used
* [wpmlcore-2420] Fix menu synchronization when menu item has quotes in its title
* [wpmlcore-2445] Use of Fileinfo functions to read file mime type when uploading a custom flag, fall back to the now deprecated `mime_content_type` function, if the first set of cuntions is not available
* [wpmlcore-2453] Fixed fatal error when setting a custom taxonomy as translatable (`Fatal error - Class WPML_Term_Language_Synchronization not found in sitepress.class.php`)
* [wpmlcore-2448] Fixed `WordPress database error You have an error in your SQL syntax` message, caused by empty or corrupted languages order.
* [wpmlcore-2452] Adding a comment to a translated post won't redirect user to the default language.
* [wpmlcore-2136] Corrected "Slawisch" to "Slowakisch" in German language name for "Slovak"

(Note: Or even this one)

**3.1.5**

* **Improvements**
  * check_settings_integrity() won't run SQL queries on front-end and in the back-end it will run only once and only in specific circumstances
  * We added ability to add language information to duplicated content, when WPML_COMPATIBILITY_TEST_MODE is defined
