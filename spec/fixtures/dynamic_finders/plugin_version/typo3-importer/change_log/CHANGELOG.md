# CHANGELOG - TYPO3 tt_news Importer

## 2.3.3
* Change FAQ link
* Change Donate link
* Confirm WordPress 5.0 compatibility
* Fix PHP7 compatibility issue

## 2.3.2
* RESOLVE #6 Error: Unable to connect to the database

## 2.3.0
* Add tests
* Change copyright text
* Update branding to Axelerant

## master
* Add CHANGELOG and CONTRIBUTING documents
* Convert TODO to https://github.com/michael-cannon/typo3-importer/issues
* Revise readme structure
* Specify a “Text Domain” and “Domain Path”
* Update POT

## 2.2.2
* Author URL update
* Update POT

## 2.2.1
* Copyright year update
* Include media ids in gallery code
* Log imported files option
* Use curl than file_get_contents

## 2.2.0
* Add Categories to Import - Thank you [FPJQ](http://fpjq.org/)
* Add filter `t3i_prepare_content` - Thank you [FPJQ](http://fpjq.org/)
* Decode Entities? - Thank you [FPJQ](http://fpjq.org/)
* Call initialization methods when needed, than always
* Skip URL check
* Update POT
* Verbiage cleanup

## 2.1.0
* Aihrus branding 

## 2.0.6
* Disable admin_init

## 2.0.5
* Use admin_init

## 2.0.4
* Added error messaging for incorrect News WHERE Clause
* Added database connection validation
* Update contact/donate information

## 2.0.3
* Add User-Agent for TYPO3 website check
* screen-meta-links endif fix
* Make okay for WordPress 3.3
* Insert and Update posts

## 2.0.2
* Fix Settings reset
* Update languages

## 2.0.1
* Installation directions update
* Revise readme description
* Update TODOs
* Import meta keywords and descriptions for All in One SEO, Bizz themes, Headspace2, Thesis and Yoast's WordPress SEO
* Update Options > Settings verbiage
* Update TYPO3 tt_news Importer verbiage
* Set default author
* Enable debug mode to handle news_to_import directly for testing purposes 
* Ignore file:// sources, they're none existant except on original computer
* Apply display none to images with file:// based source
* Update text domain and language files

## 2.0.0
* Remove TYPO3 tx_comments approved requirement
* Add askimet_spam_checker to comment importing
* Position gallery shortcode in post content
* Position more links in post content
* Disallow single image galleries
* Migrate importing to one-at-a-time model
* Separate import and option screens
* Configure related files and links header text, tag and wrapper
* Enable custom news WHERE & ORDER clause
* Enable specific news uid import/skip
* Require TYPO3 access fields
* Check that TYPO3 site exists on Website URL
* Import related comments during each news import
* Remove comment threading since TYPO3 didn't support it
* Update screenshots
* Create users with emails based upon author name and domain if no email given
* Don't create users for authors with no email or name
* Create top right meta links between options and import screens
* Make best attempts to not duplicate authors as users
* Set keywords and descriptions for All in One SEO Pack

## 1.0.2
* Update description

## 1.0.1
* Update Changelog

## 1.0.0
* Update TYPO3 tt_news Importer settings screenshot
* update CHANGELOG
* Add force_private_posts(), Great for when you accidentially push imports live, but didn't mean to;
* Remove excess options labels
* fix options saving
* Force post status save as option; Select draft, publish and future statuses from news import; Set input defaults;
* Clarify plugin description; Add datetime to custom data; remove user_nicename as it prevents authors URLs from working;
* remove testing case
* prevent conflicting usernames
* update Peimic.com plugin URL

## 0.1.1
* set featured image from content source or related images
* seperate news/comment batch limits
* CamelCase to under_score
* rename batch limit var
* lower batch limit further, serious hang 10 when doing live imports
* lower batch limit due to seeming to hang
* correct plugin url
* revise recognition
* Validate readme.txt
* Inital import of "languages" directory
* add license; enable l18n

## 0.1.0
* Initial release
