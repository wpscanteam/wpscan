# Changelog

= 2.3.8 - October 25, 2017 = 

Misc. textual improvements.

= 2.3.7 - August 29, 2017 =

Added German language file, thanks to [Christian Gunther](http://atelier.tag-eins.de/).

= 2.3.6 - September 29, 2016 =

Maintenance release. Mainly just removed some dead links from meta & getting rid of "not updated" notice. Happy widget blocking!

= 2.3.5 - March 18, 2015 =

**Fixes**

- Video URL's on their own line will now autoembed

**Improvements**

- Code styling now adheres to WordPress coding standard

= 2.3.4 - December 20, 2013 =
* Fixed: Paragraphs inside or after shortcodes
* Improved: Changed widget name for more consistency

= 2.3.3 - November 18, 2013 =
* Added: Italian translations, thanks to [Tiziano D'Angelo](http://www.dangelos.it/)
* Improved: Code loading
* Improved: added empty index.php files to prevent directory listings
* Improved: all default WordPress' post filters are now applied to the widget content as well. 

= 2.3.2 - November 8, 2013 =
* Improved: When `show_title` is false, (empty) title tags will not be displayed.

= 2.3.1 - November 6, 2013 =
* Added: Spanish translations, thanks to [Maria Ramos from WebHostingHub](http://www.webhostinghub.com/)
* Improved: Minor security and license improvements

= 2.3 - November 5, 2013 =
* Improved: Title now changes with the Widget Block, no widget re-save necessary
* Improved: Minor code improvements
* Improved: Removed all third-party meta boxes from Edit Widget Block screen.
* Improved: Plugin is now translation ready
* Added: Dutch translation

= 2.2.6 - October 30, 2013 =
* Fixed: Show title checkbox now defaults to a checked state.

= 2.2.5 - October 26, 2013 =
* Added checkbox option to widget to hide the title.

= 2.2.4 - October 21, 2013 =
* Moved menu item back to its own menu item
* Widget title now defaults to the title of the selected Widget Block
* Some textual improvements

= 2.2.3 - October 16, 2013 =
* Moved menu item to pages to prevent capability problems
* Removed WP SEO meta box from edit widget block screen

= 2.2.2 =
* Improved: UI improvements, cleaned up admin area.
* Improved: Minor code improvement

= 2.2.1 =
* Improved: small code improvements
* Improved: changed menu position 

= 2.2 =
* Fixed: shortcodes were not processed in v2.1.

= 2.1 =
* Fixed: Social sharing buttons showing up after widget content.

= 2.0.1 =
* Added: meta box in WYSIWYG Widget editor screen.
* Added: debug messages for logged in administrators on frontend when no WYSIWYG Widget OR an invalid WYSIWYG Widget is selected.
* Added: title is now optional for even more control. If empty, it won't be shown. You are now no longer required to use the heading tag which is set in the widget options since you can use a (any) heading in your post.

= 2.0 =
* Total rewrite WITHOUT backwards compatibility. Please back-up your existing WYSIWYG Widgets' content before updating, you'll need to recreate them. Don't drag them to "deactivated widgets", just copy & paste the HTML content somewhere.

= 1.2 =
* Updated the plugin for WP 3.3. Broke backwards compatibility (on purpose), so when running WP 3.2.x and below: stick with [version 1.1.1](https://downloads.wordpress.org/plugin/wysiwyg-widgets.zip).

= 1.1.2 =
* Temporary fix for WP 3.3+

= 1.1.1 =
* Fixed problem with link dialog reloading page upon submit

= 1.1 =
* Changed the way WYSIWYG Widget works, no more overlay, just a WYSIWYG editor in your widget form.
* Fixed full-screen mode
* Fixed link dialog for WP versions below 3.2
* Fixed strange browser compatibility bug
* Fixed inconstistent working
* Added the ability to use shortcodes in WYSIWYG Widget's text

= 1.0.7 =
* Fixed small bug that broke the WP link dialog for WP versions older then 3.2
* Fixed issue with lists and weird non-breaking spaces
* Added compatibility with Dean's FCKEditor for Wordpress plugin
* Improved JS

**NOTE**: In this version some things were changed regarding the auto-paragraphing. This is now being handled by TinyMCE instead of WordPress, so when updating please run trough your widgets to correct this. :) 

= 1.0.6 =
* Added backwards compatibility for WP installs below version 3.2 Sorry for the quick push!

= 1.0.5 =
* Fixed issue for WP3.2 installs, wp_tiny_mce_preload_dialogs is no valid callback. Function got renamed.

= 1.0.4 =
* Cleaned up code
* Improved loading of TinyMCE
* Fixed issue with RTL installs

= 1.0.3 =
* Bugfix: Hided the #wp-link block, was appearing in footer on widgets.php page.
* Improvement: Removed buttons added by external plugins, most likely causing issues. (eg Jetpack)
* Improvement: Increase textarea size after opening WYSIWYG overlay.
* Improvement: Use 'escape' key to close WYSIWYG editor overlay without saving changes.

= 1.0.2 =
* Bugfix: Fixed undefined index in dvk-plugin-admin.php
* Bugfix: Removed `esc_textarea` which caused TinyMCE to break
* Improvement: Minor CSS and JS improvements, 'Send to widget' button is now always visible
* Improvement: Added a widget description
* Improvement: Now using the correct way to set widget form width and height

= 1.0.1 =
* Bugfix: Fixed the default title, it's now an empty string. ('')

= 1.0 = 
* Initial release
