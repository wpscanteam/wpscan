# Change Log

## [1.1.0] - 2017-09-24

### Added

* Handles mapping rewrite tags for any post type now. Any of the standard rewrite tags are mapped. It also handles any custom taxonomy when used as part of the post type rewrite slug (e.g., `%genre%`, `%portfolio_tag%`, etc.).
* Adds proper breadcrumbs when viewing post type archives by author.
* Support for paged comments. When viewing paged comments, the post title gets linked and `Comment Page %s` becomes the final item.
* New `paged_comments` label available.
* `browse_tag` argument for controlling the header/browse tag. Defaults to `h2`.
* `list_tag` argument for controlling the list tag. Defaults to `ul`.
* `item_tag` argument for controlling the item tag. Defaults to `li`.
* The `itemprop="item"` microdata for the list item inner element.
* The `breadcrumb_trail_inline_style` filter hook for changing or disabling the inline style.

### Changed

* Changes default search label to `Search results for: %s` to avoid double quotes (search queries sometimes have quotes in them).

### Fixed

* Properly reverse term parents array (in wrong order before).
* Uses `wp_list_sort()` for sorting terms, available since WP 4.7.
* Wraps `home_url()` in `user_trailingslashit()` to make sure it has a trailing slash when it should.

## [1.0.0] - 2015-07-07

### Added

* Plugins and themes can now filter the `breadcrumb_trail_object` to use their own sub-classes of `Breadcrumb_Trail`.
* Adds the `role` and `aria-label` attributes to improve accessibility.
* Changed from a flat HTML structure to a proper HTML5 `<nav>` > header > list structure.
* Added basic CSS output for themes that don't support the plugin.  This was needed for backwards compatibility with the new HTML structure.
* Added additional classes for styling in themes such as `.trail-items` (items wrapper) and `.trail-item` (single item).
* Improved [Schema.org](http://schema.org) support for the newer [BreadcrumbList](http://schema.org/BreadcrumbList) type.
* The category will now be shown by default on sites with a `%postname%` permalink structure for single post views.
* Better support for finding related custom post types and taxonomies.
* Added French translation files.

### Fixed

* Accounts for `is_paged()` on single post views, which is needed for custom post types like forums that are paged.
* Always makes sure taxonomy terms exist before adding them as breadcrumb items.
* Uses `get_post()` instead of the deprecated `get_page()` function.
* Don't show parent page item if it's set as the front page and we're viewing a child page.

### Changed

* Removed the `title` attribute for links.  This is far better for accessibility.

### Security

* Hardening security by making sure all URLs are passed through `esc_url()`.
* Hardening security by running translations through `esc_html_e()` and `esc_html__()`.

### Removed

* bbPress support was dropped.  If needed, developers should sub-class `Breadcrumb_Trail`.

## [0.6.1]

* Make sure `breadcrumb_trail()` can return the HTML.
* Add `rel="home"` to the home page link. This got removed at some point.
* Do network and site home links in bbPress.
* Slight fix to stop bbPress from putting double "Forums" in the breadcrumb trail.
* The `show_on_front` argument should only work if the front page is not paginated.
* Better handling of the text strings, particularly when displaying date/time.
* Updated `breadcrumb-trail.pot` file for better translating.

## [0.6.0]

* [Schema.org](http://schema.org) support.
* Completely overhauled the entire plugin, rewriting large swathes of code from the ground up.  This version takes an object-oriented approach.
* Blew every other breadcrumb menu script out of the water.

## [0.5.3]

### Added

* Use `post_type_archive_title()` on post type archives in the trail.
* Add support for taxonomies that have a `$rewrite->slug` that matches a string value for a custom post type's `has_archive` argument.
* Added support for an `archive_title` label for custom post types because we can't use the  `post_type_archive_title()` function on single posts views for the post type.
* Loads of pagination support on both archive-type pages and paged single posts.
* Added support for hierarchical custom post types (get parent posts).
* Added the `network` argument to allow multisite owners to run the trail all the way back to the main site.

### Fixed

* Only check attachment trail if the attachment has a parent.
* Fixed the issue where the wrong post type archive link matches with a term archive page.

## [0.5.2]

* No friggin' clue. I think I actually skipped version numbers somehow. :)

## [0.5.1]

* Changed license from GPL 2-only to GPL 2+.
* Smarter handling of the `trail-begin` and `trail-end` classes.
* Added `container` argument for wrapping breadcrumbs in a custom HTML element.
* Changed `bbp_get_forum_parent()` to `bbp_get_forum_parent_id()`.

## [0.5.0]

* Use hardcoded strings for the textdomain, not a variable.
* Inline doc updates.
* Added bbPress support.
* Use `single_post_title()` instead of `get_the_title()` for post titles.

## [0.4.1]

* Use `get_queried_object()` and `get_queried_object_id()` instead of accessing `$wp_query` directly.
* Pass `$args` as second parameter in `breadcrumb_trail` hook.

## [0.4.0]

* New function: `breadcrumb_trail_get_items()`, which grabs a list of all the trail items.  This separates the items from the main `breadcrumb_trail()` function.
* New filter hook: `breadcrumb_trail_items`, which allows devs to filter just the items.
* New function: `breadcrumb_trail_map_rewrite_tags()`, which maps the permalink structure tags set under Permalink Settings in the admin to make for a much more accurate breadcrumb trail.
* New function: `breadcrumb_trail_textdomain()`, which can be filtered when integrating the plugin into a theme to match the theme's textdomain.
* Added functionality to handle WP 3.1 post type enhancements.

## [0.3.2]

* Smarter logic in certain areas.
* Removed localization for things that shouldn't be localized with time formats.
* `single_tax` set to `null` instead of `false`.
* Better escaping of element attributes.
* Use `$wp_query->get_queried_object()` and `$wp_query->get_queried_object_id()`.
* Add in initial support of WordPress 3.1's post type archives.
* Better formatting and organization of the output late in the function.
* Added `trail-before` and `trail-after` CSS classes if `$before` or `$after` is set.

## [0.3.1]

* Undefined index error fixes.
* Fixes for trying to get a property of a non-object.

## [0.3.0]

* Added more support for custom post types and taxonomies.
* Added more support for more complex hierarchies.
* The breadcrumb trail now recognizes more patterns with pages as part of the permalink structure of other objects.
* All post types can have any taxonomy as the leading part of the trail.
* Cleaned up the code.

## [0.2.1]

* Removed and/or added (depending on the case) the extra separator item on sub-categories and date-/time-based breadcrumbs.

## [0.2.0]

* The title of the "home" page (i.e. posts page) when not the front page is now properly recognized.
* Cleaned up the code and logic behind the plugin.

## [0.1.0]

* Launch of the new plugin.
