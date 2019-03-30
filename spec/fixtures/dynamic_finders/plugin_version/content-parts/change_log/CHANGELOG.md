# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [1.8] - 2019-01-15

### Added
- Add wrapper divs around automatically output content parts.

## [1.7] - 2017-11-30

### Fixed
- Don't Automatically output `<div>` blocks - broke styling on some some sites.

### Added
- Added settings page: Select post types to which `<div>` blocks will be automatically added.
- Added admin notification if settings page has not been visited.
- `content_parts_auto_format_post_types` filter added to enable override of admin settings.

## Changed
- Removed the `content_parts_auto_content` filter. Instead use the `content_parts_auto_format_post_types` filter.

## [1.6] - 2017-11-14

### Changed

- Use PHP5 constructors.
- Automatically output `<div>` blocks around content parts in the main content on single posts and pages. Disable via the `content_parts_auto_content` filter.
- Use SVG images.

## [1.5] - 0000-00-00

### Added
- Add post classes (`has-content-parts`, `content-parts-{n}`, `no-content-parts`).

### Changed
- Updated Tiny MCE button image.
- Tested up to WordPress 4.0

### Fixed
- Don't load editor functionality if `DOING_AJAX`.

## [1.4] - 0000-00-00

### Added
- Automatically make content parts work when 'in the loop'.
- Added `%%part%%` placeholder to before/after strings to replace with content part index.
- Add `content_part_args` filter.

## [1.3] - 0000-00-00

### Changed
- Moved code to a class structure.
- All functions can now be passed an array of parameters.
- Deprecate `the_content_part()` multiple args - now expects an array.

## [1.2] - 0000-00-00

### Changed
- Validate 'start' and 'limit' args are numeric.
- If $post not set, ignore.
- Checked WordPress 3.3 compatibility.

## [1.1] - 0000-00-00

### Added
- Added `count_content_parts()` function. props Rory.

## [1.0] - 0000-00-00

### Added
- First release.

[Unreleased]: https://github.com/benhuson/content-parts/compare/1.8...HEAD
[1.7]: https://github.com/benhuson/content-parts/compare/1.7...1.8
[1.7]: https://github.com/benhuson/content-parts/compare/1.6...1.7
[1.6]: https://github.com/benhuson/content-parts/compare/1.5...1.6
[1.5]: https://github.com/benhuson/content-parts/compare/1.4...1.5
[1.4]: https://github.com/benhuson/content-parts/compare/1.3...1.4
[1.3]: https://github.com/benhuson/content-parts/compare/1.2...1.3
[1.2]: https://github.com/benhuson/content-parts/compare/1.1...1.2
[1.1]: https://github.com/benhuson/content-parts/compare/1.0...1.1
[1.0]: https://github.com/benhuson/content-parts/tree/1.0
