# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [1.3.1] - 2018-08-02

### Fixed
- Fix page part permalink when parent is a child of other pages.

## [1.3] - 2018-05-03

### Added
- Add default template image filter `page_part_theme_default_template_image`.
- Allow found templates to be filtered before locating using the `page_part_locate_templates` filter.
- Added `page_part_theme_templates` filter to change the maximum folder depth where page part templates can be found in the theme.
- Add Template column to page parts admin table.

### Changed
- Search 2 levels deep for Page Part templates in theme folder.

### Fixed
- Fix revisions not saving.

## [1.2] - 2017-04-07

### Added
- Add `page_part_show_default_template` filter.
- Pass `$page-part` object to `page_part_theme_templates` filter.

### Changed
- Use `__construct()` for class constructor methods.

## [1.1] - 2017-01-31

### Added
- Add `page-attributes` meta box to Page Parts (includes "order" field).
- Add `page_parts_default_template_name` filter so that the Default Template name can be changed in admin menus.
- Add `page-part-default` class to page parts with no template assigned.

## [1.0] - 2016-09-13

### Added
- Add support for Page Part templates.
- Show parent hierarchy in page parts admin.

### Changed
- Improved documentation accessible via the plugins admin page.
- Use `wp_update_post()` when updating `menu_order` via AJAX.

### Fixed
- If page part has no title, show “(no title)” in admin edit list table.

## [0.9] - 2015-09-18

### Changed
- Better handling of default permalinks with anchors (where page part is a child of another page part).

## [0.8] - 2015-09-18

### Added
- Add option to set parent ID manually (if page part is not connected to a post).
- Add page part column to post type admin pages.

### Changed
- Don't show Page Parts meta box in admin nav menus.

### Fixed
- Textdomain should be a string - using a variable causes issues for parsers.

### Security
- Check and escape filtered URLs.

## [0.7] - 2015-02-20

### Added
- Added API to specify theme locations.
- Added theme locations documentation.

### Security
- Tightened up AJAX security with better POST validation and nonces.

## [0.6] - 2014-11-18

### Added
- Add "Add new page part" button on page parts to add a new part to the parent.
- Add support for author, excerpt, custom-fields and revisions.
- Added contextual documentation.
- Added `page-parts` constant.

## [0.5] - 2014-08-28

### Added
- Add plugin documentation (link on plugins page).
- Add `page_parts_supported_post_types` filter to enable support for other post types.
- Added `page_parts_admin_columns` and `page_parts_admin_column_{$column_name}` filters for adding extra columns to the page parts table.

## [0.4] - 2014-07-10

### Added
- Improve drag and drop interface - uses a 'handle' so as to not interfere with links etc.

### Changed
- Admin table displayed using `WP_List_Table` class.

### Fixed
- Order now updated immediate after drag and drop via AJAX.

## [0.3] - 2013-10-30

### Added
- Shows post thumbnail if available.
- Added language support.
- Display page part status in admin list.
- Added `register_page_part_arg`' filter.

## [0.2] - 2012-06-14

### Added
- First public release.

[Unreleased]: https://github.com/benhuson/page-parts/compare/1.3.1...HEAD
[1.3]: https://github.com/benhuson/page-parts/compare/1.3...1.3.1
[1.3]: https://github.com/benhuson/page-parts/compare/1.2...1.3
[1.2]: https://github.com/benhuson/page-parts/compare/1.1...1.2
[1.1]: https://github.com/benhuson/page-parts/compare/1.0...1.1
[1.0]: https://github.com/benhuson/page-parts/compare/0.9...1.0
[0.9]: https://github.com/benhuson/page-parts/compare/0.8...0.9
[0.8]: https://github.com/benhuson/page-parts/compare/0.7...0.8
[0.7]: https://github.com/benhuson/page-parts/compare/0.6...0.7
[0.6]: https://github.com/benhuson/page-parts/compare/0.5...0.6
[0.5]: https://github.com/benhuson/page-parts/compare/0.4...0.5
[0.4]: https://github.com/benhuson/page-parts/compare/0.3...0.4
[0.3]: https://github.com/benhuson/page-parts/compare/0.2...0.3
[0.2]: https://github.com/benhuson/page-parts/compare/0.1...0.2
