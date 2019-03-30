## [Unreleased]
## [0.4.4]
### Changed
- Fix missing removeRule() method in options page builder

## [0.4.3]
### Added
- Added alpha channel option for colorpicker field

### Changed
- Fix colorpicker not show in WordPress 4.9

## [0.4.2]
### Changed
- Fix field attributes doesn't work
- Fix image field doesn't work when use URL
- Fix slashes issue when save fields

## [0.4.1]
### Changed
- Fix Vietnamese text encoding

## [0.4.0]
### Added
- Support media buttons in editor field (requires WordPress 4.9)
- Added import/export feature for options page builder
- Hook `puppyfw_builder_assets`
- Show options page data in posts list table

### Changed
- Check the existing of function `puppyfw()` to load plugin instead of `PUPPYFW_VERSION` constant which be removed

### Removed
- Removed `PUPPYFW_VERSION` constant

## [0.3.0]
### Added
- Options page builder
- Hook `puppyfw_before_init`
- Hook `puppyfw_i18n`
- Hook `puppyfw_show_builder`
- Hook `puppyfw_fields_have_nested`

### Changed
- Refactor framework structure and api

## [0.2.0]
### Added
- Hook `puppyfw_after_init`
- Hook `puppyfw_before_page_rendering`
- Added API to get page instance
- Added API to get option value
- Added API for defining fields use OOP

### Removed
- Removed demo code. It will be moved to documentation

### Changed
- Used singleton pattern for Framework class
- Moved framework init to `plugins_loaded` hook
- Fix style editor field
- Improve demo

## [0.1.2]
### Added
- Added `html`, `colorpicker`, `datepicker` field

## [0.1.1] - 2017-09-21
### Added
- Check user capability when save

### Removed
- Remove short syntax of dependency

## [0.1.0] - 2017-09-19
- First release

[Unreleased]: https://github.com/truongwp/puppyfw/compare/0.4.4...HEAD
[0.4.4]: https://github.com/truongwp/puppyfw/compare/0.4.3...0.4.4
[0.4.3]: https://github.com/truongwp/puppyfw/compare/0.4.2...0.4.3
[0.4.2]: https://github.com/truongwp/puppyfw/compare/0.4.1...0.4.2
[0.4.1]: https://github.com/truongwp/puppyfw/compare/0.4.0...0.4.1
[0.4.0]: https://github.com/truongwp/puppyfw/compare/0.3.0...0.4.0
[0.3.0]: https://github.com/truongwp/puppyfw/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/truongwp/puppyfw/compare/0.1.2...0.2.0
[0.1.2]: https://github.com/truongwp/puppyfw/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/truongwp/puppyfw/compare/0.1.0...0.1.1
