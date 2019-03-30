# Change Log

## [1.0.0] - 2017 - 09 - 21

### Added

* New Posts widget. This is an alternative to the core recent posts widget with more options.
* Post type option to the Archives widget.
* Show count option for the Tags widget.
* Feed type option for the Authors widget.
* Proper human-readable labels for all widget form fields.
* Base widget class with reusable methods for each of the plugin's widgets.
* Support for selective refresh in the customizer.
* `widgets_reloaded_core_widgets_enabled` filter hook for disabling core widgets (only those that the plugin provides an alternative for).

### Changed

* Plugin now only works on PHP 5.3.0+.
* All code is now namespaced under the `Widgets_Reloaded` namespace or `Widgets_Reloaded\Widgets` sub-namespace.
* Core widgets are no longer disabled by default.
* Cleaned up widget form fields. Less code. More readable.
* All widget names are prefixed with `Reloaded -` to distinguish them from other widgets.
* Rewrote widget descriptions.
* Languages folder changed to `/lang`.

### Removed

* Old widget class names. These are no longer available for direct usage via `the_widget()`. You must use the newer class names.
* Search widget.  It was already the same as the core WP search widget.

### Fixed

* Using `sanitize_text_field()` instead of `strip_tags()` for widget titles. This allows widget title HTML plugins to work.

## [0.6.0]

* New `include` and `exclude` arguments for the Authors widget.
* All widgets now have defaults set. This is so that there are no undefined index notices when calling a widget using `the_widget()` or similar methods.
* Make sure the Calendar widget has a default title when shown in the customizer.
* Adds a wrapper `<p>` for the Categories widget when there's no style set.
* Eliminates all uses of `extract()` in accordance with new WP coding standards.
* Removed trailing `?>` from all PHP files.
* Dropped search widget options in favor of playing more nicely with `get_search_form()` and its hooks.
* Added the `Domain Path` plugin header.
* Complete overhaul of the sanitizing/validating functionality in the plugin for smarter handling of widget option updates.
* Incorporates newer HTML5 form fields in widget options where possible.
* Added placeholders so that it's easier to understand what each widget option does.
* Introduced the `single_text` and `multiple_text` options for the Tags widget.
* Added Finnish, French, Romanian, Spanish, and Swedish translations.
* Minor bug fixes.

## [0.5.1]

* Added an upgrade notice for users below 0.5.0.
* Added a fix for users of the MP6 plugin who are having issues with widget controls.

## [0.5.0]

* Overhauled how the entire plugin works.
* Ported in new versions of the widgets from the Hybrid Core framework.
* Users of Hybrid Core-based themes can now use this plugin and the theme at the same time.
* Recent Posts widget is no longer disabled.

## [0.4.1]

* `WP_DEBUG` notices fixes so that the plugin is a bit cleaner and uses best practices.

## [0.4.0]

* Revamped each of the widgets individually to be much easier to use (lots of pointing and clicking instead of typing in IDs).
* Loads of new options and things to play around with.
* Added the Navigation Menu widget to use the WordPress 3.0 nav menus.
* Moved the language files into the `languages` folder.
* Note that you may need to re-save your widget settings upon upgrade.

## [0.3.0]

* The widgets are now completely ported over from the Hybrid theme framework. This just makes more sense than dealing with two separate codebases.
* Individual widget files now begin with `widget-`.
* The Categories widget now has a `search` option and the `orderby` option has two new parameters: `slug` and `term_group`.
* Added a `search` and `title_li` option for the Bookmarks widget.
* Added `separator`, `search`, `name__like`, `pad_counts`, `parent`, `child_of`, and `hide_empty` options for the Tags widget.
* Added a `number` and `offset` option for the Pages widget.
* Fixed the `show_post_count` option in the Archives widget.

## [0.2.0]

* Completely rewrote every line of code to work with the WordPress 2.8+ widget API.
* By God, I'm not going to document every one of those changes.
* You'll likely have to re-add your widgets once you've upgraded because of the new widget system in WordPress.

## [0.1.2]

* Code cleanup.
* Added the Calendar widget.

## [0.1.1]

* Cleaned up a lot of the code.
* Fixed a few bugs.
* Added the Authors widget.

## [0.1.0]

* Plugin launch.
