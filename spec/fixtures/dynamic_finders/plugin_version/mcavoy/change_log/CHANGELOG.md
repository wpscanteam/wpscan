# McAvoy Change Log

All notable changes to this project will be documented in this file, according to [the Keep a Changelog standards](http://keepachangelog.com/).

This project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.3] - 2016-04-26

* Fixed the `mcavoy_searches` table schema to accommodate more searches ([#26]).


## [0.1.2] - 2016-03-29

* When `DatabaseLogger::init()` is called, the logger will now run `DatabaseLogger::maybe_trigger_activation()` which checks for the existence of the `mcavoy_db_version` option and, if it's not found, will run `activate()`. This addresses [#22] and provides more consistent behavior in WordPress Multisite instances (where there will be multiple `*_mcavoy_searches` tables).


## [0.1.1] - 2016-03-28

After 0.1.0 was released, I/10up had Lukas Pawlik (@lukaspawlik) audit the plugin before we installed it on a client site. This security release reflects his findings.

* Fixed cross-site scripting (XSS) bug where search terms weren't automatically escaped.
* Fixed fatal error (`Fatal error: Call to undefined function McAvoy\Admin\get_logger()`) when deleting saved queries that resulted as a side-effect of namespace juggling.
* Added method access modifiers to the `ListTable` class.


## [0.1.0] - 2016-03-27

Initial public release.


[Unreleased]: https://github.com/stevegrunwell/mcavoy/compare/master...develop
[0.1.2]: https://github.com/stevegrunwell/mcavoy/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/stevegrunwell/mcavoy/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/stevegrunwell/mcavoy/releases/tag/v0.1.0
[#22]: https://github.com/stevegrunwell/mcavoy/issues/22
[#26]: https://github.com/stevegrunwell/mcavoy/issues/26