# CHANGELOG - Edit Flow for Custom Bulk/Quick Edit

## master

## 1.4.0
* Remove activation helpers
* Confirm WordPress 4.7.2 compatibility
* Fix coding standards for CI
* Remove `ProjectStatus` button by stillmaintained.com from readme file
* Update FAQ links url
* Update support email address

## 1.3.1
* Update store branding

## 1.3.0
* Change brand name from Aihrus to Axelerant
* Require Custom Bulk/Quick Edit 1.6.0
* Revise plugin name
* Update copyright
* Update file headers

## 1.2.1
* Require Custom Bulk/Quick Edit 1.5.1
* Update Aihrus Framework integration
* Update copyright

## 1.2.0
* Move main class to includes
* Remove Aihrus Framework loading during requirements checking
* Require Custom Bulk/Quick Edit 1.5.0
* RESOLVE Doesn't activate with premium plugin
* Specify a “Text Domain” and “Domain Path”
* Update file structure
* Use Codeship.io than Travis CI

## 1.1.1
* BUGFIX Inactive REQ_BASE due to old Aihrus Framework
* Use Aihrus Framework 1.0.1

## 1.1.0
* Bring in Aihrus Framework
* Convert TODO to https://github.com/michael-cannon/cbqe-edit-flow/issues
* Correct meta key save and viewing for BUG #7
* Create constants out of requirements
* Current configurations could be lost during upgrading. Please copy your Edit Flow field configuration data to someplace safe to make restoration easy. The underlying custom field key naming structure has changed to support Edit Flow 0.8.0.
* Disable purchase premium links if premium is active
* FEATURE #6 Enable donate_notice
* Implement WordPress version checking
* RESOLVE #1 On delete error
* RESOLVE #2 On activate error - no cbqe free installed
* RESOLVE #4 Ensure single instance of item
* RESOLVE #7 Update fields from EF taxonomy directly
* RESOLVE #8 Save EF field per type
* RESOLVE #9 Time not supported in date editing
* RESOLVE Donate notice shows after saving settings
* RESOLVE No notices on deactivation
* Remove unused methods
* Revise readme structure
* Separate checking for active plugins and PHP from plugin versions
* Simplify class constants
* Tested up to 3.9.0
* Update readme regarding buy Premium for date and numeric fields
* Use premium link constant
* WONTFIX #3 Not needed
* WONTFIX #5 Needed

## 1.0.2
* Move screenshots to SVN assets

## 1.0.1
* URL updates

## 1.0.0
* Add screenshot 1. Edit Flow field settings
* Add screenshot 2. Quick Edit of Edit Flow attributes
* Add screenshot 3. Bulk Edit of Edit Flow attributes
* Load Edit Flow customizations from Custom Bulk/Quick Edit Premium

## 0.0.1
* Initial code release (with WordPress SEO basis, needs Edit Flow)