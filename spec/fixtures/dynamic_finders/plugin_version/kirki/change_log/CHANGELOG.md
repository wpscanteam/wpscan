## 3.0.44

Jun.25 2019, dev time: 30m

* Fix: Google fonts getting constantly downloaded when `WP_DEBUG` was set to `true`

## 3.0.43

Jun.16 2019, dev time: 30m

* Fix: Google Fonts URL references in multisites.
* New: It is now possible to reset Kirki google-font caches by visiting {site-url}/?action=kirki-reset-cache

## 3.0.42

Jun.16 2019, dev time: 2h

* Deprecated: `fontawesome` field was deprecated. If a theme uses this field users will be prompted to install the official Font Awesome plugin from the w.org repository.
* Fix: Transient for Google Fonts now has a lifetime of 1 day instead of 1 week.
* Fix: Updated Google Fonts list.

## 3.0.41

Jun.8 2019, dev time: 30m

* Fix: http/https issue for locally-hosted googlefonts
* Fix: Updated Google-fonts list.

## 3.0.40

Jun.1 2019, dev time: 30m

* Fix: Updated URL for fontawesome to avoid tracking.
* Fix: Updated Google-fonts list.

## 3.0.39

Mar.31 2019, dev time: 30m

* Fix: Updated the styles for colorpickers to make them responsive.
* Fix: Google-fonts processing for some font-weights. [#2106](https://github.com/aristath/kirki/pull/2106) props @dedalx
* Fix: SCSS support for the `code` control. [#2112](https://github.com/aristath/kirki/pull/2112) props @reiterbene
* Fix: Locally downloadding google-fonts. [#2118](https://github.com/aristath/kirki/pull/2118) props @plazorax
* Update: Updated the Google Fonts list.

## 3.0.38

Mar. 1, 2019, dev time: 20m.

* Fix: Editor styles.
* Update: Updated the Google Fonts list.

## 3.0.37

Feb. 26, 2019, dev time: 1h.

* Fix: CSS conflict in posts quickedit table
* Fix: Load webfonts in the dashboard.
* Fix: Add back the `kirki_auto_postmessage` filter.
* Update: Updated the Google Fonts list.

## 3.0.36

Feb. 17, 2019, dev time > 100h

This updates represents a big performance improvement both for the frontend and the customizer.
In the frontend the google-fonts are now loaded more efficiently and the `font-display` property was added to `@font-face` CSS from the google API responses.
In the customizer the `postMessage` module was completely rewritten.

* Fix: `active_callback` argument for `dropdown-pages` control. [#2055](https://github.com/aristath/kirki/issues/2055)
* Fix: `color ` control issues when inside a repeater. [#2059](https://github.com/aristath/kirki/issues/2059)
* Fix: Updated Google Fonts
* Fix: No longer enqueueing an empty stylesheet in order to add styles inline.
* Fix: Gutenberg implementation improvements.
* New: Google Fonts are now embedded inside the dynamic-css instead of using the webfont-loader script when not in the customizer.
* New: Google Fonts are now always used locally when possible, the google-CDN is only used as a fallback.
* New: Performance improvement by using `font-display:swap` for google-fonts.
* New: Added `kirki_googlefonts_font_display` filter.
* New: Added a new `link` section-type.
* New: Completely refactored the `postMessage` module. The new implementation is JS-based instead of PHP and is a lot more performant.
* New: Added telemetry module. See [kirki.org/docs/modules/telemetry](https://kirki.org/docs/modules/telemetry.html) for details.
* New: Improved CSS loading method. Styles are now added inline.
* New: Introduced a `kirki_output_inline_styles` filter - can be used by themes that want to enqueue a dynamic stylesheet with a URL `example.com/?action=kirki-styles` instead of the inline method.
* Deprecated: Removed the "host locally" option from typography controls. This is now the default behaviour and significantly improves performance. Option is no longer necessary.
* Deprecated: Removed the `Kirki_CSS_To_File` class.
* Reprecated: Removed the `Kirki_Modules_Webfonts_Local` class.
* Deprecated: Removed the `Kirki_Fonts_Google_Local` class.

## 3.0.35.3

Dec. 26, 2018, dev time: 1h

* Fix: Update CSS-Vars when the preview pane refreshes.
* Fix: Tweaked the CSS Values JS-validation function.
* Fix: Update Google Fonts.

## 3.0.35.2

Dec. 8, 2018, dev time: 20m

* Fix: Correctly output css-vars on the top pf admin pages for use in Gutenberg styles.
* Fix: Update Google Fonts.

## 3.0.35.1

Dec. 6, 2018, dev time: 5m

* Fix: PHP 5.2 conflict.

## 3.0.35

Dec. 6, 2018, dev time: 15h

* New: Add Gutenberg support [#2009](https://github.com/aristath/kirki/issues/2009) props @timelsass
* Fix: Add additional check for variants in the typography control - fixes JS issue if no variants were found.
* Fix: Reviews all sanitization, validation & escaping calls and adjusted them where necessary. This is one step closer to full WPTRT compliance. Props @poena for bringing this to my attention.
* Fix: Improved implementation for the `sortable` control.
* Fix: `kirki_modules` filter was not working. [#2023](https://github.com/aristath/kirki/issues/2023)
* Fix: Issue with google-fonts loading when in the customizer and the typography field uses `postMessage`. [#1988](https://github.com/aristath/kirki/issues/1988)
* Fix: Changed the priority for css-vars.
* Fix: Dependencies for the code control. [#2020](https://github.com/aristath/kirki/issues/2020)
* Fix: PHP 5.2 error `T_PAAMAYIM_NEKUDOTAYIM` [#2032](https://github.com/aristath/kirki/issues/2032)
* Fix: Code cleanup in the repeater control, props @joyously [ticket](https://wordpress.org/support/topic/repeater-setting-value-function/)
* Tweak: Removed deprecated code & code cleanups.

## 3.0.34

Sept. 14 2018, dev time: 21h.

* Fix: Error when `typography` fields don't have a font-family. [#1916](https://github.com/aristath/kirki/issues/1916), [#1797](https://github.com/aristath/kirki/issues/1797), [#1935](https://github.com/aristath/kirki/issues/1935). props @mintbird
* Fix: Allow using "Default Browser Font-Family" in default value (`typography` fields) [#1907](https://github.com/aristath/kirki/pull/1907). props @mintbird
* Fix: Envato theme-check error [#1914](https://github.com/aristath/kirki/issues/1914), [#1926](https://github.com/aristath/kirki/pull/1926). props @timelsass
* Fix: HTTPS webfont load error [#1925](https://github.com/aristath/kirki/issues/1925)
* Fix: Undefined index PHP notice for background-color. [95ca010](https://github.com/aristath/kirki/pull/1930/commits/95ca010588878363a7d2042f09428bae260cb602)
* Fix: Minor Fixes for css-variables added in v3.0.28.
* New: Allow unitless values in dimension controls.
* New: (Refactor) Migrated `image` controls to new structure in preparation of v3.1
* Update: Updated Google-fonts.

## 3.0.33

May 17 2018

* Fix: Google-Fonts folder permissions improperly set in v3.0.28.
* Fix: Select issues in repeater controls [#1892](https://github.com/aristath/kirki/issues/1892), [#1888](https://github.com/aristath/kirki/issues/1888) props @asilcetin.
* Fix: Updated Google Fonts to include latest font-family additions.

## 3.0.32

May 16 2018

* Fix: Reverted some google-fonts changes. Fixes loading issues on some environments.
* New: Added option per-typography-control to allow users to host Google Fonts on their own servers (GDPR compliance).

## 3.0.31

May 16 2018

* Fix: Added fallback to google-CDN if locally-hosted google-fonts can't be found.
* Fix: Updated google-fonts list.

## 3.0.30

May 15 2018

* Fix: Fixed caching for locally-downloaded google-fonts (GDPR compliance helper).

## 3.0.29

May 15 2018

* Fix: PHP error in some PHP versions because of the "do" method-name.

## 3.0.28

May 15 2018, dev time: 12 hours.

* Fix: Repeater control JS issue if saved value is malformatted [#1879](https://github.com/aristath/kirki/issues/1879) - props @asilcetin.
* Fix: Preset control bug [#1882](https://github.com/aristath/kirki/issues/1882).
* Fix: JS error if an SVG is uploaded to an image control [#1883](https://github.com/aristath/kirki/issues/1883) Props @seantjohnson-dev
* New: GDPR-Compliance: Google-Fonts are now downloaded server-side bypassing the google-CDN which collects user's IP addresses and personal data without their consent.
* New: Added support for css-variables.

## 3.0.27

April 30 2018, dev time: 1 hour.

* Fix: multiselect in repeaters. Props @asilcetin [#1876](https://github.com/aristath/kirki/issues/1876).
* Fix: CSS output on numeric values. [issue link](https://wordpress.org/support/topic/all-css-output-from-kirki-stop-working-on-version-3-0-26/).

## 3.0.

April 27 2018, dev time: 43 hours.

* Fix: Color Palette: material colors 'light-blue' doesn't work [#1783](https://github.com/aristath/kirki/issues/1783).
* Fix: Google Fonts switch error [#1791](https://github.com/aristath/kirki/issues/1791).
* Fix: FontAwesome JS is being loaded even if you don't need it on front end [#1786](https://github.com/aristath/kirki/issues/1786).
* Fix: Color Palette: Active color before section title [#1782](https://github.com/aristath/kirki/issues/1782).
* Fix: Removed version from the webfont script.
* Fix: Validation error for dimension fields.
* Fix: `button_label` argument for repeater fields (props @felipeelia).
* Fix: Allow html on radio-buttonset choices [#1818](https://github.com/aristath/kirki/issues/1818).
* Fix: `Kirki_Helper::compare_values` vs. `field-dependencies.js` boolean issue (props @CaptJiggly) [#1825](https://github.com/aristath/kirki/issues/1825).
* Fix: `active_callback` not working for checkboxes [#1809](https://github.com/aristath/kirki/issues/1809).
* Fix: Nested `active_callback` args not working properly (AND|OR relations) [#1809](https://github.com/aristath/kirki/issues/1809).
* Fix: Updated google-fonts.
* Fix: Display typography with no default values [#1797](https://github.com/aristath/kirki/issues/1797).
* Fix: Define "normal" as a valid css-value for sanitizations [#1814](https://github.com/aristath/kirki/issues/1814).
* Fix: `background` controls now output `background-color` as simply `background` if no `background-image` is defined in the value [#1808](https://github.com/aristath/kirki/issues/1808).
* Fix: @media-queries fix due to minimized CSS. [#1787](https://github.com/aristath/kirki/issues/1787).
* Fix: `Kirki_Helper::compare_values` contains/in PHP warning if value doesn't exist in array [#1828](https://github.com/aristath/kirki/issues/1828).
* Fix: Invalid Value in the Dimension control [#1844](https://github.com/aristath/kirki/issues/1844).
* Fix: Add `fr` to the array of valid units used in validations [
86adedb](https://github.com/aristath/kirki/pull/1784/commits/86adedb8cd4c06c7e6538c3087233a6840dee562)
* Fix: Updated webfonts.
* New: Migrated `number` control to new structure.

## 3.0.25

January 23 2018, dev time: 1 hour.

Please note that the typography controls since v3.0.23 no longer require subsets. This is not a bug or omission, subsets are simply no longer necessary because there's an implementation now that loads them properly without requiring the user to define it.

* Fix: partial reversion of webfontloader improvements in order to resolve an issue with incorect font-weights loading.

## 3.0.24

January 23 2018, dev time: 10 minutes.

* Fix: Added back the `get_google_font_subsets()` method. Although it was always meant just to be used internally apparently a couple of themes out there use it and its removal caused a fatal error.

## 3.0.23

January 22 2018, dev time: 23 hours.

* Fix: clear button on color controls [#1720](https://github.com/aristath/kirki/issues/1720)
* Fix: PHP mode in code controls.
* Fix: `active_callback` not working for upload fields [#1732](https://github.com/aristath/kirki/issues/1732)
* Fix: accessibility issue on radio-buttonset controls [#1722](https://github.com/aristath/kirki/issues/1722)
* Fix: `active_callback` not working for cropped-image controls [#1752](https://github.com/aristath/kirki/issues/1752)
* Fix: added support for `button_labels` in image fields [#1173](https://github.com/aristath/kirki/issues/1173)
* Fix: Support for adding inline CSS to an already defined stylesheet.
* Fix: Sanitization in section & panel descriptions and priorities [#1759](https://github.com/aristath/kirki/issues/1759)
* Fix: `active_callback` support when using serialized options [#1745](https://github.com/aristath/kirki/issues/1745)
* Fix: Remove timepicker from date control [#1750](https://github.com/aristath/kirki/issues/1750)
* Fix: WebfontLoader improvements.
* Fix: Now using a datepicker for the `date` control [#1767](https://github.com/aristath/kirki/issues/1767)
* New: Added "inherit" in the typography control's font-family option [w.org ticket](https://wordpress.org/support/topic/inherit-and-typography-control/)
* New: Added googlefonts resource hints. Props @aryaprakasa.
* New: Now loading fontawesome from a CDN. smaller footprint for the plugin and async loading will improve performance for everyone [#1763](https://github.com/aristath/kirki/issues/1763)
* Tweak: Removed legacy code.
* Tweak: Code cleanups.
* Deprecated: Typography controls no longer require the "subset" dropdown.

## 3.0.22

December 20 2017, dev time: 3.5 hours.

* Fix: Files cleanup. Removed webfonts.php and now use the json file.
* Fix: WordPress Coding Standards fixes.
* New: Converted all filter names to use `_` instead of `/` (WPCS). Fallback methods included.
* New: Removed inline methods for webfonts and now use [typekit/webfontloader](https://github.com/typekit/webfontloader).
* New: Update GoogleFonts list.

## 3.0.21

December 18 2017, dev time: 3 hours

* Fix: Allow HTML in labels and descriptions [#1705](https://github.com/aristath/kirki/issues/1705)
* Fix: Code controls minor refactor (now extends the `WP_Customize_Code_Editor_Control` class)
* Fix: Checkbox values sanitization inside repeater controls [#1715](https://github.com/aristath/kirki/issues/1715)
* Fix: JS error in dimension controls when not using a CSS unit [#1711](https://github.com/aristath/kirki/pull/1711) props @FrankM1
* Fix: AJAX issue on a host with weird config.
* New: Add `placeholder` argument in `select` controls [#1593](https://github.com/aristath/kirki/issues/1593)

## 3.0.20

December 13 2017, dev time: 1.5 hours

* Fix: Use `repeat` instead of `repeat-all` in background controls [#1701](https://github.com/aristath/kirki/issues/1701)
* Fix: Use `set_url_scheme()` when outputing images [#1697](https://github.com/aristath/kirki/issues/1697)
* Fix: `textarea` control is broken with HTML content [#1694](https://github.com/aristath/kirki/issues/1694) props @tutv95
* Fix: Typo in `radio` controls [#1699](https://github.com/aristath/kirki/issues/1699)
* Fix: variants selection for standard font-families.

## 3.0.19

December 8 2017, dev time: 20 minutes.

* Fix: WebfontLoader using `i` instead of `400i`.
* Fix: Sometimes `font-weight` and `font-style` don't get applied.

## 3.0.18

December 6 2017, dev time: 1 hour.

* Fix: Standards fonts sometimes not showing in typography control [#1689](https://github.com/aristath/kirki/issues/1689)
* Fix: missing .min.css file

## 3.0.17

December 5 2017, dev time: 46 hours

* Fix: In some cases options were not saved when using `option` instead of the default `theme_mod` [#1665](https://github.com/aristath/kirki/issues/1665)
* Fix: `link` control-type (alias of `url`) was not working [#1660](https://github.com/aristath/kirki/issues/1660)
* Fix: Allow using tabs & linebreaks when defining elements in the `output` argument [#1659](https://github.com/aristath/kirki/issues/1659)
* Fix: PHP Warning when using `code` controls without a `label` defined [#1658](https://github.com/aristath/kirki/issues/1658)
* Fix: Buttons inside `number` controls were not increasing/decreasing the values [#1648](https://github.com/aristath/kirki/issues/1648)
* Fix: JS error  - only on Safari - for Select controls [#1662](https://github.com/aristath/kirki/issues/1662)
* Fix: Unable to deselect all options from multiselect controls [#1670](https://github.com/aristath/kirki/issues/1670)
* Fix: `multicolor` controls missing the `alpha` channel [#1657](https://github.com/aristath/kirki/issues/1657)
* Fix: Unable to manually edit value in `multicolor` controls [#1666](https://github.com/aristath/kirki/issues/1666)
* New: Transitioned to a JS-based webfont loader method to load google-fonts instead of using a link.
* New: Moved `select` controls to new JS implementation.
* New: Moved `text` and `textarea` controls (`generic` controls) to new JS implementation.
* New: Added `text-transform` to `typography` fields [#1642](https://github.com/aristath/kirki/issues/1642)
* New: Refactored typography controls loading for better efficiency and performance
* New: Removed PHP implementation for field dependencies, now using a pure JS solution.
* New: Added support for "outer" sections [#1683](https://github.com/aristath/kirki/issues/1683)
* New: Added new `Kirki::remove_control()`, `Kirki::remove_section()` and `Kirki::remove_panel()` methods.
* New: Added 2 new filters: `kirki/{$config_id}/webfonts/skip_hidden` and `kirki/{$config_id}/css/skip_hidden` [#1678](https://github.com/aristath/kirki/issues/1678)
* Tweak: Validation & Sanitization for `dimension` and `dimensions` controls.
* Tweak: Refactored `multicolor` controls a bit.

## 3.0.16

November 19 2017, dev time: 8 hours

* Fix: `typography` controls not working when they are the only fields used [#1627](https://github.com/aristath/kirki/issues/1627)
* Fix: `slider` controls were not updating the numeric value visually in their textfield when the control was not using `postMessage` [#1633](https://github.com/aristath/kirki/issues/1627)
* Fix: Deprecated call to non-existing `Kirki_Styles_Frontend`, props @FrankM1 [#1644](https://github.com/aristath/kirki/issues/1644)
* Fix: Updated the customizer-styling module for compatibility with WP 4.9 [#1639](https://github.com/aristath/kirki/issues/1639)
* Fix: `code` controls were not using the corect `priority` [#1622](https://github.com/aristath/kirki/issues/1622)
* Fix: Multiple reports of errors in the console.
* New: Refactored the `number` controls [#1631](https://github.com/aristath/kirki/issues/1627)
* New: Refactored the `color` controls. [#1646](https://github.com/aristath/kirki/issues/1646)

## 3.0.15

November 12 2017, dev time: 5 minutes.

* Fix: PHP Warning in the `Kirki_Modules_Webfonts_Link` class [#1626](https://github.com/aristath/kirki/issues/1626)

## 3.0.14

November 11 2017, dev time: 4 hours.

* Fix: Duplicate subsets output in the Google Fonts URLs [#1618](https://github.com/aristath/kirki/issues/1618)
* Fix: Theme Check Warnings [#1613](https://github.com/aristath/kirki/issues/1613)
* Fix: Add Kirki version number when enqueueing scripts & styles (cache-busting) [#1623](https://github.com/aristath/kirki/issues/1623)
* Fix: JS conflict and PHP warning in typography fields when they are not properly defined [#1621](https://github.com/aristath/kirki/issues/1621)

## 3.0.13

November 9 2017, dev time: 3 hours.

* Fix: textdomain typo in a string.
* Fix: radio-image styling.
* Fix: JS error (underscore's `_.isUndefined` for some reason doesn't always work as expected).
* Tweak: Added reset back to sliders.
* Tweak: CSS improvements.

## 3.0.12

November 7 2017, dev time: 42 hours.

This update significantly reduces the plugin size by removing 3rd-party libraries (particularly CodeMirror) and uses the new controls and scripts that become available in WordPress 4.9.
It also changes the file structure and paves the way for a 3.1 rewrite which will be a significant improvement, making Kirki a mostly JS-based app fully integrated in WordPress's JS API and moving away from the PHP API.

* Fix: WordPress 4.9 compatibility for colorpickers.
* Fix: WordPress 4.9 compatibility for typography controls.
* Fix: WordPress 4.9 compatibility for multicolor contols.
* Fix: WordPress 4.9 compatibility for background contols.
* Fix: Refactored `editor` controls to make them compatible with WP 4.9
* Fix: Remove CodeMirror and use the code control from WordPress Core. Code controls will be displayed as textareas in WP older than 4.9.
* Fix: Use new `DateTimeControl` if in WP 4.9+ for date control.
* Fix: Text field styling.
* Fix: Switch controls labels.
* Fix: 'choices' arguments were not getting passed-on due to `is_customize_preview` checks in latest WP Versions.
* Fix: Overriding Kirki translations from a theme when Kirki is embedded.
* New: Replaced `select2` with `selectWoo`.
* New: Added a `Kirki_Control_Base` class and abstracted controls.
* New: Better file structure.
* New: Compiled JS & CSS files.
* New: Added ability to manually enter numeric values in slider controls.
* Tweak: Improved styling of color-palette controls.
* Tweak: Radio-Image controls now display images inline (using flexbox).
* Tweak: Removed the reset switch from slider controls & improved their styling.
* Tweak: Improved typography controls styling for text-align.
* Removed: Reset module.

## 3.0.11

October 12 2017, dev time: 3 hours.

* Fix: Typography controls were not properly saving some sub-values [#1521](https://github.com/aristath/kirki/issues/1521), [#1560](https://github.com/aristath/kirki/issues/1560)
* Fix: Undefined index in the code control [#1567](https://github.com/aristath/kirki/issues/1567)
* Fix: CSS Output for multicolor fields [#1564](https://github.com/aristath/kirki/issues/1564)
* Fix: JS instantiation of controls in expanded sections [#1559](https://github.com/aristath/kirki/issues/1559)
* Fix: LTR for code controls [#1558](https://github.com/aristath/kirki/issues/1558)
* Fix: Remove Reset in default sections [#1580](https://github.com/aristath/kirki/issues/1580)
* Fix: Uncaught TypeError: data.value[choiceKey].replace is not a function [#1578](https://github.com/aristath/kirki/issues/1578)
* Fix: Other code cleanup.
* Fix: Updated google-fonts.

## 3.0.10

September 21 2017, dev time: 74 hours.

* Fix: Allow HTML tags in tooltips [#1536](https://github.com/aristath/kirki/issues/1536)
* Fix: Default System Font Stack for Sans Serif Fonts in Typography Fields [#1530](https://github.com/aristath/kirki/issues/1530)
* Fix: HTML entities in repeater text field being encoded on each save? [#1523](https://github.com/aristath/kirki/issues/1523)
* Fix: Some resetting issues [#1474](https://github.com/aristath/kirki/issues/1474)
* Fix: Allow saving image fields as arrays (url,id,width,height) [#1529](https://github.com/aristath/kirki/issues/1529)
* Fix: Allow saving image fields as ID [#1498](https://github.com/aristath/kirki/issues/1498)
* Fix: Inline docs improvements.
* Fix: `$subsets` not defined in the `Kirki_Modules_Webfonts_Link` class.
* Fix: Coding improvements in the `Kirki_Field` class.
* Fix: Performance Improvements in the autoloader [see commit](https://github.com/aristath/kirki/pull/1454/commits/dd518f7dc35cacf4f2ed571b033519b353aa2545)
* Fix: Undefined index notice in the `Kirki_Output` class.
* Fix: Sanitization for `checkbox`, `switch` and `toggle` controls.
* Fix: `select2` CSS fix for `z-index` [#1459](https://github.com/aristath/kirki/issues/1459)
* Fix: Remove button in image controls when there's no image [#1469](https://github.com/aristath/kirki/issues/1469)
* Fix: Background control styling issue when no other color control exists [#1472](https://github.com/aristath/kirki/issues/1472)
* Fix: Checkbox and Toggle don't respect "value_pattern" [#1467](https://github.com/aristath/kirki/issues/1467)
* Fix: Array to string conversion when clicking reset button [#1477](https://github.com/aristath/kirki/issues/1477)
* Fix: Input Field Validation Issue [#1486](https://github.com/aristath/kirki/issues/1486)
* Fix: Typography: output property not working [#1484](https://github.com/aristath/kirki/issues/1484)
* Fix: postMessage does not work properly when using `prefix` [#1479](https://github.com/aristath/kirki/issues/1479)
* Fix: Use `wp_json_encode` instead of `json_encode`.
* Fix: Use `rawurlencode` instead of `urlencode`.
* New: Added warnings for deprecated functions/methods.
* New: `code` control now loads dynamically (performance improvement).
* New: `color-palette` control now loads dynamically (performance improvement).
* New: `color` control now loads dynamically (performance improvement).
* New: `dashicons` control now loads dynamically (performance improvement).
* New: `date` control now loads dynamically (performance improvement).
* New: `dimension` control now loads dynamically (performance improvement).
* New: `dimensions` control now loads dynamically (performance improvement).
* New: `editor` control now loads dynamically (performance improvement).
* New: `fontawesome` control now loads dynamically (performance improvement).
* New: `generic` control now loads dynamically (performance improvement).
* New: `multicheck` control now loads dynamically (performance improvement).
* New: `number` control now loads dynamically (performance improvement).
* New: `palette` control now loads dynamically (performance improvement).
* New: `preset` control now loads dynamically (performance improvement).
* New: `radio-buttonset` control now loads dynamically (performance improvement).
* New: `radio-image` control now loads dynamically (performance improvement).
* New: `radio` control now loads dynamically (performance improvement).
* New: `select` control now loads dynamically (performance improvement).
* New: `slider` control now loads dynamically (performance improvement).
* New: `switch` control now loads dynamically (performance improvement).
* New: `toggle` control now loads dynamically (performance improvement).

## 3.0.9

July 8 2017, dev time: 7 hours.

* Fix: Add alpha option to multicolor control. Props @danielortiz [#1321](https://github.com/aristath/kirki/issues/1321), [#1449](https://github.com/aristath/kirki/pull/1449)
* Fix: Googlefonts output when `default` argument contains `font-weight` instead of `variant` [#1443](https://github.com/aristath/kirki/issues/1443)
* Fix: Removed the `Kirki_Custom_Build` class.
* Fix: Plugin does not exist error when Kirki is embedded in a theme [#1448](https://github.com/aristath/kirki/issues/1448)
* Fix: Code simplifications and optimizations.

## 3.0.8

June 27 2017, dev time: 4 hours.

* Fix: Typography controls without a variant defined were adding font-weight in the customizer [#1436](https://github.com/aristath/kirki/issues/1436)
* Fix: Set default webfonts loading method to `link` [#1438](https://github.com/aristath/kirki/issues/1438)
* Fix: Bug that prevents custom args from being passed to custom controls [#1425](https://github.com/aristath/kirki/issues/1425). Props @danielortiz
* Fix: `exclude` argument in `output` when combined with `choice` [#1416](https://github.com/aristath/kirki/issues/1416)
* Fix: `active_callback` operators for greater/smaller etc [#1427](https://github.com/aristath/kirki/issues/1427)

## 3.0.7

June 26 2017, dev time: 1 hour.

* Fix: GoogleFonts links were not getting properly created [#1430](https://github.com/aristath/kirki/issues/1430)
* Fix: Incorrect logic when `Kirki::add_field()` only has 1 argument defined [#1429](https://github.com/aristath/kirki/issues/1429)

## 3.0.6

June 25, 2017, dev time: 5 minutes.

* Fix: Typo, PHP 5.2 compatibility.

## 3.0.5

June 25, 2017, dev time: 5 hours.

* Fix: Conflict with the MaxStore Pro theme [#1405](https://github.com/aristath/kirki/issues/1405)
* Fix: CSS Output for Typography controls [#1423](https://github.com/aristath/kirki/issues/1423)
* Fix: PHP Warning in Repeater control. [#1417](https://github.com/aristath/kirki/issues/1417)
* Fix: CSS conflict with the Shortcake plugin [#1418](https://github.com/aristath/kirki/issues/1418)
* Fix: `Kirki_Fonts_Google::$force_load_all_variants` was not working in version 3.0
* Fix: PHP Warning in typography control when the value was corrupted [#1426](https://github.com/aristath/kirki/issues/1426)
* Fix: Notice about incorrect `wp_add_inline_style` when googlefont URL was throwing error [#1410](https://github.com/aristath/kirki/issues/1410)
* Fix: Unable to delete the plugin when it's also embedded in the active theme and plugin version is deactivated [#1421](https://github.com/aristath/kirki/issues/1421)
* Fix: PHP 5.2 compatibility.

## 3.0.4

June 23, 2017, dev time: 2 hours.

* Fix: Added extra checks to avoid PHP Warning in the `Kirki_Fonts_Google` class [#1402](https://github.com/aristath/kirki/issues/1402).
* Fix: `fontawesome` control was throwing a warning in the theme-check plugin.
* Fix: Added the "Default" button back in image controls [#1401](https://github.com/aristath/kirki/issues/1401)
* Fix: Number controls sanitization memory issue [#1404](https://github.com/aristath/kirki/issues/1404)
* Fix: Typography controls font-weight output [#1370](https://github.com/aristath/kirki/issues/1370)
* Fix: The `icon` argument was not working for Panels.

## 3.0.3

June 22, 2017, dev time: 10 minutes/

* Fix: Error when color is not properly formatted.

## 3.0.2

June 22, 2017, dev time: 15 minutes.

* Fix: CSS bugfixes in the `editor` control.
* Fix: Improvements when embedding Kirki in a theme.

## 3.0.1

June 22, 2017, dev time: 5 minutes.

* Fix: Undefined index PHP Notice.

## 3.0.0

June 22, 2017, dev time: 243 hours.

This is a major release. Many things have been refactored and optimized. Please keep a backup before updating.

* Fix: Refactored the reset module. [#1334](https://github.com/aristath/kirki/pull/1334)
* Fix: Refactored the postMessage module [#1333](https://github.com/aristath/kirki/issues/1333)
* Fix: PHP mode on CodeMirror. [#1003](https://github.com/aristath/kirki/issues/1003)
* Fix: Dynamic repeater labels now use the label instead of value when picking up label from select field. [#1230](https://github.com/aristath/kirki/issues/1230)
* Fix: Sanitization for number fields. [#1240](https://github.com/aristath/kirki/issues/1240)
* Fix: Checkboxes sanitization. [#1195](https://github.com/aristath/kirki/issues/1195)
* Fix: Link functionality in editor field. [#968](https://github.com/aristath/kirki/issues/968), [#1159](https://github.com/aristath/kirki/issues/1159)
* Fix: Issues in Field Type editor [#1260](https://github.com/aristath/kirki/issues/1260)
* Fix: Problems with sortable control [#1253](https://github.com/aristath/kirki/issues/1253), [#1197](https://github.com/aristath/kirki/issues/1197), [#1198](https://github.com/aristath/kirki/issues/1198)
* Fix: inaccessibility of options panel [#1194](https://github.com/aristath/kirki/issues/1194)
* Fix: Fields "checkbox", "toggle" and "switch" don't save as boolean in PHP, instead integer 0/1 [#1195](https://github.com/aristath/kirki/issues/1195)
* Fix: Tooltip not working for switch [#1225](https://github.com/aristath/kirki/issues/1225)
* Fix: Tooltip height fix in [#1228](https://github.com/aristath/kirki/issues/1228)
* Fix: Tooltip not closing when clicking outside of icon [#1226](https://github.com/aristath/kirki/issues/1226)
* Fix: Issue with visual representation of color picker (alpha iris) [#1218](https://github.com/aristath/kirki/issues/1218)
* Fix: Reset is "undefined" [#1210](https://github.com/aristath/kirki/issues/1210)
* Fix: Controls that save arrays cause PHP Notices [#1199](https://github.com/aristath/kirki/issues/1199)
* Fix: Disabled the "loading" module by default. Use the `kirki/modules` filter to enable.
* Fix: Refactored saving user-meta (`'option_type' => 'user_meta'`). [#1325](https://github.com/aristath/kirki/issues/1325)
* Fix: Code fields reset [#1122](https://github.com/aristath/kirki/issues/1122)
* Fix: Typography fields reset [#1193](https://github.com/aristath/kirki/issues/1193), [#1219](https://github.com/aristath/kirki/issues/1219)
* Fix: Multicolor fields reset [#916](https://github.com/aristath/kirki/issues/916)
* Fix: Custom fonts not displayed as active in the font list after saving [#1110](https://github.com/aristath/kirki/issues/916)
* Fix: Support for `media_query` when using `'transport' => 'auto'`. [#1184](https://github.com/aristath/kirki/issues/1184), [#1127](https://github.com/aristath/kirki/issues/1127)
* Fix: Typography field bug when switching Google Fonts with different weights [#1180](https://github.com/aristath/kirki/issues/1180)
* Fix: Font Variant outputs invalid property value (typography field) [#1058](https://github.com/aristath/kirki/issues/1058)
* Fix: Updated webfonts. [#1303](https://github.com/aristath/kirki/issues/1303)
* Fix: required argument not work with postMessage type. [#1031](https://github.com/aristath/kirki/issues/1031)
* Fix: Notice: Undefined index, repeater field. [#1291](https://github.com/aristath/kirki/issues/1291)
* Fix: 403 errors for CSS and JS files on localhost. [#1309](https://github.com/aristath/kirki/issues/1309)
* Fix: Customizer doesn't load if ACF PRO is active. [#1302](https://github.com/aristath/kirki/issues/1302)
* Fix: Enqueued google font even if not in use. [#1297](https://github.com/aristath/kirki/issues/1297)
* Fix: Default dimension value does not process well percent units [#1254](https://github.com/aristath/kirki/issues/1254), [#497](https://github.com/aristath/kirki/issues/497)
* Fix: Editor field issue with RTL languages [#340](https://github.com/aristath/kirki/issues/340)
* Fix: Windows Server Issues [#1318](https://github.com/aristath/kirki/issues/1318)
* New: Added code to automatically handle translations when Kirki is embedded in a theme [#1381](https://github.com/aristath/kirki/issues/1381)
* New: Automating postMessage for composite fields. [#694](https://github.com/aristath/kirki/issues/694)
* New: OR logic in field dependencies. [#839](https://github.com/aristath/kirki/issues/839)
* New: Radio-image labels. [#1090](https://github.com/aristath/kirki/issues/1090), [#1220](https://github.com/aristath/kirki/issues/1220)
* New: Typography fields support for `prefix`, `suffix`, `value_pattern` in `output` argument. [#1183](https://github.com/aristath/kirki/issues/1183)
* New: Multi-selects in repeater fields. [#780](https://github.com/aristath/kirki/issues/780), [#1261](https://github.com/aristath/kirki/issues/1261)
* New: Typography fields now support live-updating using `'transport' => 'auto'`. [#1184](https://github.com/aristath/kirki/issues/1184), [#528](https://github.com/aristath/kirki/issues/528), [#1186](https://github.com/aristath/kirki/issues/1186)
* New: Typography fields now support filtering the available fonts. [#1202](https://github.com/aristath/kirki/issues/1202)
* New: Typography fields now support loading multiple variants. [#992](https://github.com/aristath/kirki/issues/992), [#1082](https://github.com/aristath/kirki/issues/1082), [#1114](https://github.com/aristath/kirki/issues/1114)
* New: Select fields now support optgroups. [#1120](https://github.com/aristath/kirki/issues/1120)
* New: Added new background control-type. [#741](https://github.com/aristath/kirki/issues/741), [#1283](https://github.com/aristath/kirki/pull/1283), [#952](https://github.com/aristath/kirki/pull/952)
* New: Replaced selectize with select2. [#1177](https://github.com/aristath/kirki/issues/1177)
* New: Notifications for number fields when value is invalid depending on min/max/step values.
* New: Rebuilt typography control using select2. [cafb89b ](https://github.com/aristath/kirki/commit/e27fa1ff19ab52b34467bfb306b5870d858f409f)
* New: Allow modifying values instead of replacing them when using `js_vars` with `function` set to `html` by using the `value_pattern` parameter and the `$` placeholder. [#1137](https://github.com/aristath/kirki/pull/1137)
* New: Updated CodeMirror. [fff6df0](https://github.com/aristath/kirki/commit/34fdaa562fdd33fa595db927ee597265a753b3b4)
* New: Added word-spacing to the typography control. [#1163](https://github.com/aristath/kirki/issues/1163)
* New: Refactored file structure to make fields self-contained entities, easier to decouple & debug.
* New: Introducing "modules".
* New: Refactored the tooltips feature (now a module).
* New: Selective refreshes are now a module.
* New: postMessage is now a module.
* New: Refactored section & panel icons (now a module).
* New: Customizer-Styling is now a module.
* New: Customizer-Branding is now a module.
* New: CSS-Output is now a module.
* New: Abstracted the "spacing" control and created a new "dimensions" control from it.
* New: Allow saving site-options(`'option_type' => 'site_option'`) [#1326](https://github.com/aristath/kirki/issues/1326)
* New: Added 2 new methods for enqueueing google fonts. See the [`kirki/googlefonts_load_method`](https://github.com/aristath/kirki/blob/9e3e4a6928339bdcd0f7520d305c145a80a06c8a/modules/webfonts/class-kirki-modules-webfonts.php#L100) filter.
* New: Googlefonts now by default added inline in the stylesheet to avoid an extra call to the GoogleFonts API. (SEO & performance improvement).

## 2.3.8

May 28, 2017, dev time: 15 minutes.

This is a maintenance release that prepares for 3.0.0 coming soon.

* Fix: Updating webfonts.
* New: Added ability to use upgrade notices. Needed for v3.0 in a few days.

## 2.3.7

October 22, 2016, dev time: 12 hours.

* Fix: `spacing` controls were not updating after save
* New: Now using the WP Notifications API in the customizer for spacing & dimension controls (requires WP 4.6).
* Fix: Allow overriding `option_type` with `theme_mod` when global config uses `option` by using the `option_type` argument in the fields.
* Fix: Disabled the custom kirki-preview loader. This will have to be built more modular in future versions.
* Fix: Refactored panel & section icons.
* Fix: postMessage now works better with slider controls.
* Fix: Reset button not working unless tooltips are loaded.
* Fix: Properly sanitize `link` and `url` fields.
* Fix: Automate sanitization for `repeater` fields.

## 2.3.6

August 28, 2016, dev time: 3 hours.

* Fix: CSS prefixes order fixes ([#1042](https://github.com/aristath/kirki/pull/1042)).
* Fix: `suffix` output argument support in Multicolor control ([#1042](https://github.com/aristath/kirki/pull/1042)).
* Fix: `Kirki::get_variables()` method should be static ([#1050](https://github.com/aristath/kirki/pull/1050)).
* Fix: Add line wrapping to CodeMirror ([#1079](https://github.com/aristath/kirki/pull/1079)).
* Fix: `container_inclusive` is disregarded on the selective refresh class ([#1089](https://github.com/aristath/kirki/issues/1089)).
* Fix: Support `input_attrs` parameter for controls ([#1074](https://github.com/aristath/kirki/issues/1074)).
* Fix: Outdated Google-Fonts list ([#1091](https://github.com/aristath/kirki/issues/1091)).

## 2.3.5

July 2, 2016. dev time: 6 hours.

* FIX: Missing button labels in `repeater` fields.
* FIX: Missing button label in `code` fields ([#1017](https://github.com/aristath/kirki/issues/1017)).
* FIX: Better implementation when embedding Kirki in a theme ([#1025](https://github.com/aristath/kirki/issues/1025)).
* FIX: Updated google-fonts ([#1041](https://github.com/aristath/kirki/issues/1041)).
* NEW: Allow simpler format for `variables` argument ([#1020](https://github.com/aristath/kirki/issues/1020)).

## 2.3.4

June 1, 2016, dev time: 30 minutes.

* FIX: Repeater JS issues due to error in translation strings.

## 2.3.3

May 31, 2016, dev time: 17 hours.

* FIX: Editor field covering the content ([#955](https://github.com/aristath/kirki/issues/955)).
* FIX: Smoother transition for editor switching.
* FIX: Code field JS error when using "php" mode ([#958](https://github.com/aristath/kirki/issues/958)).
* FIX: `postMessage` for typography fields ([#528](https://github.com/aristath/kirki/issues/528)).
* FIX: translation strings ([#960](https://github.com/aristath/kirki/issues/960)).
* FIX: `postMessage` for `background-image` properties ([#963](https://github.com/aristath/kirki/issues/963)).
* FIX: Reset Typography Control without font-family default value ([#951](https://github.com/aristath/kirki/issues/951)).
* FIX: Typography field: font-style missing in CSS output if variant is regular/400 ([#977](https://github.com/aristath/kirki/issues/977)).
* FIX: Placing two editor controls in the customizer leads to odd behavior ([#140](https://github.com/aristath/kirki/issues/140)).
* FIX: Typography field: letter-spacing missing in CSS output if its value is 0 ([#978](https://github.com/aristath/kirki/issues/978)).
* FIX: Allow using HTML in section descriptions ([#976](https://github.com/aristath/kirki/issues/976)).
* FIX: Bug preventing partial refreshes from working properly ([#991](https://github.com/aristath/kirki/issues/991)).
* FIX: Better internationalization handling.
* FIX: Output errors on typography settings ([#975](https://github.com/aristath/kirki/issues/975)).
* NEW: Added a new `attr` argument to `js_vars` ([#957](https://github.com/aristath/kirki/issues/957)).
* NEW: Implemented both `AND` and `OR` conditionals in `active_callback` arrays ([#839](https://github.com/aristath/kirki/issues/839)).
* NEW: Allow defining an array of dashicons to use.
* NEW: Added a `link` control type.

## 2.3.2

May 2, 2016, dev time: 52 hours.

* NEW: Completely refactored `editor` controls.
* NEW: Completely re-styled `code` controls.
* NEW: Added a new `kirki/{$config_id}/styles` filter ([#908](https://github.com/aristath/kirki/issues/908)).
* NEW: Added a `customize-control-kirki` class to all Kirki controls.
* FIX: Field type number : Cannot read property 'min' of undefined ([#911](https://github.com/aristath/kirki/issues/911)).
* FIX: All controls are now prefixed ([#918](https://github.com/aristath/kirki/issues/918))
* FIX: `alpha` argument in color-alpha controls ([#932](https://github.com/aristath/kirki/issues/932)).
* FIX: Name attribute in repeaters (props @guillaumemolter).
* FIX: Missing label for checkbox controls inside repeaters (props @guillaumemolter).
* FIX: Placing 2 editor controls in the customizer leads to odd behaviour ([#140](https://github.com/aristath/kirki/issues/140)).
* FIX: `active_callback` conbined with the old `required` argument. ([#906](https://github.com/aristath/kirki/issues/906)).
* FIX: Double prefix and suffix in `js_vars` ([#943](https://github.com/aristath/kirki/issues/943)).
* FIX: Typography control returns both 'subset' and 'subsets' indexes with the same value ([#948](https://github.com/aristath/kirki/issues/948)).
* FIX: Use `strict` JS mode in all controls.

## 2.3.1

April 19, 2016, dev time: 30 hours.

* FIX: Spacing control JS dependencies.
* FIX: Output property ignored in multicolor field.
* FIX: Image sub-controls in repeaters were causing a JS error.
* FIX: Text Domain Compliance with Themecheck.
* FIX: PostMessage scripts when using more than 1 elements for the output.
* FIX: Default values for swithes, toggles & checkboxes.
* FIX: Conflict with WP Core's `dropdown-pages` control.
* FIX: Auto-transport not working when using serialized options instead of theme_mods.
* FIX: `value_pattern` was not working properly when used in `js_vars`.
* FIX: Repeater control bugfixes (props @guillaumemolter).
* FIX: multi-selects saving single value.
* NEW: Added support for `upload` controls in repeaters (props @guillaumemolter).
* NEW: Adding mime_type parameter for image, cropped_image, upload controls in repeaters (props @guillaumemolter).
* NEW: Added color-picker support in repeater fields (props @guillaumemolter).

## 2.3.0

April 10, 2016, dev time: 21 hours.

Kirki is now 100% WordPress Coding Standards compliant.

* FIX: Escaping google-font URLs when possible.
* FIX: Only enqueue the tooltips script if needed.
* FIX: WordPress Coding Standards.
* FIX: undefined sub-controls were still being saved in typography fields
* FIX: Javascript Console Errors: "wp.customize" object undefined when Kirki fields were added in `customize_register`
* FIX: markup in editor fields - props @manuelmoreale.
* FIX: multiple styles in head when using js_vars
* FIX: Sanitization for rem units
* FIX: CSS output for multicolor controls
* NEW: Repeater labels are now dynamic - props @guillaumemolter.
* NEW: The entire header on repeaters is now draggable - props @guillaumemolter.
* TWEAK: More efficient JS code for the typography control

## 2.2.10

* FIX: Issue with URLs when using Kirki embedded in a theme and not installed as a plugin.

## 2.2.9

* FIX: Repeater controls were not working on 2.2.8 due to a typo - props @guillaumemolter
* NEW: Repeater fields now allow more control types (email/tel/url/hidden) - props @guillaumemolter

## 2.2.8

April 6, 2016, dev time: 5 hours.

* FIX: Enqueued assets missing when useg WP_DEBUG & WP_DEBUG_SCRIPT
* FIX: Checkboxes were not properly displaying their values
* FIX: Javascript errors when `number` controls were used without `min`, `max` or `step`.
* FIX: Multiselect controls issue with the `sanitize_callback` used.
* NEW: Make attributes in `cropped_image` sub-controls inside repeaters dynamic (props @guillaumemolter).

## 2.2.7

April 5, 2016, dev time: 23 hours.

* FIX: Properly parsing `postMessage` scripts when `transport` is set to `auto`.
* FIX: Background image was outputing CSS even if it was empty.
* FIX: Default value for checkboxes.
* FIX: Issue with plugin URLs in the customizer, when the plugin was embedded in a theme.
* FIX: Descriptions were now shown in `sortable` fields.
* FIX: Reset not working for textarea fields.
* FIX: In some cases only the first element in `output` arguments was being processed.
* FIX: edge-case bugfix for select controls when data saved if the db was somehow mis-formatted.
* FIX: Repeater controls now use image IDs instead of image URLs. Props @guillaumemolter
* NEW: Added `text-align` ability in `typography` fields.
* NEW: Added `text-transform` ability in `typography` fields.
* NEW: Introduce `value_pattern` argument for `output` & `js_vars`.
* NEW: Started refactoring the `Kirki_Field` class. Now each field can have its own sub-class extending the main Kirki_Field object.
* NEW: `multicolor` control.
* NEW: Added `cropped_image` support in `repeater`. Props @guillaumemolter
* TWEAK: Renamed `Kirki_Customizer_Scripts_Loading` to `Kirki_Scripts_Loading`.
* TWEAK: Renamed `Kirki_Customizer_Scripts_Tooltips` to `Kirki_Scripts_Tooltips`.
* TWEAK: Renamed `Kirki_Customizer_Scripts_Icons` to `Kirki_Scripts_Icons`.
* TWEAK: More inline comments, docs & coding-standards improvements.
* DEPRECATED: Removed the `Kirki_Colourlovers` class.

## 2.2.6

March 26, 2016, dev time: 10 hours

* FIX: Invalid variants for google fonts were getting enqueued due to a mischeck.
* FIX: Repeater rows are now minimized by default.
* FIX: Styling for the `dropdown-pages` control.
* FIX: `switch` controls now properly resize based on the label used in the `choices` argument.
* FIX: It is now possible to use `calc()` in CSS value controls.
* FIX: Styles were being applied to the customizer even if they were not defined in the `kirki/config` filter.
* FIX: Removed unnecessary class inheritances & other code cleanups.
* NEW: Allow resetting options per-section.
* NEW: Added new `color-palette` control.
* NEW: Added `'transport' => 'auto'` to auto-calculate postMessage scripts from the `output` argument when possible.
* NEW: Added Material design palettes in the `Kirki_Helper` class.
* NEW: Allow changing the "Add Row" text on repeater fields.
* NEW: Allow setting a limit for repeater rows.

## 2.2.5

March 23, 2016, dev time: 7 hours

* FIX: Google fonts now loaded via a PHP array instead of a JSON file.
* FIX: CSS issue due to escaped quotes on standard fonts.
* FIX: Issue when using `units` on `js_vars` combined with the `style` method.
* FIX: Missing textdomain on a string.
* NEW: Refactored postMessage scripts.
* NEW: Allow passing options to iris using the `choices` argument on color controls.
* NEW: Allow disabling the custom loader using the `disable_loader` argument in the `kirki/config` filter.

## 2.2.4

March 20, 2016, dev time: 6 hours

* FIX: Removed unnecessary CSS echoed by the `typography` control
* FIX: Color Calculation class improvements
* FIX: CSS improvement for `toggle` controls
* NEW: Added `dashicons` field
* NEW: Added the ability to limit the number of rows in `repeater` controls (props @fovoc)

## 2.2.3

March 19, 2016

* FIX: Selecting a color inside typography controls was throwing a JS error (typo)
* FIX: CSS alignment for descriptions in toggle controls
* FIX: Default value for letter-spacing setting in typography controls (props @andreg)

## 2.2.2.1

March 18, 2016, dev time: 5 minutes

* FIX: Backwards-compatibility bugfix

## 2.2.2

March 17, 2016, dev time: 10 minutes

* FIX: PHP notice for non-standard controls when the `element` defined in an `output` argument is of type `array`.

## 2.2.1

March 17, 2016, dev time: 3 hours

* FIX: Alpha channel was always enabled for color controls
* FIX: PHP Notices in the class-kirki-output-control-typography.php file
* FIX: PHP Fatal error on PHP 5.2
* FIX: PHP Notice in the class-kirki-field.php file
* FIX: PHP Fatal error when using background-position in the output argument
* TWEAK: Removed unused languages from CodeMirror to reduce the plugin's size

## 2.2.0

March 16, 2016, dev time: 120 hours

* FIX: Improved & simplified the `number` control.
* FIX: Improved & simplified the `spacing` control.
* FIX: Minor bugfix on the `select` control.
* FIX: WP Coding standards improvements.
* FIX: Bugfix for radio controls.
* FIX: Fixed repeater remove image not triggering save button to activate, and added a placeholder when the image is removed. (props @sayedwp)
* FIX: Fixed bug when using negative numbers as min value in the `number` field
* FIX: Typo in the textdomain for some strings (some strings were using "Kirki" instead of "kirki").
* FIX: Complete refactor & rewrite of the google-fonts implementation.
* FIX: IE11 bug on radio-image controls.
* FIX: Radio-image bug when used with serialized options.
* NEW: Complete refactor & rewrite of typography control.
* NEW: Refactored the CSS output methods.
* NEW: Added new mothods for detecting dependencies.
* NEW: Added font-subsets in typography controls.
* NEW: Google fonts now only show valid variants & subsets in typography controls.
* NEW: Implemented partial refreshes for WP 4.5 using a "partial_refresh" argument (formatted as an array).
* NEW: Better autoloader & improved file structure.
* NEW: Deprecated the `Kirki_Field_Sanitize` class in favor of a more simplified & robust implementation.
* NEW: Completely refactored the `Kirki_Field` class, we're migrating to a more OOP model.
* NEW: Added a new `kirki-generic` control.
* NEW: Deprecated the custom text control and used the new `kirki-generic` control instead.
* NEW: Deprecated the custom textarea control and used the new `kirki-generic` control instead.
* NEW: Renamed the `help` argument to `tooltip`. `help` will continue to work as an alias.
* NEW: Merged the `color` & color-alpha` controls. We now use the `color-alpha` control for all colors, and just modify the `data-alpha` property it has.
* NEW: Started an OOP rewrite of many classes
* NEW: Started rewriting the PHPUNIT tests & tweaked them so they can now run on localhosts (like VVV) and not just on travis-ci.
* NEW: Included the ariColor library for color calculations (https://aristath.github.io/ariColor/)
* TWEAK: Other code refactoring for improved performance
* TWEAK: Updated `grunt` packages.

## 2.1.0.1

February 17, 2016, dev time: 5 minutes

* FIX: PHP Notices (undefined index)

## 2.1.0

February 17, 2016, dev time: 4 hours

* FIX: Image field issues inside the Repeater field (props @sayedwp)
* NEW: Allow disabling output per-config
* NEW: Introduce 'postMessage' => 'auto' option in config (will auto-create `js_vars` using the `output` argument)
* NEW: New color control using a js-based template
* TWEAK: Branding script rewrite
* TWEAK: Color controls styling
* TWEAK: Coding improvements & cleanups

## 2.0.9

February 13, 2016, dev time: 1 hour.

* FIX: Google fonts bug (use double quotes when font name contains a space character)
* FIX: Checkbox control bug (checkboxes were always displayed as checked, regardless of their actual value)
* NEW: Intruducing KIRKI_NO_OUTPUT constant that disables CSS output completely when set to true.

## 2.0.8

February 10, 2016, dev time: 2 hours

* FIX: Only load Kirki styles when in the customizer
* FIX: Performance issue with Google Fonts
* NEW: Added radio-image controls to repeaters
* TWEAK: Better color handling in the Kirki_Color class

## 2.0.7

January 19, 2016, dev time: 1 hour

* FIX: Narrow the scope of "multicheck" modification checker (props @chetzof)
* FIX: PHP warnings due to invalid callback method
* FIX: postMessage bug introduced in 2.0.6 (2 lines commented-out)

## 2.0.6

January 18, 2016, dev time: 7 hours

* FIX: Fix active callback for multidimensional arrays. (props @andrezrv)
* FIX: Correctly check current value of checkbox control. (props @andrezrv)
* FIX: Bug in the sortable field (props @daviedR)
* FIX: Fixed some bugs that occured when using serialized options instead of theme_mods
* NEW: Added an image sub-field to repeater fields (props @sayedwp)
* NEW: Added a JS callback to js_vars (props @pingram3541)
* TWEAK: Settings sanitization
* TWEAK: Removed demo theme from the plugin. This is now provided separately on https://github.com/aristath/kirki-demo

## 2.0.5

December 23, 2015, dev time: 2.5 hours

* FIX: Disabled the ajax-loading method for stylesheets. All styles are now added inline. Will be re-examined for a future release.
* FIX: Number controls were not properly triggering changes
* FIX: Styling for number controls
* FIX: In some cases the dynamic CSS was added before the main stylesheet. We now add them using a priority of 999 to ensure they are enqueued afterwards.

## 2.0.4

December 19, 2015, dev time: 3 hours

* NEW: Added units support to the Typography field
* NEW: Default methods of enqueuing styles in now inline.
* NEW: Added 'inline_css' argument to config. set to false to add styles using AJAX.
* FIX: HTML mode for CodeMirror now functional
* FIX: PHP Notices when the config filter is used wrong
* FIX: Monor bugfix for text inputs
* FIX: Indentation & coding standards
* FIX: failing PHPUNIT test.
* TWEAK: Remove passing click event object

## 2.0.3

December 6, 2015, dev time: 45 minutes

* Bugfix for updates

## 2.0.2

December 6, 2015, dev time: 30 minutes

* FIX: Fatal error on update (not on new installations)
* FIX: Typo

## 2.0.1

December 6, 2015, dev time: 10 minutes

* FIX: Some configurations were failing with the new autoloader. Reverted to a simpler file structure.

## 2.0

December 6, 2015, dev time > 140 hours

* NEW: Added support for `sanitize_callback` arguments on each item in the CSS `output`.
* NEW: Added the ability to define an array as element in the `output`.
* NEW: Auto-prefixing CSS output for cross-browser compatibilities.
* NEW: Allow using arrays in settings.
* NEW: Dimension Field.
* NEW: Repeater Field.
* NEW: Code Field using the ACE editor.
* NEW: Typography Control.
* NEW: Preset Field.
* NEW: Demo theme.
* NEW: Spacing Control.
* REMOVED: Redux Framework compatibility.
* FIX: Minor bugfixes to the Kirki_Color class.
* FIX: kirki_get_option now uses Kirki::get_option().
* FIX: Various bugfixes.
* TWEAK: Converted the `checkbox` control to use the JS templating system.
* TWEAK: Converted the `custom` control to use the JS templating system.
* TWEAK: Converted the `multicheck` control to use the JS templating system.
* TWEAK: Converted the `number` control to use the JS templating system.
* TWEAK: Converted the `palette` control to use the JS templating system.
* TWEAK: Converted the `radio-buttonset` control to use the JS templating system.
* TWEAK: Converted the `radio-image` control to use the JS templating system.
* TWEAK: Converted the `radio` control to use the JS templating system.
* TWEAK: Converted the `select` control to use the JS templating system.
* TWEAK: Converted the `slider` control to use the JS templating system.
* TWEAK: Converted the `switch` control to use the JS templating system.
* TWEAK: Converted the `textarea` control to use the JS templating system.
* TWEAK: Converted the `toggle` control to use the JS templating system.
* TWEAK: `radio-buttonset` controls are now CSS-only.
* TWEAK: `radio-image` controls are now CSS-only.
* TWEAK: `select` controls nopw use [selectize](http://brianreavis.github.io/selectize.js/) instead of [Select2](https://select2.github.io/).
* TWEAK: Deprecated `select2` and `select2-multiple` controls. We now have a global `select` control. Previous implementations gracefully fallback to the current one.
* TWEAK: `switch` controls are now CSS-only.
* TWEAK: `toggle` controls are now CSS-only.
* TWEAK: Sliders now use an HTML5 "range" input instead of jQuery-UI.
* TWEAK: Better coding standards.
* TWEAK: Descriptions styling.
* TWEAK: Improved controls styling.
* TWEAK: Compiled CSS & JS for improved performance.
* TWEAK: Added prefix to the sanitized output array.
* TWEAK: Updated google-fonts.
* TWEAK: Grunt integration.
* TWEAK: Some Code refactoring.

## 1.0.2

July 17, 2014, dev time: 5 minutes

* NEW: Added 'disable_output' and 'disable_google_fonts' arguments to the configuration.

## 1.0.1

July 17, 2014, dev time: 1 hour

* FIX: Issues when using serialized options instead of theme_mods or individual options.
* FIX: Issues with the `output` argument on fields.
* FIX: Other minor bugfixes

## 1.0.0

July 11, 2014, dev time: 177 hours

* NEW: Added PHPUnit tests
* NEW: Use wp_add_inline_style to add customizer styles
* NEW: Rebuilt the background fields calculation
* NEW: Now using Formstone for switches & toggles
* NEW: Added a new API. See https://github.com/aristath/kirki/wiki for documentation.
* NEW: Minimum PHP requirement is now PHP 5.2
* NEW: Added a Select2 field type.
* NEW: Introducing the Kirki::get_option() method to get values.
* NEW: added 'media_query' argument to output.
* NEW: Added ability to get variables for CSS preprocessors from the customizer values. See https://github.com/aristath/kirki/wiki/variables for documentation
* NEW: now supporting 'units' to all outputs to support '!important'
* NEW: Ability to create panels & sections using the new API.
* NEW: added a get_posts method to the Kirki class.
* NEW: Implement width argument in the styling options. See https://github.com/aristath/kirki/wiki/Styling-the-Customizer
* NEW: add 'kirki/control_types' filter
* FIX: Properly saving values in the db when using serialized options
* FIX: Check if classes & functions exist before adding them (allows for better compatibility when embedded in a theme)
* FIX: PHP Warnings & Notices
* FIX: Other minor bugfixes
* FIX: Now using consistently `option_type` instead of `options_type` everywhere
* FIX: `Kirki::get_option()` method now works for all fields, including background fields.
* FIX: avoid errors when Color is undefined in background fields
* FIX: Use WP_Filesystem to get the google fonts array from a json file
* FIX: Radio-Button styling
* FIX: PHP Notices
* FIX: Typos
* FIX: Properly sanitizing rgba colors
* FIX: Properly sanitize numbers
* FIX: Make sure all variables are escaped on output
* TWEAK: Simplify the Colourlovers integration.
* TWEAK: Improve sanitization
* TWEAK: Improve the Kirki_Styles_Customizer class
* TWEAK: Code cleanups
* TWEAK: Added more inline docs (lots of them)
* TWEAK: Use active_callback for required arguments instead of custom JS
* TWEAK: Updated translation files
* TWEAK: Better color manipulation in the Kirki_Color class
* TWEAK: Move secondary classes instantiation to the Kirki() function.
* TWEAK: set a $kirki global
* TWEAK: deprecate getOrThrow method in the Kirki_Config class.
* TWEAK: Move sanitisation functions to a Kirki_Sanitize class.
* TWEAK: Rename Kirki_Framework to Kirki_Toolkit.
* TWEAK: Move variables to the new API
* TWEAK: simplify Kirki_Controls class
* TWEAK: move the kirki/fields & kirki/controls filters to the new API
* REMOVED: remove the 'stylesheet_id' from the configuration.

## 0.8.4

April 6, 2014, dev time: 0.5 hours

* FIX: Color sanitization was distorting 0 characters in the color hex.
* FIX: Properly sanitizing ColorAlpha controls
* FIX: Sanitizing more properties in the Fields class
* FIX: removing remnant double-sanitization calls from the controls classes

## 0.8.3

April 5, 2014, dev time: 28 hours

* NEW: Introduce a Field class
* NEW: Introduce a Builder class
* TWEAK: Code Cleanups
* NEW: Added ability to use 'option' as the setting type
* Fix : Bugs in the color calculation class
* TWEAK: Everything gets sanitized in the "Field" class
* FIX: Bugs in sortable field
* FIX: Editor control had no description
* NEW: Added a color-alpha control. To use it just set an rgba color as the default value.
* TWEAK: SCSS & CSS improvements
* FIX: Various PHP notices and warnings when no fields are defined
* TWEAK: More efficient color sanitization method
* TWEAK: Improved number control presentation
* TWEAK: Improved the way background fields are handled
* TWEAK: Checkboxes styling
* NEW: Allow using rgba values for background colors
* FIX: CSS fix - :focus color for active section
* NEW: Add a static 'prepare' method to the ScriptRegistry class
* FIX: Issues with the URL when Kirki is embedded in a theme

## 0.8.2

March 30, 2015, dev time: 5 minutes

* FIX: Autoloader could not properly include files due to strtolower()

## 0.8.1

March 30, 2015, dev time: 30 minutes

* FIX: Translation strings now overridable using the config filter.

## 0.8.0

March 30, 2015, dev time: 32 hours

* Improvement: OOP redesign (props @vpratfr)
* NEW: Added Palette control
* NEW: Added Editor control (WYSIWYG - uses TinyMCE)
* NEW: Added Custom control (free html)
* NEW: Added a Kirki_Colourlovers class to use palettes from the colourlovers API
* NEW: Added a composer file (props @vpratfr)
* FIX: Wrong settings IDs
* FIX: Color calculation on RGBA functions were off
* TWEAK: Restructuring the plugin (props @vpratfr)
* NEW: added a functional kirki_get_option() function
* TWEAK: Simplified configuration options.
* NEW: Turn Kirki into a singleton and a facade (props @vpratfr)
* TWEAK: Completely re-written the customizer styles
* NEW: Using SASS for customizer styles
* TWEAK: Deprecating the group_title control in favor of the new custom control
* TWEAK: Changed the CSS for checkboxes

## 0.7.1

March 15, 2015, dev time: 2 hours

* REMOVED: Remove the `kirki_get_option` function that was introduced in 0.7 as it's not working properly yet.
* FIX: Undefined index notice when a default value for the control was not defined
* TWEAK: `logo_image` now injects an `img` element instead of a `div` with custom background
* NEW: Added `description` argument in the kirki configuration (replaces the theme description)

## 0.7

March 14, 2015, dev time: 10 hours

* FIX: Array to string conversion that happened conditionally when used with googlefonts. (props @groucho75)
* FIX: Background opacity affects background-position of bg image
* FIX: font-weight not being applied on google fonts
* NEW: Added `kirki_get_option( $setting );` function that also gets default values
* TWEAK: Singleton for main plugin class
* FIX: Prevent empty help tooltips
* NEW: Added `toggle` control
* NEW: Added `switch` control
* FIX: Color controls were not being reset to default:
* TWEAK: Tooltips now loaded via jQuery
* TWEAK: Renamed `setting` to settings for consistency with WordPress core
* TWEAK: Renamed `description` to `help` and `subtitle` to `description for consistency with WordPress core
* TWEAK: Backwards-compatibility improvements
* NEW: Allow hiding background control elements by not including default values for them
* TWEAK: Performance improvements
* TWEAK: Using WordPress core controls instead of custom ones when those are available
* TWEAK: Separate logic for multiple-type controls that were using the "mode" argument. This has been deprecated in favor of completely separate control types.

## 0.6.2

March 2, 2015, dev time: 3 hours

* FIX: Frontend styles were not properly enqueued (props @dmgawel)
* NEW: Allow multiple output styles per control defined as an array of arrays.
* FIX: Background control styles
* FIX: Serialise default values for the sortable control. Now you can define default values as an array.
* FIX: Required script
* FIX: \'_opacity\' was added to a lot of controls by mistake. Removed it and wrote a migration script.

## 0.6.1

February 25, 2015, dev time: 1 hours

* FIX: Sortables controls had a JS conflict
* FIX: Switches & Toggles were not properly working

## 0.6.0

February 25, 2015, dev time: 9 hours

* FIX: Tooltips now properly working
* NEW: Added checkbox switches
* NEW: Added checkbox toggles
* FIX: Generated CSS is not properly combined & minified
* FIX: Re-structuring files hierarchy
* FIX: Simplify the way controls are loaded
* NEW: Only load control classes when they are needed
* NEW: Introducing Kirki_Customize_Control class
* FIX: CSS tweaks
* NEW: Sortable control (creating one is identical to a select control, but with `\'type\' => \'sortable\'`)
* FIX: Double output CSS (props @agusmu)
* NEW: Google fonts now parsed from a json file.

## 0.5.1

January 22, 2015

* FIX: Transport defaults to refresh instead of postMessage
* FIX: undefined index notice.

## 0.5

January 21, 2015

* NEW: Automatic output of styles for generic controls.
* NEW: Automatic output of styles + scripts for fonts (including googlefonts )
* NEW: The \'output\' argument on background controls is now an array for consistency with other controls. Older syntax is still compatible though. :)
* NEW: Add the ability to auto-generate styles for colors.
* FIX: Add a blank stylesheet if we need one and no stylesheet_id has been defined in the config options.
* FIX: CSS-only tooltips. Fixes issue with tooltips now showing up on WP >## 4
* FIX: Code cleanups
* NEW: Added support for WordPress\'s transport arguments
* FIX: All controls now have a sanitization callback. Users can override the default sanitizations by adding their own \'sanitize_callback\' argument.
* FIX: OOP rewrite
* FIX: Strip protocol from Google API link
* FIX: Loading order for some files
* FIX: Removed deprecated less_var argument

## 0.4

October 25, 2014

* FIX: bugfix for selector
* NEW: Change the Kirki theme based on which admin theme is selected.
* FIX: Tranlsation domain issue
* NEW: Added a \"group_title\" control
* FIX: Updated the required script
* FIX: Updating CSS
* Other minor improvements and bugfixes

## 0.3

May 26, 2014

* NEW: added background field
* NEW: added \'output\' argument to directly output the CSS

## 0.2

May 9, 2014

* Initial version
