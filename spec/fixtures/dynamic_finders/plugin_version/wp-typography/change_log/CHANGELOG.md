# Changes

## 5.5.4 - March 11, 2019
*   _Bugfix_: Automatic language detection now also works for locales without a country code (e.g. `fi`).
*   _Bugfix_: No PHP notices are shown for missing options anymore.

## 5.5.3 - February 2, 2019
*   _Bugfix_: Custom styles containing quote characters are now output correctly.

## 5.5.2 - January 29, 2019
*   _Bugfix_: To prevent common false positives for single-letter Roman ordinals (especially in French and Dutch), Roman numeral matching now has to be explicitly enabled in the settings. In addition, only `I`, `V`, and `X` are accepted as single-letter Roman numbers.

## 5.5.1 - January 27, 2019
*   _Bugfix_: Parts of hyphenated words should not be detected as Roman numerals anymore.
*   _Bugfix_: The Unicode hyphen character (‐) is recognized as a valid word combiner.

## 5.5.0 - January 27, 2019
*   _Feature_: French (1<sup>ère</sup>) and "Latin" (1<sup>o</sup>) ordinal numbers are now supported by the smart ordinals feature (also with Roman numerals, e.g. XIX<sup>ème</sup>).
*   _Feature_: The list of smart quotes exceptions (words beginning with apostrophes) can now be customized.
*   _Feature_: HTML5 parser performance hugely improved (up to 11× faster).
*   _Bugfix_: Output filtering is now suspended during WP-CLI commands.
*   _Bugfix_: Unit spacing is now properly applied to monetary symbols ($, €, etc.).
*   _Bugfix_: Certain HTML entities (e.g. `&amp;`) were accidentally dropped in rare cases.
*   _Bugfix_: Comply with the new WordPress Coding Standards 2.0.

## 5.4.2 - September 30, 2018
*   _Bugfix_: Advanced Custom Fields 5 now uses the correct default values for `text`, `textarea` and `wysiwyg` field types.

## 5.4.1 - September 15, 2018
*   _Bugfix_: Comply with new WordPress Coding Standards 1.1.
*   _Bugfix_: Work around GlotPress issue preventing language pack generation.

## 5.4.0 - September 9, 2018
*   _Feature_: New hooks for implementing your own typography fixes:
    -   `typo_custom_characters_node_fix`,
    -   `typo_custom_spacing_pre_node_fix`,
    -   `typo_custom_spacing_post_node_fix`,
    -   `typo_custom_html_insertion_node_fix`,
    -   `typo_custom_mixed_words_token_fix`,
    -   `typo_custom_compound_words_token_fix`,
    -   `typo_custom_words_token_fix`,
    -   `typo_custom_other_token_fix`.
*   _Feature_: A privacy statement has been added on WordPress 4.9.6+.
*   _Feature_: A narrow no-break space is now inserted between adjacent primary and secondary quotes.
*   _Change_: The Unicode hyphen character (`‐`) is now used instead of the hyphen-minus (`-`).
*   _Change_: Significantly updated hyphenation patterns for:
    -   Bulgarian,
    -   German,
    -   German (Traditional),
    -   German (Swiss Traditional),
    -   Latin (Liturgical), and
    -   Thai.
*   _Bugfix_: The comma is now recognized as a decimal separator (e.g. `1,5`, in addition to `1.5`).
*   _Bugfix_: Smart maths properly handles 2-digit years in dates.
*   _Bugfix_: Smart diacritics won't try to "correct" the spelling of `Uber` anymore.
*   _Bugfix_: French punctuation is now correctly applied to quotes preceeded or followed by round and square brackets.
*   _Bugfix_: Smart quotes replacement could result in invalid unicode sequences in rare cases.

## 5.3.5 - May 10, 2018
*   _Bugfix_: 50/50 (and x/x except 1/1) are not treated as fractions anymore.
*   _Bugfix_: The French spacing rules were not applied to closing guillemets followed by a comma.

## 5.3.4 - April 22, 2018
*   _Bugfix_: Update used libraries to the latest versions.

## 5.3.3 - April 08, 2018
*   _Bugfix_: Correctly match smart fractions even if the are followed by a comma (i.e. `1/4,`).

## 5.3.2 - March 24, 2018
*   _Bugfix_: Prevent future conflicts with other plugins by updating included libraries.

## 5.3.1 - March 15, 2018
*   _Bugfix_: Always clear the cache after updates to prevent frontend whitescreens
    under certain circumstances.

## 5.3.0 - March 13, 2018
*   _Feature_: True integration with Advanced Custom Fields 5, making the filters
    adjustable for each field via the settings UI.
*   _Feature_: The script to remove soft hyphens from clipboard selections has
    been refactored to reduce the number of loaded resources.
*   _Change_: Some API methods have been deprecated and will be removed in 6.0.0:
    -   The static methods `WP_Typography::filter*` should be replaced by static
        calls to the existing `process*` method family.
    -   In general, all instance methods of the new class `WP_Typography\Implementation`
        can now be called statically on the singleton via the `WP_Typography` superclass.
*   _Bugfix_: In rare cases, UTF-8 characters like `Å` caused all content within
    the same tag to disappear.

## 5.2.4 - February 26, 2018
*   _Bugfix_: The partial was still packaged in the wrong place, causing backend whitescreens
    in some cases.

## 5.2.3 - February 22, 2018
*   _Bugfix_: A partial was missing from the compatibility checking code for older PHP versions.

## 5.2.2 - February 04, 2018
*   _Bugfix_: Superscripts were not displayed correctly in the settings page.
*   _Bugfix_: Standalone `<` and `>` characters (i.e. not part of an HTML tag) could
    vanish in some circumstances.
*   _Bugfix_: Re-activating the plugin no longer overwrites the settings with their defaults.

## 5.2.1 - January 11, 2018
*   _Bugfix_: Languages were not sorted correctly in the settings page.
*   _Bugfix_: Circular references in caches objects have been fixed.
*   _Bugfix_: Workaround for Divi theme crash, avoiding `get_body_class()`.

## 5.2.0 - January 05, 2018
*   _Feature_: WordPress body classes (i.e. the result of `get_body_class()`) are now
    passed to the text processing methods. This means that you can exclude entire pages
    from wp-Typography's processing based on the body classes generated by WordPress.
*   _Feature_: Support for WooCommerce page descriptions (via the filter hook
    `woocommerce_format_content`).
*   _Feature_: New hyphenation languages
    -   Assamese,
    -   Belarusian,
    -   Bengali,
    -   Church Slavonic,
    -   Esperanto,
    -   Friulan,
    -   Gujarati,
    -   Kannada,
    -   Kurmanji,
    -   Malayalam,
    -   Norwegian (Bokmål)
    -   Norwegian (Nynorsk)
    -   Piedmontese,
    -   Romansh,
    -   Upper Sorbian.
*   _Change_: Updated to use version 6.1.0 of the composer package `mundschenk-at/php-typography`.
*   _Bugfix_: Numbers are treated like characters for the purpose of wrapping emails.
*   _Bugfix_: Better matching between hyphenation languages and WordPress locales.

## 5.1.3 - December 03, 2017
*   _Change_: Updated to use version 5.2.3 of the composer package `mundschenk-at/php-typography`.
*   _Bugfix_: Sometimes, the French double quotes style generated spurious ».
*   _Bugfix_: Locale-based language files where not properly matched (primarily affecting `en-US` and `en-GB`, props @strasis).

## 5.1.2 - November 25, 2017
*   _Change_: Updated to use version 5.2.2 of the composer package `mundschenk-at/php-typography`.
*   _Bugfix_: Removed some ambiguous diacritics replacements from the German language file.
*   _Bugfix_: Prevent of accidental loading of obsolete composer `ClassLoader` implementations from other plugins.

## 5.1.1 - November 16, 2017
*   _Bugfix_: Shortcodes in the new WordPress 4.8 text widget work again.

## 5.1.0 - November 14, 2017
*   _Feature_: HTML5 parser performance improved by 20 percent.
*   _Feature_: New hyphenation language "Swiss-German (Traditional)" added.
*   _Feature_: New filter hook `typo_narrow_no_break_space` to enable the NARROW NO-BREAK SPACE.
*   _Change_: Refactored plugin internals. This means that
    -   caching should be more friendly to shared hosting environments,
    -   options are stored as a single array now (i.e. fewer rows in the `options` table), and
    -   filters and actions are only added when actually needed.
*   _Change_: Updated to use version 5.2.1 of the composer package `mundschenk-at/php-typography`.
*   _Bugfix_: Narrow spaces are honored during de-widowing.

## 5.0.4 - September 09, 2017
*   _Bugfix_: Ensure proper typing for cached language plugin lists.

## 5.0.3 - September 03, 2017
*   _Bugfix_: Lower database write load by reducing option updates (props @jerzyk).

## 5.0.2 - September 02, 2017
*   _Bugfix_: "Clear Cache" and "Restore Defaults" admin notices are now shown again.
*   _Bugfix_: Object caching errors don't crash the site anymore.

## 5.0.1 - August 28, 2017
*   _Bugfix_: Fatal error on PHP 5.6.x (caused by using `__METHOD__` as a variable function) fixed (`mundschenk-at/php-typography` 5.0.2).

## 5.0.0 - August 27, 2017
*   _Feature_: Proper multilingual support (automatic language switching). Tested with
    -   [Polylang](https://wordpress.org/plugins/polylang/),
    -   [MultilingualPress](https://wordpress.org/plugins/multilingual-press/), and
    -   [WPML](https://wpml.org).
*   _Feature_: Language-specific default settings.
*   _Feature_: [Several new hooks](https://code.mundschenk.at/wp-typography/api/) added (including `typo_settings` to directly filter the settings).
*   _Change_: Updated to use version 5.0.1 of the new standalone composer package `mundschenk-at/php-typography`.
*   _Change_: Minimum PHP version increased to 5.6.0
*   _Change_: Updated list of valid top-level domains.
*   _Bugfix_: French punctuation spacing after links (and other inline tags) fixed.
*   _Bugfix_: Lone ampersands are treated as single-character words.
*   _Bugfix_: Hyphenated words are properly de-widowed.

## 4.2.1 - June 9, 2017
*   _Bugfix_: Prevent crash on PHP 5.x when building the hyphenation trie.

## 4.2.0 - June 8, 2017
*   _Feature_: Prevent line-breaks in numbered abbreviations (e.g. `ISO 9001`).
*   _Feature_: Added new hook `typo_php_typography_caching_enabled` to disable object caching for very resource-starved environments.
*   _Change_: Core API refactored and minimum PHP version increased to 5.4.0.
*   _Change_: Updated hyphenation patterns:
    -   German
    -   German (Traditional)
    -   Latin
    -   Latin (Liturgical)
*   _Change_: Updated list of valid top-level domains.

## 4.1.2 - May 26, 2017
*   _Bugfix_: Hyphenation patterns at the end of word were accidentally ignored.
*   _Bugfix_: Diacritics replacement does not count soft hyphens as word boundaries anymore.

## 4.1.1 - March 19, 2017
*   _Bugfix_: Performance issue accidentally introduced in 4.1.0 fixed.

## 4.1.0 - March 18, 2017
*   _Feature_: Hyphenator instance has been made cacheable.
*   _Feature_: Workaround for broken GoDaddy APC object cache.
*   _Bugfix_: Incorrect replacement of initial hyphens fixed.
*   _Bugfix_: French spacing rules improved.
*   _Bugfix_: Proper dashes for German date intervals.
*   _Bugfix_: `WP_Typography::get_user_settings` and `WP_Typography::process_title` now work correctly (props @roopemerikukka).

## 4.0.2 - February 17, 2017
*   _Bugfix_: Workaround for plugins that call `wptexturize` too early (wasn't actually working before).

## 4.0.1 - January 7, 2017
*   _Bugfix_: Workaround for PHP 5.3 issue in `dewidow` callback.

## 4.0.0 - January 6, 2017
*   _Feature_: API improvements for developers
    -   New Settings API added.
    -   Easier access via new static methods `WP_Typography::filter*`.
    -   Updated [API documentation](https://code.mundschenk.at/wp-typography/api/).
*   _Feature_: Re-vamped settings page
    -   Uses tabs for easier navigation.
    -   Follows WordPress styleguide more closely.
    -   Includes online help.
*   _Feature_: New hyphenation languages
    -   Hindi,
    -   Marathi,
    -   Occitan,
    -   Oriya,
    -   Panjabi,
    -   Tamil,
    -   Telugu.
*   _Change_: Uses minified JavaScript.
*   _Change_: Updated list of valid top-level domains.
*   _Change_: "Ignore errors in parsed HTML" is the default again (as it was pre 3.5.2) and can be switched on and off via the settings page. Parsing errors can be filtered via the new hook `typo_handle_parser_errors` (`typo_ignore_parser_errors` still works as well, of course).

## 3.6.0 - December 26, 2016
*   _Feature_: Added hook `typo_ignore_parser_errors` to re-enable "parser guessing" as it was before version 3.5.2.
*   _Feature_: Added new hook `typo_disable_filtering` to selectively disable filter groups.

## 3.5.3 - December 17, 2016
*   _Bugfix_: Remove ambiguous entries from German diacritics replacement file.

## 3.5.2 - December 14, 2016
*   _Change_: Return unmodified HTML if a processed text fragment is not well-formed. This improves compatibility with page builder plugins (and themes) that do weird things with the `the_content` filter.

## 3.5.1 - November 05, 2016
*   _Bugfix_: Quotes ending in numbers were sometimes interpreted as primes.

## 3.5.0 - October 21, 2016
*   _Feature_: Added "Latin (Liturgical)" as a new hyphenation language.
*   _Feature_: Limited support for ACF Pro.
*   _Change_: Better compatibility with improperly written plugins (ensuring that `wptexturize` is always off).
*   _Change_: Only use the WP Object Cache for caching, not transients, to reduce database usage and prevent clogging in some configurations.
*   _Change_: Updated list of valid top-level domains.
*   _Change_: Updated HTML5 parser (html5-php) to 2.2.2.
*   _Bugfix_: Custom hyphenations with more than one hyphenation point were not working properly.
*   _Bugfix_: The `min_after` hyphenation setting was off by one.
*   _Bugfix_: An IE11 bug on Windows 7 was previously triggered when the Safari workaround is enabled.
*   _Bugfix_: Language names were not translated in the settings screen.
*   _Bugfix_: Fractions did not play nice with prime symbols.

## 3.4.0 - July 10, 2016
*   Store hyphenation patterns as JSON files instead of PHP to work around a GlotPress bug that prevents timely language pack updates.
*   Out-of-the box support for Advanced Custom Fields (specifically for fields of the types `text`, `textarea` and `wysiwyg`).
*   Updated list of valid top-level domains.
*   Tested as compatible with WPML.

## 3.3.1 - June 27, 2016
*   The JavaScript files for `Remove hyphenation when copying to clipboard` were missing from the build.
*   Fixed a typo in the settings page.

## 3.3.0 - June 27, 2016
*   Updated HTML parser (html5-php) to 2.2.1.
*   Updated list of valid top-level domains.
*   Removed IE6 references and workarounds. He's dead, Jim.
*   Prevent references to US non-profit organizations like `501(c)(3)` being replaced with the copyright symbol (props @randybruder).
*   Added optional clean up of text copied to clipboard to prevent stray hyphens from showing on paste.
*   Added CSS classes for smart fractions ("numerator", "denominator") and ordinal suffixes ("ordinal").
*   Fixed « and » spacing when French punctuation style is enabled.
*   Fixed `<title>` tag handling (no more `&shy;` and `<span>`tags, props @mpcube).
*   [Preliminary API documentation](https://code.mundschenk.at/wp-typography/api/) has been added to the plugin website.

## 3.2.7 - April 14, 2016
*   "Duplicate ID" warnings should be gone now, regardless of the installed libXML version.

## 3.2.6 - April 05, 2016
*   Fixed autoloading issue on frontpage. Sorry!

## 3.2.5 - April 05, 2016
*   Properly handle `<title>` in WordPress 4.4 or higher (props @TimThemann).
*   Fixed missing parameter that prevented the `Hyphenate headings` setting from working correctly.

## 3.2.4 - April 04, 2016
*   Fixed filtering of `<title>` tag (do only smart character replacement).

## 3.2.3 - March 28, 2016
*   Made Safari rendering bug workaround less aggressive by not enabling discretionary ligatures.

## 3.2.2 - March 22, 2016
*   Fixed Safari rendering bug workaround on Safari 9.1 (Mac OS X 10.11.4).

## 3.2.1 - March 20, 2016
*   Accidentally, the filter for `the_content` was dropped in the version 3.2.0.

## 3.2.0 - March 20, 2016
*   Added support for the French punctuation style (thin non-breakable space before `;:?!`).
*   Added proper hyphenation of hyphenated compound words (e.g. `editor-in-chief`).
*   Added partial support for styling hanging punctuation.
*   Added adjustable limit for the number of cached text fragments.
*   Changed behavior of caching setting: it needs to be explicitely enabled. Having it on by default caused too many problems on shared hosting environments.
*   Started adding filters for programmatic adjustments to the typographic enhancements.
*   Made main plugin class a singleton to ensure easier access for theme developers.
*   Added the wp-Typography filter to additional WordPress hooks and completely disabled `wptexturize` (if Intelligent Character Replacement is enabled).

## 3.1.3 - January 13, 2016
*   Pre­vent in­cor­rect re­place­ment of straight quotes with primes (e.g. `"number 6"` is not re­placed with `“num­ber 6″` but with `“num­ber 6”`).
*   Fixed a bug that pre­vented header tags (`<h1>` … `<h6>`) that were set as “tags to ig­nore” from ac­tu­ally be­ing left alone by the plu­gin.

## 3.1.2 - January 7, 2016
*   Do not create (most) transients if Disable Caching is set. This prevents unchecked database growth on large installations.

## 3.1.1 - January 5, 2016
*   Fixed fatal error when running on PHP 5.3 (use of $this in anonymous function).

## 3.1.0 - January 3, 2016
*   Minimum PHP version updated to 5.3.4 (from 5.3.0) to ensure consistent handling of UTF-8 regular expressions.
*   Added workaround for insane NextGEN Gallery filter priority (props @Itsacon).
*   Added "Clear Cache" button.
*   Changed internal option names to conform to WordPress standards (no camel case).
*   Performance improvements through lazy initialization and caching of the PHP_Typography object state.
*   Fixed diacritics replacement for UTF-8 strings
*   Refactored plugin code for easier maintenance.
*   Date-like values (e.g. "during the fiscal year 2015/2016") are not converted to smart fractions anymore.
*   Added ability to switch between dash styles: both traditional US (em dash without spacing) and international usage (en dash with spaces) can be selected.
*   Various white-space fixes related to dash styling.
*   Language names in the Settings panel are sorted correctly for all locales.
*   Fixed a bug where block-level tags where not detected corrected.
*   Added workaround for duplicate ID warnings generated by some versions of libXML.
*   Updated all hyphenation files and added the following new languages:
    -   Afrikaans,
    -   Armenian,
    -   Dutch,
    -   Georgian,
    -   German (Traditional),
    -   Latin (Classical),
    -   Latvian,
    -   Thai, and
    -   Turkmen.

## 3.0.4 - December 12, 2015
*   Prevent accidentally invalid XPath queries from being fatal on the frontend.
*   Replaced old FAQ links in the README.

## 3.0.3 - December 8, 2015
*   Use WordPress languages packs for translations.
*   Fixed a bug in the XPath expression for ignoring tags by CSS ID.

## 3.0.2 - December 3, 2015
*   A typo prevented custom quote styles from working.

## 3.0.1 - December 3, 2015
*   Prevent drop-down box settings from being accidentally overwritten (props Stefan Engenhorst).
*   Earlier check for minimum PHP version to prevent a parsing error on PHP 5.2 (props @Javi).

## 3.0.0 - December 2, 2015
*   DOM-based HTML parsing with HTML5-PHP
*   Translation-ready & German translation added
*   Added German as a diacritics language (mainly for French words).
*   Various optimizations (hyphenation is still slow, though)
*   Fixed custom hyphenation patterns.
*   Fixed some calls to deprecated functions.
*   Adopted semantic versioning for the project.
*   Added workaround for Safari font bug.
*   Added transient caching to speed things up a bit.

## 2.0.4 - January 4, 2011

*   An errant "settings" link was being injected into the "Plugins" page. It has been removed.

## 2.0.3 - January 3, 2011

*   Removed "text-rendering: optimizeLegibility;" from the plugin's default CSS rules as a bug in Chrome with this statement causes all soft-hyphens to be displayed throughout the text. This will only correct the settings in new downloads. So, if you have an older version installed, remove the "* {text-rendering: optimizeLegibility;}" statement from the "Styling for CSS Hooks" textarea in this plugin's options page (the very last field).

## 2.0.2 - July 16, 2010

*   Rolled back application of wp-Typography's title filter to bloginfo('name') and bloginfo('description') to resolve conflicts introduced with RSS feeds

## 2.0.1 - July 14, 2010

*   Applied wp-Typography's title filter to bloginfo('name') and bloginfo('description')
*   Prevented processing of wp_title() and wp_post_title() so that HTML tags do not appear in page title

## 2.0 - July 7, 2010

*   Simplified acronym identification to not include some obscure uppercase characters. This will reduce support for some non-English languages, but it resolves an issue of catastrophic failure (where the entire page fails to load) with certain server configurations.
*   Security Fix: Prevented comments with exceptionally long strings from causing fatal PHP error.
*   Added `*{text-rendering: optimizeLegibility;}` to default CSS rules to enable kerning and ligatures in supported browsers. Note this will not appear for upgrades, only new installs
*   Upgraded to [PHP Typography 2.0](http://kingdesk.com/projects/php-typography/)

## 1.22 - March 4, 2010

*   Fixed bug that caused occasional hyphenation errors for non-English languages.
*   Upgraded to [PHP Typography 1.22](http://kingdesk.com/projects/php-typography/)

## 1.21.1 - January 22, 2010

*   Deepened font stacks on admin page – some special characters were not displaying on certain system configurations

## 1.21 - December 31, 2009

*   Fixed bug in custom diacritic handling
*   Upgraded to [PHP Typography 1.21](http://kingdesk.com/projects/php-typography/)

## 1.20 - December 20, 2009

*   Verified compatible with WordPress 2.9
*   Resolved uninitialized variable
*   Added HTML5 elements to parsing algorithm for greater contextual awareness
*   Upgraded to [PHP Typography 1.20](http://kingdesk.com/projects/php-typography/)

## 1.19 - December 1, 2009

*   Fixed bug where dewidow functionality would add broken no-break spaces to the end of texts, and smart_exponents would drop some of the resulting text.
*   Declared encoding in all instances of mb_substr to avoid conflicts
*   Corrected a few instances of undeclared variables.
*   Upgraded to [PHP Typography 1.19](http://kingdesk.com/projects/php-typography/)

## 1.18 - November 10, 2009

*   Added Norwegian Hyphenation Patterns
*   Upgraded to [PHP Typography 1.18](http://kingdesk.com/projects/php-typography/)

## 1.17 - November 9, 2009

*   Fixed bug in diacritic handling.
*   Upgraded to [PHP Typography 1.17](http://kingdesk.com/projects/php-typography/)

## 1.16 - November 4, 2009

*   Added automated diacritic replacements (i.e. "creme brulee" becomes "crème brûlée").
*   Improved smart quotes and smart dashes with sensitivity to adjacent diacritic characters.
*   Upgraded to [PHP Typography 1.16](http://kingdesk.com/projects/php-typography/)

## 1.15 - October 21, 2009

*   Replaced quotation language styles with individual selection of primary and secondary quotation styles.  NOTE: this change requires reselection of quotation styles for anyone using non-English preferences.
*   Tested for WordPress version 2.8.5 compatibility.
*   Upgraded to [PHP Typography 1.15](http://kingdesk.com/projects/php-typography/)

## 1.14 - September 8, 2009

*   Improved space collapse functionality.
*   Corrected bug in smart quote and single character word handling where the "0" character may be improperly duplicated
*   Upgraded to [PHP Typography 1.14](http://kingdesk.com/projects/php-typography/)

## 1.13.1 - August 31, 2009

*   Clarified requirement for PHP `mbstring` extension, and refined a test upon installation of the plugin to catch incapable server environments.
*   Corrected default hyphenation language pattern to `English (United States)`.

## 1.13 - August 31, 2009

*   Added option to collapse adjacent space characters to a single character
*   Upgraded to [PHP Typography 1.13](http://kingdesk.com/projects/php-typography/)

## 1.12 - August 17, 2009

*   Corrected multibyte character handling error that could cause some text to not display properly
*   Upgraded to [PHP Typography 1.12](http://kingdesk.com/projects/php-typography/)

## 1.11 - August 14, 2009

*   Added language specific quote handling (for single quotes, not just double) for English, German and French quotation styles
*   Upgraded to [PHP Typography 1.11](http://kingdesk.com/projects/php-typography/)

## 1.10.1 - August 14, 2009

*   Left a setting in test mode.  That is corrected.

## 1.10 - August 14, 2009

*   Fixed typo in default CSS styles
*   Added language specific quote handling for English, German and French quotation styles
*   Corrected multibyte character handling error that could cause some text to not display properly
*   Expanded the multibyte character set recognized as valid word characters for improved hyphenation
*   Upgraded to [PHP Typography 1.10](http://kingdesk.com/projects/php-typography/)

## 1.9 - August 12, 2009

*   Added option to force single character words to wrap to new line (unless they are widows).
*   Upgraded to [PHP Typography 1.9](http://kingdesk.com/projects/php-typography/)

## 1.8.1 - August 7, 2009

*   Added optional automatic inclusion of styling of CSS hooks
*   Fixed "Restore Defaults" conflict with other plugins

## 1.8 - August 4, 2009

*   Corrected math and dash handling of dates
*   Styling of uppercase words now plays nicely with soft-hyphens
*   Upgraded to [PHP Typography 1.8](http://kingdesk.com/projects/php-typography/)

## 1.7.2 - July 29, 2009

*   Now WordPress MU compatible
*   Updated Options Page to new `register_setting()` and `settings_fields()` API

## 1.7.1 - July 29, 2009

*   Updated thin space handling to be off by default, and updated the description in the admin panel to warn of rare mishandling in Safari and Chrome.

## 1.7 - July 29, 2009

*   Reformatted language files for increased stability and to bypass a false positive from Avira's free antivirus software
*   Upgraded to [PHP Typography 1.7](http://kingdesk.com/projects/php-typography/)

## 1.6 - July 28, 2009

*   Efficiency Optimizations ( approximately 25% speed increase )
*   Upgraded to [PHP Typography 1.6](http://kingdesk.com/projects/php-typography/)

## 1.5 - July 27, 2009

*   Added the ability to exclude hyphenation of capitalized (title case) words to help protect proper nouns
*   Added Hungarian hyphenation patterns
*   Upgraded to [PHP Typography 1.5](http://kingdesk.com/projects/php-typography/)

## 1.4 - July 23, 2009

*   Fixed an instance where pre-hyphenated words were hyphenated again
*   Upgraded to [PHP Typography 1.4](http://kingdesk.com/projects/php-typography/)

## 1.3 - July 23, 2009

*   Removed two uses of create_function() for improved performance
*   Corrected many uninitialized variables
*   Corrected two variables that were called out of scope
*   Upgraded to [PHP Typography 1.3](http://kingdesk.com/projects/php-typography/)

## 1.2 - July 23, 2009

*   added new 100 character option for max widow length protected
*   added new 100 character option for max pull length for widow protection
*   moved the processing of widow handling after hyphenation so that max-pull would not be compared to the length of the adjacent word, but rather the length of the adjacent word segment (i.e. that after a soft hyphen)
*   Upgraded to [PHP Typography 1.2](http://kingdesk.com/projects/php-typography/)

## 1.1 - July 22, 2009

*   took advantage of new feature in PHP Typography 1.1 where we could just set user settings without first setting phpTypography defaults for a slight performance improvement.
*   Decoded special HTML characters (for feeds only) to avoid invalid character injection (according to XML's specs)
*   Upgraded to [PHP Typography 1.1](http://kingdesk.com/projects/php-typography/)

## 1.0.4 - July 20, 2009

*   Added test for curl to avoid bug where admin panel would not load

## 1.0.3 - July 17, 2009

*   Reverted use of the hyphen character to the basic minus-hyphen in words like "mother-in-law" because of poor support in IE6
*   Zero-width-space removal for IE6 was broken.  This is corrected.
*   Clarified some labels in the admin interface
*   Simplified the admin interface URL

## 1.0.2 - July 16, 2009

*   Fixed smart math handling so it can be turned off.
*   Corrected smart math handling to not convert slashes in URLs to division signs
*   Corrected issue where some server settings were throwing a warning in the admin panel for use of file_get_contents()

## 1.0.1 - July 15, 2009

*   Corrected label in admin interface that indicated pretty fractions were part of basic math handling.

## 1.0 - July 15, 2009

*   Changed default settings from all options being enabled to a minimal set being enabled.
*   Added test to phpTypography methods `process()` and `process_feed()` to skip processing if `$isTitle` parameter is `TRUE` and `h1` or `h2` is an excluded HTML tag

## 1.0 beta 9 - July 14, 2009

*   Added catch-all quote handling, now any quotes that escape previous filters will be assumed to be closing quotes
*   A section of resource links were added to the wp-Typography admin settings page.

## 1.0 beta 8 - July 13, 2009

*   Changed thin space injection behavior so that for text such as "...often-always?-judging...", the second dash will be wrapped in thin spaces
*   Corrected error where fractions were not being styled because of a zero-space insertion with the wrap hard hyphens functionality
*   Added default class to exclude: `noTypo`
*   Changed order of admin page options, moving hyphenation options toward the top

## 1.0 beta 7 - July 10, 2009

*   Added "/" as a valid word character so we could capture "this/that" as a word for processing (similar to "mother-in-law")
*   Corrected error where characters from the Latin 1 Supplement Block were not recognized as word characters
*   Corrected smart quote handling for strings of numbers
*   Added smart guillemet conversion: `&lt;&lt;` and `&gt;&gt;` to `&laquo;` and `&raquo;`
*   Added smart Single Low 9 Quote conversion as part of smart quotes: comma followed by non-space becomes Single Low 9 Quote
*   Added Single Low 9 Quote, Double Low 9 Quote and &raquo; to style_initial_character functionality
*   Added a new phpTypography method smart_math that assigns proper characters to minus, multiplication and division characters
*   Depreciated the phpTypography method smart_multiplication in favor of smart_math
*   Cleaned up some smart quote functionality
*   Added ability to wrap after "/" if set_wrap_hard_hyphen is TRUE (like "this/that")
*   Titles were not being properly processed, this has been corrected

## 1.0 beta 6 - July 9, 2009

*   Critical bug fix:  RSS feeds were being disabled by previous versions.  This has been corrected.

## 1.0 beta 5 - July 8, 2009

*   Corrected error where requiring  Em/En dash thin spacing "word-" would become "word &ndash;" instead of "word&ndash;"
*   Corrected default settings
*   Alphabetically sorted languages returned with get_languages() method
*   Added a "Restore Defaults" option to the admin page

## 1.0 beta 4 - July 7, 2009

*   Added default encoding value to smart_quote handling to avoid PHP warning messages
*   Disabled processing of category titles using wp_list_categories()

## 1.0 beta 3 - July 6, 2009

*   Corrected curling quotes at the end of block level elements
*   Disabled processing of page titles (some browsers did not properly handle soft hyphens) reverts to wp-texturize for titles.

## 1.0 beta 2 - July 6, 2009

*   Corrected multibyte character conflict in smart-quote handling that caused infrequent dropping of text
*   Thin space injection included for en-dashes

## 1.0 beta 1 - July 3, 2009

*   Initial release
