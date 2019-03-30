# Changelog

## v3.2.2 (2018-06-18)
Updated sailthru_horizon_meta_tags filter to apply to Content API calls. 

## v3.2.1 (2018-04-11)
Added a filter to allow customers to override API verification in the setup process. The goal of this feature is to mitigate some edge cases where the setup process returns a payload to WordPress VIP creates an error on their platform. Most customers using this plugin are not affected. 
Changed ajaxurl used in widget to be namespaced to prevent collision.
Fixed issue whereby any error on a signup widget would render on all signup widgets on the page.
Added a filter to allow the localized js to be loaded in wp_footer()
Removed php 7.2 unsupported code. (Thanks srtfisher)
Added support for Page in Sailthru meta box. 
Extended timeout for VIP API calls to 3 seconds. 
Squished a few more bugs. 


## v3.2.0 (2018-02-18)
Fixed bug with rendering of checkboxes on widget subscription.
Fixed issue with validation of email addresses on subscription widget. 
Fixed PHP warnings on newly created instance on subscription widget if debugging is turned on. 


## v3.1 (2017-12-10)
Added ability to select JS versions in the setup
Added new flag to check for API readiness. Must re-save keys ato add flag
Added a check to verify if SPM is enabled on Sailthru customer account
Subscribe widget now supports instance level source var
Subscribe widget now can add an Event API call when converting
Non VIP customers can create a WordPress user when new users subscribe via the subscribe widget
Fixed a number of bugs, and updated coding standards to WordPress VIP
Concierge and Scout disabled when Sailthru Script Tag is enabled
Added support for latest SPM and Sailthru Script Tag. 

## v3.0.8 (2017-10--24)
Fixed a bug with deployment of Sailthru Script Tag where Sailthru functions are not available due to incorrect Setup of Sailthru.init
Added filters to allow customers to customize rendering of Script Tag 

## v3.0.7 (2017-10--5)
Added support for latest version of Sailthru Script Tag and some big fixes. 

## v3.0.6 (2016-07-15)

Version 3.0.6 of the plugin adds support for Sailthru's content API and additional support for our personalization engine JavaScript as well as bug fixes and improvements. 

#### Added Content API support

Each time a post is added or saved it is now pushed to Sailthru's Content API. Any additional custom fields produced by a WordPress plugin are passed as vars. The post type is also passed a a var so that you can filter data feeds based on post type as well as tags. 

Content API calls can be disabled and the Spidering process used by applying the filter ```sailthru_content_api_enable``` in your functions.php file with a return value of ```false```

#### Added option to choose Javascript Library

Customers can choose between Personalize JS and Horizon JS versions. During the sunsetting of Horizon JS in 2016 we will provide options for which version of our JavaScript library that will be available. 

#### Sailthru Subscription Widget
Fixed a bug whereby smart lists were available in the subscription widget. Changed Sailthru subscription widget to only use natural lists as subscription option as Smart Lists cannot be posted to.

#### Added setHorizonCookie to newsletter singup widget

Added a call to setHorizonCookie that will be called upon form submission of the Sailthru subscribe widget. This should drop the sailthru_hid cookie.


#### Updated Sailthru Client Library 
Added an integration parameter to all API calls to help Salthru support identify the WordPress plugin version to help provide faster responses and initial investigations.
