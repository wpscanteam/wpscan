CHANGELOG
=========
## 1.3.9
* Added possibility to create new posts
* Added option `add_new` (true/false) which sets whether to enable creating new

## 1.3.8
* Fixed bug where pasting regular content would cast a TypeError and stop executing
* Fixed Notice when on 404 page

## 1.3.7
* Removed class requirement on auto config
* Added full ACF support

## 1.3.6
* Added option `init_on_load` to set Fronted loading behavior
* Added filter `save_extra_data`
* Added filter `autosave_extra_data`
* Added more specificity to 3rd party libraries to avoid css conflicts
* Changed so that 3rd party javascript libraries will be enqueued separately
* Fixed p-tags being inserted in auto configured post_title
* Fixed post revisions not honoring the constant `WP_POST_REVISIONS`

## 1.3.5
* Added automatic config of `post_content`, `post_title` and `post_thumbnail` if no settings are set __requires editable contents to be in a wrapping container with class `hentry` like `<article class="hentry"><h1 class="entry-title"></h1><div class="entry-content"></entry-content></article>`__, can be turned off by setting `auto_configure` to `false`
* Added option `auto_configure`
* Added check/set post locks
* Removed [plugin-update-checker](https://github.com/YahnisElsts/plugin-update-checker) in favor for the official plugin repo

## 1.3
* Added [Shortcake](https://github.com/fusioneng/Shortcake) integration (__requires Shortcake v0.6.0__)
* Added ability to send boolean through `permission` setting (see issue [#17](https://github.com/jesperbjerke/wa-fronted/issues/17))
* Added ability to set capability as `permission` setting
* Added logged in session check
* Added ability to edit custom excerpt
* Changed page reload after save to show notification toast instead
* Changed when scripts are loaded so we only need to check for options once
* Changed `wpautop` in TinyMCE to `false` to avoid getting shortcode html comments wrapped in p-tags
* Fixed revisions not sorted by date properly
* Fixed shortcode rendering and binding when stepping through revisions
* Fixed autosaving running even though post is already saving

## 1.2.1
* Added button to remove shortcode
* Added action `wa_fronted_footer_scripts`
* Added modifications to support [Shortcake](https://github.com/fusioneng/Shortcake) integration
* Changed a select2 selectors to be more specific in order to avoid conflicts

## 1.2
* Added CTRL + click link in editor to open in new tab/window
* Fixed shortcodes not being filtered on save
* Fixed shortcode edit button not binding on load
* Fixed gallery images triggering resize handles and image toolbar
* Fixed gallery not being rendered on insert
* Fixed gallery editing and shortcode binding

## 1.1
* Switched Medium Editor to TinyMCE in order to be closer to WP Core
* Added filter `featured_image_toolbar`
* Added filter `on_tinymce_setup`
* Added option `shortcodes`
* Changed filter `medium_extensions` to `editor_plugins`
* Changed options saved to session to be saved to WA_Fronted::options instead
* Changed so that WA_Fronted::$options is not JSON encoded until it's sent to javascript
* Fixed issue [#13](https://github.com/jesperbjerke/wa-fronted/issues/13)
* Fixed faulty compilation of options based on field types

## 1.0
* Fixed shortcode edit and image edit toolbar taking up space in footer
* Fixed problem with image dragging and showing the image edit toolbar
* Fixed shortcodes not rendering when showing revisions
* Fixed a few CSS kinks
* Fixed image align left and center
* Made an [online demo](http://fronted.westart.se)

## 0.9.5
* Added autosaving
* Added filter `wa_fronted_get_autosave`
* Added filter `wa_fronted_autosave_data`
* Added filter `wa_get_js_i18n`
* Added translation function for javascript
* Added ability to edit rendered shortcodes
* Added filter `shortcode_actions`
* Added action `shortcode_action_{shortcode base}`
* Fixed faulty regex in `wa_render_shortcode`
* Fixed faulty regex in `filter_shortcodes` if there were multiple occurrences of the exact same shortcode
* Fixed faulty regex in `unfilter_shortcodes`

## 0.9.1
* Updated Medium Editor to 5.8.3
* Fixed typo in the PHP version check
* Cleaned up and restructured README.md for 1.0 release
* Added javascript and php function reference to the Wiki
* Added extension how-to guide to the Wiki

## 0.9
* Added ability to set post parent to hierarchical post types
* Added ability to drag image to move it within the editable area
* Added PHP version check before init
* Made the image upload button into an extendable toolbar element
* Added javascript filter `image_upload_toolbar`
* Added javascript filter `image_edit_toolbar`
* Added [Rangy](https://github.com/timdown/rangy)
* Updated Plugin Update Checker to master branch

## 0.8.5
* Added support for adding/managing taxonomies, categories and tags
* Added post revision handling
* Added php filter `wa_fronted_revisions`
* Added javascript filter `revision_content`
* Added javascript filter `revision_db_value`
* Changed jQuery UI selectmenu to [select2](https://select2.github.io/)
* Moved documentation to Wiki

## 0.8
* Updated Medium Editor to 5.8.2
* Updated Tipso to 1.0.6
* Added ability to save data to wp_options table
* Added trim() before saving content to remove excessive whitespace
* Ability to set default options in posttype-level of array
* Styled checkboxes in settings modal

## 0.7.5
* Updated Medium Editor to 5.8.1
* Added multiple `output_to` support
* Added support for writing shortcodes
* Added toolbar button `renderShortcode`
* Fixed some toolbar buttons not being rendered
* Fixed issue where image with caption would not render if inserted without selection
* Fixed issue with aligning/editing/removing images with caption

## 0.7
* Added choice-based fields (enables dropdown select to choose between values to insert) for custom fields
* Added support for ACF fields: `select` and `radio` 
* Added ability to omit `selector` and only set `attr` in `output_to` to target the editor element
* Removed fatal error trigger if no configuration filter found (plugin will just not initialize instead)
* Changed link to Editus (formerly known as Lasso) in README.md
* Fixed issue where the ACF-edit button would be replaced by new content after save

## 0.6.5
* Added native custom field support
* Fixed faulty logic in validation settings in ACF field type switch

## 0.6.1
* Updated Medium Editor to 5.7.0
* Added basic RTL support

## 0.6
* Updated Medium Editor to 5.6.3
* Added file-api to modernizr
* Added image upload by dropping image to the editable area
* Changed jQuery UI resizable to custom function instead (problems with unnecessary bloated markup and css added by jQuery UI)
* Fixed issue with getting proper image size of square images when resizing
* Performance improvements of image resizing
* Added `cleanPastedHTML : true` to medium-editor to fix ugly markup when copying and pasting html
* Added image toolbar when clicking on image, mimicking toolbar in tinymce

## 0.5
* Updated Medium Editor to 5.6.2
* Added Sale price scheduling for WooCommerce
* Added live validation
* Added option `paragraphs`
* Added option `validation`

## 0.4.5
* Updated Medium Editor to 5.6.1
* Added WooCommerce support (as another core extension)
* Added filter `supported_woo_fields`
* Added filter `wa_fronted_settings_fields`
* Added ability to set post as featured
* Added ability allow/disable comments
* Fixed faulty nonce sent through Ajax

## 0.4
* Updated Medium Editor to 5.6.0
* Refactored `wa-fronted.php` and `scripts.js`, separating ACF functions into a core extension
* Added extendability to the javascript object, curtesy of ACF, (mimics wp hooks in PHP like `add_action` and `add_filter`)
* Added editor option `native`
* Changed how `acf_form()` would save since it stopped submitting through Ajax
* Fixed issue where editor toolbar would not respect options since Medium Editor changed `disableToolbar`
* Fixed issue where specific `output_to` would not search within the container element

## 0.3.1
* Updated Medium Editor to 5.5.3

## 0.3
* Updated Plugin Update Checker to 2.2
* Changed action hooks `wa_before_fronted_scripts`, `wa_after_fronted_scripts` to `wa_fronted_before_scripts`, `wa_fronted_after_scripts` (to respect a more uniform naming standard of hooks)
* Added settings modal with options to change different post settings
* Added nonce validation to ajax post save
* Added action hook `wa_fronted_settings_form`
* Added action hook `wa_fronted_settings_modal_footer`
* Added action hook `wa_fronted_settings_form_save`
* Added filter `wa_fronted_settings_values`

## 0.2
* Added support for featured image
* Disabled and moved unnecessary functions if not logged in and not on frontend
* Added unsaved changes warning if leaving page
* Added action hook `wa_fronted_toolbar`

## 0.1.2
* Removed submodule link of plugin updater

## 0.1.1
* Added updating functionality through github, curtesy of [YahnisElsts](https://github.com/YahnisElsts/plugin-update-checker), as well as automatic background updates
* Added oEmbed support (automatic conversion of valid oEmbed)
* Updated Medium Editor to 5.5.1
* Save options to session, reducing loading/compiling

## 0.1
* First public release