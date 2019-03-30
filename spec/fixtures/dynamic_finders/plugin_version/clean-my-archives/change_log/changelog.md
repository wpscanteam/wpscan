# Change Log

## [1.2.0] - 2017-09-30

### Added

* New `show_comment_count` parameter.  Set to `0` or `false` to hide the comment count.
* New `format_month_year` parameter to change the month + year date format.  Any valid PHP date format is acceptable.
* New `format_post_date` parameter to change the post date format.  Any valid PHP date format is acceptable.

### Changed

* By default, the comment count will only appear if comments are open or the post has existing comments.

### Fixed

* When a post doesn't have a title, display the post ID.
* Display the correct monthly archive link for custom post types.

## [1.1.0] - 2015-12-15

### Added

* New `order` parameter. Posts can now be ordered in ascending (`ASC`) or descending (`DESC`).  The default is descending.

### Changed

* Minor code cleanup.

## [1.0.0] - 2015-08-19

### Added

* Passes the `clean-my-archives` tag into `shortcode_atts()` so that devs can filter it.

### Changed

* Inline docs cleanup.

### Fixed

* Load translations in admin so plugin headers are translated there.

### Security

* Validate integers passed through the shortcode as actual integers.
* Escaped URLs to harden security.
* Escaped text strings to harden security.

## [0.2.0]

* Use `wp_reset_postdata()`, not `wp_reset_query()`.
* Smarter code formatting for day and comments number.
* Add support for custom post types or a mix of any post type.
* Code formatting and inline doc cleanup.
* Use the newer `ignore_sticky_posts` instead of `caller_get_posts`.
* Add `<span>` wrappers for styling the day and comments number.
* Add `.day-duplicate` class to `<li>` if it's a repeating day.
* Add `<div class="clean-my-archives">` wrapper for entire output.

## [0.1.0]

* Plugin launch.  Everything's new!
