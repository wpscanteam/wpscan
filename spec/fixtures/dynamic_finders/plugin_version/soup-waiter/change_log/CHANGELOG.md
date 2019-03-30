# Changelog for Vacation Soup Waiter

## 1.2.3 (xx.xx.xx)

* **Enhancements**:
- Removed 10 property limit 

* **Bug Fixes**:
- Recent posts show all user's posts in single user mode


## 1.2.2 (2018.10.15)

* **Enhancements**:
- Added Enhanced Multi-user capabilities
- Enabled switchable multi-user or shared user settings
- autocreate byLine for future posts as well

* **Bug Fixes**:
- Corrected error in migration code
- Fix 'you aren't allowed hereXX' due to new page link style
- fixed auth failure on connect tab
- fixed auth-level permission error on connect menu/tab
- remove false-positive alerts
- fixed 'next' on owner
- Fixed tab links for new menu structure
- removed cause of alerts when rapid clicking in Safari
- Fixed Dates/times now work in Timezones
- Always stored as GMT, always localised in browser

## 1.2.0 (2018.08.30)

* **Enhancements**:
- Each WP user now has their own settings
- Refactored form submission
- Added ability to schedule a post at a specified time

* **Bug Fixes**:
- Some forms complained they could not contact the server
- Removed slashes from meta keys explicitly
- Stopped causing blank posts from being created
- Fixed various bugs in time of posting

## 1.0.18 (2018.03.26)

* **Bug Fixes**:
- Upgraded Pixabay API to match remote changes

## 1.0.17 (2018.03.23)

* **Bug Fixes**:
- Fixed conflict with WordFence

## 1.0.16 (2018.03.15)

* **Enhancements**:
- Added eternal scrolling to recent posts
- Added release notes within the Soup 

## 1.0.15 (2018.02.23)

* **Enhancements**:
- Less than 100 words in a post warn and make pending in soup
- Validate for Re-used Title
- Validate for no Image
- Improved Featured Image handling (inserting new media)
- Added Local Preview
- Added Autosave 
- Added Lat & Long to post
- Added tags for magazines
- Added Synchronising one at a time
- Made Social service check report correctly
- Added "View in Soup" to each post
- Enabled multiple categories
- Added syndicated status to posts (View in Soup only if synced)
- Change the Create title text to 'Edit' when appropriate
- Allow editing published posts
- Change the Create title text to show if published
- Added margin below magazine tags

* **Bug Fixes**:


## 1.0.14 (2018.01.09)

* **Bug Fixes**:
  - Removed "You have no properties" error on plugin update

## 1.0.12 (2018.01.06)

* **Bug Fixes**:
  - Removed attempt to force synchronization

## 1.0.11 (2018.01.06 )

* **Bug Fixes**:
  - Removed synchronisation for stability
  - Improved Password setting

## 1.0.9 (2018.01.03)

* **Bug Fixes**:
  - Connect password issues fixed

## 1.0.8 (2017.12.31)

* **Enhancements**:
  - Improved automatic tags
  - Automatically set Geo of all posts to first properties location
  - Only posts with a featured image get syndicated
  - Historic posts automatically syndicated
  - Improved connect->service checks

* **Bug Fixes**:
  - Manually created posts now syndicate properly
  - Vacation Soup posts saved as draft for review now syndicate
  - Stopped suplicate posts appearing in the soup
  - Stopped featured image being dropped when editing a post
  - Fixed bug in enabling re-synch buttton after completion
  - Fixed bug in synchronising old posts without images

## 0.2.13.1 (2017.12.21)

* **Bug Fixes**:
  - Corrected instructions

## 0.2.13 (2017.12.21)

* **Enhancements**:
  - Removed Google Maps dependency


## 0.2.12 (2017.12.20)

* **Enhancements**:
  - Added Latitude & Longitude to Destinations and Posts
  - Coloured required fields when being redirected for user input

* **Bug fixes**:
  - Removed duplicate destinations from Create screen caused by multiple properties at destination
  - Fixed UI fault when topics used up
  - Added Southern latitudes to Geography

## 0.2.11 (2017.12.03)

* **Enhancements**:
  - Added Category selector to new posts
  - Added multiple category select on create
  - Prefill password field effect

* **Bug fixes**:
  - Fixed fault that incorrectly handled quotes in house names (etc), as in Life O'Reilly
  - Fixed fault with Destinations not handling non-latin characters (as in São Paulo)
  - Fixed validation error when adding a second property
  - Corrected registration link on connect page
  - Fixed error in adding 3rd image as featured

## 0.2.10 (2017.11.22)

* **Bug fixes**:
  - Tags syndicating to Soup Kitchen correctly
  - Scheduled posting error fixed for exact dates
  - Improved links between kitchen and waiter

## 0.2.9 (2017.11.14)

* **Bug fixes**:
  - Fixed featured images from non-pixabay sources
  
## 0.2.8 (2017.11.05)

* **Bug fixes**:
  - Fixed posting fault labelled get_extra_permastruct
  - Fixed Syndication
  - Fixed erroneous path/url assumptions
  - Fixed erroneous saving of posts
  
## 0.2.7 (2017.11.04)

* **Bug fixes**:
  - Type coercion errors fixed
  
## 0.2.5 (2017.11.04)

* **Bug fixes**:
  - Improved Sanitisation, issues identified by WordPress team
  - Improved namespace polution, identified by WordPress team
  
## 0.2.4 (2017.11.04)

* **Enhancements**:
  - Wordpress Directory additions
  
## 0.2.3 (2017.11.02)

* **Enhancements**:
  - Added hyperlink to registration in connect
  
## 0.2.2 (2017.10.30)

* **Enhancements**:
  - Added Done button to most tabs, to improve flow
  - Force validation when clicking done
  - Added required* on necessary fields

* **Bug fixes**
  - Corrected auto-navigation of tabs on setup
  - Not displaying owners name on owners tab correctly
  - Re-added password field on connect screen

## 0.2.1 (2017.10.27)

* **Enhancements**:
  - Removed Social Connectors
  - Added alternate destination names

## 0.2.0 (2017.10.25)

* **Bug fixes**:
  - Fixed several errors related to handling a new (or empty) Kitchen

* **Enhancements**:
  - Made connect responsive
  - Syndicating Featured Image
  
## 1013.80 target (2017-10-09)

* **Enhancements**:
  - Removed Dashboard Tab
  - Reduced Card Title font-weight to normal (not bold, or 600)
  - Fixed occasional error alert on create, caused by ajax and page refresh clashing

## 1009.84 (2017-10-09)

* **Enhancements**:
  - Improved Service Check UI, and made it asynchronous
  - Added destination selection to Create Post
  - Added refresh button to Trending Searches to see more
  - Retain same topic list when changing destination on Create screen
  - Cleaned up Create layout & made responsive

## 1008.86 (2017-10-08)

* **Bug fixes**:
  - Fixed critical faults causing Waiter\property class not found, and PHP errors

## 1007.86 (2017-10-07)

* **Bug fixes**:
  - Fixed bug causing errant behaviour when clicking motd
  - Fixed visible input fields in social-container when not editing
  - Fixed some intermittent errors in new account creation
  - Fixed portrait images being available from Pixabay
  - Made Create Post featured Image responsive

* **Enhancements**:
  - Added auto-installer for Timber
  - Added installation instructions
  - Added simple service checks to connect tab
  - Enabled replacing the featured image by clicking on it
  - Moved Kitchen endpoint to core.vacationsoup.com
  - Implemented message of the day (MOTD) served from core
  - Implemented Trending Topics served from core
  - Refactor out old context code
  - Persist Post Topics and exclude from trending
  - Added VacationSoup as an autoTag example

## 1002.90 (2017-10-02)

Test release - not for consumption

## 0929.94 (2017-09-29)

Initial release for UI testing

* **Bug fixes**:
  - Lots and lots

* **Enhancements**:
  - Too many to mention
  
