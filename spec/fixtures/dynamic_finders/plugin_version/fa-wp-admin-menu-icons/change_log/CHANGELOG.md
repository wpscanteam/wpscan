# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [v3.6.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v3.5.0...v3.6.0) - 2018-12-07

### Changed

- Update Font Awesome from v5.5.0 to v5.6.0

## [v3.5.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v3.4.0...v3.5.0) - 2018-11-03

### Changed

- Update Font Awesome from v5.4.2 to v5.5.0

## [v3.4.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v3.3.0...v3.4.0) - 2018-10-28

### Changed

- Update Font Awesome from v5.4.1 to v5.4.2

## [v3.3.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v3.2.0...v3.3.0) - 2018-10-13

### Changed

- Update Font Awesome from v5.3.1 to v5.4.1

## [v3.2.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v3.1.0...v3.2.0) - 2018-08-31

### Changed

- Improve Makefile
- Update Font Awesome from v5.2.0 to v5.3.1

## [v3.1.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v3.0.0...v3.1.0) - 2018-07-29

### Changed

- Update Font Awesome from v5.1.0 to v5.2.0

## [v3.0.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.8.0...v3.0.0) - 2018-07-05

### Changed

- Initialize the plugin earlier in the WP lifecycle
- Update Composer PHP version range

### Removed

- `composer.json.version`

## [v2.8.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.7.0...v2.8.0) - 2018-06-20

### Added

- Tested with WordPress v4.9.6

### Changed

- Update `.gitattributes`
- Update Font Awesome from v5.0.13 to v5.1.0

## [v2.7.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.6.0...v2.7.0) - 2018-05-10

### Changed

- Update Font Awesome from v5.0.12 to v5.0.13

## [v2.6.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.5.0...v2.6.0) - 2018-05-03

### Added

- Add `.gitattributes` to set `export-ignore` attribute for files not needed in production
- Add script to get Font Awesome shims file

### Changed

- Update Font Awesome from v5.0.11 to v5.0.12
- Update Font Awesome shims

## [2.5.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.4.0...v2.5.0) - 2018-05-02

### Changed

- Update Font Awesome from v5.0.10 to v5.0.11
- Update Composer PHP version range

## [2.4.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.3.1...v2.4.0) - 2018-04-21

### Changed

- Update Font Awesome from v5.0.9 to v5.0.10

## [2.3.1](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.3.0...v2.3.1) - 2018-03-29

### Changed

- Update README.txt changelog

## [2.3.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.2.1...v2.3.0) - 2018-03-29

### Changed

- Bump Font Awesome version from 5.0.8 to 5.0.9

## [2.2.1](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.2.0...v2.2.1) - 2018-03-25

### Fixed

- Fix styles action

## [2.2.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.1.0...v2.2.0) - 2018-03-25

### Added

- Add support for Font Awesome versions. Icons are now cached with their Font Awesome version so they can be updated when the Font Awesome version changes.

## [2.1.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.0.1...v2.1.0) - 2018-03-19

### Added

- Add links to changelog
- Add links to readme badges
- Integrate Travis and Code Climate test coverage

### Changed

- Instead of storing all icons in the plugin, get them remotely, as needed, and cache them in the database for future use
- Make hooks code DRYer
- Stop using static methods, to make testing easier
- Make icons smaller so they look better next to Dashicons
- Update Font Awesome shims

## [2.0.1](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v2.0.0...v2.0.1) - 2017-12-21

### Added

- Add CC BY 4.0 attribution in `icons/README.md` to adhere to [Font Awesome license](https://fontawesome.com/license)

### Fixed

- Fix old syntax in readme examples
- Add missing 'Usage' section to `README.txt`

## [2.0.0](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v1.0.4...v2.0.0) - 2017-12-20

### Added

- Add unit tests

### Changed

- Upgrade to Font Awesome 5 icons and class syntax
- Use PSR instead of WordPress for code style

### Deprecated

- Deprecate use of Font Awesome 4 class syntax

## [1.0.4](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v1.0.3...v1.0.4) - 2017-10-29

### Changed

- Format code

### Removed

- Remove caveat from documentation because it no longer applies

## [1.0.3](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v1.0.2...v1.0.3) - 2017-06-17

### Added

- Add more icons

## [1.0.2](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v1.0.1...v1.0.2) - 2017-06-16

### Fixed

- Fix undefined index

## [1.0.1](https://github.com/ptrkcsk/fa-wp-admin-menu-icons/compare/v1.0.0...v1.0.1) - 2017-06-16

### Fixed

- Add icons to `icons/`. The directory was empty on the WordPress plugin repository.

## 1.0.0 - 2017-03-25
