# Change Log for WP-Markdown

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

### [1.6.1] - 2017-12-27

* Remove test files from final build
* Removed readme.txt in favour of readme.md

### [1.6.0] - 2017-12-25

* Fixed PHP7 deprecation notices
* Load prettify.js in the footer (See [#60](https://github.com/stephenharris/WP-MarkDown/pull/60/) )
* Ensure the toolbar javascript runs as late as possible. Fixes conflict with Shortcoder which calls Qtags late on and destroys the markdown toolbar. Fixes [#53](https://github.com/stephenharris/WP-MarkDown/pull/53/).
* Update markdown extra version. Thanks to @lite3. Closes [#43](https://github.com/stephenharris/WP-MarkDown/pull/43/).
* By default balance tags before HTML is converted to markdown. (Adds filter to prevent this behaviour). See [#47](https://github.com/stephenharris/WP-MarkDown/pull/47/).


## [1.5.1] - 2014-04-09
* Address issues with (since withdrawn) 1.5.0 version.

## [1.5.0] - 2013-12-07
* Handle tables. See [#35].
* Fix responsive layout issue. See [#31].
* Use compressed `prettify.js`.
* Fix bug with lists not being escaped.
* Fix textdomain. Change to `wp-markdown`.
* Add language file.
* Fix incompatability issues with bbPress.

## [1.4] - 2013-12-07
* Fix issue with consecutive shortcodes.
* Fix editing bbPress topics/replies on the front-end corrupts Markdown. See [#25].

## [1.3] - 2013-09-01
* Apply kses and balance tags after MD->HTML conversion. See [#23].
* Compress scripts and minify icon sprite. See [#7].
* Add 'more' tag to Markdown editor.
* Add support for iframes. See [#22].
* Fix bug with underscores in shortcodes.
* Add support for `tbody`, `tfoot` and `thead` tags.
* Refactoring including renaming of plugin style and script handles.

## [1.2] - 2013-07-03
* Fix problems with images nested inside links. See [#12].
* Ensure prettify is loaded, if needed, on home page. See [#6].
* Update Markdownify.
* Update Prettify.

## [1.1.6] - 2012-12-03

* Remove the `wpautop`/`unwpautop` functions. If using oEmbed, use `[embed]` shortcode.
* Add public wrapper functions.
* Remove bbPress front-end TinyMCE editor if using Markdown.

## [1.1.5] - 2012-08-09
* Fix bug introduced in 1.1.4 where line breaks are stripped (affects code blocks).

## [1.1.4] - 2012-08-05
* Fix bug where oEmbed would not work. Thanks to Michael & Vinicius.
* Add a filter for Markdown 'help' text: `wpmarkdown_help_text`.
* Support for Markdown Extra (currently not supported in pagedown previewer).

## [1.1.3] - 2012-06-18
* Stable with WordPress 3.4.
* Fix bug relating to title attributes for links and images.

## [1.1.2] - 2012-03-29
* Fix bug relating to comments by logged out users.

## [1.1.1] - 2012-03-24
* Fix backslash bug.

## [1.1] - 2012-03-13
* Add option to replace TinyMCE with Markdown help bar on post editor.

## 1.0 - 2012-03-13
* Initial release.

[Unreleased]: https://github.com/stephenharris/wp-markdown/compare/1.5.1...HEAD
[1.5.1]: https://github.com/stephenharris/wp-markdown/compare/1.5.0...1.5.1
[1.5.0]: https://github.com/stephenharris/wp-markdown/compare/1.4...1.5.0
[1.4]: https://github.com/stephenharris/wp-markdown/compare/1.3...1.4
[1.3]: https://github.com/stephenharris/wp-markdown/compare/1.2...1.3
[1.2]: https://github.com/stephenharris/wp-markdown/compare/1.1.6...1.2
[1.1.6]: https://github.com/stephenharris/wp-markdown/compare/1.1.5...1.1.6
[1.1.5]: https://github.com/stephenharris/wp-markdown/compare/1.1.4...1.1.5
[1.1.4]: https://github.com/stephenharris/wp-markdown/compare/1.1.3...1.1.4
[1.1.3]: https://github.com/stephenharris/wp-markdown/compare/1.1.2...1.1.3
[1.1.2]: https://github.com/stephenharris/wp-markdown/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/stephenharris/wp-markdown/compare/1.1...1.1.1
[1.1]: https://github.com/stephenharris/wp-markdown/compare/1.0...1.1

[#35]: https://github.com/stephenharris/WP-MarkDown/issues/35
[#31]: https://github.com/stephenharris/WP-MarkDown/issues/31
[#25]: https://github.com/stephenharris/WP-MarkDown/issues/25
[#23]: https://github.com/stephenharris/WP-MarkDown/issues/23
[#22]: https://github.com/stephenharris/WP-MarkDown/issues/22
[#12]: https://github.com/stephenharris/WP-MarkDown/issues/12
[#7]: https://github.com/stephenharris/WP-MarkDown/issues/7
[#6]: https://github.com/stephenharris/WP-MarkDown/issues/6
