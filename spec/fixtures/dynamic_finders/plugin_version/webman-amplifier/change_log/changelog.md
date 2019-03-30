# WebMan Amplifier Changelog

## 1.5.7

* **Fix**: Issue when custom metabox not displaying on new post edit page

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/metabox/class-metabox.php


## 1.5.6

* **Add**: New WordPress 5.0 post type labels
* **Update**: Improving compatibility with WordPress 5.0 (Gutenberg editor)
* **Fix**: Metabox tabs conditional switching upon page template change
* **Fix**: PHP error thrown by metabox functionality in admin posts list
* **Fix**: Shortcodes pagination on website homepage

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/metabox/class-metabox.php
	includes/metabox/fields/sections.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/testimonials.php
	languages/webman-amplifier.pot


## 1.5.5

* **Fix**: Compatibility with WordPress 5.0

### Files changed:

	changelog.md
	class-wm-amplifier.php
	readme.txt
	webman-amplifier.php
	includes/metabox/class-metabox.php
	includes/visual-editor/visual-editor.php


## 1.5.4

* **Fix**: Compatibility with WooSidebars

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/compatibility/compatibility.php


## 1.5.3

* **Fix**: Compatibility with WPBakery Page Builder (Visual Composer)

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/definitions/definitions.php


## 1.5.2

* **Fix**: Compatibility with most Beaver Builder 2.0.4

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/definitions/partial/accordion.php
	includes/shortcodes/definitions/partial/tabs.php


## 1.5.1

* **Fix**: PHP error when loading Visual Composer compatibility file

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/class-shortcodes.php


## 1.5.0

* **Update**: Making custom Beaver Builder elements translatable with WPML plugin
* **Update**: Improving code and its organization
* **Update**: Plugin information

### Files changed:

	changelog.md
	class-wm-amplifier.php
	readme.txt
	webman-amplifier.php
	includes/compatibility/compatibility.php
	includes/compatibility/wpml/*.*
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/*.*
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/renderers/accordion.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/item.php
	includes/shortcodes/renderers/message.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/price.php
	includes/shortcodes/renderers/row.php
	includes/shortcodes/renderers/slideshow.php
	includes/shortcodes/renderers/tabs.php
	includes/shortcodes/renderers/testimonials.php
	includes/visual-editor/visual-editor.php


## 1.4.11

* **Fix**: Do not override shortcodes scripts enqueuing when `slick` is in array

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/class-shortcodes.php


## 1.4.10

* **Fix**: Issue introduced in version 1.4.9

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/class-shortcodes.php


## 1.4.9

* **Fix**: Visual Composer compatibility

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/class-shortcodes.php


## 1.4.8

* **Fix**: Carousel item wrapper custom class not applying

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	assets/js/shortcode-posts-slick.js


## 1.4.7

* **Update**: Improving accessibility

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/item.php


## 1.4.6

* **Fix**: Beaver Builder Agency super-admin screen integration

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/class-shortcodes.php


## 1.4.5

* **Fix**: Beaver Builder admin screen integration

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/class-shortcodes.php


## 1.4.4

* **Fix**: `wma_meta_option()` function premature output filter

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/functions.php


## 1.4.3

* **Add**: Option to sort all posts shortcodes output by menu order
* **Add**: Compatibility for Jeptack Sitemaps for Projects, Staff and Testimonials custom post types
* **Update**: Default posts count shortcode attribute set to specific number instead of `-1`
* **Update**: Localization instructions
* **Update**: Improving accessibility: changing all remaining <i> icons to <span> with aria-hidden attribute
* **Fix**: Subnav widget title displaying HTML tags

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/item.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/testimonials.php
	includes/widgets/w-module.php
	includes/widgets/w-subnav.php
	languages/*.*


## 1.4.2

* **Fix**: Make `empty()` work with old PHP versions

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/message.php


## 1.4.1

* **Add**: Notification text of empty shortcode/page builder module output
* **Update**: Improved custom post types and their compatibility with WordPress admin tables
* **Update**: Localization
* **Fix**: Compatibility with Visual Composer plugin
* **Fix**: Do not display empty metaboxes

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/metabox/class-metabox.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/renderers/accordion.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/message.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/table.php
	includes/shortcodes/renderers/tabs.php
	includes/shortcodes/renderers/testimonials.php


## 1.4

* **Add**: Compatibility with WordPress 4.7
* **Update**: Removing obsolete `wma_vc_custom_post_removal()` function
* **Update**: Improved RTL stylesheets
* **Update**: Subnav widget improved
* **Update**: Renamed "Enter title here" text for Staff custom post type
* **Update**: Improved icon font processor (removing query string from URLs, minifying CSS file)
* **Update**: Font Awesome 4.7
* **Update**: Localization
* **Fix**: Taxonomy name in column heading of custom post types admin table

### Files changed:

	changelog.md
	class-wm-amplifier.php
	readme.txt
	webman-amplifier.php
	assets/font/config.php
	assets/font/fontello.css
	assets/font/fontello.dev.css
	assets/scss/metabox.scss
	assets/scss/shortcodes-generator.scss
	assets/scss/shortcodes-vc-addons.scss
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/icons/class-icon-font.php
	includes/metabox/class-metabox.php
	includes/shortcodes/class-shortcodes.php
	includes/visual-editor/visual-editor.php
	includes/widgets/w-subnav.php


## 1.3.21

* **Add**: Integration with WooSidebars plugin

### Files changed:

	changelog.md
	class-wm-amplifier.php
	readme.txt
	webman-amplifier.php
	includes/integration/integration.php
	includes/integration/woosidebars/class-woosidebars.php


## 1.3.21

* **Update**: Cleaning and improving custom post types permalinks setup
* **Update**: Improving metaboxes and icons font admin screen styles

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	assets/css/admin-icons.css
	assets/scss/admin-icons.scss
	assets/scss/metabox/_tabs.scss
	assets/scss/metabox/_base.scss
	includes/icons/class-icon-font.php
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php


## 1.3.20

* **Fix**: Styling issue in icons list in WordPress dashboard

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	includes/icons/class-icon-font.php


## 1.3.19

* **Update**: Improving accessibility: changing <i> icons to <span> with aria-hidden attribute
* **Update**: Improving custom post types by allowing archive pages
* **Update**: Improving taxonomies visibility in navigational menus and updating label texts
* **Update**: Improved disabling of Visual Composer support
* **Update**: Removed <header> tag from Content Modules
* **Fix**: JavaScript errors in Safari browser

### Files changed:

	changelog.md
	readme.txt
	webman-amplifier.php
	assets/css/admin-addons.css
	assets/js/shortcode-accordion.js
	assets/js/shortcode-posts-isotope.js
	assets/js/shortcode-posts-masonry.js
	assets/js/shortcode-posts-owlcarousel.js
	assets/js/shortcode-posts-slick.js
	assets/js/shortcode-tabs.js
	assets/scss/admin-addons.scss
	includes/functions.php
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/icons/class-icon-font.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/icon.php
	includes/shortcodes/renderers/message.php


## 1.3.18

* **Fix**: JavaScript errors in Beaver Builder page builder editor

### Files changed:

	webman-amplifier.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php


## 1.3.17

* **Fix**: Compatibility issue with OwlCarousel script

### Files changed:

	webman-amplifier.php
	assets/js/shortcode-posts-owlcarousel.js
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php


## 1.3.16

* **Update**: Removing obsolete scripts

### Files changed:

	webman-amplifier.php
	assets/js/plugins/imagesloaded.min.js
	includes/shortcodes/page-builder/beaver-builder/modules/css/settings.css


## 1.3.15

* **Update**: Improved support with Beaver Builder plugin
* **Update**: Adding `is-active` CSS classes on active elements controlled with JavaScript
* **Fix**: Shortcode JavaScript update when editing with Beaver Builder

### Files changed:

	webman-amplifier.php
	assets/js/shortcode-accordion.js
	assets/js/shortcode-posts-isotope.js
	assets/js/shortcode-posts-masonry.js
	assets/js/shortcode-posts-slick.js
	assets/js/shortcode-tabs.js
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/page-builder/beaver-builder/modules/includes/frontend.css.php
	includes/shortcodes/page-builder/beaver-builder/modules/includes/frontend.js.php
	includes/shortcodes/page-builder/beaver-builder/modules/includes/frontend.php


## 1.3.14

* **Update**: Removing closing PHP tag from end of files
* **Update**: Removed bxSlider script
* **Fix**: Enqueuing of shortcode scripts (need to register scripts earlier)

### Files changed:

	*.php
	includes/shortcodes/class-shortcodes.php


## 1.3.13

* **Update**: Removing arrow from Subnav widget title
* **Update**: Improving security by using `wp_strip_all_tags` function
* **Fix**: Visual Composer compatibility file PHP error
* **Fix**: Typo in shortcodes definitions

### Files changed:

	webman-amplifier.php
	includes/functions.php
	includes/metabox/fields/select.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/page-builder/visual-composer/visual-composer.php
	includes/shortcodes/renderers/item.php
	includes/shortcodes/renderers/slideshow.php
	includes/widgets/w-subnav.php
	includes/widgets/w-tabbed-widgets.php
	includes/widgets/w-twitter.php
	languages/webman-amplifier.pot


## 1.3.12

* **Fix**: Don't output metabox if we have empty array of fields

### Files changed:

	webman-amplifier.php
	includes/metabox/class-metabox.php


## 1.3.11

* **Update**: Removing obsolete IE8 scripts
* **Fix**: Fixing compatibility with Beaver Builder page builder plugin

### Files changed:

	webman-amplifier.php
	assets/js/shortcode-posts-bxslider.js
	assets/js/shortcode-posts-isotope.js
	assets/js/shortcode-posts-masonry.js
	assets/js/shortcode-posts-owlcarousel.js
	assets/js/shortcode-posts-slick.js
	assets/js/shortcode-slideshow-owlcarousel.js
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/slideshow.php
	includes/shortcodes/renderers/testimonials.php


## 1.3.10

* **Add**: Support for customizer selective refresh on widgets
* **Update**: Removed custom `admin-thumbnail` image size
* **Update**: Scripts: Isotope 3.0.1, Slick 1.6.0
* **Update**: Setting Masonry script to use percent positioning
* **Update**: Plugin PHPDoc DocBlock header

### Files changed:

	class-wm-amplifier.php
	webman-amplifier.php
	assets/js/shortcode-posts.js
	assets/scss/admin-addons.scss
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/widgets/w-contact.php
	includes/widgets/w-module.php
	includes/widgets/w-posts.php
	includes/widgets/w-subnav.php
	includes/widgets/w-tabbed-widgets.php
	includes/widgets/w-twitter.php


## 1.3.9

* **Fix**: Icon font CSS styles conflict

### Files changed:

	assets/font/fontello.css


## 1.3.8

* **Update**: Improved Slick slider functionality

### Files changed:

	assets/js/shortcode-posts.js


## 1.3.7

* **Fix**: Typos
* **Fix**: Duplicate button ID when set via Beaver Builder page builder

### Files changed:

	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/image.php
	includes/shortcodes/renderers/icon.php


## 1.3.6

* **Update**: Visual Composer 4.11+ compatible

### Files changed:

	includes/shortcodes/class-shortcodes.php


## 1.3.5

* **Add**: Slick (v1.5.9) slider script support
* **Update**: Improved compatibility with SSL
* **Update**: Plugin info texts
* **Update**: Removing localization files in favor of translate.wordpress.org

### Files changed:

	class-wm-amplifier.php
	readme.md
	readme.txt
	webman-amplifier.php
	assets/js/shortcode-posts.js
	assets/js/plugins/slick.js
	assets/js/plugins/slick.min.js
	includes/icons/class-icon-font.php
	includes/metabox/class-metabox.php
	includes/shortcodes/class-shortcodes.php


## 1.3.4

* **Update**: Improved scripts registering and loading
* **Update**: Updated scripts versions (ImagesLoaded 4.1.0, Isotope 2.2.2)

### Files changed:

	webman-amplifier.php
	assets/js/plugins/imagesloaded.min.js
	assets/js/plugins/isotope.pkgd.min.js
	includes/icons/class-icon-font.php
	includes/metabox/class-metabox.php
	includes/shortcodes/class-shortcodes.php


## 1.3.3

* **Update**: Improved icon font admin screen
* **Update**: Removed Isotope admin pointer message
* **Update**: Updated localization

### Files changed:

	class-wm-amplifier.php
	webman-amplifier.php
	webman-amplifier-setup.php
	includes/icons/class-icon-font.php


## 1.3.2

* **Update**: Improved compatibility with child themes
* **Update**: Passed attributes into widget title filter

### Files changed:

	webman-amplifier.php
	includes/widgets/w-contact.php
	includes/widgets/w-module.php
	includes/widgets/w-posts.php
	includes/widgets/w-subnav.php
	includes/widgets/w-tabbed-widgets.php
	includes/widgets/w-twitter.php


## 1.3.1

* **Update**: Removing Beaver Builder Lite Version WordPress multisite installation fix

### Files changed:

	webman-amplifier.php
	includes/shortcodes/class-shortcodes.php


## 1.3

* **Update**: Beaver Builder 1.7 compatible (partial refresh activated for all modules)
* **Update**: Removing obsolete Beaver Builder page builder modules
* **Update**: Improved Beaver Builder page builder modules setup
* **Update**: Improved Tabs and Content Modules accessibility
* **Update**: Improved flexibility of shortcodes
* **Update**: Improved Staff post labels
* **Fix**: Unified the page builder modules naming style

### Files changed:

	webman-amplifier.php
	includes/custom-posts/staff.php
	includes/icons/class-icon-font.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_accordion.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_button.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_call_to_action.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_content_module.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_divider.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_message.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_posts.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_table.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_tabs.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_testimonials.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/divider.php
	includes/shortcodes/renderers/dropcap.php
	includes/shortcodes/renderers/icon.php
	includes/shortcodes/renderers/marker.php
	includes/shortcodes/renderers/message.php
	includes/shortcodes/renderers/progress.php
	includes/shortcodes/renderers/table.php


## 1.2.9.2

* **Update**: Improved Testimonials shortcode accessibility (heading tag setup)
* **Update**: License updated to GPLv3
* **Fix**: Typos in readme files

### Files changed:

	license.txt
	readme.txt
	readme.md
	webman-amplifier.php
	includes/shortcodes/renderers/testimonials.php


## 1.2.9.1

* **Add**: Additional custom post type and taxonomy labels
* **Update**: Shortcodes default options
* **Update**: Shortcodes classes output
* **Update**: Shortcodes accessibility (heading tag setup)
* **Update**: Localization

### Files changed:

	readme.txt
	webman-amplifier.php
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/divider.php
	includes/shortcodes/renderers/dropcap.php
	includes/shortcodes/renderers/icon.php
	includes/shortcodes/renderers/item.php
	includes/shortcodes/renderers/marker.php
	includes/shortcodes/renderers/message.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/price.php
	includes/shortcodes/renderers/progress.php
	includes/shortcodes/renderers/table.php
	includes/shortcodes/renderers/testimonials.php
	languages/webman-amplifier-sk_SK.mo
	languages/webman-amplifier-sk_SK.po
	languages/webman-amplifier-xx_XX.pot


## 1.2.9

* **Add**: Prepared for WordPress language packs
* **Add**: Added WordPress 4.4 compatibility (additional custom post types and taxonomies labels)
* **Update**: Visual Composer 4.9 plugin supported
* **Update**: Icons font admin screen improved
* **Update**: Renamed `sass` folder to `scss`
* **Update**: Using specific number of posts in `WP_Query` objects in shortcodes
* **Update**: Localization texts (updated also translation text domain) and files

### Files changed:

	class-wm-amplifier.php
	readme.txt
	webman-amplifier.php
	assets/css/shortcodes-vc-addons.css
	assets/scss/shortcodes-vc-addons.scss
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/icons/class-icon-font.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/page-builder/visual-composer/visual-composer.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/testimonials.php
	languages/readme.md
	languages/webman-amplifier-sk_SK.mo
	languages/webman-amplifier-sk_SK.po
	languages/webman-amplifier-xx_XX.pot
	All the PHP files containing the translation strings.


## 1.2.8.1

* **Fix**: Reverting back the custom post types custom capabilities in favour of WordPress native ones

### Files changed:

	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php


## 1.2.8

* **Update**: Removed custom Visual Composer admin styling in favour of native Visual Composer UI
* **Update**: Updated custom post types capabilities names
* **Update**: Improved Submenu widget
* **Fix**: Visual Composer icon selector not keeping the selected icon

### Files changed:

	assets/css/shortcodes-vc-addons.css
	assets/js/shortcodes-vc-addons.js
	assets/sass/shortcodes-vc-addons.scss
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/definitions.php
	includes/widgets/w-subnav.php

#### Files removed:

	assets/css/rtl-shortcodes-vc-addons.css
	assets/sass/rtl-shortcodes-vc-addons.scss
	assets/sass/vc-addons/_base.scss
	assets/sass/vc-addons/_columns.scss
	assets/sass/vc-addons/_elements.scss
	assets/sass/vc-addons/_modals.scss
	assets/sass/vc-addons/_navigation-bar.scss
	assets/sass/vc-addons/_row.scss
	assets/sass/vc-addons/rtl/_base.scss
	assets/sass/vc-addons/rtl/_columns.scss
	assets/sass/vc-addons/rtl/_elements.scss
	assets/sass/vc-addons/rtl/_modals.scss
	assets/sass/vc-addons/rtl/_navigation-bar.scss
	assets/sass/vc-addons/rtl/_row.scss
	assets/sass/vc-addons/rtl/_shortcodes.scss


## 1.2.7

* **Fix**: Issue of loading icon font files on each admin page (now they load on post edit screen only and only for specific post types to prevent issues with other plugins, such as Caldera Forms)

### Files changed:

	includes/shortcodes/class-shortcodes.php


## 1.2.6

* **Fix**: Improved PHP versions (mainly 7, but applies for others too) compatibility

### Files changed:

	includes/functions.php


## 1.2.5

* **Add**: "Specialty" taxonomy to Staff custom post type
* **Update**: Improved Content Module shortcode
* **Update**: Improved accessibility
* **Update**: Improved admin UI
* **Update**: Allowed filtering Beaver Builder custom module definition array
* **Update**: Removed obsolete `.eot` font files
* **Update**: Hooking custom posts registration on `init` action with priority `0` instead of `10` (before `widgets_init`)
* **Update**: Localization

### Files changed:

	class-wm-amplifier.php
	assets/css/metabox.css
	assets/font/fontello.css
	assets/font/fontello.dev.css
	assets/font/fontello.eot
	includes/custom-posts/staff.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/item.php
	includes/shortcodes/renderers/posts.php
	languages/sk_SK.mo
	languages/sk_SK.po
	languages/xx_XX.pot


## 1.2.4

* **Update**: Testimonials headings updated to H2 tag
* **Fix**: Visual Composer shortcodes layout issue (for Posts, Testimonials and Content Modules)

### Files changed:

	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/testimonials.php


## 1.2.3

* **Add**: WordPress 4.3 support
* **Update**: Metabox controls styles
* **Update**: Improved accessibility
* **Update**: Allowed overriding `$helper` variable in Posts shortcode
* **Update**: Allowed premature overriding of Posts and Testimonials shortcode item
* **Update**: Added headings into Contact widget sections
* **Fix**: Visual Composer custom shortcode mapping via dashboard not working

### Files changed:

	assets/css/admin-addons.css
	assets/css/metabox.css
	assets/js/metabox.js
	assets/sass/admin-addons.scss
	assets/sass/metabox.scss
	assets/sass/metabox/_field-range.scss
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/testimonials.php
	includes/widgets/w-contact.php


## 1.2.2

* **Add**: Visual Composer 4.6+ support
* **Add**: Ability to filter icons in metaboxes and page builders
* **Add**: Applied SASS for all CSS stylesheets
* **Update**: Scripts updates: Isotope 2.2.1, bxSlider 4.2.5
* **Update**: Retina ready admin interface, removed support for Internet Explorer 8
* **Update**: Removed front-end shortcodes sample CSS stylesheet
* **Update**: Removed obsolete jQuery plugins CSS stylesheets
* **Update**: Supplying unpacked, non-minified styles and JavaScript
* **Update**: Metabox icons selector (custom radio buttons control) styles and functionality
* **Update**: Sample plugin setup file for usage in themes
* **Update**: Improved and optimized code
* **Update**: Localization

### Files changed:

	class-wm-amplifier.php
	webman-amplifier-setup.php
	webman-amplifier.php
	assets/css/admin-addons.css
	assets/css/input-wm-radio.css
	assets/css/metabox.css
	assets/css/rtl-metabox.css
	assets/css/rtl-shortcodes-generator.css
	assets/css/rtl-shortcodes-vc-addons.css
	assets/css/shortcodes-bb-addons.css
	assets/css/shortcodes-vc-addons.css
	assets/js/metabox.js
	assets/js/shortcode-accordion.js
	assets/js/shortcode-parallax.js
	assets/js/shortcode-posts.js
	assets/js/shortcode-slideshow.js
	assets/js/shortcode-tabs.js
	assets/js/shortcodes-button.js
	assets/js/shortcodes-ie.js
	assets/js/shortcodes-vc-addons.js
	assets/sass/admin-addons.scss
	assets/sass/input-wm-radio.scss
	assets/sass/metabox.scss
	assets/sass/rtl-metabox.scss
	assets/sass/rtl-shortcodes-generator.scss
	assets/sass/rtl-shortcodes-vc-addons.scss
	assets/sass/shortcodes-bb-addons.scss
	assets/sass/shortcodes-vc-addons.scss
	includes/functions.php
	includes/custom-posts/modules.php
	includes/metabox/fields/radio.php
	includes/metabox/fields/slider.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/definitions.php
	includes/visual-editor/visual-editor.php
	includes/widgets/w-twitter.php
	languages/sk_SK.mo
	languages/sk_SK.po
	languages/xx_XX.pot


## 1.2.1

* **Update**: Font Awesome 4.3
* **Fix**: Hashtag links in Twitter widget

### Files changed:

	assets/font/*.*
	includes/widgets/w-twitter.php


## 1.2

* **Add**: Visual Composer 4.5.2 compatibility (fixed the `content` parameter not being parsed)
* **Update**: Using `tag_escape()` where needed
* **Update**: Rehooked the custom widgets to early `init` action
* **Update**: WP_Query optimalizations
* **Update**: Generalized script handler names
* **Update**: Removing obsolete theme constants (making theme library independent)
* **Update**: Beaver Builder affiliate link updated
* **Fix**: Filter hook names for Beaver Builder page builder integration

### Files changed:

	class-wm-amplifier.php
	includes/functions.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/item.php
	includes/shortcodes/renderers/message.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/price.php
	includes/shortcodes/renderers/row.php
	includes/shortcodes/renderers/separator_heading.php
	includes/shortcodes/renderers/slideshow.php
	includes/shortcodes/renderers/testimonials.php
	includes/widgets/w-contact.php
	includes/widgets/w-module.php
	includes/widgets/w-posts.php
	includes/widgets/w-subnav.php
	includes/widgets/w-tabbed-widgets.php
	includes/widgets/w-twitter.php


## 1.1.7.6

* **Update**: Removing `uninstall.php` file to prevent possible issues when deleting the plugin via WordPress dashboard

#### Files removed:

	uninstall.php


## 1.1.7.5

* **Update**: Contact Widget anti-spam protection

### Files changed:

	includes/widgets/w-contact.php


## 1.1.7

* **Update**: Compatibility with Visual Composer 4.5

### Files changed:

	assets/css/shortcodes-vc-addons.css
	assets/css/dev/shortcodes-vc-addons.dev.css
	includes/shortcodes/class-shortcodes.php


## 1.1.6

* **Update**: Security tightening
* **Update**: Improved support with Beaver Builder page builder plugin
* **Update**: Improved shortcodes filters and escaping
* **Update**: Removed `wptexturize()` from preformated text shortcode
* **Update**: Removed obsolete constants
* **Update**: Metabox fields improvements
* **Update**: Localization
* **Update**: Update scripts: Isotope v2.2.0, BxSlider v4.2.3

### Files changed:

	includes/functions.php
	includes/metabox/fields/checkbox.php
	includes/metabox/fields/images.php
	includes/metabox/fields/radio.php
	includes/metabox/fields/repeater.php
	includes/metabox/fields/sections.php
	includes/metabox/fields/select.php
	includes/metabox/fields/slider.php
	includes/metabox/fields/texts.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/renderers/accordion.php
	includes/shortcodes/renderers/audio.php
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/column.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/divider.php
	includes/shortcodes/renderers/dropcap.php
	includes/shortcodes/renderers/icon.php
	includes/shortcodes/renderers/image.php
	includes/shortcodes/renderers/item.php
	includes/shortcodes/renderers/last_update.php
	includes/shortcodes/renderers/list.php
	includes/shortcodes/renderers/marker.php
	includes/shortcodes/renderers/message.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/pre.php
	includes/shortcodes/renderers/price.php
	includes/shortcodes/renderers/pricing_table.php
	includes/shortcodes/renderers/progress.php
	includes/shortcodes/renderers/row.php
	includes/shortcodes/renderers/separator_heading.php
	includes/shortcodes/renderers/slideshow.php
	includes/shortcodes/renderers/table.php
	includes/shortcodes/renderers/tabs.php
	includes/shortcodes/renderers/testimonials.php
	includes/shortcodes/renderers/text_block.php
	includes/shortcodes/renderers/video.php
	includes/shortcodes/renderers/widget_area.php
	includes/visual-editor/visual-editor.php


## 1.1.5

* **Update**: Improved support with Beaver Builder (unfortunatelly, not backwards compatible as custom modules file names have been renamed)

### Files changed:

	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_accordion.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_button.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_call_to_action.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_content_module.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_countdown_timer.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_divider.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_icon.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_list.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_message.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_posts.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_pricing_table.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_progress.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_separator_heading.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_slideshow.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_table.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_tabs.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_testimonials.php
	includes/shortcodes/page-builder/beaver-builder/modules/wm_widget_area.php


## 1.1.4

* **Fix**: Custom posts issue introduced in update 1.1.3

### Files changed:

	class-wm-amplifier.php


## 1.1.3

* **Update**: Icon font updated to Font Awesome v4.1 (resave the font to regenerate)
* **Update**: Isotope license notification moved to WordPress pointer
* **Update**: Localization function
* **Update**: Removed deprecated action hooks
* **Fix**: Scripts and conditions for including Shortcode Generator button
* **Fix**: Localization texts

### Files changed:

	class-wm-amplifier.php
	assets/font/config.php
	assets/font/fontello.dev.css
	assets/js/shortcodes-button.js
	assets/js/dev/shortcodes-button.dev.js
	includes/visual-editor/visual-editor.php
	languages/sk_SK.po
	languages/xx_XX.pot


## 1.1.2

* **Update**: Function for color format change
* **Update**: Functions for folder and file creation
* **Update**: Example setup file
* **Fix**: Removing Visual Composer front end styles

### Files changed:

	webman-amplifier-setup.php
	includes/functions.php
	includes/shortcodes/class-shortcodes.php


## 1.1.1

* **Update**: Improved support for Beaver Builder plugin
* **Update**: Schema.org markup generator function
* **Update**: Hook names
* **Fix**: PHP error when using the Beaver Builder plugin

### Files changed:

	class-wm-amplifier.php
	includes/functions.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php


## 1.1

* **Add**: Visual Composer 4.4 support
* **Add**: Beaver Builder plugin support
* **Add**: Plugin action links plugins admin page
* **Add**: Slovak localization file
* **Update**: Optimized and improved code
* **Update**: Removed obsolete files
* **Update**: Better file organization
* **Update**: Scripts updated: Isotope 2.1.0
* **Update**: Removed support for old WordPress versions
* **Update**: Renamed `type` shortcode attribute to `appearance` (keeping backwards compatibility)
* **Update**: Localization functions and files
* **Fix**: Fixed hook names
* **Fix**: Vertical tabs min tab content height

### Files changed:

	class-wm-amplifier.php
	uninstall.php
	webman-amplifier-setup.php
	assets/css/admin-addons.css
	assets/css/input-wm-radio.css
	assets/css/metabox.css
	assets/css/rtl-shortcodes-generator.css
	assets/css/rtl-shortcodes-vc-addons.css
	assets/css/shortcodes-bb-addons.css
	assets/css/shortcodes-vc-addons.css
	assets/css/dev/admin-addons.dev.css
	assets/css/dev/input-wm-radio.dev.css
	assets/css/dev/metabox.dev.css
	assets/css/dev/rtl-shortcodes-generator.dev.css
	assets/css/dev/rtl-shortcodes-vc-addons.dev.css
	assets/css/dev/shortcodes-bb-addons.dev.css
	assets/css/dev/shortcodes-vc-addons.dev.css
	assets/js/shortcode-tabs.js
	assets/js/shortcodes-button.js
	assets/js/dev/shortcode-tabs.dev.js
	assets/js/dev/shortcodes-button.dev.js
	includes/class-icon-font.php
	includes/functions.php
	includes/custom-posts/logos.php
	includes/custom-posts/modules.php
	includes/custom-posts/projects.php
	includes/custom-posts/staff.php
	includes/custom-posts/testimonials.php
	includes/metabox/class-metabox.php
	includes/metabox/fields/radio.php
	includes/metabox/fields/select.php
	includes/metabox/fields/slider.php
	includes/metabox/fields/texts.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/page-builder/beaver-builder/beaver-builder.php
	includes/shortcodes/page-builder/beaver-builder/modules/accordion.php
	includes/shortcodes/page-builder/beaver-builder/modules/button.php
	includes/shortcodes/page-builder/beaver-builder/modules/call_to_action.php
	includes/shortcodes/page-builder/beaver-builder/modules/content_module.php
	includes/shortcodes/page-builder/beaver-builder/modules/countdown_timer.php
	includes/shortcodes/page-builder/beaver-builder/modules/divider.php
	includes/shortcodes/page-builder/beaver-builder/modules/icon.php
	includes/shortcodes/page-builder/beaver-builder/modules/list.php
	includes/shortcodes/page-builder/beaver-builder/modules/message.php
	includes/shortcodes/page-builder/beaver-builder/modules/posts.php
	includes/shortcodes/page-builder/beaver-builder/modules/pricing_table.php
	includes/shortcodes/page-builder/beaver-builder/modules/progress.php
	includes/shortcodes/page-builder/beaver-builder/modules/separator_heading.php
	includes/shortcodes/page-builder/beaver-builder/modules/slideshow.php
	includes/shortcodes/page-builder/beaver-builder/modules/table.php
	includes/shortcodes/page-builder/beaver-builder/modules/tabs.php
	includes/shortcodes/page-builder/beaver-builder/modules/testimonials.php
	includes/shortcodes/page-builder/beaver-builder/modules/widget_area.php
	includes/shortcodes/page-builder/beaver-builder/modules/css/settings.css
	includes/shortcodes/page-builder/beaver-builder/modules/includes/frontend.php
	includes/shortcodes/page-builder/beaver-builder/modules/js/settings.js
	includes/shortcodes/renderers/button.php
	includes/shortcodes/renderers/call_to_action.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/divider.php
	includes/shortcodes/renderers/icon.php
	includes/shortcodes/renderers/message.php
	includes/shortcodes/renderers/price.php
	includes/shortcodes/renderers/table.php
	includes/visual-editor/visual-editor.php
	includes/widgets/w-contact.php
	includes/widgets/w-module.php
	includes/widgets/w-posts.php
	includes/widgets/w-subnav.php
	includes/widgets/w-tabbed-widgets.php
	includes/widgets/w-twitter.php
	templates/content-shortcode-posts-post.php
	templates/content-shortcode-posts.php


## 1.0.9.15

* **Add**: Function to register additional custom taxonomies
* **Add**: 'wma_supports_subfeature( $subfeature )' function
* **Update**: Function to check if the theme supports plugin's features
* **Update**: Improved disabling shortcodes and icon font classes
* **Update**: Improved performance of the code
* **Update**: Metabox styles
* **Update**: Renamed 'remove_vc_shortcodes' to 'remove-vc-shortcodes' (while keeping backwards compatibility)
* **Update**: WebMan Amplifier setup file
* **Fix**: Function name for 'WMAMP_LATE_LOAD' feature

### Files changed:

	class-wm-amplifier.php
	webman-amplifier.php
	webman-amplifier-setup.php
	assets/css/metabox.css
	assets/css/dev/metabox.dev.css
	includes/functions.php
	includes/shortcodes/class-shortcodes.php


## 1.0.9.14

* **Update**: Allow disabling shortcodes, icon font and metaboxes classes

### Files changed:

	class-wm-amplifier.php


## 1.0.9.13

* **Update**: Posts shortcode filter name

### Files changed:

	includes/shortcodes/renderers/posts.php


## 1.0.9.12

* **Update**: Updated Twitter OAuth library

### Files changed:

	includes/twitter-api/OAuth.php
	includes/twitter-api/twitteroauth.php


## 1.0.9.11

* **Update**: Optimized code
* **Update**: Including Twitter OAuth library conditionally to prevent issues with other plugins

### Files changed:

	class-wm-amplifier.php
	includes/functions.php
	includes/shortcodes/class-shortcodes.php
	includes/widgets/w-twitter.php


## 1.0.9.10

* **Update**: Widgets class names
* **Update**: Admin styles
* **Fix**: Post thumbnails size in WordPress admin
* **Fix**: Visual Composer Accordions and Tabs shortcode issue

### Files changed:

	assets/css/admin-addons.css
	assets/css/rtl-shortcodes-vc-addons.css
	assets/css/shortcodes-vc-addons.css
	assets/css/shortcodes-vc-addons-old.css
	assets/css/dev/admin-addons.css
	assets/css/dev/rtl-shortcodes-vc-addons.css
	assets/css/dev/shortcodes-vc-addons.css
	assets/css/dev/shortcodes-vc-addons-old.css
	assets/js/shortcodes-vc-addons.js
	assets/js/dev/shortcodes-vc-addons.js
	includes/shortcodes/definitions/definitions.php
	includes/widgets/w-contact.php
	includes/widgets/w-module.php
	includes/widgets/w-posts.php
	includes/widgets/w-subnav.php
	includes/widgets/w-tabbed-widgets.php
	includes/widgets/w-twitter.php


## 1.0.9.9

* **Add**: Widgets
* **Add**: Option to deactivate the plugin after theme change
* **Update**: Code effectivity
* **Update**: Scripts: imagesLoaded 3.1.8, Isotope 2.0.1, jQuery OwlCarousel 1.3.3
* **Update**: Admin notice function
* **Update**: Localization file

#### Files added:

	includes/widgets/w-contact.php
	includes/widgets/w-module.php
	includes/widgets/w-posts.php
	includes/widgets/w-subnav.php
	includes/widgets/w-tabbed-widgets.php
	includes/widgets/w-twitter.php

### Files changed:

	class-wm-amplifier.php
	webman-amplifier.php
	assets/js/plugins/imagesloaded.min.js
	assets/js/plugins/isotope.pkgd.min.js
	assets/js/plugins/owl.carousel.min.js
	includes/functions.php
	includes/functions.php
	languages/wm_domain.pot


## 1.0.9.8

* **Update**: Improved Tabs shortcode
* **Fix**: Shortcode Generator shortcode attributes
* **Fix**: Improved shortcodes scripts enqueuing

### Files changed:

	assets/css/shortcodes-vc-addons.css
	assets/css/dev/shortcodes-vc-addons.dev.css
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/renderers/accordion.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/row.php
	includes/shortcodes/renderers/slideshow.php
	includes/shortcodes/renderers/tabs.php
	includes/shortcodes/renderers/testimonials.php


## 1.0.9.7

* **Update**: WordPress 4.0 support
* **Update**: Improved shortcodes scripts enqueuing

### Files changed:

	assets/metabox.css
	assets/dev/metabox.dev.css
	includes/shortcodes/renderers/accordion.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/row.php
	includes/shortcodes/renderers/slideshow.php
	includes/shortcodes/renderers/tabs.php
	includes/shortcodes/renderers/testimonials.php


## 1.0.9.6

* **Add**: Additional arguments for `do_action()` for better flexibility.

### Files changed:

	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/renderers/accordion.php
	includes/shortcodes/renderers/content_module.php
	includes/shortcodes/renderers/countdown_timer.php
	includes/shortcodes/renderers/posts.php
	includes/shortcodes/renderers/row.php
	includes/shortcodes/renderers/slideshow.php
	includes/shortcodes/renderers/tabs.php
	includes/shortcodes/renderers/testimonials.php


## 1.0.9.5

* **Add**: Compatibility with Visual Composer 4.3+

### Files changed:

	webman-amplifier-setup.php
	assets/css/shortcodes-vc-addons.css
	assets/css/rtl-shortcodes-vc-addons.css
	assets/css/dev/rtl-shortcodes-vc-addons.dev.css
	assets/css/shortcodes-vc-addons-old.css
	assets/css/dev/shortcodes-vc-addons.dev.css
	assets/css/dev/shortcodes-vc-addons-old.dev.css
	assets/js/shortcodes-vc-addons.js
	assets/js/dev/shortcodes-vc-addons.dev.js
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/vc_addons/shortcodes-admin.php


## 1.0.9.4

* **Add**: `style` attribute to Icon shortcode
* **Update**: Visual Composer element screen tabs redesigned
* **Update**: Setup actions updated
* **Fix**: Applying `active` class on active tab content

### Files changed:

	class-wm-amplifier.php
	assets/css/shortcodes-vc-addons.css
	assets/css/dev/shortcodes-vc-addons.dev.css
	assets/js/shortcode-tabs.js
	assets/js/dev/shortcode-tabs.dev.js
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/renderes/icon.php


## 1.0.9.3

* **Fix**: Non-admin user lockout

### Files changed:

	includes/class-icon-font.php


## 1.0.9.2

* **Fix**: The Shortcode Generator issue in Firefox browser

### Files changed:

	assets/js/dev/shortcodes-button.dev.js
	assets/js/shortcodes-button.js


## 1.0.9.1

* **Fix**: The issue with admin notice

### Files changed:

	class-wm-amplifier.php


## 1.0.9

* **Add**: Master Slider shortcode support for Visual Composer
* **Add**: Shortcode to display a custom post meta field value `[wm_meta field="wmamp-meta-field" custom"1/0" /]`
* **Add**: Option to define the supported version of plugin for themes
* **Update**: Column shortcode styling improvements
* **Update**: Divider shortcode styling option added for Visual Composer
* **Update**: Taxonomies list sorted by name in shortcodes descriptions in Visual Composer
* **Update**: Visual Composer inner column support improved
* **Update**: Visual Composer Image shortcode styling options added
* **Update**: Localization texts changed

### Files changed:

	webman-amplifier.php
	webman-amplifier-setup.php
	assets/js/shortcode-accordion.js
	assets/js/dev/shortcode-accordion.dev.js
	includes/functions.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/renderers/accordion.php
	includes/shortcodes/renderers/column.php
	includes/shortcodes/renderers/image.php
	includes/shortcodes/renderers/meta.php
	includes/shortcodes/renderers/row.php
	languages/wm_domain.php


## 1.0.8

* **Add**: Support for Visual Composer v4.2
* **Update**: Sample setup file

### Files changed:

	webman-amplifier-setup.php
	includes/functions.php
	includes/metabox/class-metabox.php
	includes/shortcodes/class-shortcodes.php
	includes/shortcodes/definitions/definitions.php
	includes/shortcodes/vc_addons/shortcodes-admin.php


## 1.0.7

* **Update**: Metabox class improved (not to throw out PHP warning)
* **Update**: Metabox function name fixed in `webman-amplifier-setup.php`

### Files changed:

	includes/metabox/class-metabox.php
	webman-amplifier-setup.php


## 1.0.6

* **Update**: Sorting font icons preview alphabetically
* **Fix**: Isotope filter fixed for RTL languages

### Files changed:

	includes/class-icon-font.php
	assets/js/dev/shortcode-posts.dev.js
	assets/js/shortcode-posts.js


## 1.0.5

* **Add**: plugin deactivation hook
* **Update**: Better hooking into `wma_meta_option()` function
* **Update**: Sorting outputs of `wma_pages_array()` and `wma_taxonomy_array()` functions
* **Update**: Filter names fixed in `wma_posts_array()`, `wma_pages_array()` and `wma_widget_areas_array()` functions

### Files changed:

	webman-amplifier.php
	includes/functions.php


## 1.0

* Initial release.
