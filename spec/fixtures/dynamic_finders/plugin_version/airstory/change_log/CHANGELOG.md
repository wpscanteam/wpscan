# Airstory Change Log

All notable changes to this project will be documented in this file, according to [the Keep a Changelog standards](http://keepachangelog.com/).

This project adheres to [Semantic Versioning](http://semver.org/).

## [1.1.7]

* Sunset the plugin in preparation for [Airstory deprecating documents on January 15, 2019](https://www.airstory.co/airstory-update-2018/) ([#91]).

## [1.1.6]

* Log any libxml errors that occur while importing post content ([#85]).

## [1.1.5]

* Add a minimum PHP version (5.3) to the `readme.txt` file ([#73]).
* Explicitly set `Access-Control-Allow-Origin` headers for the Airstory webhook request ([#74]).
* Plugin now attempts to resolve any redirects for the webhook URI before connecting to Airstory ([#75]).
* Explicitly whitelist the Airstory webhook within [WP-SpamShield](https://www.redsandmarketing.com/plugins/wp-spamshield-anti-spam/) ([#79]).
* Only require Mcrypt for environments running PHP < 7.0 ([#83]).
* Exclude non-essential [WP Async Task](https://github.com/techcrunch/wp-async-task) files from the plugin build.

## [1.1.4]

* Ensure content is being consistently converted to UTF-8 before performing any operations on it, drastically reducing some of the special character issues that have been reported by users.
* Improved error handling if WordPress fails to authenticate with Airstory when saving the user token.
* Fixed issue where not all user data was being removed on plugin uninstall.
* Updated README files to reflect changes in Airstory's billing model.

## [1.1.3]

* Explicitly import `WP_Error` into `Airstory\Credentials`.
* Add fallback cipher algorithms for environments running older versions of OpenSSL.
* Remove requirement for libxml 2.7.8 or newer, which was introduced in version [1.1.1].
* Better handling of `WP_Error` objects when decoding JSON responses from the Airstory API.

## [1.1.2]

* Fix an issue with a missing file distributed with version 1.1.1.

## [1.1.1]

* Improve support for accented and non-Latin characters when importing into WordPress.
* Add explicit check for libxml >= 2.7.8, as versions before that don't support the `LIBXML_HTML_NODEFDTD` constant.
* Clean up coding standards.

## [1.1.0]

* Introduce two connectivity checks in the "Compatibility" table to help identify issues accessing either the Airstory API or the WP REST API.
* Improve error messaging around the webhook, making it easier to troubleshoot connection issues.
* Add the plugin version to the header of the Tools > Airstory page.
* Refactor the logic when saving user settings.

## [1.0.1]

* Refactor the `grunt build` task to include the readme.txt file and skip the `dist/` directory when building the plugin's language files.
* Fixed a small typo in the plugin's README file.
* Fix issue with missing gradient background in the SVG version of the Airstory icon.
* Fixed bug where saving a user profile could fail without an Airstory user token.

## [1.0.0]

* Initial public release.


[Unreleased]: https://github.com/liquidweb/airstory-wp/compare/master...develop
[1.1.7]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.7
[1.1.6]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.6
[1.1.5]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.5
[1.1.4]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.4
[1.1.3]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.3
[1.1.2]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.2
[1.1.1]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.1
[1.1.0]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.1.0
[1.0.1]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.0.1
[1.0.0]: https://github.com/liquidweb/airstory-wp/releases/tag/v1.0.0
[#73]: https://github.com/liquidweb/airstory-wp/issues/73
[#74]: https://github.com/liquidweb/airstory-wp/issues/74
[#75]: https://github.com/liquidweb/airstory-wp/issues/75
[#79]: https://github.com/liquidweb/airstory-wp/issues/79
[#83]: https://github.com/liquidweb/airstory-wp/issues/83
[#85]: https://github.com/liquidweb/airstory-wp/pull/85
[#91]: https://github.com/liquidweb/airstory-wp/pull/91
