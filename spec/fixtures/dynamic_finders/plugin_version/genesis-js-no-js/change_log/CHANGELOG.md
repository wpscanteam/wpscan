# Change Log for Genesis JS / No JS

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

Nothing yet.

## [3.2.1] - 2017-11-29
### Fixed
- Fatal error, requiring wrong file name.

## [3.2.0] - 2017-11-29
### Added
- Unit tests, with 100% code coverage.
- Mutation tests, with MSI of 100%.
- `.editorconfig` file for code standards in IDEs.
- New Plugin class which loads textdomain.

### Changed
- Name of main class.
- Refreshed Travis config, switched to build stages.
- Refreshed .gitattributes.

## [3.1.1] - 2017-11-29
### Changed
- Rename PHPCS config file, since PHP_CodeSniffer 3.1 minimum is required.

### Fixed
- Check and deactivate correctly if PHP requirement not met.

## [3.1.0] - 2017-11-28
### Added
- `Requires PHP` header to `readme.txt`.

### Changed
- Dropped PHP requirement for running the plugin from 7.1 to 7.0.

## [3.0.1] - 2017-08-24
### Fixed
- Function name prefixes.

## [3.0.0] - 2017-08-24

### Added
- Banner and icon PSDs to assets.
- PHP version check in main plugin file.
- GitHub documents and templates.
- [Code of conduct].
- [Travis CI] support.
- `.gitattributes` file to reduce Git / Composer distributable archive size.
- Coding standards checks and fixes.

### Changed
- [#2]: Bumped minimum required PHP version to **PHP 7.1**.
- [#4]: Improved replacement technique, to avoid parsing class name string with a regular expression (props [Tim Jensen]).
- Bumped minimum required WP version to **WordPress 4.6**.
- Bumped Tested Up To version to 4.8.1.
- Moved PHP 7.1+ code into separate `init.php` file.
- Update documentation.

### Removed
- Explicit load plugin text domain call.

## [2.1.0] - 2016-08-08

### Added
- Load plugin text domain.
- `composer.json`.

### Changed
- Better [change log format].
- Update documentation.

## [2.0.0] - 2014-08-23

### Added
- GitHub Updater plugin support

### Changed
- Refactor class into a new file. Stops using half-implemented Singleton pattern.
- Update documentation.

## [1.0.1] - 2011-06-02

### Fixed
- Hooked in with priority 1 to avoid a theme placing anything before the script (props [Josh Stauffer]).

## 1.0.0 - 2011-05-24

- Initial release.

[#2]: https://github.com/GaryJones/genesis-js-no-js/issues/2
[#4]: https://github.com/GaryJones/genesis-js-no-js/issues/4

[change log format]: http://keepachangelog.com/en/1.0.0/
[Code of conduct]: CODE_OF_CONDUCT.md
[Josh Stauffer]: http://twitter.com/joshstauffer
[Tim Jensen]: https://github.com/timothyjensen
[Travis CI]: https://travis-ci.org/GaryJones/genesis-js-no-js

[Unreleased]: https://github.com/GaryJones/genesis-js-no-js/compare/3.2.1...HEAD
[3.2.1]: https://github.com/GaryJones/genesis-js-no-js/compare/3.2.0...3.2.1
[3.2.0]: https://github.com/GaryJones/genesis-js-no-js/compare/3.1.1...3.2.0
[3.1.1]: https://github.com/GaryJones/genesis-js-no-js/compare/3.1.1...3.1.1
[3.1.0]: https://github.com/GaryJones/genesis-js-no-js/compare/3.0.1...3.1.0
[3.0.1]: https://github.com/GaryJones/genesis-js-no-js/compare/3.0.0...3.0.1
[3.0.0]: https://github.com/GaryJones/genesis-js-no-js/compare/2.1.0...3.0.0
[2.1.0]: https://github.com/GaryJones/genesis-js-no-js/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/GaryJones/genesis-js-no-js/compare/1.0.1...2.0.0
[1.0.1]: https://github.com/GaryJones/genesis-js-no-js/compare/1.0.0...1.0.1
