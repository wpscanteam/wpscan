# Changelog #

## 2.3.3: 2016-12-17 ##
* Fix frontend ajax requests. ([*](https://wordpress.org/support/topic/video-overlay-does-not-work/))

## 2.3.1 & 2.3.2: 2016-12-16 ##
* Fix for *illegal video* message when using oEmbed. ([*](https://wordpress.org/support/topic/illegal-warning-displays-on-youtube-videos-2/), [*](https://wordpress.org/support/topic/illegal-warning-displays-on-youtube-videos/))
* Fix for *are you sure* error on post creation. ([*](https://wordpress.org/support/topic/latest-update-causing-error/), [*](https://wordpress.org/support/topic/error-are-you-sure-you-want-to-do-this-3/))

## 2.3.0: 2016-12-15 ##
* Now compatible with [Video SEO](https://yoast.com/wordpress/plugins/video-seo/)! ([*](https://wordpress.org/support/topic/compatibility-with-video-seo), [*](https://wordpress.org/support/topic/video-seo-featured-video-plus-compatability), [*](https://wordpress.org/support/topic/fantastic-a-must-have-for-all-video-sites))
* Fix AJAX vulnerability reported by [@jamesgol](https://github.com/jamesgol).
* **Disallow raw embeds (`iframe`, `object`, `embed`) by default for new videos -- can be enabled in the settings.** Could have been misused if somebody had gained access to an editor account beforehand. Reported by [@jamesgol](https://github.com/jamesgol).
* "Single" now actually means single posts **and** pages. ([*](https://wordpress.org/support/topic/is_singular), [*](https://github.com/ahoereth/featured-video-plus/issues/7))
* Fix some problem with fixed size specifications. ([*](https://wordpress.org/support/topic/modifying-size-has-no-effect), [*](https://wordpress.org/support/topic/not-able-to-change-size-of-video), [*](https://wordpress.org/support/topic/width-function-on-featured-video-plus-width560-is-not-working), [*](https://wordpress.org/support/topic/the_post_video-is-the-wrong-size))

## 2.2.3: 2016-07-19 ##
* Fix for bad iframe src attributes. ([*](https://wordpress.org/support/topic/fix-for-wordpress-442-for-youtube-video-error))
* Fix a problem with image type detection. ([*](https://wordpress.org/support/topic/warning-and-no-featured-image-generated?replies=3), [*](https://wordpress.org/support/topic/plugin-is-not-supporting-by-wordpress-44))

## 2.2.2: 2015-09-15 ##
* Fix for not correctly hidden preload images. ([*](https://wordpress.org/support/topic/your-aplication-is-not-working-right-on-wordpress-43–es_es), [*](https://wordpress.org/support/topic/play-and-load-images-appended-to-body-since-update-to-221), [*](https://wordpress.org/support/topic/big-black-play-triangle-under-video))
* Replace features videos more reliably on AJAX requests. ([*](https://wordpress.org/support/topic/video-embedding-issue-when-using-infinite-scroll))

## 2.2.1: 2015-09-08 ##
* Now compatible with infinite scroll! ([*](https://wordpress.org/support/topic/vimeo-thrumbnails-not-work), [*](https://wordpress.org/support/topic/video-embedding-issue-when-using-infinite-scroll), [*](https://wordpress.org/support/topic/featured-video-plus-jetpack-infinite-scroll-video-width-problem))
* Fix bad overlay sizing when loading from cache. ([*](https://wordpress.org/support/topic/video-shrinking-on-2nd-play))
* Fix local video responsiveness in recent WordPress videos.
* The `has_post_video` function is now pluggable.
* The `get_the_post_video_url` function post id argument is now optional ([*](https://wordpress.org/support/topic/video-url)).

## 2.2.0: 2015-07-20 ##
* Shortcodes can now be used as featured content (e.g. `[gallery]`).
* Added fine tuned autoplay options.
* New option for hiding YouTube video annotations. ([*](https://wordpress.org/support/topic/add-feature-to-hide-youtube-screen-annotation))
* Expose a JS function to manually re-initialize the plugin's JS behavior like responsive sizing and overlays. Specifically interesting when using FVP in combination with a infinite scroll plugin. ([*](https://wordpress.org/support/topic/open-video-overlay-when-featured-image-is-clicked-in-loop))
* Fetch high quality thumbnails for YouTube and Dailymotion. ([*](https://wordpress.org/support/topic/featured-image-size-42))
* Fix bug which suppressed the removal of foreign featured images. ([*](https://wordpress.org/support/topic/cannot-remove-featured-image-if-a-featured-video-is-set))
* Fix 'undefined function exif_imagetype' error. ([*](https://wordpress.org/support/topic/cant-add-featured-video-1), [*](https://wordpress.org/support/topic/infinite-spinning-wheel-all-previous-videos-not-working-anymore), [*](https://wordpress.org/support/topic/error-message-444))
* Implement a workaround for a bug with iframes in Google Chrome, see [[0](https://code.google.com/p/chromium/issues/detail?id=395533)], [[1](https://code.google.com/p/chromium/issues/detail?id=395791)]. ([*](https://wordpress.org/support/topic/found-a-huge-critical-bug-videos-vanish-after-using-back))
* Fix bug which resulted in a invisible video playing in the background when using autoplay and overlay mode. ([*](https://wordpress.org/support/topic/video-overlay-with-autoplay-causes-two-videos-to-play))

## 2.1.2: 2015-06-16 ##
* Fix bug which resulted in missing featured images when a post did not have a featured video. ([*](https://wordpress.org/support/topic/cookie-send-to-you-and-video-yes-image-no), [*](https://wordpress.org/support/topic/version-221-featured-image-not-diplayed))

## 2.1.1: 2015-06-15 ##
* Fix play and loading featured image overlay for some themes. ([*](https://wordpress.org/support/topic/play-icon-missing))
* Fix broken `remove featured image` link. ([*](https://wordpress.org/support/topic/cant-remove-featured-image-2),  [*](https://wordpress.org/support/topic/version-210-conflict-with-wp-featured-image), [*](https://wordpress.org/support/topic/fvp-not-working-after-210-update))

## 2.1.0: 2015-06-11 ##
* Display options are now chained using OR - if one of them holds, the replace mode is used.
* Added `always use replace mode when viewing single posts and pages` option, was implicitly true since 2.0.0. ([*](https://wordpress.org/support/topic/featured-video-overrides-featured-image))
* Fixed undefined warnings when using `WP_DEBUG`. ([*](https://wordpress.org/support/topic/debug-error-16))
* Fixed double-wrapped .post-thumbnails. ([*](https://wordpress.org/support/topic/video-no-longer-appearing))
* Lazy loading a video no longer breaks other videos. ([*](https://wordpress.org/support/topic/blank-screen-after-the-video-is-played))

## 2.0.3: 2015-06-01 ##
* Remove usage of PHP short array syntax in order to support PHP versions lower than 5.4 ([*](https://wordpress.org/support/topic/bug-on-version-201))

## 2.0.2: 2015-06-01 ##
* Fixed undefined warnings when saving posts with fresh featured videos.

## 2.0.0 & 2.0.1: 2015-06-01 ##
* __Requires WordPress 3.7 or higher now!__ This reflects versions of WordPress which are "officially" [supported](https://codex.wordpress.org/Supported_Versions). The plugin will from now on try to stick to supporting all versions listed there.
* Major code refactor which results in many bugs scrubbed.
* Support for raw embed codes and [all WordPress core media providers](https://codex.wordpress.org/Embeds#Okay.2C_So_What_Sites_Can_I_Embed_From.3F).
* Updated wp.org icon and cover.


## 1.9.1: 2014-09-06 ##
* __Last update compatible all the way back to WordPress 3.2!__
* You can now specify the '[end](https://developers.google.com/youtube/player_parameters#end)' parameter for YouTube embeds ([*](http://wordpress.org/support/topic/how-to-specify-start-and-end-for-youtube-videos))
* Added option for only displaying videos on single posts/pages ([*](http://wordpress.org/support/topic/i-need-to-only-change-the-featured-images-not-the-thumbnails),[*](http://wordpress.org/support/topic/video-thumbnails-with-link-to-post),[*](http://wordpress.org/support/topic/want-everything-of-fvp-other-than-feature-video-thumb))
* Removed hardcoded http protocol for embeds [*](http://wordpress.org/support/topic/fix-for-videos-over-ssl)

## 1.9: 2014-01-02 ##
* Replaced Video.js with MediaElement.js (ships with WordPress since 3.6 - __breaks local videos partially if you use an older WordPress version!__)
* Added Spanish translations! Translation by [WebHostingHub.com](http://webhostinghub.com)
* Updated FitVids.js to 1.0.3

## 1.8: 2013-05-16 ##
* Video.js [4.0](http://blog.videojs.com/post/50021214078/video-js-4-0-now-available)
* Customize the local video player
* Better autoplay handling
* Remove anchors wrapping videos
* General bug fixes

## 1.7.1: 2013-04-30 ##
* Fixed manual usage option ([*](http://wordpress.org/support/topic/lightbox-video-on-featured-image-click))
* Added featured image mouse over effect for featured video AJAX usage

## 1.7: 2013-04-30 ##
* Added functionality to display featured video in an lightbox using AJAX on featured image click ([*](http://www.web2feel.com/garvan/))
* Added functionality to replace featured image with featured video on demand when image is clicked using AJAX ([*](http://wordpress.org/support/topic/lightbox-video-on-featured-image-click))
* `get_the_post_video_url` has a new second parameter (boolean) to get the fallback video's URL ([*](http://wordpress.org/support/topic/fallback-video-url))
* Tested with WordPress 3.6

## 1.6.1: 2013-04-18 ##
* Fixed removing featured image when no featured video is specified ([*](http://wordpress.org/support/topic/featured-image-doesnt-save))

## 1.6: 2013-04-16 ##
* Added `get_the_post_video_url($post_id)` PHP-Function
* Added YouTube `enablejsapi` parameter with `playerapiid` (`fvpid + $post_id`) and iframe id ([*](http://wordpress.org/support/topic/need-filter-for-iframe-and-embed-code-manipulation))
* Added a filter for `get_the_post_video`: `get_the_post_video_filter` ([*](http://wordpress.org/support/topic/need-filter-for-iframe-and-embed-code-manipulation))
* Added option for using the featured image as video thumbnail for local videos
* Fixed local videoJS ([*](http://wordpress.org/support/topic/how-to-style-the-player-play-button-pause-button-etc))
* Fixed auto width and height for the Dailymotion and videoJS players
* Fixed YouTube videos for which the plugin cannot access the YouTube API ([*](http://wordpress.org/support/topic/link-appearing-red-in-featured-video-section))

## 1.5.1: 2013-03-27 ##
* Fixed Featured Video box on new-post.php
* Enhanced Featured Image ajax behavior

## 1.5: 2013-03-22 ##
* __AJAXified__ the Featured Video box - just like Featured Images
* Added options for a) disabling VideoJS JS/CSS, b) enabling VideoJS CDN and c) YouTube `wmode`
* Plugin no longer breaks WP image editor ([*](http://wordpress.org/support/topic/breaks-image-scaling-shows-nan))

## 1.4: 2013-03-15 ##
* __WP 3.5 Media Manager__ seamless integrated
* Time-links now available for YouTube and Dailymotion (append #t=1m2s)
* New `autoplay` setting
* Specify your Dailymotion Syndication Key
* Added `get_the_post_video_image` & `get_the_post_video_image_url`
* Local videos no longer break when domain changes or attachment is edited
* Better Featured Image handling

## 1.3: 2013-01-16 ##
* __Internationalization__: Added German translations
* Added customizations for YouTube and Dailymotion
* Revamped video sizing
* Better error handling
* Contextual help on media settings and post edit screen
* LiveLeak (very experimental, they have no API)

## 1.2: 2013-01-09 ##
* __Local Videos__: mp4, webm, ogg
* More dynamic user interface
* Minimized JS and CSS

## 1.1: 2012-12-16 ##
* __Dailymotion__
* Fixed YouTube time-links
* Enhanced interaction of Featured Videos & Featured Images

## 1.0: 2012-12-13 ##
* Release
