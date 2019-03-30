# Advanced Post Excerpt Change Log

All notable changes to this project will be documented in this file, according to [the Keep a Changelog standards](http://keepachangelog.com/).

This project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.0] - 2018-12-31

* Added support for the WordPress block editor (a.k.a. Gutenberg) [[#10]).
* Rewrite the plugin to use proper namespaces ([#9]).
* Bump the minimum PHP version to PHP 7.0 ([#8]).
* Rewrite the test suite using the WordPress core test suite ([#5]).

## [0.2.1] - 2017-03-04

* Fixed localization by adding missing [`load_plugin_textdomain()`](https://developer.wordpress.org/reference/functions/load_plugin_textdomain/) call ([#3]).
* Repaired the `composer.json` file, adding additional information.


## [0.2.0] - 2017-03-04

* Upgraded Composer dependencies
* Run PHP_CodeSniffer as part of the Travis-CI build process ([#1]).
* Switched to using [`get_post_types_by_support()`](https://developer.wordpress.org/reference/functions/get_post_types_by_support/), which was introduced in WordPress 4.5.
* Removed the alignment (left/center/right) buttons from the Advanced Post Excerpt TinyMCE instance ([#2]).

### Restoring alignment buttons

If you'd prefer to keep the alignment buttons that were removed by default in [#2], you can do so with the following code:

```php
// Restore alignleft, aligncenter, and alignright buttons to the post excerpt editor.
remove_filter( 'teeny_mce_buttons', 'ape_remove_alignment_buttons_from_excerpt', 10, 2 );
```


## [0.1.0] - 2016-02-26

* Initial public release.


[Unreleased]: https://github.com/stevegrunwell/advanced-post-excerpt/compare/master...develop
[1.0.0]: https://github.com/stevegrunwell/advanced-post-excerpt/releases/tag/v1.0.0
[0.2.1]: https://github.com/stevegrunwell/advanced-post-excerpt/releases/tag/v0.2.1
[0.2.0]: https://github.com/stevegrunwell/advanced-post-excerpt/releases/tag/v0.2.0
[0.1.0]: https://github.com/stevegrunwell/advanced-post-excerpt/releases/tag/v0.1.0
[#1]: https://github.com/stevegrunwell/advanced-post-excerpt/issues/1
[#2]: https://github.com/stevegrunwell/advanced-post-excerpt/issues/2
[#3]: https://github.com/stevegrunwell/advanced-post-excerpt/issues/3
[#5]: https://github.com/stevegrunwell/advanced-post-excerpt/pull/5
[#8]: https://github.com/stevegrunwell/advanced-post-excerpt/pull/8
[#9]: https://github.com/stevegrunwell/advanced-post-excerpt/pull/9
[#10]: https://github.com/stevegrunwell/advanced-post-excerpt/pull/10
