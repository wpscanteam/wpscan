# Full Changelog #

## 2.2.0 ##

* Add `get_the_item_post_count` and `the_item_post_count` template methods to get or display the number of posts associated with a term.
* Add support for `get-all-children` when specifying a `parent-term`.
* Add extra filename for template matching: `a-z-listing-$slug.php` where `$slug` is the slug of the post containing the shortcode.
* Deprecate PHP 5.3-5.5. Please ensure you are running at least PHP 5.6. The plugin may work on older PHP versions, but compatibility is not guaranteed.
* Bugfix for incorrect behaviour of `exclude-terms` in the shortcode. Thanks go to Chris Skrzypchak for finding this.

## 2.1.4 ##

### Bug Fix ###

* Fixed a spurious `NOTICE` message (shown below) when error logging is output to the browser. Thanks to the discovery by @npiper.
  * If your site is not showing the message below then you do not need to upgrade with any urgency.

`Notice: Trying to get property of non-object in [Path-to-WordPress]/wp-content/plugins/a-z-listing/classes/class-a-z-listing.php on line 215`

## 2.1.3 ##

### Bug Fix ###

* Fixed the bug reported by @ighosts22 where the letter for non-alphabetic items was not pointing at the list of items.
* Fixed incorrect behaviour discovered after adding tests to the automated testing to verify that I correctly fixed the above bug.

## 2.1.2 ##

### Bug Fix ###

* Post links in 2.1.0 and 2.1.1 included a series of `%09` which caused visitors' clicks to return a 404 Not Found error. Thanks to @forestpump for their effort in finding the problem and highlighting the fix.

## 2.1.1 ##

### Bug Fix ###

* Replace hardcoded path to `admin-ajax.php` in widget administration javascript.
  * This release fixes the widget administration form for sites running in a path similar to [https://example.com/wp/](https://example.com/wp/). You should install this fix if your site is a configured in a subfolder to be able to successfully configure the widget.
  * Sites running in the top-level, e.g. [https://example.com/](https://example.com/), already work correctly and their behaviour is unchanged by this fix. You do not need to hurry to update if your site is configured at the top-level without a subfolder.

## 2.1.0 ##

### Bug Fixes ###

* Fix widget configuration autocomplete fields for target post and parent post in the theme customizer
* Fix taxonomy-term-filtered listings displaying all posts (e.g. shortcodes of the form `[a-z-listing taxonomy="category" terms="term"])
* Fix `get_the_item_object()` to work with old-style overridden indices
* Fix `get_the_item_object()` to correctly extract the item ID and load the correct item
* Improve javascript on the widget configuration
* Clarified the examples with explanations about "post types", "taxonomies", and "terms" to explain what each of these mean.

### New Features ###

* Add parent-page attribute to the shortcode
* Add simpler and safer filter for overriding the index letter for an item
* Add simpler and safer filter for overriding the title for an item
* Add new function for fetching meta data in a template: `$a_z_listing->get_item_meta()`
* Allow exclude-terms to be used with display="posts"
* Moved template loading function outside of the `A_Z_Query` class to prevent accidental access to the plugin internal structure

## 2.0.6 ##

* *Personal Note:* Sorry to everyone who upgraded to 2.0.0 thru to 2.0.5 about yet another update. I have failed you all by shipping faulty versions to you, and I'm sorry, especially so that you've had to endure so many updates the past few days.
* Fix widget target post support

## 2.0.5 ##

* Fix filtering posts by multiple taxonomy terms

## 2.0.4 ##

* Fix styling error causing two or more posts to sometimes appear on the same line

## 2.0.3 ##

* Minor style tweak to fix short listings, and long titles

## 2.0.2 ##

* Fix broken styling in 2.0.0

## 2.0.1 ##

* Fix javascript error on widgets screen

## 2.0.0 ##

* Improved widget configuration.
* New attribute added to the shortcode when `display="posts"`:
  * `exclude-posts`: remove specific posts from the list
* New attributes added to the shortcode when `display="terms"`:
  * `exclude-terms`: sets the terms to exclude from display
  * `parent-term`: set the parent that all displayed terms must be organised under
  * `hide-empty-terms`: hide terms that have no posts associated
* Fix the stylesheet to better cope with variances in font-size and text length in the alphabet links list and widget.
* Introduce PHP classes for adding numbers and grouping to the alphabet. Allows unhooking from the filters to undo the changes, where previously you could not unhook these modifications once they'd been applied.

### BREAKING CHANGES ###

* Multi column example:
  If you have copied the multi-column example in previous releases to your theme folder then you will need to perform some manual steps.
  If you have not edited the file, just delete it and the new template from the plugin will take control and perform the same functionality.
  If you have modified the example template then you will need to compare with the file in the plugin at `templates/a-z-listing.php` and merge any changes into your template.
* Template customisations:
  If you have customised the in-built templates or written your own then you may experience breakage due to the post object not being loaded automatically.
  If you require the template to access more than the post title and URL then you will need to add an additional call after `the_item()` to load the full `WP_Post` object into memory.
  To load the post object you need to call `$a_z_query->get_the_item_object( 'I understand the issues!' );`.
  **The argument must read exactly as written here to confirm that you understand that this might cause slowness or memory usage problems.**
  *This step is purposely omitted to save memory and try to improve performance.*

## 1.9.1 ##

Add CSS classes to letters indicating presence of posts or not:

* `has-posts` allows styling of letters that have posts visible in the listing
* `no-posts` allows styling of letters that do not have any posts visible in the listing

You can use these classes to hide letters that have no posts by including the following CSS rule:

```css
.az-letters ul.az-links li.no-posts {
    display: none;
}
```

## 1.9.0 ##

* Fix multi-column example template
* Update multi-column styles to include display:grid support
* Add back-to-top link
* Add server system requirements to readme
* Add PHP section to readme including link to API Reference

## 1.8.0 ##

* Add extra shortcode attributes:
  * `numbers`: appends or prepends numerals to the alphabet
    * Default value: unset
    * Can be set to either `before` or `after`.
    * Any value other than unset, `before` or `after` will default to **appending** numerals to the alphabet
  * `grouping`: tells the plugin if and how to group the alphabet
    * Default value: unset
    * Can be set to any positive number higher than `1` or the value `numbers`
    * Any value other than a positive number or the value `numbers` will default to disabling all grouping functionality
    * When set to a number higher than `1` the listing will group letters together into ranges
      * For example, if you chose `3` then a latin alphabet will group together `A`, `B`, and `C` into `A-C`. Likewise for `D-F`, `G-I` and so-on
      * When using this setting, if numbers are also shown via the `numbers="before"` or `numbers="after"` attribute then they will be shown as a single separate group `0-9`
    * When set to the value `numbers` it will group numerals into a single group `0-9`
      * This requires the numbers to be displayed via the `numbers="before"` or `numbers="after"` attributes
  * `alphabet`: allows you to override the alphabet that the plugin uses
    * Default value: unset.
    * When this attribute is unset, the plugin will either use the untranslated default, or if [glotpress](https://translate.wordpress.org/projects/wp-plugins/a-z-listing) includes a translation for your site's language as set in `Admin -> Settings -> Site Language` it will use that translation.
    * The current untranslated default is: `AÁÀÄÂaáàäâ,Bb,Cc,Dd,EÉÈËÊeéèëê,Ff,Gg,Hh,IÍÌÏÎiíìïî,Jj,Kk,Ll,Mm,Nn,OÓÒÖÔoóòöô,Pp,Qq,Rr,Ssß,Tt,UÚÙÜÛuúùüû,Vv,Ww,Xx,Yy,Zz`
    * Accepts a single line of letters/symbols, which need to be separated via the comma character `,`
    * Including more than one letter/symbol in each group will display posts starting with any of those under the same section
    * The first letter/symbol in each group is used as the group's heading when displayed on your site
* Bugfix: Shortcode to display taxonomy terms wouldn't also display numbers groups. Hat-tip to @sotos for the report.

## 1.7.2 ##

* Bugfix: Previous release broke the shortcode

## 1.7.1 ##

* Add additional filters allowing for hyphens or underscores to be used when defining. The readme.txt incorrectly used then-unsupported names with hyphens in examples so now we support both.
* Add numbers="before" and numbers="after" in shortcode

## 1.7.0 ##

* Add support for taxonomy term listings to the shortcode
* Add support for filtering by taxonomy terms to the shortcode

## 1.6.5 ##

* Regression fix for widget accessing WP_Post object as array

## 1.6.4 ##

* Bugfix for accessing array as object PHP Warning. Reported by @babraham76

## 1.6.2 ##

* Bugfix for more complex templates - accessing post thumbnails failed.

## 1.6.1 ##

* Regression fix: Notice was emitted by PHP about invalid variable. This was cosmetic only, and had no impact on functionality.

## 1.6.0 ##

* Fix bug of case sensitity in listings order
* Better warning of deprecated functions when called by other plugins or themes

## 1.5.4 ##

* Fix post links when using an alternative titles taxonomy (discovered by [bugnumber9](https://profiles.wordpress.org/bugnumber9))
* Ensure that we don't access rogue objects. Warnings and errors in 1.5.3 are squashed now.
* Verified that [tests](https://travis-ci.org/bowlhat/wp-a-z-listing) pass correctly before releasing this version.

## 1.5.3 ##

* Regression in 1.5.2 causing empty listing is fixed

## 1.5.2 ##

* Regression fix for styling loading - seems the widget code was still causing issues
* Add inline PHPdoc to all functions and custom filters

## 1.5.1 ##

* Fix multiple post-types support for shortcode
* Update documentation to explain how to show multiple post-types with the shortcode

## 1.5.0 ##

* Ensure styling is loaded correctly
* Ensure styling works correctly when using the multi-column template

## 1.4.1 ##

* Fix warning introduced by 1.4.0 about implicit coercion between WP_Post and string

## 1.4.0 ##

* Add support for passing a WP_Post object instead of an ID to the widget function
* Fix widget config not saving post-type parameter
* Fix warning of incorrect usage of `has_shortcode()` function
* Fix section-targeting to work as described

## 1.3.1 ##

* Fix broken admin pages caused by 1.3.0

## 1.3.0 ##

* Added targeted stylesheet loading to enqueue only on pages where the short-code is active
* Further improved default stylesheet loading

## 1.2.0 ##

* Changed default to apply the in-built styles, unless overridden

## 1.1.0 ##

* Minor refactoring to remove unused variables
* Fix some Code-Smell (phpcs)

## 1.0.1 ##

* BUGFIX: lower-case titles missing

## 1.0.0 ##

* BREAKING CHANGE: Refactored several function names. If you have written your own template/loop you will need to adapt your code. See the readme's Theming section for details.
* Added `post-type` attribute into the shortcode to display for post-types other than pages.
* Minor code cleanup.

## 0.8.0 ##

* Standardised on naming convention of `*_a_z_*` in function names, e.g. `get_the_a_z_listing()`, rather than the former `*_az_*` names, e.g. `get_the_az_listing()`.
* Converted version numbering to semver style.
* Fixed the in-built styling.
* Added filter to determine whether to apply in-built styles in addition to hidden setting: `set_option( a-z-listing-add-styling', true );`.
* Added taxonomy terms list support.

## 0.7.1 ##

* Fix potential XSS vector.

## 0.7 ##

* rebuilt most of the logic in preparation for more functionality.
* added template/theming capability (BIG change!)
* Added option to choose to apply default styling of the widget.

## 0.6 ##

* STYLING BREAKING change: the widget's CSS class is changed from `bh_az_widget` to `a-z-listing-widget`. Please update your CSS accordingly.
* Conformed to WordPress coding style guidelines.
* Updated widget class to call php5-style constructor.
* Applied internationalisation (i18n).
* Added testsuite.

## 0.5 ##

* Added new shortcode to display the index page.

## 0.4 ##

* fixed file locations causing failure to load.

## 0.3 ##

* fixed failure to activate as reported by [ml413](https://profiles.wordpress.org/ml413) and verified by [creativejuiz](https://wordpress.org/support/users/creativejuiz/); [reference](https://wordpress.org/support/topic/fatal-error-when-trying-to-install-1).

## 0.2 ##

* renamed the plugin file and packaged for release

## 0.1 ##

* first release
