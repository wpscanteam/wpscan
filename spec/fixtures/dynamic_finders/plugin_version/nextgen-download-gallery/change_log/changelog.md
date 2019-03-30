# NextGEN Download Gallery

## Changelog

### 1.6.0, 2018-11-24

* changed: requires minimum PHP version 5.6 (recommend version 7.2 or greater)
* added: setting for enabling Select All button, on by default
* tested: WordPress 5.0

### 1.5.4, 2018-05-08

* fixed: downloads fail in Google Chrome on iOS (iPhone / iPad)
* changed: added the gallery name as the third parameter of the `ngg_dlgallery_image_path` filter hook

### 1.5.3, 2016-11-19

* fixed: if can't open the zip file, don't attempt to send it (fixes errors logged for `feof()`)
* fixed: deprecated warning on non-static method call in PHP 7
* added: Polish translation (thanks, Jakub Molek!)

### 1.5.2, 2015-08-30

* fixed: Download All button intermittent failures since NextGEN Gallery 2.1.7

### 1.5.1, 2015-08-13

* fixed: Download All button missing since NextGEN Gallery 2.1.7

### 1.5.0, 2015-06-13

* fixed: NextGEN Gallery no longer permits typing in download gallery template name; add our templates to list
* added: action hooks `ngg_dlgallery_zip_before_send` and `ngg_dlgallery_zip_after_send`
* changed: Download All handled via POST, not GET; more robust

### 1.4.4, 2014-10-27

* fixed: suppress errors on `set_time_limit()` to avoid download problems when that function has been disabled
* added: Czech translation (thanks, [Rudolf Klusal](http://www.klusik.cz/)!)

### 1.4.3, 2014-10-21

* fixed: Danish translation (thanks, [Ligefrem](http://www.ligefrem.dk/)!)

### 1.4.2, 2014-09-18

* fixed: French translation (thanks, Nicolas Sizun!)
* fixed: Portuguese for "select all" has wrong gender (thanks, [Juliano Arantes](http://www.42fotografia.com.br/)!)

### 1.4.1, 2014-06-25

* fixed: reverted to using admin-ajax.php for handling the ZIP request; admin-post.php was redirecting to the home page for non-admin users on at least one website (why? anybody know, please [tell me in the support forum](https://wordpress.org/support/topic/only-administrator-can-download)).

### 1.4.0, 2014-06-22

* fixed: zip file was getting name ".zip" when no gallery name set
* fixed: Dutch translation (thanks, [Ivan Beemster](http://www.lijndiensten.com/)!)
* fixed: Georgian translation (from Google Translate) renamed ka_GE so it might work now :)
* fixed: download gallery title is "tagged: {taglist}" when using shortcode `nggtags_ext` or `ngg_images` in NextGEN Gallery 2.0.x now too!
* added: support for downloading everything from a gallery all at once
* added: stylesheet to force HR to behave nicely in common themes ("Finally!" so say we all)
* added: filter `ngg_dlgallery_zip_pre_add` so that plugins/themes can supply a callback function name for PclZip `PCLZIP_CB_PRE_ADD` argument
* changed: select all button now toggles between selected and unselected
* changed: JavaScript now loaded as external script, not part of gallery template
* changed: process download action through admin-post.php, no need for AJAX logic (still supported for legacy customised templates)
* changed: [translations now updated online](https://translate.wordpress.org/projects/wp-plugins/nextgen-download-gallery), so .po files removed from plugin

### 1.3.1, 2013-08-25

* fixed: undeclared variable warning when number of columns set in Gallery settings
* fixed: download failures on some websites caused by theme or other plugins using output buffering early
* fixed: download failures on some websites when using readfile(), now use read/write/flush loop

### 1.3.0, 2013-08-16

* fixed: `nggtags_ext` works in NextGEN Gallery 2.0.7+
* changed: script timeout set to 300 seconds during download build, maybe this will help with large zip files on slow servers

### 1.2.3, 2013-07-05

* added: filter `ngg_dlgallery_image_path` for altering image path (e.g. to pick up a higher resolution version)
* added: filter `ngg_dlgallery_zip_filename` for altering name of ZIP download file

### 1.2.2, 2013-06-23

* added: shortcode `nggtags_ext` supports images attribute, for number of images to display per page
* changed: translation updates using Google Translate, which is to say: badly! Please help by [registering to translate into your preferred language](https://translate.wordpress.org/projects/wp-plugins/nextgen-download-gallery).

### 1.2.1, 2013-03-23

* fixed: download gallery title is "tagged: {taglist}" when using shortcode `nggtags_ext`; was using gallery title from first image (NextGEN Gallery bug)
* added: filter 'ngg_dlgallery_tags_gallery_title' for changing gallery title when using shortcode `nggtags_ext`

### 1.2.0, 2013-03-23

* fixed: template was HTML-encoding the gallery title & description when they are already HTML-encoded
* added: shortcode `nggtags_ext` to extend `nggtags` so that you can specify a gallery template

### 1.1.1, 2012-12-07

* fixed: submit list of images to download via POST, to prevent list length errors and truncation

### 1.1.0, 2012-10-14

* added: "select all" button on download gallery template (only visible if JavaScript enabled)
* changed: no longer require Zip extension, uses WordPress-supplied PclZip class

### 1.0.2, 2012-08-22

* fixed: sanitise the Zip filename, removing spaces and special characters, so that downloaded files are received correctly on Firefox and others

### 1.0.1, 2012-07-26

* fixed: provide ZipArchive error message when zip create fails
* fixed: use WordPress function `get_temp_dir()` to get temporary file directory, which can be specified by setting `WP_TEMP_DIR` in wp-config.php if required (thanks, WP-Spezialist)

### 1.0.0, 2012-07-06

* initial public release

### 0.0.1, 2012-06-14

* private release
