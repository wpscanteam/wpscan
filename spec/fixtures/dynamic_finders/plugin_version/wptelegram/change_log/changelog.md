# Changelog
All notable changes to this project are documented in this file.

## [2.1.1 - 2019-03-27](https://github.com/manzoorwanijk/wptelegram/releases/tag/v2.1.1)

### Bug fixes
* Fixed the step in delay on post edit page

## [2.1.0 - 2019-03-26](https://github.com/manzoorwanijk/wptelegram/releases/tag/v2.1.0)
### Enhancements
* Improved the template conditional logic
* Made delay to be more granular - can be set in half a minute steps
* Added option to allow newlines in `{post_excerpt`
* Added option to send `{categories}` as hashtags

### Bug fixes
* Fixed the issue with scheduled posts not being sent to Telegram

## 2.0.19
* Added the conditional logic for Message Template

## 2.0.16
* Fixed the HTML bug in Notifications

## 2.0.15
* Fixed the PHP fatal error

## 2.0.14
* Fixed the PHP fatal error

## 2.0.13
* Added fixes for WP 5+
* Fixed double posting by block editor
* Fixed the issue with Override Options not expanding in Block Editor
* Improved the logging to include logs about featured image
* Removed the override metabox from the post types not chosen to be sent
* Added tutorial videos in the sidebar
* Updated CMB2

## 2.0.12
* Fixed the Notification issue caused by some faulty plugins
* Fixed the issue with Post to Telegram caused by Cron Control
* JS fixes

## 2.0.11
* Fixed the bug when scheduling the posts

## 2.0.10
* Delayed loading of modules to fix the translation issues
* Fixed the HTML entity issue for Markdown
* re-enabled sending password protected posts
* Added support for saving override options for Pending posts
* Minor fixes

## 2.0.9
* Fixed Send to Telegram button for Drafts
* Added support for saving override options for drafts and future posts
* Removed the ugly newline character at the beginning of the message when using Single Message with Image after the text
* Added Disable Notifications in override options
* Fixed the issue with saving of "Send files by URL" option
* Minor fixes

## 2.0.8
* Added the logging feature for debugging
* Added the option to upload the files
* Improved the proxy handling
* Changed the way Bot API creates logs
* Minor fixes

## 2.0.7
* Fixed the 404 CSS error for public.min.css
* Added the delAy options for posts
* Restored the old user profile field for Chat ID
* Added Bot Username field 

## 2.0.6
* Fixed the 404 JS error for public.min.js

## 2.0.5
* Fixed the override metabox issue

## 2.0.4
* Fixed the override metabox issue caused by other JS errors

## 2.0.3
* Fixed the issue with image being sent as caption

## 2.0.2
* Fixed the issue caused by is_success()

## 2.0.0
* Major Release with full revamp
* Added modular functionality
* Removed PHP 5.3 requirement to avoid double posting

## 1.9.4
* Fixed the double posting problem caused by the last update
* Added the filter for default inline button

## 1.9.3
* Fixed the issue with Scheduled posts caused by previous update

## 1.9.2
* Fixed the issue of category/author filter for future posts
* Added the filter to explicitly change the Inline URL Button text 

## 1.9.1
* Fixed the inline keyboard issue with image posts
* Fixed the double posting problem due to some plugins
* Other fixes

## 1.9.0
* Removed the API validation of bot token upon saving the settings
* Minor fixes

## 1.8.3
* Fixed the fatal error when using Google Script

## 1.8.2
* Added option to add inline button for Post URL
* Added support for WP-CLI
* Fixed the issue with spaces in WP Tags
* Minor fixes

## 1.8.1
* A few more hooks and filters
* Updated German translation, thanks to @robertskiba
* Minor fixes

## 1.8.0
* Added support for sending files along with the post.
* A few more hooks and filters
* Minor fixes

## 1.7.9
* Fixed the issue with sending test messages

## 1.7.8
* Added the support for bypassing blockage using Google App Script.
* Fixed the issue with double quotes in message template
* Minor fixes

## 1.7.7
* Fixed the issue with saving the settings with proxy

## 1.7.6
* Added support for many proxy types

## 1.7.5
* Added the hidden support for proxy
* Added hooks to bot API for modifying curl handle

## 1.7.4
* Added the latest update for Bot API Library
* Increased the default request timeout
* Added few more hooks for bot API request params

## 1.7.3
* Fixed the syntax error in previous update

## 1.7.2
* Some more control for user permissions
* Fixed the issue of bot token loss when saving the settings

## 1.7.1
* Added new filters for controlling the sent message

## 1.7.0
* Revamped Telegram Bot API Library to make it more portable
* Changed a few hooks to avoid confusion
* Added Catalan translation. Thanks to jdellund
* Minor fixes

## 1.6.5
* Enabled `parse_mode` for in image caption

## 1.6.4
* Added few more hooks for more control and customizations

## 1.6.3
* Added Russian translation. Thanks to Oxford
* Updated EmojiOne Area library to v3.2.6 to enable emoji search
* Updated Select2 library to v4.0.5

## 1.6.2
* Added method for creating API log
* Added method to modify curl handle for file uploads
* More filters to control the process
* Bug fixes

## 1.6.1
* Fixed the Fatal Error caused by WP_Error when saving the settings
* Added Portuguese Brazilian translation. Thanks to HellFive Osborn
* Fixed the issue caused by unending Markdown which stopped notifications

## 1.6.0
* Total revamp of the notification sending mechanism
* Allow users to receive email notifications on Telegram
* Added compatibility with every plugin that uses `wp_mail()` to send emails
* Fixed bugs in notification processing

## 1.5.7
* Fixed the issue of posts not being sent when published by cron
* Fixed the hyperlink issue in content URLs after the previous update
* Added more filters to control the way post_content and post_excerpt are processed

## 1.5.6
* Added German translation. Thanks to [Muffin](https://t.me/Muffin)
* Fixed post_date format and localization issue.
* Fixed shortcode issue in post_content
* Improved processing of post_content and post_excerpt
* Added option to choose the way consecutive messages are sent
* Fixed caption issue when sending image after the text
* Improved plugin strings for easy translations
* Bug fixes and performance improvements

## 1.5.4
* Added Italian translation. Thanks to [Mirko Genovese](http://www.mirkogenovese.it)
* Added Arabic translation. Thanks to @Mohamadbush and Mohammad Taher
* Fixed the HTML parsing issue when using Content before Read More tag as Excerpt Source
* Added hooks before and after sending the message
* Added `{post_date}` and `{post_date_gmt}` macros to be used in Message Template

## 1.5.3
* Added Persian translation. Thanks to [mohammadhero](https://profiles.wordpress.org/mohammadhero/)

## 1.5.2
* Added hooks and filters for post title, author, excerpt, featured_image etc.
* Final support for the search plugin

## 1.5.1
* Fixed the warning for undefined index when not using categories/terms restriction

## 1.5.0
* Added support for Read More tag to be used in Excerpt Source
* Improved Telegram API as a Library for developers to use
* Many upgrades to provide basis for future plugin(s)
* Minor fixes

## 1.4.3
* Fixed the bug with scheduled posts when using override switch

## 1.4.2
* Fixed the unwanted warning about invalid bot token

## 1.4.1
* Fixed warnings when settings not saved
* Added language pack for translations
* Minor fixes

## 1.4
* Introducing Website notifications to Telegram
* Dropped support for WordPress 3.5 and older

## 1.3.8
* Filter posts by author
* Filter posts by categories or terms of custom taxonomies
* You can now explicitly set Excerpt Source
* Performance improvements

## 1.3.7
* Delayed `save_post` hook execution to fix the issue with some custom fields
* Added filters to give you more control over macros and their values
* Added separate filters for modifying the values of individual custom fields and taxonomies
* Minor fixes

## 1.3.6
* Now Featured Image can be sent after the text
* Image and text can be send in a single message

## 1.3.5
* Now Featured Image can be sent with Caption
* Caption source can explicitly be chosen
* Added support for sending only Featured Image
* Minor fixes

## 1.3.4
* Fixed the text issue with scheduled posts

## 1.3.3
* Optimized Settings tabs for small screens
* Added tab icons to fit on small screens
* Minor fixes

## 1.3.2
* Fixed message template issue in post edit screen

## 1.3.0
* Total revamp of the settings page
* Added tabbed interface to reduce scrolling
* Added a beautiful template editor with emojis :)
* Added direct support for Custom Post Type selection
* Added the option to choose Channel/chat at the post edit screen
* Preserve override option for Scheduled (future) Posts
* Bug fixes for older WordPress versions

## 1.2.0
* Added support for PHP 5.2
* Minor bug fixes

## 1.1.0
* Added direct support for Custom Fields
* Added support for including {taxonomy} in template
* Fixed HTML issue with {content}

## 1.0.9
* Fixed HTML Parse Mode issue
* Fixed URL issue in Markdown style

## 1.0.8
* Added support for scheduled posts
* Fixed HTML Entities issue in the text

## 1.0.6
* Fixed excerpt length bug

## 1.0.5
* Minor fixes

## 1.0.4
* Updated README

## 1.0.3
* Minor fixes

## 1.0.2
* Changed the override option to make it more versatile
* Bug fixes

## 1.0.0
* Initial Release.