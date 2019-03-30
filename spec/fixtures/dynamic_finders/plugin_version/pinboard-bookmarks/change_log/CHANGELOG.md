# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.7.4] - 2019-02-24
### Fixed
* Make sure that item timestamp and local offset are an integer.

## [1.7.3] - 2018-10-21
### Added
* Added widget ID in debug display.
* Checked all files with [WordPress Coding Standard for PHPCS](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards).
### Fixed
* Fixed filtering the widget title using widget id base.

## [1.7.2] - 2018-06-02
### Changed
* Created some functions in a separate file.
### Fixed
* Minor bug fix and enhancements.

## [1.7.1] - 2018-03-25
### Changed
* Updated shortcode.

## [1.7.0] - 2018-03-25
### Changed
* Added an option to rearrange the elements of each items.
### Fixed
* Fixed shuffling of items.
* Fixed open link in new tabs for source.

## [1.6.0] - 2017-09-24
### Removed
* Removed support for Twitter.
* Removed option to get bookmarks from tags without setting a username.
### Added
* Added introductory text.
### Fixed
* Fixed option name for uninstall.php.
* Minor fixes.

## [1.5.0] - 2017-07-15
### Changed
* Display the source of the bookmark, even if a source has not been defined in the widget admin.
### Fixed
* Minor fixes.

## [1.4.0] - 2017-07-14
### Added
* Display the source of the bookmarks, if activated.
### Changed
* Display a different URL to the archive in different cases.
* Improve control for username.
* Changed some class names.
### Fixed
* Fix time display: now the plugin displays correctly the seconds.
* Fix URL when using more than 1 tag.
* Minor fixes.

## [1.3.0] - 2017-04-29
### Changed
* Updated shortcode options.

## [1.2.0] - 2017-04-29
### Added
* Added "no-follow" option to all external links.
* Added the number of retrieved items in debug section.
* Added option to select the type of list (bullet or numeric list).
* Added option to get bookmarks labeled with the source, like `from:pocket`.
* Added option to display debugging informations to admins only.
* Added option to display the time of the bookmarks.
### Changed
* Changed capabilities for viewing debug informations.
### Security
* Hardening security.

## [1.1.0] - 2017-01-04
### Changed
* Various small improvements.
### Security
* Hardening security.

## 1.0.0 - 2017-01-02
### Added
* First release of the plugin.

[Unreleased]: https://github.com/aldolat/pinboard-bookmarks/commits/develop
[1.7.2]: https://github.com/aldolat/pinboard-bookmarks/compare/1.7.1...1.7.2
[1.7.1]: https://github.com/aldolat/pinboard-bookmarks/compare/1.7.0...1.7.1
[1.7.0]: https://github.com/aldolat/pinboard-bookmarks/compare/1.6.0...1.7.1
[1.6.0]: https://github.com/aldolat/pinboard-bookmarks/compare/1.5.0...1.6.0
[1.5.0]: https://github.com/aldolat/pinboard-bookmarks/compare/1.4.0...1.5.0
[1.4.0]: https://github.com/aldolat/pinboard-bookmarks/compare/1.3...1.4.0
[1.3.0]: https://github.com/aldolat/pinboard-bookmarks/compare/1.2...1.3
[1.2.0]: https://github.com/aldolat/pinboard-bookmarks/compare/1.1...1.2
[1.1.0]: https://github.com/aldolat/pinboard-bookmarks/compare/1.0...1.1
