# Revision Strike Change Log

All notable changes to this project will be documented in this file, according to [the Keep a Changelog standards](http://keepachangelog.com/).

This project adheres to [Semantic Versioning](http://semver.org/).

## [0.6.0] - 2017-09-16

* Fixed bug where warnings were being thrown when Revision Strike was being run verbosely via WP-CLI. Props @ivankruchkoff. ([#29])
* Re-licensed the plugin under the MIT license.
* Updated Composer dependencies and bumped the minimum development version of PHP to 7.0 (though the plugin is still targeting PHP 5.3+). ([#32])


## [0.5.0] - 2017-05-15

* Add the `revisionstrike_capabilities` filter to allow setting required capabilities to access Revision Strike settings page. Props @pereirinha. ([#28])
* Updated Composer and npm dependencies.
* Update the Code Climate configuration.
* Coding standards cleanup.


## [0.4.1] - 2017-03-04

* Converted unit tests to use the 1.0.x development branch of [WP_Mock](https://github.com/10up/wp_mock)
* Adjusted visibility of `RevisionStrikeCLI::log_deleted_revision()`. ([#20])


## [0.4.0] - 2016-07-29

* Move from the manual pre-commit hook to [WP Enforcer](https://github.com/stevegrunwell/wp-enforcer).
	* As a result, minor standards-related changes have been made to the code to comply with the [WordPress Coding Standards](https://codex.wordpress.org/WordPress_Coding_Standards).
* Re-work the copy on Tools &rsaquo; Revision Strike to be more clear to site administrators. ([#26])
* Add additional tests around the Tools &rsaquo; Revision Strike page confirmation messages. ([#25])


## [0.3.0] - 2016-06-20

* Lock Composer dependency versions to ensure more consistent testing via Travis-CI.
* Add the `revisionstrike_get_revision_ids` filter to enable third-party plugins and themes to alter the array of revision IDs. ([#21])
* Implement Grunt to more consistently build releases. ([#18])


## [0.2.0] - 2015-08-16

* Added a "Limit" setting to Settings &rsaquo; Writing. ([#13])
* Added a "clean-all" WP-CLI command. ([#14])
* Clarified language on the Settings &rsaquo; Writing and Tools &rsaquo; Revision Strike pages. Props to @GhostToast for the suggestion! ([#16])
* Strike requests are now batched into groupings of 50 IDs at a time to avoid overwhelming underpowered machines. ([#17])


## [0.1.0] - 2015-08-09

Initial public release.


[Unreleased]: https://github.com/stevegrunwell/revision-strike/compare/master...develop
[0.6.0]: https://github.com/stevegrunwell/revision-strike/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/stevegrunwell/revision-strike/compare/v0.4.1...v0.5.0
[0.4.1]: https://github.com/stevegrunwell/revision-strike/compare/v0.3.0...v0.4.1
[0.4.0]: https://github.com/stevegrunwell/revision-strike/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/stevegrunwell/revision-strike/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/stevegrunwell/revision-strike/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/stevegrunwell/revision-strike/releases/tag/v0.1.0
[#13]: https://github.com/stevegrunwell/revision-strike/issues/13
[#14]: https://github.com/stevegrunwell/revision-strike/issues/14
[#16]: https://github.com/stevegrunwell/revision-strike/issues/16
[#17]: https://github.com/stevegrunwell/revision-strike/issues/17
[#18]: https://github.com/stevegrunwell/revision-strike/issues/18
[#20]: https://github.com/stevegrunwell/revision-strike/issues/20
[#21]: https://github.com/stevegrunwell/revision-strike/issues/21
[#25]: https://github.com/stevegrunwell/revision-strike/issues/25
[#26]: https://github.com/stevegrunwell/revision-strike/issues/26
[#28]: https://github.com/stevegrunwell/revision-strike/pull/28
[#29]: https://github.com/stevegrunwell/revision-strike/pull/29
[#32]: https://github.com/stevegrunwell/revision-strike/pull/32
