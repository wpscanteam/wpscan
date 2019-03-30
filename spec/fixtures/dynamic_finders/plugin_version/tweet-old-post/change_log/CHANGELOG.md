
 ### v8.2.2 - 2019-03-20 
 **Changes:** 
 * New: Feedback button on plugin dashboard. Help us make ROP better by filling out the form!
* Fix: Minor typos
* PRO: You can now share custom messages/share variations in the order they were added.
* PRO Change: Updated custom messages/share variations metabox design
 
 ### v8.2.1 - 2019-03-01 
 **Changes:** 
 * Fix: Sharing queue issue with sites running WPML plugin
 
 ### v8.2.0 - 2019-02-09 
 **Changes:** 
 * New: The share post on publish feature is now in the lite version of the plugin. This should help with Facebook app review process (see revive.social docs)
 
 ### v8.1.8 - 2019-01-29 
 **Changes:** 
 * Fix: Minor bugs
 
 ### v8.1.7 - 2019-01-18 
 **Changes:** 
 * New: Adds basic support for WPML content sharing(see revive.social docs)
* Fix: Low PHP version notice was not showing the right text
* Fix: Minor bugs
 
 ### v8.1.6 - 2018-12-13 
 **Changes:** 
 * Fixed undefined variable error
 
 ### v8.1.5 - 2018-12-13 
 **Changes:** 
 * New: Made post share content filterable, you can now use post excerpt field (see docs)
* New: Pinterest shares will now link to the post on your website
* Changed: Bit.ly authentication method, old method will be deprecated in the future
* Changed: Custom message labels
* Fix: Pointer JavaScript error
* PRO Fix: Publish now feature not always showing
 
 ### v8.1.4 - 2018-12-03 
 **Changes:** 
 * New: Admin pointers for new plugin installs
* Change: Rename custom messages to "Share Variations"
* Fix: Automatically remove whitespace when adding credentials
* Fix: Excess blank space in shares caused by Gutenberg Editor
* PRO Fix: Publish now not showing on custom post types edit screens
 
 ### v8.1.3 - 2018-11-01 
 **Changes:** 
 * - Adds: Option to delete plugin settings on uninstall
* - Fix: Change twitter credential labels to match that on developer.twitter.com apps
* - Fix: Various typos
* - Fix: Issue with media library not loading when PRO plugin is installed in some cases
* - Fix: Error when other plugins also try to authenticate with Facebook
* - PRO: Adds support for magic tags for Custom Share Messages and Additional Text
* - PRO: Adds support for custom post type taxonomy hashtags
* - PRO: Adds Option to make share instantly option checked by default
 
 ### v8.1.2 - 2018-10-08 
 **Changes:** 
 * Fixed issue with hashtags in content
* Adds notice for PHP versions lower than 5.6
* Replaced goo.gl shortener with firebase dynamic links
 
 ### v8.1.1 - 2018-09-22 
 **Changes:** 
 * Fix rebrandly shortner missing feature.
* Adds option to disable the instant sharing feature.
 
 ### v8.1.0 - 2018-09-04 
 **Changes:** 
 * Adds support for Pinterest sharing feature
* Adds support for library media sharing feature
* Adds support for immediate post sharing feature
* Changed hashtags placement for Twitter
* Fixed hashtags for Tumblr
* Fixed Jetpack staging mode check
 
 ### v8.0.9 - 2018-06-18 
 **Changes:** 
 * Fix issue with Exclude posts blank page on non-English websites.
* Adds dedicated app workflow for Twitter authentication. 
* Adds tweet intent and review buttons in the header.
* Adds filter for content before sharing.
 
 ### v8.0.8 - 2018-05-25 
 **Changes:** 
 * Prevent sharing when the website is in the staging environment.
* Improve UI accessibility. 
* Adds possibility to fetch more post types.  
* Strip redundant shortcodes on post content sharing.
 
 ### v8.0.7 - 2018-05-10 
 **Changes:** 
 * Fix status migration issue from v7.
* Fix compatibility with the PRO version for the linkedin sharing on company pages.
* Fix compatibility with the PRO version for the thumblr sharing issues.
* Fix small typos in the plugin settings. 
 
 ### v8.0.6 - 2018-05-08 
 **Changes:** 
 * Fix hashtags issue when using post content as a source.
* Fix LinkedIn broken link when no image is used.
* Fix issue with sharing when multiple accounts are used with different custom schedules.
* Adds link only in the preview, remove from facebook message content.
* Adds limit for the number of logs.
 
 ### v8.0.5 - 2018-05-04 
 **Changes:** 
 * Fix issue with common hashtags using post content.
* Fix issue with add service when an account was removed from the list.
* Fix issue with cron lag between shares
* Improve disable state for pro services.
* Fix exclude posts inconsistency. 
* Fix incomplete UTM tags on certain shortners. 
* Fix refresh queue on start sharing. 
* Fix freezing message in frontend when the sharing is happening. 
* Fix Facebook limits regarding the number of accounts fetched. 
* Fix compatibility with PRO version regarding sharing on LinkedIn. 
 
 ### v8.0.4 - 2018-05-02 
 **Changes:** 
 * Fix issue with UTM tags and shortner consistency.
* Adds Exclude Posts as a separate page. 
* Fix issue with sharing stopped after the first share. 
* Fix timeline events refresh when the min interval changes. 
* Fix Facebook page accounts not showing in certain environments.
* Adds remove account feature for permanently delete an account from the list.
 
 ### v8.0.3 - 2018-04-28 
 **Changes:** 
 * Fix schedule synchronization issues.
* Fix LinkedIn authentication with the wrong redirect_url.
 
 ### v8.0.2 - 2018-04-27 
 **Changes:** 
 * Fix issue with old Facebook applications and strict OAuth urls settings.
* Fix issue taxonomies filter setting. 
* Fix filter by excluded posts issue.
* Fix issue when LinkedIn exceptions on login.
* Adds more exceptions handling for Facebook authentications.
* Fix compatibility with pro version for post_types and custom share messages.
 
 ### v8.0.1 - 2018-04-26 
 **Changes:** 
 * Fix Linkedin error on loading SDK class.
* Fix multiple twitter accounts warning message.
* Fix foreach loop on the services model.
* Fix Facebook authentication issues with application url.
* Adds notice when using an old Pro version.
 
 ### v8.0.0 - 2018-04-26 
 **Changes:** 
 * Major improvements to the codebase.
* Adds schedule and format per accounts, not per networks as it was before.
* Improve settings UI as well as the accounts authentication workflow.
* Improve posts selections per accounts.
* Improves logs reporting and messages.
* Adds major improvements to schedules trigger, implementing a new way of using wp-cron events for the plugin sharing.
 
### 7.4.8 - 06/04/2017
**Changes:** 
- update description

### 7.4.8 - 03/04/2017
**Changes:** 
- Fixed bad chars in name for twitter.
- Fixed facebook display users.

### 7.4.7 - 23/01/2017
**Changes:** 
- Fixed remote check for pro version.
- Added rviv.ly.
- Fixed clear setting on uninstall.

### 7.4.6 - 03/11/2016
**Changes:** 
- Fixed deactivation error

### 7.4.5 - 02/11/2016
**Changes:** 
- Improved schedule trigger mechanism
- Fixed post format saving issues
- Fixed status saving issue
- Updated readme and assets

### 7.4.0 - 28/09/2016
**Changes:** 
- Added support for custom messages
- Fixes issue with multiple taxonomies having the same name
- Fixed instructions for popups

### 7.3.8 - 19/07/2016
**Changes:** 
- Improved categories excluding UI in the General tab
- Improved design of the social networks authorization popups
- Added more shortners
- Fixed issue with wrong tags fetch

### 7.3.7 - 30/05/2016
**Changes:** 
- Fixed issue with inverted settings in post format and custom schedule

### 7.3.6 - 27/05/2016
**Changes:** 
- Fixed issue sample post rendering
- Improved error logging for facebook request
- Fixed typos in facebook description
- Added default tab for Manage Queue

### 7.3.5 - 26/05/2016
**Changes:** 
- Fixed issue with shortners and slow loading page
- Fixed layout issues for post with images on Manage Queue section
- Fixed issue with encoding

### 7.3.2 - 22/05/2016
**Changes:** 
- Fixed exclude posts bug
 ### 7.3.1 - 20/05/2016 **Changes:** - Fixed compatibility with old PHP versions where anonymous functions are not supported.  ### 7.3.0 - 19/05/2016 **Changes:** - Added advanced scheduling option - Added fix for is.gd - Fixed responsive issue - Fixed some security issues  ### 7.2 - 11/02/2016 Changes: tweet-old-post Fix readme tweet-old-post per network buffer 1) removed the global buffer and added a per-network buffer 2) if min and/or max date of posts is 0, do not include that part in the query tweet-old-post Fixed randomization algorithm, preventing share twice of same post until the end of cycle Fixed date filter when both of them are 0 ### 7.1 - 14/01/2016 Changes: tweet-old-post Add confirmation box to reset settings. Add confirmation box to reset settings in the plugin options. tweet-old-post Bug fixes for cron and image posting 1) Create endpoint for remote check 2) White posting to twitter, post without image if media is invalid tweet-old-post Bug fix Show alert only when showAlert is being sent from the back end tweet-old-post Bux fix: Support from cron If cron is disabled/inoperative, fire events through the endpoint if they are due tweet-old-post Call ROP endpoint Call the ROP endpoint with the correct network arguments tweet-old-post If cron is not running, reschedule future tweets In case the cron is only temporarily disabled, the future schedule should not be cleared. So, when the endpoint is called, we fetch the cron, clear it, execute the passed schedule and schedule the future ones. tweet-old-post Fixed schedule inconsistency Fixed posting with image tweet-old-post Merge pull request #41 from HardeepAsrani/development Add confirmation box to reset settings. tweet-old-post Fixed menu icon ### 7.0.8 - 18/09/2015 Changes: tweet-old-post tweet-old-post removed new lines for tweets tweet-old-post tweet-old-post fixed problems with custom icons tweet-old-post *fixed problem with mysql_get_client_info tweet-old-post Fixed multisite issue for redirect url tweet-old-post making translation ready tweet-old-post fixed single quotes problem tweet-old-post fixed tumblr tags ### 7.0.6 - 28/05/2015 Changes: tweet-old-post tweet-old-post removed redundant code tweet-old-post tweet-old-post added compatibility for wordpress 4.2.2 tweet-old-post tweet-old-post fixed compatibility with pro version ### 7.0.4 - 25/05/2015 Changes: tweet-old-post tweet-old-post fixed issue with tweet length tweet-old-post fixed issue with facebook hashtag tweet-old-post tweet-old-post added bussines version ### 7.0.4 - 16/04/2015 Changes: tweet-old-post tweet-old-post fixed bug with the new facebook api changes. tweet-old-post changed pro banner tweet-old-post Merge branch 'development' of https://github.com/Codeinwp/tweet-old-post into development ### 7.0.3 - 03/04/2015 Changes: tweet-old-post tweet-old-post fixed problem with media_id tweet-old-post tweet-old-post fixed bug with logs reporting in system info where there is no log available. tweet-old-post Update readme.txt tweet-old-post Update readme.txt ### 7.0.2 - 26/03/2015 Changes: tweet-old-post tweet-old-post Removed twitter update_with_media call. tweet-old-post Fixed activation error notices when WP_DEBUG was enabled tweet-old-post Merge remote-tracking branch 'origin/development' into development ### 7.0.1 - 06/03/2015 Changes: tweet-old-post http bug tweet-old-post Final version of tweet old post tweet-old-post final vers tweet-old-post Added Top 5.7 version tweet-old-post added strlower tweet-old-post Tweets now are posted immediately, fixed scheduling and added debug messages tweet-old-post latest stable version 6.2 tweet-old-post added exclude posts back tweet-old-post latest major fixes tweet-old-post fixed interrupted posting tweet-old-post Added settings link, fixed tweet cutting and added cron debug messages Added settings link, fixed tweet cutting and added cron debug messages tweet-old-post latest top fixes [stable version ] tweet-old-post almost added fb tweet-old-post stable version with linkedin + facebook tweet-old-post custom icon, final fixes tweet-old-post fixed fb instructions + small css things tweet-old-post Set up localization and translation tweet-old-post 6.8.1 with multi-language + cpt support tweet-old-post fix post issue tweet-old-post various small fixes to encoding tweet-old-post various fixes tweet-old-post fix for coma on the exclude post page tweet-old-post fixed the shortner problem that was not adding the analytics. tweet-old-post fixed the cron issue tweet-old-post increased notification time check by *5 increased notification time check by *5 tweet-old-post tweet-old-post Added post format per network tweet-old-post Rearranged the options tweet-old-post Merge remote-tracking branch 'origin/development' into development tweet-old-post tweet-old-post Fixes for no account post sharing issue tweet-old-post Added immediately share after start tweet-old-post redesign and on/off button tweet-old-post tweet-old-post Improved tabs graphic tweet-old-post Added remote cron check tweet-old-post tweet-old-post added pro badge for linkedin post format tweet-old-post fixed compatibility issue with older versions tweet-old-post tweet-old-post added pro badge for linkedin post format tweet-old-post fixed compatibility issue with older versions tweet-old-post tweet-old-post fixed the relative path issue tweet-old-post Update readme.txt tweet-old-post tweet-old-post fixed issue with notices tweet-old-post solved some cron compatibilty problems tweet-old-post tweet-old-post fixed double posting issue for cron tweet-old-post tweet-old-post fixed backwards compatibility issue tweet-old-post Removed useless spaces in post format tweet-old-post fixed custom field from url issue tweet-old-post tweet-old-post fixed problem with oauth time tweet-old-post fixed problem with cron time tweet-old-post tweet-old-post fixed problem with oauth time tweet-old-post fixed problem with cron time tweet-old-post Merge remote-tracking branch 'origin/development' into development tweet-old-post Update core.php tweet-old-post Update tweet-old-post.php tweet-old-post Update view.php tweet-old-post Update OAuth.php tweet-old-post Update tweet-old-post.php tweet-old-post tweet-old-post added more complex log system tweet-old-post improved cron schedule tweet-old-post Merge remote-tracking branch 'origin/development' into development tweet-old-post tweet-old-post fixed sample tweet tweet-old-post added support for pro version tweet-old-post tweet-old-post added clock feature tweet-old-post tweet-old-post fix for old cron tweet-old-post fix sample tweet image tweet-old-post tweet-old-post removed console clock tweet-old-post Update readme.txt tweet-old-post Fixed https request tweet-old-post Update tweet-old-post.php tweet-old-post Update core.php tweet-old-post Update style.css tweet-old-post Update tweet-old-post.php tweet-old-post tweet-old-post fixed typo bugs. tweet-old-post Update readme.txt tweet-old-post tweet-old-post fixed excluded post bug tweet-old-post fixed cron time issue tweet-old-post added more log types messages tweet-old-post improved system info tweet-old-post Merge remote-tracking branch 'origin/development' into development tweet-old-post tweet-old-post update version tweet-old-post tweet-old-post added sib banner tweet-old-post tweet-old-post updated changelog tweet-old-post tweet-old-post fixed bug with share more than once. tweet-old-post Update tweet-old-post.php tweet-old-post Update view.php tweet-old-post tweet-old-post Fixed issue cron stop tweet-old-post Fixed issue for excluded post tweet-old-post Added exclude posts from custom post types. tweet-old-post Merge remote-tracking branch 'origin/development' into development tweet-old-post tweet-old-post Fixed issue cron stop tweet-old-post Fixed issue for excluded post tweet-old-post Added exclude posts from custom post types. tweet-old-post updated version tweet-old-post tweet-old-post fixed sample post issue tweet-old-post tweet-old-post fixed tweet custom field url tweet-old-post tweet-old-post changed version tweet-old-post fixed minutes typo tweet-old-post tweet-old-post rollback generate tweet tweet-old-post Merge remote-tracking branch 'origin/development' into development tweet-old-post tweet-old-post fixed image compatibility tweet-old-post tweet-old-post fixed pro compatibility tweet-old-post Update readme.txt tweet-old-post buttons added: Google Plus, XING , Stumbleupon , Tumblr tweet-old-post strip html response. tweet-old-post tweet-old-post rewrite the tweet generation tweet-old-post added usefull filtes and hooks tweet-old-post tweet-old-post Fixed issue with duplicate posting tweet-old-post Added Xing and Tumbr Networks tweet-old-post Fixed issue with random posts on large databases. tweet-old-post tweet-old-post Fixed issue with duplicate posting tweet-old-post Added Xing and Tumbr Networks tweet-old-post Fixed issue with random posts on large databases. tweet-old-post tweet-old-post Fixed no link issue tweet-old-post Added new info to System Log tweet-old-post tweet-old-post FIxed compatibilty issues with old pro version tweet-old-post tweet-old-post added chacter count when media is active tweet-old-post tweet-old-post fixed link position in tweets. tweet-old-post tweet-old-post removed only pro badge on custom schedule secundar tabs tweet-old-post tweet-old-post fixed problem with strange chars in tweets.
