# CHANGELOG - Flickr Shortcode Importer

## master

## 2.2.3
* Changed support email address to support@axelerant.com
* Confirm WordPress 4.7.2 compatibility
* Removed stillmaintained.com project status button
* Require Aihrus Framework version 1.2.9
* Update Axelerant FAQ links

## 2.2.2
* Samples text update
* Update readme verbiage
* Update requirements

## 2.2.1
* Require Aihrus Framework version 1.2.2
* Update store branding

## 2.2.0
* Aihrus Framework version 1.2.0
* RESOLVE static referencing of $this->flickset_id
* Update branding to Axelerant
* Update file headers
* Update tests

## 2.1.1
* Clean up 2.0.3 directories from SVN
* RESOLVE Bulk import [flickr] shortcoded media
* RESOLVE Check for photo data '_content' field
* RESOLVE Return no content in case getPhotoInfo fails

## 2.1.0
* Add option Set Descriptions
* Aihrus Framework version 1.1.4
* Clean up FAQ
* Convert TODO to https://github.com/michael-cannon/flickr-shortcode-importer/issues
* Correct [ gallery] tag inclusion
* RESOLVE PHP Strict Standards:  call_user_func_array() expects parameter 1 to be a valid callback, non-static method Flickr_Shortcode_Importer::activation() should not be called statically
* RESOLVES #3 After importing via post "Import [flickr] content", it's not unchecked
* RESOLVES #4 Import of image description
* RESOLVES #5 https URLs fails
* RESOLVES #6 Migrate from FlickrManager fails?
* RESOLVES dan-coulter/phpflickr#38 unexpected 'unset'
* Revise readme installation
* Revise readme structure
* Specify a “Text Domain” and “Domain Path”
* Update file structure
* Update [PHP Wrapper for the Flickr API](https://github.com/dan-coulter/phpflickr)
* Use Codeship.io than Travis CI

## 2.0.3
* Correct support forums location
* transformmed > transformed

## 2.0.2
* Simplify `wp_enqueue_style` handling

## 2.0.1
* Add media ids to gallery shortcode insertion
* Add screenshot 14. Imported [flickr-gallery] photoset as [gallery] with media ids
* Change $2 donation request to $5
* Revise ci rules
* Travis ignore WordPress.WhiteSpace.ControlStructureSpacing - false positives
* Update &$this to $this
* Update bio
* Use https jQuery transport

## 2.0.0
* Add setting options for Flickr User ID and Images Per Page
* Coding standards updates
* Correct fsi_get_option call
* Correct label for "Import [flickr] content" checkbox
* Correct settings URL
* Escape HTML in localizations as needed
* Include [flickr-gallery] in Ajax importing
* Migrate code to updated framework
* Remove "Compatiblity" verbiage
* Remove blank descriptions from settings options
* Remove mention of premium version
* Remove most `debug_mode` checks
* Rename WP_AJAX call
* Update API
* Update CHANGELOG and TODO content
* Update POT
* Update import examples
* Update progress bar scripts and styles
* Update readme verbiage
* Use `empty` vs. `isset` checks

## 1.8.1
* Author URL update
* Copyright year update
* TODO Add media ids to gallery shortcode insertion
* Update POT

## 1.8.0
* Aihrus branding
* `fsi_save_post` condition check
* Remove in2code reference

## 1.7.11
* Init internal post_types
* Debug import routine via [ponyandmeow.com](http://ponyandmeow.com/)
* Detect for no photos in flickrset

## 1.7.10
* Post type value bug fix

## 1.7.9
* Support custom post types
* Revise admin_init to init with is_admin check

## 1.7.8
* Use admin_init

## 1.7.7
* Post [flickr] Import Widget? - Thank you Roy Halpin for the idea

## 1.7.6
* Check if function_exists for add_screen_meta_link

## 1.7.5
* Use Flickr photo id than src to consistently reload imports as needed

## 1.7.4
* Add update_fsi_options function
* Turn off force_reimport after usage
* Further test and review force_reimport 

## 1.7.3
* Fix licensing relations

## 1.7.2
* Consistent `Photo by ` text string
* Rearrange attribution_link and attribution_text
* screen-meta-links endif fix
* Revise Reset heading verbiage
* Reorder options
* Enable license appending to image description
* Add image reimport option
* Make okay for WordPress 3.3

## 1.7.1
* Keep Import [flickr] content checked in page/post edit screens

## 1.7.0
* Enable importing from edit page and post screen
* Add screenshot 13

## 1.6.1
* Import Flickr video - optional rendering as video/object/embed tag using Flickr src or locally
* Add option Replace Filename with Image Title?
* Add option Image Import Size
* Reorder settings slightly
* Update settings verbiage
* Give fsi_get_options default option
* Set class description for checkbox labels
* Add option Image Link Size
* Add option Link Image to Attachment Page?
* Set fsi_get_options defaults where applicable
* Clean up options
* Remove option Image Link Size - redundant
* Add [flickr-gallery] screenshot
* Add image wrap and attribution screenshot

## 1.6.0
* Remove repeated comment
* CHANGE Don't remove first [flickr] from post by default
* Support [flickr]flickr URL[/flickr] shortcodes
* Revised video importing - Imported swf videos are no-go
* Source formatting
* Add option Skip Importing Videos

## 1.5.3
* Add add_theme_support( 'post-thumbnails' )
* Display more debug
* Verbiage updates

## 1.5.2
* Import [flickr-gallery mode="photoset" photoset="72157626986038277"] shortcode content
* Import [flickr-gallery mode="tag" tags="typo3" tag_mode="all"] shortcode content
* Import [flickr-gallery mode="interesting"] shortcode content
* Import [flickr-gallery mode="recent"] shortcode content
* Import [flickr-gallery mode="search" tags="barcamp" group_id="431412@N25"] shortcode content

## 1.5.1
* Reduce find tag greediness

## 1.5.0
* Pull in largest original source when no original secret or format exists
* Update POT

## 1.4.9
* Update languages

## 1.4.8
* Fix reset operations

## 1.4.7
* Include media and author image

## 1.4.6
* Enable Image Wrap Class 
* Enable Attribution
* skip_importing_post_ids validate for integer CSV
* Use Flickr username for backlink 

## 1.4.5
* Adapt for staticflickr.com URL

## 1.4.4
* Validate CSV input
* Options > Settings verbiage update 
* Create top right meta links between options and import screens
* Sectionalize settings
* Create flickr link in description?
* Enable debug mode
* Edit flickr link text

## 1.4.3
* Add option Set own Flickr API key

## 1.4.2
* Add option Posts to Import
* Add option Skip Importing Post IDs...
* Add screenshots 9 & 10 for Before & After Flickr Shortcode Importer for Flickr-sourced A/IMG Tag

## 1.4.1
* Add A/IMG, Warning and FAQ updates readme
* Resolve http://wordpress.org/support/topic/flickr-shortcode-importer-plugin?replies=3#post-2283617

## 1.4.0
* Production worthy

## 1.3.5
* Rename ChangeLog to changelog.txt
* Convert Flickr sourced IMG to [flickr]

## 1.3.4
* Check for camera given photo title
* html_entity_decode photo description
* Update Options screenshot
* Put progress for a/img to shortcode conversion - moved convert_flickr_sourced_tags() into ajax_process_shortcode()
* Update readme verbiage

## 1.3.3
* Add option Default A Tag Class

## 1.3.2
* Properly call cbMkReadableStr

## 1.3.1
* Update plugin description

## 1.3.0
* Fix over zealous replacement of content for A/IMG tag to [flickr] conversion
* Use cbMkReadableStr to pretty print media filenames as a title as needed
* Update Options screenshot
* Replace preg_match_all with explode and preg_match to handle single line of many A/IMG tags
* Line break after shortcodes to ensure proper reading by WordPress
* Add option Default Image Alignment
* Add option Default Image Size
* Add warnings to readme
* Import Flickr-based A/IMG tags
* Set get_shortcode_size default to medium
* Add Estimated time required to import notice

## 1.2.0
* Add option Set Captions
* Add option Force Set Featured Image
* Add option Make Nice Image Title?
* Allow 2 minutes per photo import before timing out
* Add Flickr Shortcode Importer before & after screenshots for [flickrset]
* Import [flickrset] shortcode content

## 1.1.0
* Add Flickr Shortcode Importer Options screenshot
* Add option Remove First Flickr Shortcode
* Add option to setting Featured Image or not
* Add import page link to options page
* Add conversion limit option
* Polish up About Flickr Shortcode Importer section
* Add text domain
* Rename class.settings.php to class.options.php
* Add [flickr] Options link to [flickr] Import page
* Add icon to [flickr] Import page
* Flickr Shortcode Importer Options page added
* [flickr] Options linked from Plugins
* Update pot file
* Remove old settings file
* Use Alison Barret's class My_Theme_Options
* Add ob_settings.php options page helper for using Settings API
* TODO video import
* Backup or reversion reminders

## 1.0.1
* Replace duplicate lookup by guid with _flickr_src in postmeta
* RenderVideo via FlickrManager code
* Remove [flickr] lookup LIMIT

## 1.0.0
* Initial release for production use

## 0.1.0
* Initial release for production testing
* Prep for further production testing;
* Remove import LIMIT;
* Turn off duplicate handling due to being unable to process guid setting or recall;
* Remove unused helper files;
* Add screenshots;
* Set version 0.1.0;
* Correct featured image setting and first_image removal handling;
* Prevent duplicate [flickr] imports;
* Revise readme content;
* Handle featured image setting;
* Remove first [flickr] from post_content;
* Correct [flickr] replacement for attachment links
* Load phpFlickr;
* In test mode;
* Verbiage updates;
* Process shortcode via do_shortcode;
* Readme thank you
* Update method names for FSI;
* Remove unused methods;
* Begin post pulling with [flickr];
* Set 5-minute time limit per post;
* Update verbiage for FSI usage
* UL shortcode samples
* Update for coding standard;
* Disallow production use
* Set version 0.0.0
* Domain text;
* Add language
* Don't Use Text
* Add PHPFlickr library;
* Add FlickManager reference
* Update verbiage to Flickr Shortcode Importer;
* Ignore options for now

## 0.0.1
* Initial code release 