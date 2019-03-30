# Changelog

## 0.0.87 – 18.03.2019

**Fixes:**

* Fixed issue when settings were not saving in admin


## 0.0.86 – 18.03.2019

**Enhancements:**

* Added `target_url` property to `[anycomment_socials]` shortcode which allows to specify URL where to redirect user after authorization

**Fixes:**

* Fixed issue `ERR_TOO_MANY_REDIRECTS` error when logging in via social on admin login form
* Fixed issue when successful submission alert was shown twice in admin
* Email notifications now responsive and have crossbrowser support
* Changed no avatar from SVG to PNG so it can be displayed normally in email clients


## 0.0.85 – 19.02.2019

**Enhancements:**

* Improved Email notifications UI, no more template, it is is now unified: has avatar, author name, reply comment data, etc
* \#353, Added new option to hold only first comment and any further can pass without pre moderation
* \#326, Added ability to import comments from HyperComments inside "Tools" tab by specifying URL to XML file
* \#343, Migrated Google+ to Google People API
* Cache directory was moved from plugin to wp-content/cache/anycomment
* \#378, Added iThemes Security to the conflict list

**Fixes:**

* \#382, Fixed broken layout in screens < 1400 inside admin dashboard
* \#384, Fixed issued when nested comments were not sorted properly
* \#385, Fixed issue when shortcode was inserted on non-WordPress page, e.g. HTML caused notice error on comment count
* \#383, Fixed issue when ArgumentCountError fatal was given on  execution of delete_comment hook by Akismet


## 0.0.84 – 14.02.2019

**Enhancements:**

* Payment integration with Freemius to buy add-on directly from plugin
* Cache basting mechanism on successful user authentication, #380


**Fixes:**

* Fixed issue with Akismet when some websites did not have notifications and some had error when adding new comment

## 0.0.83 – 12.02.2019

**Enhancements:**

* Added ability to specify number of words before "..." in the recent comments widget, #374
* Reverted close comments behaviour. Now when "Close discussion" is unchecked, comment box would be hidden completely and not styles and scripts would be loaded, #371
* Added ability to hide whether comment was edited or not, #364

**Fixes:**

* Fixed IE error on "Object doesn't support property or method 'isNaN'"
* Fixed "Notice: Trying to get property of non-object" in "Emails" page, #373
* Fixed issue when WordPress native login did not redirect back to comments
* Fixed issue with thousand separator being &nbsp; instead of as space, #370
* Fixed issue when Akismet filtering was not working properly

## 0.0.82 – 25.01.2019

**Fixes:**

* Removed Freemius integration left by mistake, it should come a bit later


## 0.0.81 – 25.01.2019

**Enhancements:**

* New hook `anycomment/admin/options/update` with two arguments fired after some set of options being updated
* Added support for Internet Explorer 9+ (need more testing)


**Fixes:**

* Fixed issue when user avatar did not change when settings were updated, #361
* Fixed issue when moderators did not see admin bar while hide admin bar options was enabled, #359
* Fixed issue when users/admins were notified about about new comment even thought it was not process by Akismet yet, #358
* Fixed issue when authorized users did not see alert about comment being moderated, #365
* Fixed issue when alert message on the top right was not see as some themes have floating header
* Fixed 200 when comments template did not exist on the page, #362
* Fixed issue when stars were showing incorrect half of the rating, #355


## 0.0.80 – 08.01.2019

**Fixes:**

* Fixed issue when main js asset was loading in `<head>` instead of before `</body>`


## 0.0.79 – 07.01.2019

**Enhancements:**

* Sidebar news is now showing proper date format
* Introducing new REST API filter `anycomment/rest/comments/item_for_response` to control single comment output data
* Steam is now showing proper username, avatar & profile URL, #346
* Facebook username is now clickable, #344
* Improved mobile layouts, #351
* Now when comments are closed instead of comment form, it says "Comments closed.", replies and edits are not allowed, #347
* Now possible to choose comment date between relative (e.g. 1 minute ago) and absolute (defined in WordPress's settings), #350
* Added ability to add custom CSS via "Editor" tab in "Settings", #341

**Fixes:**

* Possible fix of issue when error toast was shown about invalid nonce, #342
* Fixed memory exhaustion caused by integration with WP Users Avatar, #348
* Fixed issue when some of the websites had styles for bullet points and they were shown in the attachment list 
* Fixed issue when core CSS style was loaded before `</body>` instead of `<head>`
* Fixed issue when reCAPTCHA position did not cache no matter what was set in admin settings
* Fixed issue when comments failed to load due to missing site key for reCAPTCHA
* Fixed issue when link from YouTube was not attached as video below the comment, #244
* Fixed issue when background color was ignored in comment list for widget

## 0.0.78 – 22.12.2018

**Fixes:**

* Fixed issue when sending comment did not clear the field, but comment was actually added 
* Fixed issue when real-time update did not work properly
* Fixed issue with anchors in specific comment, e.g. domain.com/page.html/#comment-1

## 0.0.77 – 21.12.2018

**Enhancements:**

* Warn users about missing API keys when reCAPTCHA enabled, #333
* Removed .map.css & .map.js files, package is not lighter, #336
* Chart data in Console tab is now display months data in native language + it is now cached

**Fixes:**

* Fixed issue when user avatars did not display in the admin, #331
* Fixed issue when new comment alert was shown when comment was deleted or on moderation, #335
* Fixed issue when comment notification was sent for non-comment (related to WooCommerce)


## 0.0.76 – 09.12.2018

**Enhancements:**

* Speed improvements, comments should load even faster now
* "Add comment" placeholder is the comment field is not users semi hidden color from design settings, #329
* Added new hook `anycomment/user/logged_in` fires after user is successfully logged in
* Added 304 code notice for WP Super Cache users, #296

**Fixes:**

* Fixed design issue when social tab was not displaying proper form styles
* Fixed issue when Mail.Ru did not show as active when enabled
* Fixed issue when some websites had problem with loading comments or widget in sidebar, #327
* Fixed issue when user was not notified about new reply when sent from admin panel, #330
* Possible fix of invalid nonce error when dealing with cache plugins (implemented for: WP Super Cache, WP Rocket, WP Fastest Cache and W3 Total Cache)

## 0.0.75 – 05.12.2018

**Enhancements:**

* Added Yandex & Mail.Ru to authorization options, #282
* Integration settings are not split into tabs for easier navigation
* Admin settings are now saved without page reload

**Fixes:**

* Fixed issue when error was shown in Tools tab
* Fixed issue when WP User Avatar settings were not taking affect

## 0.0.74 – 27.11.2018

**Enhancements:**

* Added ability guest users to like/dislike, #179
* Added Steam as authorization option, #311
* Added likes/dislikes, #322
* Added new option to control type of likes to display: just likes or likes/dislikes, #322
* JS main dependency is not much lighter ~600kb

**Fixes:**

* Fixed issue when "New comment was added" alert was not showing when real-time updates option was on, #297
* Fixed possible authentication problem
* Fixed issue when guest users could subscribe multiple times for same post
* Fixed issue when admin bar setting was not taken affect
* GDPR checkbox is unchecked by default

## 0.0.73 – 21.11.2018

**Enhancements:**

* Added pretty like animation, #316
* New widget to display list of comment in the sidebar, #319

**Fixes:**

* Fixed issue when sender name was not set from the admin panel, #317
* Fixed issue when it was not possible to copy long text as it was folding/unfolding on this action, #320
* Fixed issue when newlines and some of the other issue when user was posing comment as non-admin user
* Fixed issue when global border radius was not changing based on the settings value
* Fixed issue when repeating error messages could have been shown in case user tried to use admin's email to login via social, #312
* Possible fix to the issue when some of the users experienced problems with real time notification about new comments, #310

**Other:**

* Social icons are now on the right of the avatar, #318

## 0.0.72 – 15.11.2018

**Fixes:**

* Fixed issue when alert error message about Instagram was showing on every social tab
* Fixed issue with dropdown when items were aligned to the opposite side of it, #307
* Fixed WooCommerce compatibility (#302) + added compatibility when WooCommerce reviews are not used within tabs (#308)
* Fixed issue when copyright was not possible to uncheck, #301
* Possible fix for Internet Explorer 11
* Fixed issue when native notification from WordPress was inheriting styles from plugin, #300
* Fixed issue when emails were not sending
* Fixed issue when some of the themes were cut or had broken templates because of plugin

**Other:**

* Added missing translation for subscription form


## 0.0.71 – 13.11.2018


**Fixes:**

* Fixed 500 error on latest version


## 0.0.70 – 13.11.2018

**Enhancements:**

* Added ability to see list of ratings in "Rating" submenu
* Added ability to see list of subscribers in "Subscribers" submenu
* Added ability to see list of emails in "Emails" submenu
* Added transliteration for username, now instead of having `{socialname}_{username}`, it would be prettier, e.g. john_doe. Current usernames would be converted accordingly, #298
* Added "All In One WP Security" to the list of possible problems as it may cause failure to load comments, #284
* Subscription form: Better visual design for subscription form, #294
* Subscription form: guest users can now subscribe but need to confirm it by provided email, #294
* Subscription form: users can unsubscribe anytime by following the link provided in the bottom of the email, #294
* Subscription form: added email template for confirmation email, #294
* Plugin is now following PSR-4 and most of the plugin comply with WordPress Coding Standards

**Fixes:**

* Fixed issue when on mobile devices attachments icon was too small to click on
* Fixed issue when it was not possible to load or add comments for custom post types, #292
* Fixed issue when email notifications were not send when reply option was disabled
* Fixed issue when some hooks related to rest in functions.php were causing incorrect notification in console
* Fixed issue when it was not possible to turn off some of the default options in admin
* Fixed a few typos in translations

## 0.0.69 – 06.11.2018

**Fixes:**

* Fixed issue when incorrect option was used to grab admins email on some websites
* Fixed issue when recent addition of shortcode could break WP native API

## 0.0.68 – 05.11.2018

**Enhancements:**

* WooCommerce support, #280 (credits to @artikus11)
* Added new option to show/hide list of available social networks under WordPress' native login form, #150
* Added new shortcode `[anycomment_socials]` to "Shortcodes" tab to display list of available social to login in custom place
* Added new option to show/hide admin bar for regular users and those who used social network, #290, #233
* Added moderation icon besides comment owner name to point to the admin that this comment is waiting to be moderated, #291
* Added edited icon besides comment owner name to show users that comment was edited, #243 (credits @mihdan)
* Subscription: Added ability to subscribe by email to comments for specific post, #71
* Subscription: Added ability customize email template, #71
* Added new option to to specify sender name

**Fixes:**

* Fixed issue with social icon conflict with existing Fontawesome library, #288
* Fixed issue when user agreement checkbox was misaligned on some of the websites
* Fixed issue when dropdown was too narrow and some options were not seen well, #289
* Fixed issue when links and other tags were missing attributes (e.g. `<a>` was missing href)


## 0.0.67 – 01.11.2018

**Enhancements:**

* Added original comments wrapper. Should help themes align comments properly, #283
* Added "WordPress only" as a form type in "Elements" tab
* Added new option under "Generic" tab to define comment update time in minutes
* Added helper to "Possible problems" which detects problematic hooks which deactivate WP REST API

**Fixes:**

* Fixed translations in "Integration" tab regarding reCAPTCHA, #269
* Fixed issue when comments were not displaying in Internet Explorer, #272
* Fixed issue when comments were not shown in short page, #275
* Fixed issue when plugin was conflicting with jQuery which caused problems for sticky headers, sliders, etc, #274
* Fixed issue when facebook URL was longer then 100 chars. Now such URLs will be added to user meta, #285
* Minor fixes to CSS for proper alignment of elements
* Fixed issue when some websites had problems that they saved the post and some of the tags or attributes were not saved (kses issue)
* Fixed issue when comments were not put on hold when matched stop words


## 0.0.66 – 26.10.2018

**Enhancements:**

* Same style for name when user does not have website or social available
* JavaScript bundle is now having async to speed-up loading of comments, #256 (credits @mihdan)
* Added ability to define comments background color, border radius, outside (margin) and inside (padding) space, #249
* nofollow for link in plugin copyright, #249 (credits @artikus11)
* User is not alerted when comment was added in case when "Moderate first" option is enabled, as not users thought that comment was not send and sent duplicates, #249 (credits @artikus11)
* Added ability to add admin links to all moderated comments or to single one, #246

**Fixes:**

* Fixed issue when on update of the comment, previous text was recovered, #249
* Fixed issue with comments which are not wrapped with `<p>` tag causing them to have different line height then other comments, #249
* Fixed issue when button border radius was also changing it for "Author" label, #249
* Fixed AnyComment logo design in the footer of comments, #249 (credits @artikus11)
* Fixed issue when social icons could be not well aligned when custom designed is used and global font size is bigger then usual, #250 (credits @artikus11)
* Corrected description for reCAPTCHA integration about "Invisible" type, #264 (credits @LDSgent)
* Fixed issue when email queue table was having incorrect structure which caused issue with email notifications, #266
* Fixed issue when send/save comment button was disabled on error and user could submit form again,  #260 (credits @mihdan)
* Fixed issue when "or as guest" part was showing even when "Only social" option was chosen, #253

## 0.0.65 – 22.10.2018

**Enhancements:**

* New design
* Optimized main JavaScript file, removed some dependencies and now it lighter
* Other little cosmetic changes and improvements

**Fixes:**

* Fixes various visual bugs related to CSS on frontend
* Fixed issue when some of the users received too many repeating emails cause by incorrect table structure, #240
* Fixed issue when clicking on checkbox from reply could uncheck checkbox from other form
* Fixed issue when guest user could rate page many times
* Fixed issue when users had username instead of first and last name in the comment, #232
* Fixed possible issue when user social avatar was not uploaded causing him to have default avatar
* Fixed issue when button border radius from design settings was ignored, #231
* Fixed issue with quotes on some of the website, #230
* Possible fix for Safari problem when users were unable to save admin form, #159 (credits @mihdan)
* Fixed issue when admin comments with links were marked to be moderated (credits @artikus11), #236

## 0.0.64 – 18.10.2018

**Fixes:**

* Fixed issue with rating, some of the users said that they could not rate posts more then once, #235


## 0.0.63 – 17.10.2018

**Fixes:**

* Fixed issue when users were unable to place rating as migration failed to create rating table from 0.0.61, #217

## 0.0.62 – 17.10.2018

**Enhancements:**

* Cosmetic changes to paragraphs as now it is more visible when new one started, #225

**Fixes:**

* Fixed issue when comment moderation was on, but they were still showing to the end user, #223
* Changed Product to Article for rating as provides clearer idea about the content inside, #220
* Fixed issue when scrolling to comments section or to specific comment was not working and was throwing console error, #219
* Fixed issue when users were unable to place rating as migration failed to create rating table from 0.0.61, #217
* Fixed issue when user was able to send empty comment before even typing anything, #226
* Fixed issue when user could click two times on send comment button and duplicate comment would be sent, #218
* Fixed issue when on some websites REST API requests were cached, #216, #224


## 0.0.61 – 15.10.2018

**Enhancements:**

* Added ability to rate page in comments as guest or logged in user (possible to disable from admin), #156
* Added ability to edit comment or reply to a comment right below it, #164
* Added new option to enable/disable "Read more" for long comment, #169

**Fixes:**

* Fixed bad layout problem in admin after 0.0.60 update
* Fixed issue with comment dates when they were displaying e.g. "2 hours ago" even though comment was just posted, #208
* Fixed issue when non-admin user was unable to send some of the custom formatting from editor, #210
* Fixed issue when some clients have new MySQL version and `utf8mb4_unicode_520_ci` is no longer support, #211
* Fixed issue when close button of the gallery was not seen because of admin bar being over it (when user is logged in), #209
* Added missing set-up instructions per social network, #215
* Fixed issue when non-owner of the comment could see edit and delete actions (they did not work anyways), #203
* Fixed issue when comment was liked and after refresh it was still showing no likes, #152

## 0.0.60 – 10.10.2018

**Enhancements:**

* Cosmetics CSS changes to the list of socials on user side
* New fresh look of admin interface (new look for form fields, fixed font sizes, etc)
* Added better color picker in admin, #168


**Fixes:**

* Fixed issue when update comment and then reply action still was on the update action when sending comment, #205
* Fixed issue with news description having "?" in Russian language

## 0.0.59 – 06.10.2018

**Enhancements:**

* Now when option "show alert on new comment" is on, new comment will be show automatically, without a need to click on the alert message
* Added "Tools" tab for having different helpers from plugin. Ability to drop cache, open comments for all posts, pages, any post type, WooCommerce and see debug information

**Fixes:**

* Fixed issue when "Read more" was overflowing text
* Fixed issue when logged in user did not see his avatar in editor, #189
* Fixed issue when comment count header was not showing after recent update, #199
* Fixed issue when table for managing notification emails was not created, #196
* All tables which come from plugin now prefixed as defined by config, #200
* Now editor styles also adapt to custom styles defined in "Design" tag (e.g. font family, font size, etc), #195
* Fixed issue when some themes have special styles for `<p>` or `<ul>` tag which caused comment text to be weirdly formatted, #202
* Fixed issue when user was not moved to the editor on reply/edit/update comment action, #191
* Fixed issue when option "show alert on new comment" was shown to the user who sent the comment, #193
* Fixed issue when user was able to send empty comment text because editor leaves some underlying `<p>` tag which is visually invisible and therefore looks like empty comment, #197
* Fixed issue when remembered comment did not recover after page refresh, #201
* Fixed issue when admin did not receive email notification about new comment from guest users, #194

**Other:**

* Corrected Russian translation for option to clean editor formatting, #192


## 0.0.58 – 04.10.2018

**Enhancements:**

* Added left side highlight of a comment when clicked on "replied to" link and when user comes from email, #170
* [Comment editor] Enhanced editor, now possible to use: bold, italics, underline, quote, order/unordered list and link, #47
* [Comment editor] Ability to choose what editor options are available or disable toolbar completely, #47
* Comment read more now considers content height instead of length as it includes HTML and website can be wide, which breaks logic of content length, #105
* Added "*" for name and email fields to point that they are important to enter
* Send comment button is toggled as disabled when agreement is not accepted (for guest and authorized users)
* Added Russian translation for lightbox, #187


**Fixes:**

* Fixed issue with translations on number of comments in the header in Russian language, #178
* Fixed issue when some websites had broken CSS styles after activating plugin, #177
* Fixed issue when guest users were not able to submit uploaded documents, #175
* Fixed issue when "Login with:" was displayed even thought none of the socials were enabled, #166
* Now when comments is deleted, trashed/untrashed, marked as spam, status changed, its cache will be dropped and it will display on frontend accordingly, #162
* Fixed broken header notice on installation (sorry guys, I know it sucks)
* Fixed issue when comment attachment was not really deleted when comment was permanently deleted

## 0.0.57 – 25.09.2018

**Enhancements:**

* Added ability to disable WordPress from login options in "Socials" -> "WordPress", #154

* [Gallery] Ability to preview image in the gallery (can use LEFT-RIGHT arrow keys to iterate through images, ESC to close gallery), #147
* [Gallery] After image or file is uploaded, they will be added as small block below the comment box, #147
* [Gallery] Images are now handled smarter: original source is kept as it is and small thumbnail is cropped from original source as a preview, #147
* [Gallery] Ability to delete file when adding/updating comment (file will be erased from DB and filesystem), #147

* Removed ability to choose predefined themes and no more support for dark theme in favor of customizer. However, white theme is kept as the default one, #155

> The support of dark theme was a bit pain in the ass. So we sat and thought it would be better if give control over the theme to you.
> Give ability to drag & drop some of the elements, change colors, sized, etc. However it will come a bit further, for now a few new design options will be added.

* Added option to premoderate comments with links, #84
* Improved comments caching, they should be working even faster now, #151

**Fixes:**

* Added missing Russian translation for "Sorting"
* Fixed situation when one user with two social networks and same email address was always logged in with the first recorded social


## 0.0.56 – 17.09.2018

**Enhancements:**

* Comments are now nested up to 3 levels, any further replies will be added without further nesting. Two benefits: easier to maintain mobile view + easier to follow conversation
* Child comments are now having "reply to {name}" where {name} is the name of the person to whom reply is made
* Comments are now cached. This will help to limit number of requests to the database, load comments faster & help people who have limited resource environments
* From now on, plugin will crop original avatar from social into smaller version, which will increase loading speed of comment and take less disc space (existing avatar will be enhanced automatically for you), #149
* Converted sorting dropdown to multi dropdown. Now it has sorting option & logout link. When user is guest, it only has sorting options, #145
* When user registered via default WordPress form, and the same user is trying to authenticate using via social (using same email), he will see error message that he needs to use regular login form in this case, #143
* Integration tab now has option to add reCAPTCHA to comment form (for all, guests or authenticated users only, choose theme, etc), #146
* Added guides in Russian & English on how to set-up reCAPTCHA, #146
* Added ability to change border radius of avatars, #148
* Added WordPress icon as authorization option in social list, #131
* Added ability to choose default avatar (when user does not have any avatar). Currently possible to choose default from AnyComment or ones available from [Gravatar](https://en.gravatar.com/site/implement/images/), #138
* Small cosmetic style changes

**Fixes:**

* Added Russian translations for default sorting function
* Fixed list-style issue on some websites
* Logout link does not ask extra confirmation
* Sorting dropdown will close when clicked outside the element. Previously it was always open

## 0.0.55 – 10.09.2018

**Enhancements:**

* Added a Jetpack, Disqus, Disable Comments and a few other plugin to the list of possible problems, #134
* Improved mobile layout, #106
* Improved speed of theming, now x1.5 faster to generate custom styles
* Added logout link to logged in client, #133
* Added ability to customize generated notification email (only for  admin and reply for now), #97
* Added "Shortcodes" tab. It will have list of available shortcodes, #139
* Added a helper notice to admins & moderators about closed comments per post, globally or if post is password protected (comments did not show in this case), #142
* Added ability to rearrange guest form fields or remove unwanted, #125
* Added ability to define default sorting (ascending or descending order), #85

**Fixes:**

* Fixed notice message in admin, #132
* Fixed issue when "load on scroll" option was active and comments did not load on short pages because it was not possible to scroll, #135
* Fixed issue when custom styles were ignored as dark theme was selected
* JavaScript & Css assets are not loaded on the page, when comments are disabled or post is password protected
* Fixed issue when user was trying to login using the social network with same email as one of the existing account. It caused no problem, but redirect to page and user was not logged in, #29


## 0.0.54 – 06.09.2018

**Enhancements:**

* Small improvements in the documentation on how to set-up certain social network

**Fixes:**

* Small fixed for cached sidebar news. Added dependency on the website locale
* Fixed issue when some users were unable to authorize using Google caused 500 error, #127
* Fixed issue on comment delete, no more need to add DELETE option in Apache or Nginx
* Fixed typo in Russian translation message when trying to delete a comment
* Fixed issue when comments displayed on the single page could go over the page content as invisible element, #129
* Fixed issue with file input icon (was displaying as black square instead), #128
* Fixed issue when send comment button was too close to the "accept privacy policy" checkbox

## 0.0.53 – 04.09.2018

**Fixes:**

* Small fixes to translations regarding options to show/hide user URL
* Fix for main plugin shortcode, now use `[anycomment include="true"]` to include comments on custom place (reported by Ivan)

## 0.0.52 – 03.09.2018

**Enhancements:**

* Ability to customize styles of the plugin in the frontend (e.g. color of button, text size, color, avatar sizes, etc). Check out "Settings" -> "Design" tab , #113
* Files: attach files by dragging into the comment area, #68
* Files: attach files via by clicking on small photo icon in the top right of the comment text field, #68
* Files: ability to allow/disallow file upload by guest users, #68
* Files: plugin will add URL of the uploaded file to the comment field (when there is already some comment text, URL will be appended), #68
* Files: option to define comma-separated list of allowed MIME types (e.g. .jpg, .png) or even as image/* for all images and audio/* for audios, #68
* Files: added list of uploaded files in the admin (possible to delete, paginate, etc), #68
* When user logs out from admin top bar or somewhere else, he is going to be redirected back to post comment section instead of a login page, #122
* Added some text above list social icons as some of the users were confused and thought these were sharing buttons, #123
* Added "Possible Problems" to dashboard to help admin to figure out about possible problems or conflicts with other plugins, #117
* When some comment is remembered the comment field will expand automatically after the page has loaded
* Now "Read more", "Show less" link below long comment as some users were a bit confused that it is possible to expand comment by clicking on its text, #118
* Ability to attach Tweets from Twitter directly in the comment by adding link to it, #96

**Fixes:**

* Fixed issue when white theme had white links
* Fixed default options overwrite, before default values were not applied
* Fixed missing Russian translation when user is guest and only has option to authorize using social
* Some themes have hash navigation to comments as "#respond", so it was added, #124
* Removed hash from "Callback URL" as Google does not allow it, #119

## 0.0.51 – 28.08.2018

**Enhancements:**

**Fixes:**

* Fixed issue when reply user dialog was in dark color in dark theme (invisible), #114
* Fixed issue when guest inputs (name, email, website) were white in dark theme

## 0.0.50 – 27.08.2018

**Enhancements**

* News of plugin in the right sidebar inside console are display per your blog language. For now English and Russian supported
* Likes are now shown to guest users, however they do not have ability to like. When liked by guest, plugin will show alert about requirement to login, #108
* Removed submenu from main menu in admin. Now all of the submenus can be found as tabs inside the dashboard
* "Settings" tab in admin is now split into specific configuration tabs: General, Design, Moderation & Notifications
* Now possible to specify #comments, #to-comments or #load-comments (e.g. https://yourwebsite.com/cool-post/#comments) to move users screen to comment section
* Added proper subject to each type of email (e.g. sent to admin and to user as reply)
* Added option to make video or image link as attachment, #87
* Added option to make links in comment clickable or not, #83

**Fixes:**

* Added [Facebook guide](https://anycomment.io/en/api-facebook/) details regarding "Status" & HTTPs requirement & fixed other guides, also added instruction on how and where to find "Callback URI", #102
* Cosmetic style corrections (fixed height/alignment/decoration of button, make inline guest inputs 100%), #104
* Fixed issue when link in news sidebar lead to 404 page,  #109
* Plugin was not showing comment box until option to show comment was enabled and at least one social was configured. Now this logic is a bit different (plugin allows guest users), so now only required to enable option to show comment box, #112
* Some users were confused with dropdowns in the admin, as they did not have any visuals, such as triangle to see that there is a list of options
* When load on scroll is enabled and user comes from email his screen was not moved directly to the comment, #103
* When user was logged in via social network, he was redirected back to the top of the post. Now he is being moved to comment section
* Fixed issue with `trim()` warning (only some users experienced such problem) near avatars in Dashboard & Comments page in admin
* Fixed issue when emails about comment reply were not send to guest users (as it was not planned to have guest form). Now we have, so should support it
* Fixed dark theme CSS styles as after recent update of styles they got broken

**Other:**

* Added new entry to FAQ about Facebook forcing websites to have HTTPs in order to use API

## 0.0.49 – 24.08.2018

* Cosmetic fixes of form: avatar was not shown for logged in user & button was not properly aligned


## 0.0.48 – 23.08.2018

> I will try to deliver more fixes and features over next release. Thanks for using AnyComment <3.
> Please give us short review if you like it.

**Fixes:**

* Fixed division by 0 issue, which caused comments not to load, #101
* Fixed some style conflict issues
* Other small fixes & improvements

## 0.0.47 – 23.08.2018

**Fixes:**

* Fixed issue when selecting both types did not allow guests to leave a comment

## 0.0.46 – 23.08.2018

**Enhancements:**

* Major elements, such as textarea, buttons are now more unified, #90
* Leave comment as guest, via social or both. Ability to define this from admin, #94
* New comment form layout for guest users, social icons, #94
* When guest user entered name, email and/or website, it will be remembered - no need to type every time
* Added warning about [Clearfy](https://wordpress.org/plugins/clearfy/) (only when activated) in the dashboard as some users reported to have problems with it, #95


**Fixes:**

* Fix for missing Gravatar images in the comment section by guest users & now a bit faster on repeating gravatars, #92
* Added FAQ entry about how to fix problem when unable to delete comment (lack of `DELETE` as request option)
* Comment text is now stored safely even when you close tab or switch tabs, so you can continue typing it
* Added user's website to the comment when submitted as guest, #93

## 0.0.45 – 21.08.2018

> *IMPORTANT NOTE 1:* Please if you find any bugs report on the [support forum](https://wordpress.org/support/plugin/anycomment) or the [issue tracker](https://github.com/bologer/anycomment.io/issues)


> *IMPORTANT NOTE 2:* this plugin update includes email sending features, which might require SMTP configuration.
> We recommend to install [WP Mail SMTP](https://wordpress.org/plugins/wp-mail-smtp/) and follow on the instruction below:
> [English guide on SendPulse example](https://anycomment.io/en/smtp-sendpulse/)
> [Инструкция на русском на примере SendPulse](https://anycomment.io/smtp-sendpulse/)

**Enhancements:**

* Added Instagram, Dribble and Twitch as authorization option, #72
* Alert shown when new comment was added. Comment list will be automatically refreshed once clicked on alert, #63
* Added option to enabled/disable alert notification about new comment, #63
* Now social media avatar shown globally in admin (e.g. in `dashboard`, `user.php`, `comment.php`, etc), #61
* Better layout for plugin news in admin, `New` label is shown for articles which are not older then 2 weeks, #62
* Added caching for news in dashboard (no need to load them every time) and limited to 3
* New design for setting up social networks, now tabbed, #64
* Added guides English & Russian guides for Vkontakte, Facebook, Twitter, Google, GitHub, Odnoklassniki, Instagram, Twitch, Dribbble to help you with configurations, #66
* Added base plugin shortcode - `[anycomment]` to displays comment box, #67
* Now links, images or videos (e.g. YouTube, Rutube) displayed as attachments under comment text, #69
* Long comment text will be limited in height, by clicking on text will allow to expand it, #73
* Adding new comment is now 2x faster, ~500ms
* Loading comments is now 2x faster and there is no more iframe, therefore comments loaded directly
* Plugin is now sending email notification about new reply to the comment, #71
* Clicking on the "Reply" button in the email, will redirect user directly to the reply in the comments section, #81
* Removed iframe, now comments rendered directly on the page = comments can be searched by crawlers = better SEO, #80
* Option to define interval to check for new comments, #82
* Option to define list of comma-separated words. If one of them match comment text, it will be marked for moderation, #86
* Comment text field is now expanding automatically when you start typing new comment/edit existing/replying to someone
* Option to notify administrator by email about new comment, #77

**Fixes:**

* When user did not have social profile URL it lead to clickable name but incorrect URL, #60
* Do not load styles & scrips globally, only in plugin pages
* Plugin icon in admin sidebar was not displaying correctly and was overflowing when menu was opened
* Newlines in comment are now displaying correctly. Previously everything was as a single line
* Fixed issue when limit of number of comments per page was ignored and maximum number of comments displayed
* Fixed overlapping sidebar news in admin on screens smaller then 1000px

## 0.0.41 – 29.07.2018

* Fix issue when User Agreement checkbox was not shown

## 0.0.40 – 29.07.2018

**Enhancements:**

* Comment send button is now changing text based on action (edit/reply/send)
* Ability to specify User Agreement URL (used to collect consents from users to moderate personal information), text & URL is shown to guest users below list of available authorization options, #56
* Ability to delete personal or any comment if user has moderate permission, #59
* Moved social URL to the name of the user, better user experience (when enabled to show URLs)

**Fixes:**

* Uninstall hook was not properly cleaning-up data after plugin, #42
* Social authorization icon was shown even though it was disabled in admin, #57
* Guest user is not redirected back to post as redirect param is missing in social authentication URL, #58
* Options to enable/disabled show user social profile URL was ignored

## 0.0.35 – 20.07.2018
> **Important note:**
> Plugin was completely rewritten to React. It was required as on the very early stage it had a lot of JavaScript, partly merged with HTML).
> Logic behind plugin stays the same, we even added a few improvements and fixes, hope you like the change.

**Enhancements:**

* Comments rewritten to React!
* Post author now has "Author" badge in comments section, #45
* All assets are now minified (css, js) = faster load time
* Now possible to see number of likes per comment (`/wp-admin/edit-comments.php`) & user (`/wp-admin/users.php`), #43
* All settings moved to dashboard tabs (pages are still available, no worries), #38
* Mark new comment to be moderated first or be approved immediately, #50
* Ability to choose whether to show social profile URL in comments (when show is chosen, mini social icon in the bottom right corner will be clickable), #51
* Added new column "Social URL" in `users.php` which displays user's social profile URL

**Fixes:**

* Fixed issue when long texts were overflowing maximum with of the comment
* Fixed issue when it was not possible to disabled footer copyright ("Thanks" option in admin), #46
* Fixed issue when first & last name was not recorded in user profile

## 0.0.33 – 16.07.2018
* Fixed problem with array syntax support on PHP version 5.5, #49
* Fixed possible XSS in the comment

## 0.0.32 – 10.07.2018
* introducing comment likes, #35
* minified CSS, to save some loading time
* ability to define default user role on creation (registration via plugin), #37
* when user has non-default Gravatar, use it, otherwise use default from plugin, #10
* proper integration with WP User Avatar & Akismet
* load commnets on scroll (new options to load comments when user scroll to it), #36
* and other small bug fixes & improvements

## 0.0.2 – 01.07.2018
* admin OR moderator was unable to edit comment as it was too old
* ability to specify number of default comments to load. The same settings applies to number of comment loaded per page, when there are more comments on post/page then specified in settings
* plugin is not enabled until you specify at least one social network, even thought you set plugin to be ON in general settings, #11
* refactoring of comments logic towards native WordPress REST
* ability to update any comment if user has `moderate_comments` or `edit_comment` capability (no time limit)
* ability to update personal comment within 5 minutes
* guest user cannot see comment actions (reply/edit)
* added two new authorization methods: GitHub & Odnoklassniki
* comment text box was overflowing on long texts, #22
* better responsiveness of dashboard layout, #32
* avatars uploaded locally to escape problem when some social medias were blocking access to avatar after token expiration, #14
* display most recent news from plugin, #31
* other small bug fixes and improvements
* moved completely towards REST architecture

## 0.0.1 - 24.06.2018
* First Release
* Options to specify API details (secrets, etc) for social authorization: Vk, Twitter, Facebook, Google
* Integrated with [WP User Avatar](https://wordpress.org/plugins/wp-user-avatar/)
* Authorize via VK, Twitter, Facebook, Google
* date when comment is left is based on website's language. List of supported languages can be seen [here](https://github.com/hustcc/timeago.js/tree/master/src/lang)
* comment count at the top updated automatically when new comment added
* add comments with AJAX, no need to refresh the page
* ability to reply to nested comments up to 2 levels
* when all socials disabled, libraries not loaded and they are not shown to end user
