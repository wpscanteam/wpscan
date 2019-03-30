## 1.3.0
While primarily a maintenance release, one new feature has been added. WP Featherlight now supports Gutenberg galleries.

Here's a full list of what's changed since the last release:

- Feature: Gutenberg support
- Tweak: General code cleanup in plugin
- Dev: Updated [Featherlight](https://github.com/noelboss/featherlight/) to `1.7.13`
- Change of ownership

## 1.2.0
This is primarily a maintenance release, but one new feature has been added. HTML in captions is now supported!

Here's a full list of what's changed since the last release:

- Feature: Allowed HTML to be displayed in lightbox image captions
- Dev: Updated [Featherlight](https://github.com/noelboss/featherlight/) to `1.7.9`
- Dev: Updated [jQuery Detect Swipe](http://github.com/marcandre/detect_swipe) to `2.1.4`

## 1.1.0
Thanks to some changes implemented in the core featherlight script, the accessibility of WP Featherlight is now significantly improved. Lightboxed elements now have more appropriate focus management for screen readers and the close button is more accessible.

This update also fixes a potential plugin compatibly problem in the WordPress admin. In version 1.0, it was possible under unusual circumstances for the plugin to throw a fatal error when attempting to add the disable checkbox to the publish metabox.

- Tweak: Improved accessibility (accessible close button, better focus management)
- Fix: Prevented a fatal error that could happen when another plugin unsets the WP_Post object on the publish metabox.
- Dev: Updated [Featherlight](https://github.com/noelboss/featherlight/) to `1.7.0`

## 1.0.0
Even though this is a major version change, this is primarily a maintenance release. The reason for the jump to 1.0.0 is because we've changed some code which could break backwards compatibility with custom extensions and integrations.

If you're just using the plugin on your site and haven't customized it or paid anyone to customize it for you, you should be able to update without any issues.

If you're a developer and have written custom code extending the PHP side of WP Featherlight, be sure to test your code before updating.

Under the hood, we've [deprecated some internal methods](https://github.com/cipherdevgroup/wp-featherlight/search?utf8=%E2%9C%93&q=_deprecated_function) which could potentially break custom code which extends WP Featherlight. The changes are primarily limited to class initialization, so unless you were doing something specific to that, it's unlikely that you'll run into issues.

- Tweak: Improved transition between images within galleries
- Tweak: Moved our disable lightbox checkbox into the publish meta box to streamline the admin
- Tweak: Made styles more aggressive to ensure elements look consistent across different themes by default
- Fix: Reduced false positives for URLs that use image extensions but don't actually link to an image
- Dev: Updated [Featherlight](https://github.com/noelboss/featherlight/) to `1.5.1`
- Dev: Updated [jQuery Detect Swipe](http://github.com/marcandre/detect_swipe) to `2.1.3`
- Dev: Deprecated some internal methods
- Dev: Reorganized how classes are instantiated and plugin actions are fired

## 0.3.0

There are quite a few internal changes in the plugin for this release, plus some nice new features and improvements on the front-end. We've streamlined everything as much as possible and also added support for some languages other than English! Here's a breakdown of everything that's changed:

### New Features
- Automatic captioning for WordPress images and gallery items (Including Jetpack Galleries)
- Spanish language translation

### Enhancements
- Updated [Featherlight](https://github.com/noelboss/featherlight/) to `1.3.3`
- Improved gallery styles on desktop and mobile devices
- Streamlined overall styles
- Added SVG icons for more visual consistency across various platforms
- Simplified the text used in the admin metabox to ease translations (props @toscho)

### Bug Fixes
- Improved handling of images when certain caching plugins are enabled
- Prevented gallery arrows from being hijacked by WP Emoji
- Fixed a bug which allowed multiple light boxes to be opened using keyboard commands

### Developer Stuff
- Reduced overhead by loading language files only when needed (props @toscho)
- Improved the save routine for our admin metabox (props @toscho)
- Added a `wp_featherlight_captions` filter to control auto-captioning. Filter it to false to disable captions.
- Re-structured the plugin's internal code base and deprecated plugin constants
- Added Grunt and Bower the plugin to allow easier updates and releases in the future

### Added Language Support
- German
- Spanish
- French
- Portuguese (Brazil)
- Spanish (Peru)

## 0.2.0

The primary feature in this release is the addition of a visual loader and the automatic lightboxing of external images. In prior versions, only images from the WordPress host domain were lightboxed automatically. This caused some problems with people using a CDN as the URLs were treated as external.

There have also been a handful of code improvements under the hood including:

- Added gallery support for Jetpack Tiled Galleries
- Improved URL handling to match more image instances automatically
- Fixed a mistake in the textdomain path
- Improved admin metabox markup (props @GaryJones)
- Fixed a typo in the main stylesheet's script handle (props @GaryJones)

## 0.1.1

Fixed a bug that caused all WordPress galleries to open in a light box. Now only galleries which have been set to link to the media attachment are opened using Featherlight.

## 0.1.0

Initial release!
