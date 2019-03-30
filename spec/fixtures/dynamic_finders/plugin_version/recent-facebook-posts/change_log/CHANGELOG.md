Changelog
============

#### 2.0.13 - May 30, 2018

- Explicitly define FB Graph API version 
- Update link to website for finding your Facebook page ID.


#### 2.0.12 - October 25, 2017

Misc. textual improvements.


### 2.0.11 - October 24, 2016

**Fixes**

- Fixed "undefined function" errors when using certain cache plugins.


### 2.0.10 - September 15, 2016

**Improvements**

- Added additional CSS class to post container when post has media elements. Thanks [Robbert van Mourik](https://github.com/rvmourik)!
- Accessibility improvements to output.

**Additions**

- Added Norwegian translations, thanks to Joakim O. Saunes.
- Added `rfbp_render_before` and `rfbp_render_after` filters. Thanks [Justin](https://github.com/dannyvankooten/recent-facebook-posts/pull/19)!


### 2.0.9 - July 25, 2016

**Improvements**

- Facebook texts are now localized according to the site's locale.

**Additions**

- Added Hungarian translations, thanks to Daniel Kocsis.
- Added Polish translations, thanks to Sophia Davenport.


#### 2.0.8 - July 1, 2015

**Additions**

- Added Turkish translations, thanks to Halukcan Pehlivanoğlu!

#### 2.0.7 - May 15, 2015

**Fixes**

- Video posts were not showing correctly

**Improvements**

- Added play icon overlay to video's

**Additions**

- Added Italian translations, thanks to [Luigi Savini](https://github.com/gigiame)
- Added Portugese translations, thanks to [Jonadabe](https://github.com/Jonadabe)

#### 2.0.6 - May 15, 2015

**Fixes**

- Hooks were double added when using the widget

**Improvements**

- Added a notice about using the shortcode to the plugin's settings page.

**Additions**

- Added German translations, thanks to [Henrik Heller ](http://www.gmx.net/).

#### 2.0.5 - March 23, 2015

**Additions**

- Added Swedish translations, thanks to [Robin Wellström](http://robinwellstrom.se/).

#### 2.0.4 - February 19, 2015

**Fixes**

- Issue where settings page would just load an empty screen. ([Issue #6](https://github.com/dannyvankooten/wordpress-recent-facebook-posts/issues/6))

**Improvements**

- Updated all links to use HTTPS protocol.

#### 2.0.3 - September 22, 2014

**Improvements**

- Now loading minified asset (.css and .js) files by default
- Added some missing text domains
- Minor improvements to settings page and settings handling.

**Additions**

- Added Spanish language, thanks [Hermann Bravo](http://hbravo.com/)
- Added `rfpb_widget_options` filter to filter all widget options. Closes [#3](https://github.com/dannyvankooten/wordpress-recent-facebook-posts/issues/3), thanks [KilukruMedia](https://github.com/KilukruMedia)
- Added [languages/recent-facebook-posts.pot](http://plugins.svn.wordpress.org/recent-facebook-posts/trunk/languages/recent-facebook-posts.pot) file for easier translating. Please send in your language files (.po and .mo) if you created any.

#### 2.0.2 - September 17, 2014

**Fixes**

- Removed duplicate `picture` in call to Facebook API. Fixes a "Syntax error" in later API versions. Props [danielfharmonic](https://github.com/danielfharmonic).

#### 2.0.1 - September 15, 2014

**Improvements**

- The plugin will now show a detailed error message if anything related to the connection to Facebook failed.
- Updated Dutch translation

#### 2.0 - September 15, 2014

**Fixes**

- Fixed an issue with Facebook statuses containing Emojis

**Improvements**

- Better sanitizing throughout the plugin, using native WP functions.
- Improved inline code documentation
- Prevent direct file access
- Changing thumbnail sizes does not require a cache refresh to fetch new video images

**Additions**

- New FB configurations are now automatically tested.

#### 1.8.5 - December 3, 2013
* Fixed: Character encoding for scandinavian languages etc.

#### 1.8.4 - December 2, 2013
* Fixed: Empty events won't show
* Improved: a cache renewal is no longer required after changing the image size
* Improved: after changing important settings, cache will automatically be cleared
* Improved: added a *test configuration* button which performs a simple ping to Facebook.
* Improved: added an info message for new users
* Improved: filters are now added the "WordPress way", which means they can be disabled
* Improved: namespaced the trigger for renewing the cache
* Improved: added empty `index.php` files to prevent directory listings
* Improved: code clean-up

#### 1.8.3 - November 17, 2013
* Fixed: removed weird character between comment count and timestamp

#### 1.8.2 - November 17, 2013
* Fixed: some translated strings in settings pages were not printed.
* Improved: plugin file can no longer be access directly
* Improved: better plugin code loading
* Improved: disabled plugin directory listing
* Added: domain path
* Added: license file
* Updated Dutch translations

#### 1.8.1 - November 4, 2013
* Fixed: link previews without images not showing
* Added: filter `rfbp_show_link_images` to hide link preview images
* Improved: Link preview CSS

#### 1.8 - November 3, 2013
* Added: previews of attached links, with image and short description (like Facebook)
* Added: Translation files
* Added: Dutch translations
* Improved: Moved cache time to a filter.
* Improved: Removed `session_start()` call.

#### 1.7.3 - October 28, 2013
* Added: `rfbp_read_more` filter.
* Added: `rfbp_content` filter.
* Added: option to unhook `wpautop` from `rfbp_content` filter.

#### 1.7.2 - October 18, 2013
* Fixed: No posts showing up for Scandinavian languages
* Improved: Links will no longer show up twice
* Added: Conversion of common smileys

#### 1.7.1 - October 17, 2013
* Fixed: fetching posts from wrong Facebook page. Sorry for the quick version push.
* Improved: default CSS

#### 1.7 - October 16, 2013
* Fixed issue where strings with dots where turned into (broken) links.
* Improved: better linebreaks
* Improved: Now using WP Transients for caching
* Improved: Now using WP HTTP API for fetching posts, which allows for other transfer methods besides just cURL.
* Improved: No user access token is required any more. Access tokens will now *never* expire.

#### 1.6 - October 7, 2013
* Improved code performance and readability
* Improved usability of admin settings
* Improved: cleaner HTML output
* Improved: default CSS
* Improved: image resizing
* Improved: default settings
* Added installation instructions link to admin settings
* Added many CSS classes to output
* Fixed extra double quote breaking link validation

**Important:** CSS Selectors and HTML output has changed in this version. If you're using custom styling rules you'll have to edit them after updating.

#### 1.5.3 - October 3, 2013
* Improved: Code improvement
* Improved: UI improvement, implemented some HTML5 fields
* Improved: Moved options page back to sub-item of Settings.

#### 1.5.2 - October 1, 2013
* Fixed: max-width in older browsers

#### 1.5.1 - September 20, 2013
* Improved: a lot of refactoring, code clean-up, etc.
* Improved: "open link in new window" option now applies to ALL generated links

#### 1.5
* Improved: huge performance improvement for retrieving posts from Facebook
* Improved: some code refactoring
* Improved: cache now automatically invalidated when updating settings
* Improved: settings are now sanitized before saving
* Fixed: like and comment count no longer capped at 25
* Changed links to show your appreciation for the plugin.

#### 1.4
* Changed cache folder to the WP Content folder (outside of the plugin to prevent cache problems after updating the plugin).
* Added redirection fallbacks when headers have already been sent when trying to connect to Facebook.
* Fixed error message when cURL is not enabled.
* Improved some messages and field labels so things are more clear.
* Updated Facebook API class.

#### 1.3
* Added Facebook icon to WP Admin menu item
* Changed the connecting to Facebook process
* Improved error messages
* Improved code, code clean-up
* Improved usability in admin area by showing notifications, removing unnecessary options, etc.
* Added notice when access token expires (starting 14 days in advance)
* Fixed: Cannot redeclare Facebook class.
* Fixed: Images not being shown when using "normal" as image source size
* Fixed: empty status updates (friends approved)

#### 1.2.3
* Changed the way thumbnail and normal image links are generated, now works with shared photos as well.
* Added read_stream permission, please update your access token.
* Added cache succesfully updated notice

#### 1.2.2
* Added option to hide images
* Added option to load either thumbnail or normal size images from Facebook's CDN
* Added border to image links

#### 1.2.1
* Fixed parameter app_id is required notice before being able to enter it.

#### 1.2
* Fixed: Reverted back to 'posts' instead of 'feed', to exclude posts from others.
* Fixed: undefined index 'count' when renewing cache file
* Fixed: wrong comment or like count for some posts
* Improved: calculation of cache file modification time to prevent unnecessary cache renewal
* Improved: error message when cURL is not enabled
* Improved: access token and cache configuration options are now only available when connected

#### 1.1.2
* Fixed: Added spaces after the like and comment counts in the shortcode output

#### 1.1.1
* Updated: Expanded installation instructions.
* Changed: Some code improvements
* Added: Link to Facebook numeric ID helper website.
* Added: Check if cache directory exists. If not the plugin will now automatically try to create it with the right permissions.
* Added: option to open link to Facebook Page in a new window.

#### 1.1
* Added: Shortcode to show a list of recent facebook updates in your posts: '[recent_facebook_posts]'

#### 1.0.5
* Added: More user-friendly error message when cURL is not enabled on your server.

#### 1.0.4
* Improved: The way the excerpt is created, words (or links) won't be cut off now
* Fixed: FB API Error for unknown fields.
* Added: Images from FB will now be shown too. Drop me a line if you think this should be optional.

#### 1.0.3
* Improved the way the link to the actual status update is created (thanks Nepumuk84).
* Improved: upped the limit of the call to Facebooks servers.

#### 1.0.2
* Fixed a PHP notice in the backend area when renewing cache and fetching shared status updates.
* Added option to show link to Facebook page, with customizable text.

#### 1.0.1
* Added error messages for easier debugging.

#### 1.0
* Added option to load some default CSS
* Added option to show like count
* Added option to show comment count
* Improved usability. Configuring Recent Facebook Posts should be much easier now due to testing options.

#### 0.1
* Initial release
