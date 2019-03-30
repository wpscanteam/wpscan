# vBSSO Connect WordPress

### Changelog

### 1.4.3

* Technical release.

_[Updated on March 26, 2019]_

### 1.4.2

* Update core version.

_[Updated on March 21, 2019]_

### 1.4.1

* Added PHP 71, 72 support (Feature #6421).

_[Updated on March 20, 2019]_

### 1.4.0

* Splitting the vBSSO functionality into the independent features: Login, Logout, Registration, Avatars, Update User Profile, User Profile, Member Profile.

_[Updated on July 25, 2017]_

### 1.3.0

* Added PHP 5.3, 5.4, 5.5, 5.6, 7.0 support for WordPress 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7.
* Fixed the user group syncing issue.
* EOL (End-of-life due to the end of life of this version) for PHP 5.2 support.
* EOL (End-of-life due to the end of life of this version) for WordPress 3.x support.

_[Updated on March 10, 2017]_

### 1.2.11

* Added PHP 5.6 support
* Fixed invalid HTML makeup in vBSSO widget
* Fixed incorrect link to Visitor Messages page.
* Other enhancements and bugs fixes.

_[Updated on Updated June 05, 2015]_

### 1.2.10

* Added support of cross-domain single-sign on in Internet Explorer.
* Fixed warning when wigdet had empty title.
* Fixed a possibility to save an empty Shared Key.
* Fixed an issue when sometimes user could not be created.

_[Updated on February 28, 2015]_

### 1.2.9

* Fixed vBSSO options saving after fresh installation.
* Fixed links overriding when network enabled.
* Fixed `Forgot your password` link overriding.
* Enhancements and bugs fixes.

_[Updated on November 1, 2014]_

### 1.2.8

* Added support for WordPress 3.9
* Implemented vBulletin Notifications in WordPress vBSSO Widget.
* Implemented "Ignore Membership" feature.
* Improved vBSSO vBulletin usergroups.
* Added WordPress Network.
* Fixed an issue when allow_url_fopen is disabled.
* Enhancements and bugs fixes.

_[Updated on July 17, 2014]_

### 1.2.7

* Fixed "Call to undefined method stdClass::add_role()" issue.
* Prepared the feature to handle broken user accounts between WordPress and vBulletin.
* Enhancements and bugs fixes.

_[Updated on May 21, 2013]_

### 1.2.6

* Improved vBSSO Login widget.
* Improved support of vBSSO WordPress SSL mode.
* Implemented vBSSO vBulletin usergroups API.
* Enhancements and bugs fixes.

_[Updated on May 20, 2013]_

### 1.2.5

* Fixed the issue with inability to log out.
* Enhancements and bugs fixes.

_[Updated on February 17, 2013]_

### 1.2.4

* Adjusted vBSSO Widget once WordPress is not connected to vBSSO.
* Enhancements and bugs fixes.

_[Updated on September 23, 2012]_

### 1.2.3

* Added customizable vBSSO "Login" widget.
* Added compatibility with WordPress 3.x.
* Added support of non-Latin characters in username (might be restricted by vBulletin username restriction rules).
* Enhancements and bugs fixes.

_[Updated on September 3, 2012]_

### 1.2.2

* Added support of vBulletin Profile Page connected to WordPress.
* Added support of vBulletin Author Page connected to WordPress.
* Added support of "Registration" url connected to vBulletin.
* Enhancements and bugs fixes.

_[Updated on August 10, 2012]_

### 1.2.1

* Fixed "Use of undefined constant IS_PROFILE_PAGE - assumed 'IS_PROFILE_PAGE'".
* Fixed an issue when sometimes avatars are not fetched from vBulletin and displayed.
* Enhancements and bugs fixes.

_[Updated on June 22, 2012]_

### 1.2

* Disabled E_DEPRECATED setting in error reporting (since PHP 5.3.0 only) to make PHP ignore "Deprecated: Function set_magic_quotes_runtime()" used in WordPress.
* Implemented fetching of blog avatars required for "Blogs Directory" (http://premium.wpmudev.org/project/blogs-directory) plugin from vBulletin. The blog avatar is an user avatar fetched of user who has a "Blogger" role in WordPress blog.
* Added an option to fetch or not avatars from vBulletin in Settings page.
* Improved installation process by adding a check for the required PHP extension before the plugin is completely activated.
* Fixed the issue with saving footer link option.
* Hid unnecessary options from vBSSO Settings page.

_[Updated on September 28, 2011]_

### 1.1

* Overrode lostpassword_url to let vBSSO take care of this functionally.
* Fixed the logging condition in case if we are unable to find user when try to sync user credentials.
* Added config.custom.default.php file as a config sample.
* Fixed css to display "SSO provided By" text correctly in different theme layouts.

_[Updated on September 18, 2011]_

### 1.0

* Initial version released.

_[Released on September 10, 2011]_