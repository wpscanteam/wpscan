# CHANGELOG GC Testimonials to Testimonial Widget

## master

## 1.3.1
* Update store branding

## 1.3.0
* Change branding from Aihrus to Axelerant
* Require Testimonials Widget 3.1.0
* Update copyright text
* Update import verbiage
* Update plugin name

## 1.2.2
* Disallow activation when required plugins aren't activated
* Require Aihrus 1.1.0
* Require Testimonials Widget 2.19.0
* Update Aihrus integration
* Update copyright year

## 1.2.1
* Change `self::notice_updated` to `aihr_notice_updated`
* Require Testimonials by Aihrus 2.18.1
* Revise Plugin Name: Testimonials – GC Testimonials Migrator
* Use Codeship.io than Travis CI

## 1.2.0
* Allow activation with Testimonials Premium
* Move ci to tests
* Move CSS to assets
* Move files to assets
* Move lib to includes/libraries
* Move main class to own class file
* Remove Travis config
* Revise required file paths
* Revise required_once for Aihrus Framework
* Specify a “Text Domain” and “Domain Path”
* Use $plugin_assets than $plugin_path

## 1.1.2
* RESOLVE load precedence issue

## 1.1.1
* Branding update
* BUGFIX Disable donate doesn't work
* BUGFIX Fatal error due to inactive REQ_BASE via old Aihrus Framework
* Show premium link when its not activated
* Use Aihrus Framework 1.0.1
* Use aihr_check_aihrus_framework

## 1.1.0
* Convert TODO to https://github.com/michael-cannon/gc-testimonials-to-testimonials/issues
* Implement PHP version checking
* Implement WordPress version checking
* Revise readme installation
* Revise readme structure
* Tested up to 3.9.0

## 1.0.4
* Update Aihrus framework

## 1.0.3
* Update Aihrus framework

## 1.0.2
* Check for PHP 5.3
* Move screenshots to SVN assets

## 1.0.1
* Add screenshot 1. GC Testimonials to Testimonials Settings
* Add screenshot 2. GC Testimonials to Testimonials Migrator
* Rename do_something to migrate_item
* Update Aihrus Framework
* Use common helper add_media

## 1.0.0
* Initial code release 

## 0.0.0
* $this to __CLASS__
* Abstract get_posts_to_process method
* Add Ajax processing screen
* Add EDD_SL_Plugin_Updater.php
* Add LICENSE
* Add StillMaintained.com notice
* Add [[gallery]]
* Add action `gct2t_update`
* Add aihrus framework
* Add and highlight video introduction
* Add licensing helper
* Add post_id to do_something
* Add settings help tabs
* Add shortcode `gc_testimonials_to_testimonials_shortcode`
* Add trim validator
* Add widget template
* Adjust load priority to support other plugins tying in
* Allow blank NEW_* settings
* Baseline API
* Baseline readme.txt tags
* Centralize styles/scripts handling
* Change $2 donation request to $5
* Check for sections() and settings() as needed
* Comment out init() by default
* Correct Youtube video linking
* Correct cbqe_ options tagging
* Delete prepare script on run
* Don't auto-delete prepare script
* Enable activation and version checking
* Enqueue jquery-ui-progressbar
* Full stack developer verbiage
* Minimally require WordPress 3.5
* Prevent unwanted slug__ naming
* Purge excess code
* Rename `gc_testimonials_to_testimonials` to `wps` for action and filter names
* Revise headers
* Revise installation instructions
* SEO tweaks
* Simplify `wp_enqueue_style` handling
* Simplify filter naming
* Support base and slug settings
* Test hphpa
* Tested up to: 3.8.0
* Travis ignore WordPress.WhiteSpace.ControlStructureSpacing - false positives
* Tweaks titles
* Update POT
* Update Travis
* Update about image path
* Update donate text
* Use abstract class Aihrus_Settings
* Use abstract class Aihrus_Widget
* Use do_load
* Use static for $admin_page
* Use str_getcsv
* apt-get update
* https jQuery transport