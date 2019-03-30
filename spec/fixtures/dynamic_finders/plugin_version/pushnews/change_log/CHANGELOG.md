CHANGELOG
=========

# 1.8.1
- Saving "send push"/"send email" checks on custom post drafts

# 1.8.0
- Preventing Push/Email send while saving a draft post
- Added support for custom post types

# 1.7.3
- Fixed date comparison (now using GMT)

# 1.7.2
- Fixed bad production API endpoint

# 1.7.1
- Fixed sending Push after editing a Post

# 1.7.0
- Added support for Wordpress 5
- Updated API url
- Allowing Push/Email sending after editing a Post
- Enhanced Push/Email sending for scheduled Posts
- Editing a scheduled Post will now show if it has scheduled Push/Email
- Added Service Worker under "/wp-content/plugins/pushnews/sdk/pushnews-sw.js.php" (preparing for future native Widget Support)

# 1.6.0
- No longer pre-checking "Send Push" and "Send Pushmail" checkboxes

# 1.5.4
- Updated Push Notifications plugin behaviour, now sending featured image as SuperPush

# 1.5.3
- Fixed some issues regarding updated posts

# 1.5.2
- Fixed some issues regarding scheduled posts

# 1.5.1
- Fixed some issues regarding the automatic push notifications

# 1.5.0
- Added send automatic push mail feature on new post publish

# 1.4.0

- Added send automatic push notification feature on new post publish

# 1.3.0

- Simplified tag installation so it only requires the App ID

# 1.2.0

- Making sure all tag configuration elements are trimmed before printed

# 1.1.0

- Removed short array syntax to allow compatibility with PHP 5.3
- Updated API domain

# 1.0.0

- Plugin approved by WordPress.org

# 1.0.0-rc2

Addressed WordPress.org Plugin reviewers' issues:

- Incorrect Readme
  - Fixed Contributors list in readme.txt
- Too Many Tags
  - Removed excessive tags from readme.txt
- API Token
  - Removed public API_TOKEN constant
- Your admin dashboard is an iframe
  - Replaced iframe with a link to Pushnews

# 1.0.0-rc1

- First Release Candidate