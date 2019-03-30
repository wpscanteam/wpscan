### HEAD

### 1.7.8 Marsh 4th, 2019
* Add 720k angular-tooltips module
* Fix sticky sass
* Fix template list
* Fix wp-ng-router base state
* Replace component mm.foundation
* Fix module init
* Fix url ui-router
* Fix wp_ng_get_ng_router_url with nested route
* Add transient cache ui router states
* Bug fix controllerAs and rename with prefix $
* Fix smoothscrool offset selector not found.
* Add foundation angularjs dropdown pane-align top for dropup

### 1.7.7 January 28th, 2019
* Remove woocommerce fix cart cookie on rest request.
* Add some function class template. Fix list template add action template
* Bug fixing wp-ng-router set otherwise to all url not only wrapped.
* Update ng-location-search to v1.1.2
* Update slick-carousel
* Add template_plugin, template_plugin_item params to ng-gallery shortcode.
* ng-gallery fix gallery shortcode content not empty
* Fix html attributes change empty val to null val  
* Remove antimoderate svg. Only jpeg or png.
* Bug fix initial-value if input number
* Fix foundation init
* Add reinit object fit on module loaded by oc.lazyload

### 1.7.6 December 18th, 2018
* Fix not exist $current_screen
* Fix ui-router 
* Add ui-router option for set baseUrl
* Add multiple aliases and multiple sources webicon for default settings.

### 1.7.5 December 2th, 2018
* Fix webfont class 
* Add shortcode pageslide
* Add foundation reinit on module loaded with oc.lazyload
* Some bug fix
* Fix slider height auto
* Fix wp_ng_json_encode unicode for shortcode
* Add module rc-http

### 1.7.4 November 13th, 2018
* Add parser tools

### 1.7.3 October 31th, 2018
* Fix unitegallery error

### 1.7.2 October 31th, 2018
* Fix aping gallery template link target and add rel attribute.

### 1.7.1 October 24th, 2018
* Add module ngRateIt
* Fix do_shortcode for content by apply_filters 'the_content'

### 1.7.0 October 23th, 2018
* Add shortcode ng-social-share-links
* Bug fixing ui-router restrict metabox for manage_options user
* Bug fix ui-router redirect page url or state name
* Refactoring ui-router page

### 1.7.0-beta4: October 12th, 2018
* Small Refactoring

### 1.7.0-beta3: October 8th, 2018
* Fix shortcode hook gallery for ngGallery

### 1.7.0-beta2: October 5th, 2018
* Add module checkox-list

### 1.7.0-beta1: October 4th, 2018
* Update Angular and dep modules from 1.6.9 to 1.7.4

### 1.6.5-beta15: October 4th, 2018
* Fix ng-dialog button css.
* Add rest set language action.

### 1.6.5-beta14: September 27th, 2018
* Fix clear cache on update section

### 1.6.5-beta12: September 26th, 2018
* Fix smoothscroll default param value

### 1.6.5-beta11: September 20th, 2018
* Add no-anim-out class for animsition for remove out animation.

### 1.6.5-beta10: September 20th, 2018
* Add Resend one time request for nonce update
* Add extend nonce life time from same as cache third party (wp cache enabler)

### 1.6.5-beta9: September 6th, 2018
* Fix elementor post id support
* Fix ngDialog style overflow .ngdialog-content
* Replace wpautop by wpngautop for content in template shortcode

### 1.6.5-beta8: August 28th, 2018
* Fix elementor pages for woocommerce and stag-catalog

### 1.6.5-beta7: August 27th, 2018
* Bug Fix style ValityCss. Add option style valitycss on v modules and 
  add dependencie if one of v modules is active
* Add scroll by id with smoothScroll module.
* Add smoothScrool Options in descriptor modules

### 1.6.5-beta6: August 24th, 2018
* Update rc-gallery to v1.1.1
* Add tabs shortcode

### 1.6.5-beta5: August 22th, 2018
* Update ng-dialog to v1.4.0

### 1.6.5-beta4: August 21th, 2018
* Add Accordion shortcode

### 1.6.5-beta3: August 6th, 2018
* Fix wpng_json_encode single.
* Add ui-router wrap_exclude
* Fix logout destroy_session not exist.

### 1.6.5-beta1: August 3th, 2018
* Fix wpngautop function for not wrap paragraph if not contain html and shortcode

### 1.6.4: July 6th, 2018
* Update module ui.select.zf6
* Add compatibility wp_cache_clear_cache
* Add mode shuffle sources for shortcode gallery


### 1.6.3: July 4th, 2018
* Fix webfontloader async display
* Add action clean cache for compatibility with cache enabler.
* Update angular module ui.select and bs3-2-zf6
* Update ng-location-search
* Add module ui.select.zf6
* Add check global function wp_ng_is_advanced_cache
* Add Outdated browser template redirect for ie under 11.
* Remove angular module ng.deviceDetector

### 1.6.2: June 2th, 2018
* Add routed page with ui-router module
* Add compatibility wpNgConfig for WP_CACHE enabled (use cookie)
* Update ui-router to v0.4.2
* Update rollbar-php to v1.4.2
* Update rc-rollbar to v2.3.9
* Update foundation to v6.4.3
* Update ng-location-search to v1.0.2
* Update awesome-foundation6-checkbox to v1.0.2
* Update bs3tozf6 to v1.1.1
* Add timeout animsition options
* Set enabled timeout on default with 3000ms animsition script.
* Add modules: angular-ismobile, angular-inview
* Fix webfont loader if not combine scripts.
* Add logout remove php SESSION COOKIE
* Fix elementor 2.0
* Fix init settings options before other plugins set prio to -1.
* Fix Gallery unitegallery source alt mandatory.
* Fix wpngautop
* Add wp_get_attachment_image_attributes hook for work with antimoderate.
* Update antimoderate to v1.1.7

### 1.6.1: Marsh 28th, 2018
* Fix anisition not load href empty.
* update angular 1.6.4 to 1.6.9
* Fix select bs2zf
* Fix parser shortcode map type
* Fix wp_ng_get_module_options and wp_ng_get_script_options if use module with dot (ui.router) 

### 1.6.0: Marsh 15th, 2018
* Elementor Compatibility widget to invoke the angular compile.
* Elementor Compatibility lazyload angular module.
* Elementor Compatibility for combine script and style.
* Fix input form.
* Add console icon
* Add angular flatpickr fix
* Add translation boolean
* Fix Checkbox value initial.
* Add module ui-event.
* Update module ng-antimoderate.
* Fix input translation label for checkbox and radio.
* Add Lib Google Geocode
* Add is active module.
* Fix module check is module handle already have prefix.
* Add Extra Scripts options
* Add extra script object-fit.js and aos.js
* Fix get_template return at string Remove undesired characters like trim but for all string.
* Add function wp_ng_trim_all
* Add function wp_ng_get_modules_scripts
* Add function wp_ng_get_modules_styles
* Add function wp_ng_get_html_attributes
* Add implementation of lazyload modules.
* Add template and action hook for lazyload.
* Add module angular-snapscroll and angular-swipe
* Add options for custom handles to combine script and style.
* Add options for custom cdn url angular and jquery.
* Add WebFont Loader script.
* Add AOT Animate On Trigger
* Add ui-swiper templates
* Add template galleries for aping support.

### 1.5.0: January 21th, 2018
* Release.

### 1.5.0-beta36: January 20th, 2018
* Add init email on hook after_theme_support with plugin support.
* Add metabox email options.
* Add style for metabox email options.
* Add ip address email
* Add user agent email
* Fix Initial value directive.
* Refactoring input shortcode
* Add radio input shortcode

### 1.5.0-beta35: January 11th, 2018
* Add wpml compatibility insert rest media alt text for translation.

### 1.5.0-beta34: December 20th, 2017
* Add built-in el-size directive.
* Add gallery for module owl2
* Fix gallery shortcode and templates
* Update rc-gallery to v1.0.4

### 1.5.0-beta33: December 18th, 2017
* Add dependencie wp-ng_mutationObserver-shim to ngTinyScrollbar for auto update option.

### 1.5.0-beta32: December 17th, 2017
* Add ui-swiper module
* Add duParallax module
* Replace gulp-cssnano by gulp-postcss.

### 1.5.0-beta31: December 15th, 2017
* Add Angular image dimensions module
* Add Angular Grister2 module

### 1.5.0-beta30: December 15th, 2017
* Bug fixing active module cache on condition.
* Bug fixing sanitize_name first do replacement then resolve prefix.

### 1.5.0-beta29: December 11th, 2017
* Refactoring template gallery
* Bug fixing.

### 1.5.0-beta28: December 8th, 2017
* Fix admin chosen jquery image.
* Add compatibility rc-gallery shortcode with wp gallery shortcode
* Add admin gallery field in media upload for set shortcode gallery. 
* Add wp_ng_sanitize_name.

### 1.5.0-beta27: December 6th, 2017
* Change delimiter object array from single underscore to double underscore.

### 1.5.0-beta26: December 6th, 2017
* Add Modules rcGallery, rcGalleryUnitegallery and rcGalleryGalleria.
* Add Shortcode rc-gallery, rc-gallery-unitegallery and rc-gallery-galleria for rcGallery module.
* Fix CJSON if PHP Mbstring extension is not enable get blog charset option. 

### 1.5.0-beta25: November 15th, 2017
* Bug fix settings register fields.

### 1.5.0-beta24: November 15th, 2017
* Readme
* Fix descritor module url site and module and small text.

### 1.5.0-beta23: November 15th, 2017
* wp_ng_json_decode and encode change encoding bracket from &#91; to %5B for 
allown in wp editor tinymce on switch visual and text mode.

### 1.5.0-beta22: November 14th, 2017
* Add map shortcode for leaflet.
* Add icon id accepted.
* Add shortcode parser.

### 1.5.0-beta21: November 9th, 2017
* Update ng-antmoderate to v1.1.5
* Add config module antimoderate.
* Add config webicon alias and icon.
* Add admin module webicon fields.

### 1.5.0-beta20: November 8th, 2017
* Update leaflet-plugin to v1.9.3

### 1.5.0-beta19: November 7th, 2017
* Add translation for shortcode attribute.

### 1.5.0-beta18: November 5th, 2017
* refactoring global hooks and core functions.
* Fix prefix action settings form.
* Add hook wp-ng_version_update

### 1.5.0-beta17: November 3th, 2017
* Fix initialize settings and logging.

### 1.5.0-beta16: October 30th, 2017
* Fix variable email {site_url}.
* Update ngLocationSearch v1.0.2

### 1.5.0-beta15: October 24th, 2017
* Update antimoderate v1.1.4
* Update ngMagnify v0.0.2

### 1.5.0-beta14: October 19th, 2017
* Update bower version module videogular vimeo 1.0.0

### 1.5.0-beta13: October 19th, 2017
* Update bower version module videogular vimeo.

### 1.5.0-beta12: October 19th, 2017
* Fix rollbar env check on save admin.

### 1.5.0-beta11: October 18th, 2017
* Add input textarea model.

### 1.5.0-beta10: October 18th, 2017
* Add disable env rollbar is WP_ENV is defined

### 1.5.0-beta9: October 16th, 2017
* Update videogular vimeo 

### 1.5.0-beta8: October 15th, 2017
* Update module hlSticky to 0.4.1

### 1.5.0-beta7: October 15th, 2017
* Update plugin antimoderate
* Update Readme

### 1.5.0-beta6: October 13th, 2017
* Add Module Angular Grid
* Bug fix wpngautop remove default tag on li.

### 1.5.0-beta5: October 10th, 2017
* Add wpngautop
* Fix asset_path

### 1.5.0-beta4: October 9th, 2017
* Remove nl2br. use wisywig align button.

### 1.5.0-beta3: October 9th, 2017
* Add Enable nl2br for content, excerpt, acf_content

### 1.5.0-beta2: October 7th, 2017
* Add config api key and access token to apiNG.
* Add module for twitter and OpenWeatherMap.

### 1.5.0-beta1: October 7th, 2017
* Add Module ngLocationSearch
* Add Module bgf.paginateAnything
* Add Module apiNG plugin instagram
* Add Module apiNG plugin facebook
* Add Module apiNG plugin flickr
* Add Module apiNG plugin tumblr
* Add Module apiNG plugin wikipedia
* Add Module apiNG plugin dailymotion
* Add Module apiNG plugin vimeo
* Add Module apiNG plugin youtube

### 1.4.9: September 28th, 2017
* Fix directive initial value removeIndent.
* Fix ui-select form-inline

### 1.4.8: September 28th, 2017
* Add module angular.backtop

### 1.4.7: September 25th, 2017
* Add class css ng-animate-disabled

### 1.4.6: September 25th, 2017
* Add comment module vButton. incompatibility with angular foundation 6
* Update module pageslide.

### 1.4.5: September 20th, 2017
* Bug fix config env json for spécialchar. Add to json_encode "JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP"
* Remove module angulr-initial-value.
* Add built-in directive initialValue.
* Shortcode remove ng-init for set value input and replace by directive initial-value.

### 1.4.4: September 19th, 2017
* Add hook filter wp_ng_get_module_option

### 1.4.3-beta5: September 18th, 2017
* Bug fix config with string not correctly encoded. 

### 1.4.3-beta4: September 18th, 2017
* Rename translation file

### 1.4.3-beta3: September 15th, 2017
* Update Translation.

### 1.4.3-beta2: September 15th, 2017
* Fix descrition setting action logger.

### 1.4.3-beta1: September 10th, 2017
* Add lib class CJSON
* Add deprecated classes.

### 1.4.2-beta15: September 10th, 2017
* Update angular-bootstrap to v2.5.0

### 1.4.2-beta11: September 1th, 2017
* Load plugin.php if is_plugin_active function not exist.

### 1.4.2-beta10: August 28th, 2017
* Add Module ngStickyFooter
* Add Module ngInput
* Add Module angular-sortable-view
* Add MutationObserver-shim for ngStickyFooter
* Update rc-media module to fix event resize, fix input model update on delete and add sortable preview gallery.

### 1.4.2-beta9: August 23th, 2017
* Bug Fix Videogular CustomEvent for Object doesn't support this action' on Win8.1 + IE11. Add custom-event-polyfill.
* Bug Fix scss select-bs-2-zf

### 1.4.2-beta8: August 18th, 2017
* Update ngGeonames fix angular 1.6 http jsonp
* fix ui.select for foundation.

### 1.4.2-beta7: August 16th, 2017
* Add helper class, email class, template class.
* Add Email Settings ans template.
* Refactoring ngAnimate css.
* ui.select remove selectize foundation and replace with bs 2 zf

### 1.4.2-beta6: August 15th, 2017
* add font awesome to ui.bootstrap and mm.foundation
* Add bs3-2-zf6 style css form bridge between bootstrap 3 and foundation 6.


### 1.4.2-beta5: August 11th, 2017
* Add directive passwordMatch
* Add directive numbersOnly
* Add directive goConfigUrl
* Add directive goBack

### 1.4.2-beta4: August 9th, 2017
* Add rc-photoswipe module
* Add isoCurrencies module

### 1.4.2-beta3: August 8th, 2017
* Update 720k social share module
* Add default config social share vie config provider

### 1.4.2-beta2: August 4th, 2017
* Fix wpNgRest for update nonce if cookie is changed and nonce must be refreshed by client.

### 1.4.2-beta1: Jully 28th, 2017
* Add filter mapObjectKey
* Change wpNgRest Provider to set header on common with interceptor request set header if rest url match.

### 1.4.1-beta19: Jully 25th, 2017
* Refactoring load settings

### 1.4.1-beta19: Jully 25th, 2017
* Add module ng-photoswipe

### 1.4.1-beta18: Jully 25th, 2017
* Bug fixing jquery chosen embedded in wp-ng_admin style. Solution load style at priority 100 (end) end dequeue style and script handle jquery-chosen.


### 1.4.1-beta17: Jully 25th, 2017
* Add module ng-sweet-alert
* Add module apiNG

### 1.4.1-beta16: Jully 24th, 2017
* Add angular module v-button
* Add angular module v-tabs
* Add angular module v-accordion
* Add angular module v-modal
* Add angular module v-textfield

### 1.4.1-beta15: Jully 20th, 2017
* Add Rollbar logging PHP
* Add File Logging

### 1.4.1-beta14: Jully 16th, 2017
* Add Rollbar angular module "tandibar/ng-rollbar"

### 1.4.1-beta13: Jully 5th, 2017
* Bug fix leaflet google map url protcol for https 

### 1.4.1-beta12: Jully 5th, 2017
* Add Angular Module Galleria
* Add gulp assets vendor copy to dist vendor (for example galleria theme)

### 1.4.1-beta11: June 27th, 2017
* Fix html special char attributes with ENT_QUOTES

### 1.4.1-beta10: June 26th, 2017
* Add module angular-trustpass

### 1.4.1-beta9: June 7th, 2017
* Add module angularjs-gauge
* Add module oi.select

### 1.4.1-beta8: June 6th, 2017
* add htmlspecialchars for before esc_attr value attribute in shortcodes for prevent special char in html attribute.

### 1.4.1-beta7: June 6th, 2017
* Add module ng.deviceDetector
* Update rc-media to alpha2
* Update rd-dialog to 1.0.4
* Add Directive to wp-ng "ngUpdateHidden"
* Add sass mixins for resolve url image and font
* Refactoring rc-media style
* Add shortcode rc-media

### 1.4.1-beta6: Mai 24th, 2017
* Add module rc-media, rc-dialog, webicon, angular-img-crop, ng-file-upload

### 1.4.1-beta5: Mai 22th, 2017
* Add module angular tiny scroll bar

### 1.4.1-beta4: April 29th, 2017
* Add module angular progress button styles 

### 1.4.1-beta3: April 26th, 2017
* Small fix ngDialog css

### 1.4.1-beta2: April 25th, 2017
* Add Module Angular Initial Value

### 1.4.1-beta1: April 23th, 2017
* Change nonce error status code 403 to 406 for auto reload page.

### 1.4.0: April 22th, 2017
* Update ngAntimoderate v1.0.4
* Add filter wp_ng_get_active_modules
* Bug fix bower fallback

### 1.4-beta1: April 18th, 2017
* Update Angular v1.5.10 to v1.6.4
* Add module Authentication satellizer
* Bug fix js angular-social-share
* Bug fix bootstrap-screensize include dependencie of rt-debounce.
* Bug fix angular foundation 6 (mm.foundation) reveal on IE not working. To fix bug load dependencie es6-shim.js

### 1.3.10: April 17th, 2017
* Refactoring label for shortcode
* Add shortcode for checkbox. label can use content shortcode and html.
* Bug fix attribute without value.

### 1.3.9: April 14th, 2017
* Add on shortcode form ng-change.

### 1.3.8: April 14th, 2017
* Bug fix locale shortcode add en_US
* Add Shortcode alert
* Add input value and init attribute value="My default value"
* Fix no model in input with model="true" attribute in shortcode.

### 1.3.7: April 13th, 2017
* Add conditional or in the inline string conditions (condition|condition2)
* Fix conditional inline string (condition|condition2|condition3&condition4|condition5)
* Fix locationTools.decode
* Bug fix shortcode param
* Change name file shortcode
* Add shrotcode ng-form-select for form select
* Add shortcode nf-form-locale for create a select with locale available language.
* Add module angular ui mask

### 1.3.6: Marsh 31th, 2017
* wpNg add factory locationTools to encode and decode URI
* Add Generic URI Query on locationStart.

### 1.3.5: Marsh 31th, 2017
* Bug fix wp_ng_add_plugin_support on add mixed features with param and without param.
* Bug fix tiny mce editor.
* Small bug fix

### 1.3.4: Marsh 28th, 2017
* Add filter condition to load module. and refactoring to accept 2 param condition.

### 1.3.3: Marsh 27th, 2017
* Refactoring field settings name to label
* Add module social 720kb.socialshare.
* Add module videogular
* Add shortcode ng-directive start implementation.
* Add shortcode ng-socialshare (use module 720kb.socialshare)
* Add directive ifModuleLoaded. Example check ui-bootstrap module loaded or and mm.foundation module load.

### 1.3.2: Marsh 13th, 2017
* Update angular foundation v0.11.15
* Add workaround CSS for angular foundation tabs not working with foundation v6.3 

### 1.3.1: February 21th, 2017
* Add module bootstrap-screensize.

### 1.3.0: February 15th, 2017
* Add Shortcodes for Form (ng-form-input, ng-form-submit).
* Bug fix not found in queue script and style removed by deregister. Add dequeue before deregister.

### 1.2.16: February 13th, 2017
* Bug fix conditional to use function with args separate them with char '$' in the string.

### 1.2.15: February 13th, 2017
* Add wp_ng_current_plugin_supports for force active module in plugin

### 1.2.14: February 10th, 2017
* Move preload in wp-ng.js to add class on app element.
* bug fix action if ng-submit is defined

### 1.2.13: February 7th, 2017
* Bug fix jquery load jquery-core and jquery-migrate.
* Add cdn jquery-migrate with fallback
* Add options to disbale cdn angular and jquery

### 1.2.12: February 6th, 2017
* Workaround form not send if action not defined or action egual to base url. Force action to base url (woocommerce add to cart).
* Add module wp-ng_LiveSearch

### 1.2.11: February 4th, 2017
* Bug fix foundation init if not defined.

### 1.2.10: February 2th, 2017
* Bug fix bower get version with '#'
* Add accordion animation.

### 1.2.9: February 1th, 2017
* Add module ng-focus-if

### 1.2.8: January 31th, 2017
* Add angular module hl.sticky
* Bug fix module name in descriptor. All __dot__ not __DOT__

### 1.2.7: January 31th, 2017
* Reverse foundation load on run angular. Bug init drill menu in pageslide.

### 1.2.6: January 31th, 2017
* Bug fix load foundation. move load foundation on document ready.
* Workaround sticky on initialize.

### 1.2.5: January 30th, 2017
* Add options adavanced 
* Add option disable wpautop
* Add option disable tinymce verify html

### 1.2.4: January 23th, 2017
* Bug fix "register_external_modules" with style src not empty add subfield style to default on.

### 1.2.3: January 23th, 2017
* Update ng-antimoderate

### 1.2.2: January 5th, 2017
* Add on uninstall plugin delete options wp-ng

### 1.2.1: December 20th, 2016
* Add log and check foundation initialized
* Add settings app element

### 1.2.0: December 19th, 2016
* Update foundation 6.3.0

### 1.1.2: December 19th, 2016
* Add module angular-progressbar, angularjs-breakpoint

### 1.1.1: December 19th, 2016
* Add Angular module angular-svg-round-progressbar
* various fix

### 1.1.0: December 12th, 2016
* Settings page tab to auto load angular module

### 1.0.4: December 1th, 2016
* Add wp-ng generic directives
* Remove module angular html compile directive

### 1.0.3: November 29th, 2016
* Add some angular modules
* Update Readme

### 1.0.2: November 10th, 2016
* Update Readme

### 1.0.1: November 10th, 2016
* Update Readme

### 1.0.0: November 8th, 2016
* First Release

### 1.0-beta17: November 2th, 2016
* Add ng-cloak-animation

### 1.0-beta16: November 2th, 2016
* Add angular ngGeonames module
* Add angular ngAntimoderate module

### 1.0-beta15: October 17th, 2016
* Remove angular-pjax module

### 1.0-beta14: October 17th, 2016
* Add angular-pjax module

### 1.0-beta10: October 6th, 2016
* Add modules

### 1.0-beta9: October 5th, 2016
* Add compatibility wp rest api and wpml for rest api

### 1.0-beta8: September 8th, 2016
* Bug fix add field settings

### 1.0-beta7: September 7th, 2016
* Bug fix get_local_path for combine style and script

### 1.0-beta6: August 16th, 2016
* Small change wp-ng.js 
* Add notice minimum version of WP. 
* Add fr_FR
* get_option return default if option return false or empty string 

### 1.0-beta5: August 16th, 2016
* Various bug fix
* Add settings cache
* Refactor bootstrap angular app
* Add manage handle with multiple angular module in same script. Each module will be separate with '+' for enqueue the script.
* Add filter to exclude module default module exclude is 'wp-ng_app' and module name with the app name.
* Add dependency jquery for angular script

### 1.0-beta4: August 15th, 2016
* Various bug fix
* Add settings cache
* Refactor bootstrap angular app

### 1.0-beta3: August 9th, 2016
* Rename author and change link author to RedCastor
* Bug fix handle script or style not registered. Add check handle isset in registered array $wp_script and $wp_style 

### 1.0-beta2: August 8th, 2016
* Change action enqueue script to wp_head
* Add setting body cloak
* Add disable settings
* Add filter "wp_ng_app_config"
* Add in wpngRootConfig more configuration "baseUrl", "local", "debug", "env"

### 1.0-beta1: August 3th, 2016
* Start Project
