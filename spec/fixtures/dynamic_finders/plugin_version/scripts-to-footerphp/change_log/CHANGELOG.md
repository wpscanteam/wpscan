### Changelog

##### 0.6.3 - 9-12-18
Moved the 'set_header_scripts' function into a 'wp_head' add_action to allow for conditional checks to work within the 'stf_exclude_scripts' filter. 

##### 0.6.2
Added support for disabling plugin on 404 pages, thanks to Alex (@piscis on GitHub)

##### 0.6.1
Updates custom taxonomy check for custom taxonomy archives and some error logging functions. 

##### 0.6.0
- Add settings page with global disable options for home page, search pages, post type archives, taxonomy archives, and other archives.
- Update uninstall.php to remove things correctly.
- Add FAQ to readme.txt and readme.md.
- Add this changelog as a separate file.
- Change the custom post type filter. Refer to updated [FAQ](https://github.com/joshuadavidnelson/scripts-to-footer/#faq) and [documentation](https://github.com/joshuadavidnelson/scripts-to-footer/wiki).
- Add support for custom taxonomy archives.
- Change the exclude filter, to be more relevant to the new options. Older filter is depreciated, but still supported (for now).
- Update the post meta for disabling the plugin on specific posts/pages.
- Add Github Updater support.
- Removed CMB and built metaboxes the old fashion way.
- Added debug logging to better track any potential errors moving forward.

##### 0.5
Reverted metabox version to previous - invalid error was sneaking through.

##### 0.4
Added filter to exclude pages, updated metabox version, plugin version bump and updated readme.txt file.

##### 0.3
Added conditional to disable on plugin on admin dashboard, version bump. 
 	
##### 0.2
Updating code to be object-oriented and added page metabox to disable plugin on specific pages.

##### 0.1
Initial release
