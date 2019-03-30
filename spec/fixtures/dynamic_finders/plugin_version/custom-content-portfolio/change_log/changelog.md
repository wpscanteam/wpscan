# Change Log

## [2.1.0] - 2017-09-29

### Added

* Support for translatable capability labels in the [Members plugin](https://themehybrid.com/plugins/members).
* Support for WP's newer taxonomy capabilities for both the `portfolio_category` and `portfolio_tag` taxonomies.  New caps are in the form of `assign_portfolio_*`, `edit_portfolio_*`, `delete_portfolio_*`, and the normal `manage_portfolio_*` cap.

### Changed

* `languages` folder renamed to `lang` for consistency with my other plugins.
* "Category" and "Tag" singular and plural labels are now prefixed with "Project".  This helps differentiate them in taxonomy lists.

### Fixed

* Typo in textdomain for a single text string that couldn't be translated.

## [2.0.1] - 2016-11-14

### Fixed

* Meta keys were switched on activation callback for correcting old portfolio project URLs.

## [2.0.0] - 2016-11-14

### Added

* New `ccp_is_archive()` conditional tag for checking if on archive.
* New `ccp_get_settings_page_slug()` for add-ons to get the appropriate settings page when adding custom sections and fields.
* Meta fields are now registered to work with the REST API.

### Changed

* [ButterBean framework](http://themehybrid.com/plugins/butterbean) replaced the fields manager code. Note that this breaks back-compat with any custom code for the meta box.
* Calls to `register_meta()` are now in line with WP 4.6+.

### Fixed

* Settings page slug changed to `ccp-settings` from `settings` to avoid conflicts with other plugins.  Note that this is a breaking change for add-ons with custom settings sections or fields.
* Corrected post type labels.
* Corrected taxonomy labels.
* Make sure to not return an empty string on the `enter_title_here` hook when not our post type.

## [1.0.1] - 2015-11-05

### Fixed

* Allow for an empty project, category, tag, or author rewrite base but handle conflicts when more than one are empty.

## [1.0.0] - 2015-11-02

### Added

* Settings screen under the Portfolio menu item.
* General portfolio settings for title and description.
* Permalink settings for all portfolio pages.
* Sticky projects.
* Support for project author archives.
* Category taxonomy.
* Tag taxonomy.
* Support for audio, gallery, image, and video post formats.
* Project client field.
* Project location field.
* Project start date field.
* Project end date field.
* Filters for all post type and taxonomy labels and text.
* Outputs project data for themes without support.
* Basic template hierarchy for themes to use.
* Full compliment of template tags for themes.
* Custom admin screen help tabs.
* Project Details meta box with an API for devs to hook into.
* Filter and action hooks for pretty much everything.
* Support for the Custom Background Extended plugin.
* Support for the Custom Header Extended plugin.

### Changed

* Complete UI overhaul for the plugin.
* `portfolio_item` post type became the `portfolio_project` post type.
* `portfolio` taxonomy became the `portolio_category` taxonomy.
* `portfolio_item_url` meta key became the `url` meta key.

### Removed

* Several internal plugin filters and actions were removed.

## [0.1.0]

* Plugin launch.  Everything's new!
