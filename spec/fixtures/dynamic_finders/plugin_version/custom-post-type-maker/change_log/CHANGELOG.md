## Changelog

### 1.1.6
- Fixes tab navigation (Thanks @mediengestalter2)[#16](https://github.com/Graffino/Custom-Post-Type-Maker/issues/16)

### 1.1.5
- Add ability to show custom post in REST API (Thanks @asithade)[#14](https://github.com/Graffino/Custom-Post-Type-Maker/issues/14).

### 1.1.4
- Add ability to show custom taxonomy column in post listing.

### 1.1.3
- Removed forgotten development dump. Sorry about that.

### 1.1.2
- [Bugfix] Make `with_front` available in `register_post` when set to `false` (Credit: @cmerrick). Closes: [#7](https://github.com/Graffino/Custom-Post-Type-Maker/issues/7)

### 1.1.1
- [Feature] Auto-flush rewrite rules on: custom post save, plugin activation, plugin deactivation.
- [Bugfix] Made `publicly_queryable` default to true. This fixes permalink errors after upgrading to v1.1.0 on existing installations.
- [Localization] Add french translation. (Credit: @momo-fr).

### 1.1.0
- [Feature] Implemented `publicly_queryable`. Closes: [#5](https://github.com/Graffino/Custom-Post-Type-Maker/issues/5)

### 1.0.4
- [Bugfix] Renamed plugin to match WP Plugins

### 1.0.3
- [Bugfix] Fix typos

### 1.0.2
- [Bugfix] Fixed `undefined` error that prevented media library from loading

### 1.0.1
- Compatibility with future version of WP

### 1.0.0
- [Added] Ability to select [DashIcons](https://developer.wordpress.org/resource/dashicons/#layout) as Custom Post Type icon.
- [Bugfix] Fixed `add_utility_page provokes "deprecated" notice in 4.5.2`
- [Forked] Forked https://wordpress.org/plugins/custom-post-type-maker/
