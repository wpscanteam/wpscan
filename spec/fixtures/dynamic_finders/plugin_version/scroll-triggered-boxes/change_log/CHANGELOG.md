Changelog
==========

#### 2.2.3 - May 11, 2016

Scroll Triggered Boxes has a new name & home: [Boxzilla](https://wordpress.org/plugins/boxzilla/)!

You can keep on using Scroll Triggered Boxes, but Boxzilla comes with some neat improvements over this older version. Whenever you're ready to make the switch, please read through the [upgrade guide](https://kb.boxzillaplugin.com/updating-from-scroll-triggered-boxes/) for a full list of changes.

#### 2.2.2 - April 11, 2016

**Fixes**

- Fixes notice on settings page when creating a new box.

**Improvements**

- Fallback for box initialization when other script errors.
- Getting ready for new Exit Intent add-on, to be released soon.
- Use event bubbling for `#stb-103` style links, so link elements loaded over AJAX can also open boxes.


#### 2.2.1 - March 2, 2016

**Fixes**

- "Test mode" setting from individual box pages not saving and throwing a warning.


#### 2.2 - March 2, 2016

**Fixes**

- CSS `initial` keyword compatibility fix for Internet Explorer

**Additions**

- Allow glob-style patterns for matching URL's and referer URL's, eg `*.google.com`.
- Allow matching any condition or all conditions to load a box.

**Improvements**

- Boxes can now be marked "unclosable" by filtering the box options (see FAQ).
- When box is "center" positioned, clicking the overlay now uses an error click margin to avoid unintentionally dismissing a box.
- Close icon can now be removed by passing an empty string to the `stb_box_close_icon` filter.
- "Test mode" setting is now shown on individual box settings pages as well, for convenience.
- When editing a box, an empty box rule is now always shown.


####  2.1.4 - November 19, 2015

**Fixes**

- Do not show box instantly if auto-show is disabled. Fixes an issue with [the premium MailChimp add-on](https://scrolltriggeredboxes.com/plugins/mailchimp).

####  2.1.3 - October 19, 2015 

**Fixes**

- (Non-fatal) JS error introduced in version 2.1.2

**Improvements**

- Improved error messages & general textual improvements to admin pages.

####  2.1.2 - October 15, 2015 

**Fixes**

- Sample boxes were no longer being created on plugin installation

**Improvements**

- Added "Box ID" column to boxes overview page so it's easier to find your box ID.

**Additions**

- The box cookie is now set after each form submissions, preventing it from showing up again
- When using [MailChimp for WordPress](https://mc4wp.com), the box will now auto-show again after submitting the page.

####  2.1.1 - August 20, 2015 

**Fixes**

- Activation error on Multisite.

**Additions**

- Added an "instant" option as the box trigger, which shows the box immediately after loading a page.

####  2.1 - July 8, 2015 

**Fixes**

- "If post is" filter with empty value was not working.

**Improvements**

- Added autocomplete search to filter rule values, which autocompletes post, page, category and post type slugs.
- Minor other usability improvements to box filters.

**Additions**

- Added `is_post_in_category` filter rule condition, to target posts that have a certain category.

####  2.0.4 - July 6, 2015 

**Fixes**

- Boxes were not showing if any other resource (images, scripts, etc.) on the page failed to load.

**Improvements**

- Extension thumbnails are now clickable.
- Prevent notice for empty string values in box rules.

**Additions**

- The plugin now creates a sample box upon plugin installation.

####  2.0.3 - July 2, 2015 

**Fixes**

- The cookie for closing a box was always set to expire at the end of the session

####  2.0.2 - May 18, 2015 

**Fixes**

- JavaScript error when loading box editor in HTML mode
- Remove type hint for function that adds metaboxes, as this differs for new (unpublished) boxes

**Improvements**

- Output HTML for boxes at a slightly earlier hook, for better [MailChimp for WordPress](https://mc4wp.com/) compatibility.


####  2.0.1 - May 12, 2015 

**Fixes**

- Fix page level targeting no longer working

####  2.0 - May 12, 2015 

Major revamp of the plugin, maintaining backwards compatibility.

**Important changes**

- The plugin now comes with several [premium add-on plugins which further enhance the functionality of the plugin](https://scrolltriggeredboxes.com/plugins#utm_source#### wp-plugin-repo&utm_medium=scroll-triggered-boxes&utm_campaignchangelog).
- PHP 5.3 or higher is required.
- "Test mode" is now a global setting.
- Various UX improvements.

If you encounter a bug, please [open an issue on GitHub](https://github.com/ibericode/scroll-triggered-boxes/issues).

####  1.4.4 - April 4, 2015 

**Additions**

- Added a PHP version check in preparation for the upcoming [Scroll Triggered Boxes v2.0](https://scrolltriggeredboxes.com/a-new-site/) release.

####  1.4.3 - January 29, 2015 

**Improvements**

- Various performance improvements
- Updated all links to use `https` protocol

####  1.4.2 - December 4, 2014 

**Fixes**

- Box not automatically appearing if cookie time was set, caused by yesterdays update.

####  1.4.1 - December 3, 2014 

**Fixes**

- CSS Height issue breaking SIDR navigation in some themes.

**Improvements**

- If cookie lifetime option is set to 0, existing cookies will be ignored now too.

####  1.4 - November 17, 2014 

**Additions**

- Added option to disable box for smaller screen sizes, defaults to box width.

####  1.3.1 - September 4, 2014 

**Bugfixes**

- Fixed an issue with rules disappearing when having more than 5 posts.

**Improvements**

- Some textual improvements.

####  1.3 - July 30, 2014 

**Improvements**

- Various code improvements
- Minified all assets (scripts and styles)
- You can now contribute to the [Scroll Triggered Boxes plugin on GitHub](https://github.com/ibericode/scroll-triggered-boxes).

**Additions**

- Add "bottom center" and "top center" position options

####  1.2.2 - July 7, 2014 

**Additions**

- Added Spanish translations, thanks to [Paul Benitez of Tecnofilos](http://www.tecnofilos.net/)

**Improvements**

- Now using native JS cookies, greatly reducing the script size.
- Added various debugging statements to the script.

####  1.2.1 - May 21, 2014 

**Additions**

- You can now use JavaScript functions like `STB.show( 42 )` or `STB.hide( 42 )` to show/hide boxes.

**Improvements**

- Box is now more responsive, it will now never stretch beyond the screen width.
- Various minor code improvements.
- Wrapped remaining strings in translation calls.

####  1.2 - April 18, 2014 
* Improved: Plugin is now fully translatable. Fixed various string typo's.