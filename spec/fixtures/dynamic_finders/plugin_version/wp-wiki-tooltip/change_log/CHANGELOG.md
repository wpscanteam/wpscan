# Changelog of WP Wiki Tooltip

## [1.9.0 - C6H13NO2 | Isoleucine ]
*Release Date - January 1st, 2019*

* sections of Wiki pages can be used for tooltips, now (use shortcode attribute ```section="anchor-of-section"```)
* the used Tooltipster plugin is updated to its version 4.2.6
* a new option is available to set the animation how the tooltip appears
* the new JavaScript I18N Support was implemented for the Classic-Block of Gutenberg


## [1.8.1]
*Release Date - February 24th, 2018*

* bug-fix to handle trigger 'hover' on devices with touchscreen right

## [1.8.0 - C6H9N3O2 | Histidine]
*Release Date - February 23rd, 2018*

* if tooltip trigger 'hover' is selected you can set explicitly how the link has to work
* special options for handling errors are available
* a new version of Tooltipster plugin was released that leads to some programmatic and design changes
* a preview for every tooltip designs is available at options page now

## [1.7.4]
*Release Date - July 15th, 2017*

* the updated file for AJAX communication was lost since version 1.7.0

## [1.7.3]
*Release Date - June 11th, 2017*

* missed one JS file in former updates

## [1.7.2]
*Release Date - June 11th, 2017*

* minor bug-fix

## [1.7.1]
*Release Date - June 11th, 2017*

* if target of Wiki links is set to `"_blank"` the `rel="noopener noreferrer"` attribute is set, too
* some language improvements

## [1.7.0 - C2H5NO2 | Glycine]
*Release Date - October 22nd, 2016*

* you can set if tooltips are triggered by click or hover
* a minimum screen width can defined that is necessary to enable tooltips

## [1.6.0 - C5H9NO4 | Glutamic Acid]
*Release Date - January 30th, 2016*

* the plugin comes with a [TinyMCE](https://codex.wordpress.org/TinyMCE) plugin that helps users creating the shortcodes
* some new graphical assets have been added to support high-DPI displays (aka ‘retina’) and Right-to-Left languages

## [1.5.1]
*Release Date - December 30th, 2015*

* some messages on the settings page improved
* separate German formal and informal language files

## [1.5.0 - C5H10N2O3 | Glutamine]
*Release Date - December 29th, 2015*

* New feature: thumbnail pictures can be enabled and styled - both, globally and by shortcode
* Minor bug-fix that uses the complete right Wiki URL when requesting the tooltip content

## [1.4.1]
*Release Date - December 11th, 2015*

* Minor bug-fix to avoid not showing animated loading bar direct after adding a new URL field

## [1.4.0 - C3H7NO2S | Cysteine]
*Release Date - November 7th, 2015*

* Multiple Wiki URLs can be managed in the backend. The wanted Wiki can be chosen via an attribute in the shortcode.

## [1.3.0 - C4H7NO4 | Aspartic Acid]
*Release Date - August 18th, 2015*

* Elements of tooltips (header, body, footer) are decoupled from the standard elements of WordPress (e.g. headings) now
* Three new fields in the backend can be used to set CSS options for every element of the tooltips

## [1.2.1]
*Release Date - August 17th, 2015*

* Fixes a minor bug that occurred (seldom) when multiple jQuery plugins are used within the same WordPress installation

## [1.2.0 - C4H8N2O3 | Asparagine]
*Release Date - August 14th, 2015*

* Redesigned the requests to the WIKI API by using the [WordPress HTTP API](http://codex.wordpress.org/HTTP_API) and encapsulating them into an own class
* A base class for all class of this plugin is introduced

## [1.1.0 - C6H14N4O2 | Arginine]
*Release Date - August 7th, 2015*

* Refactored the AJAX call to load tooltip content due to the rules of [WordPress AJAX API](https://codex.wordpress.org/AJAX_in_Plugins)
* Added error handling if settings reset fails

## [1.0.1]
*Release Date - August 5th, 2015*

* Minor bug-fix due to compatibility problems with older PHP versions

## [1.0.0 - C3H7NO2 | Alanine]
*Release Date - August 3rd, 2015*

* Option page for WordPress backend added
* Graphical assets for WordPress plugin repository added
* Complete German translation added

## [0.5.0]
*Release Date - July 31st, 2015*

* Initial release

[1.9.0 - C6H13NO2 | Isoleucine ]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.9.0
[1.8.1]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.8.1
[1.8.0 - C6H9N3O2 | Histidine]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.8.0
[1.7.4]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.7.4
[1.7.3]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.7.3
[1.7.2]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.7.2
[1.7.1]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.7.1
[1.7.0 - C2H5NO2 | Glycine]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.7.0
[1.6.0 - C5H9NO4 | Glutamic Acid]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.6.0
[1.5.1]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.5.1
[1.5.0 - C5H10N2O3 | Glutamine]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.5.0
[1.4.1]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.4.1
[1.4.0 - C3H7NO2S | Cysteine]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.4.0
[1.3.0 - C4H7NO4 | Aspartic Acid]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.3.0
[1.2.1]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.2.1
[1.2.0 - C4H8N2O3 | Asparagine]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.2.0
[1.1.0 - C6H14N4O2 | Arginine]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.1.0
[1.0.1]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.0.1
[1.0.0 - C3H7NO2 | Alanine]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/1.0
[0.5.0]: https://github.com/nida78/wp-wiki-tooltip/releases/tag/0.5