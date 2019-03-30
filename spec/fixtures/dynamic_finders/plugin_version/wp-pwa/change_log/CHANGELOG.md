## [1.13.5](https://github.com/frontity/wp-plugin/compare/v1.13.4...v1.13.5) (2019-02-08)


### Bug Fixes

* **versions:** fixes error messages on low php and wp versions ([752f5b6](https://github.com/frontity/wp-plugin/commit/752f5b6))

## [1.13.4](https://github.com/frontity/wp-plugin/compare/v1.13.3...v1.13.4) (2019-02-08)


### Bug Fixes

* **activation:** prevents activation if low php or wp version ([e8e5092](https://github.com/frontity/wp-plugin/commit/e8e5092))
* **general:** fix small syntax problems with PHP 5.3 ([243c483](https://github.com/frontity/wp-plugin/commit/243c483))

## [1.13.3](https://github.com/frontity/wp-plugin/compare/v1.13.2...v1.13.3) (2019-02-07)


### Bug Fixes

* **loader:** fixes loader for external injection ([ae5979a](https://github.com/frontity/wp-plugin/commit/ae5979a))

## [1.13.2](https://github.com/frontity/wp-plugin/compare/v1.13.1...v1.13.2) (2019-02-06)


### Bug Fixes

* **loader:** fixes loader bar ([30c2274](https://github.com/frontity/wp-plugin/commit/30c2274))

## [1.13.1](https://github.com/frontity/wp-plugin/compare/v1.13.0...v1.13.1) (2019-02-06)


### Bug Fixes

* **injector:** adds version to injector url to refresh cache ([6b9f412](https://github.com/frontity/wp-plugin/commit/6b9f412))

# [1.13.0](https://github.com/frontity/wp-plugin/compare/v1.12.1...v1.13.0) (2019-02-06)


### Bug Fixes

* **images:** prevents data-attachment-id if src is external ([d8a3c81](https://github.com/frontity/wp-plugin/commit/d8a3c81))
* **latest:** fixes latest filter ([64b90ad](https://github.com/frontity/wp-plugin/commit/64b90ad))


### Features

* **injector:** adds auto injector ([4538e16](https://github.com/frontity/wp-plugin/commit/4538e16))

## [1.12.1](https://github.com/frontity/wp-plugin/compare/v1.12.0...v1.12.1) (2019-01-30)


### Bug Fixes

* **update:** fixes update settings ([7632455](https://github.com/frontity/wp-plugin/commit/7632455))

# [1.12.0](https://github.com/frontity/wp-plugin/compare/v1.11.0...v1.12.0) (2019-01-29)


### Bug Fixes

* **purifier:** fixes warnings when running purifier ([5e8f75c](https://github.com/frontity/wp-plugin/commit/5e8f75c))
* **settings:** removes api_filters from settings ([b42942a](https://github.com/frontity/wp-plugin/commit/b42942a))


### Features

* **rest-api:** adds support for excludeFields param ([60d58b1](https://github.com/frontity/wp-plugin/commit/60d58b1))
* **settings:** adds injection type setting ([d762327](https://github.com/frontity/wp-plugin/commit/d762327))

# [1.11.0](https://github.com/frontity/wp-plugin/compare/v1.10.7...v1.11.0) (2019-01-18)


### Bug Fixes

* **babel:** fixes browsers support versions ([7c87d93](https://github.com/frontity/wp-plugin/commit/7c87d93))
* **dashboard:** changes solution for screenshot in dashboard ([15114f4](https://github.com/frontity/wp-plugin/commit/15114f4))
* **dashboard:** maskes dashboard responsive ([e943d58](https://github.com/frontity/wp-plugin/commit/e943d58))
* **image:** fixes dashboard screenshot not found ([ad405eb](https://github.com/frontity/wp-plugin/commit/ad405eb))
* **purge-button:** adds feedback to PurgeButton ([b5535c0](https://github.com/frontity/wp-plugin/commit/b5535c0))
* **purifier:** fixes deprecated warnings ([f4199f6](https://github.com/frontity/wp-plugin/commit/f4199f6))
* **stores:** fixes site_id validation on start ([dc34bfd](https://github.com/frontity/wp-plugin/commit/dc34bfd))
* **stores:** refactor and fixes saving invalid settings ([fe2111b](https://github.com/frontity/wp-plugin/commit/fe2111b))
* **styles:** fixes styles to be responsive ([bfc0f6e](https://github.com/frontity/wp-plugin/commit/bfc0f6e))
* **styles:** fixes WP padding on mobile ([8913efd](https://github.com/frontity/wp-plugin/commit/8913efd))


### Features

* **rest-api:** expose settings on the rest api ([bc15236](https://github.com/frontity/wp-plugin/commit/bc15236))

## [1.10.7](https://github.com/frontity/wp-plugin/compare/v1.10.6...v1.10.7) (2019-01-04)


### Bug Fixes

* **request-site-id:** change traffic to UNKNOWN ([07b553e](https://github.com/frontity/wp-plugin/commit/07b553e))

## [1.10.6](https://github.com/frontity/wp-plugin/compare/v1.10.5...v1.10.6) (2019-01-02)


### Bug Fixes

* **request-site-id:** change source to origin ([da6300f](https://github.com/frontity/wp-plugin/commit/da6300f))

## [1.10.5](https://github.com/frontity/wp-plugin/compare/v1.10.4...v1.10.5) (2018-12-27)


### Bug Fixes

* **request-demo:** fix form field names ([2a1d856](https://github.com/frontity/wp-plugin/commit/2a1d856))

## [1.10.4](https://github.com/frontity/wp-plugin/compare/v1.10.3...v1.10.4) (2018-12-24)


### Bug Fixes

* **update:** adds github plugin uri to wp-pwa.php ([bc11a34](https://github.com/frontity/wp-plugin/commit/bc11a34))

## [1.10.3](https://github.com/frontity/wp-plugin/compare/v1.10.2...v1.10.3) (2018-12-24)


### Bug Fixes

* **images:** fixes image url in dashboard view ([c0547f1](https://github.com/frontity/wp-plugin/commit/c0547f1))
* **update:** fixes update process ([e1e0574](https://github.com/frontity/wp-plugin/commit/e1e0574))
* **validation:** fixes site id validation ([fedaa5a](https://github.com/frontity/wp-plugin/commit/fedaa5a))

## [1.10.2](https://github.com/frontity/wp-plugin/compare/v1.10.1...v1.10.2) (2018-12-24)


### Bug Fixes

* **amp:** fixes amp url ([bdcf78f](https://github.com/frontity/wp-plugin/commit/bdcf78f))
* **injector:** fixes php error about sitId undefined in dev ([893127c](https://github.com/frontity/wp-plugin/commit/893127c))
* **validation:** fixes site_id validation ([2ebe7b1](https://github.com/frontity/wp-plugin/commit/2ebe7b1))

## [1.10.1](https://github.com/frontity/wp-plugin/compare/v1.10.0...v1.10.1) (2018-12-21)


### Bug Fixes

* **filename:** renames frontity.php to wp-pwa.php to avoid conflicts ([a3211f4](https://github.com/frontity/wp-plugin/commit/a3211f4))

# [1.10.0](https://github.com/frontity/wp-plugin/compare/v1.9.1...v1.10.0) (2018-12-21)


### Bug Fixes

* **dashboard:** use proper form instead of only a button ([53fd3f0](https://github.com/frontity/wp-plugin/commit/53fd3f0))
* **demos:** show links ([71c70b1](https://github.com/frontity/wp-plugin/commit/71c70b1))
* **demos:** update links with UTM campaigns ([56b08e9](https://github.com/frontity/wp-plugin/commit/56b08e9))
* **htmlpurifier:** use explicit htmlpurifier text to avoid confusion ([aada9af](https://github.com/frontity/wp-plugin/commit/aada9af))
* **injector:** change settings names in injector ([eb8ef92](https://github.com/frontity/wp-plugin/commit/eb8ef92))
* **injector:** fixes injector not being loaded ([05bd015](https://github.com/frontity/wp-plugin/commit/05bd015))
* **injector:** use wp_pwa_path name again ([66f02c9](https://github.com/frontity/wp-plugin/commit/66f02c9))
* **settings:** don't use the update plugin logic for update settings ([9fd3d22](https://github.com/frontity/wp-plugin/commit/9fd3d22))
* **settings:** fixes settings saved without validation ([e8b157e](https://github.com/frontity/wp-plugin/commit/e8b157e))
* **settings:** move initialization and update of settings out of Class ([015c2a3](https://github.com/frontity/wp-plugin/commit/015c2a3))
* **settings:** site id is no longer restricted to 17 chars ([7a6e70f](https://github.com/frontity/wp-plugin/commit/7a6e70f))


### Features

* **all:** migrate to react [WIP] ([9ea3150](https://github.com/frontity/wp-plugin/commit/9ea3150))
* **all:** new plugin design! ([e7757ea](https://github.com/frontity/wp-plugin/commit/e7757ea))

## [1.9.1](https://github.com/frontity/wp-plugin/compare/v1.9.0...v1.9.1) (2018-12-11)


### Bug Fixes

* **semantic-release:** move to dotenv and release.scripts.js ([a0d82b7](https://github.com/frontity/wp-plugin/commit/a0d82b7))

# [1.9.0](https://github.com/frontity/wp-plugin/compare/v1.8.0...v1.9.0) (2018-12-11)


### Features

* **injector:** add a filter for the js injector ([b6d9fd9](https://github.com/frontity/wp-plugin/commit/b6d9fd9))

# [1.9.0](https://github.com/frontity/wp-plugin/compare/v1.8.0...v1.9.0) (2018-12-11)


### Features

* **injector:** add a filter for the js injector ([b6d9fd9](https://github.com/frontity/wp-plugin/commit/b6d9fd9))

# [1.8.0](https://github.com/frontity/wp-plugin/compare/v1.7.6...v1.8.0) (2018-11-16)


### Bug Fixes

* **transients:** never expire them and set hit or miss when id is zero ([b4095f2](https://github.com/frontity/wp-plugin/commit/b4095f2))


### Features

* **wp-embeds:** send height from wp post embeds ([9e61012](https://github.com/frontity/wp-plugin/commit/9e61012))

## [1.7.6](https://github.com/frontity/wp-plugin/compare/v1.7.5...v1.7.6) (2018-11-08)


### Bug Fixes

* **amp:** fix types for custom post types in AMP ([dc3c8cf](https://github.com/frontity/wp-plugin/commit/dc3c8cf))

## [1.7.5](https://github.com/frontity/wp-plugin/compare/v1.7.4...v1.7.5) (2018-11-02)


### Bug Fixes

* **attachment-ids:** return ids with integer values and purge transients ([6a25ff1](https://github.com/frontity/wp-plugin/commit/6a25ff1))

## [1.7.4](https://github.com/frontity/wp-plugin/compare/v1.7.3...v1.7.4) (2018-10-31)


### Bug Fixes

* **forbidden-images:** create fix_forbidden_image WIP ([b390d3e](https://github.com/frontity/wp-plugin/commit/b390d3e))
* **forbidden-images:** use fix_forbidden_media when the query is true ([2ca8ef9](https://github.com/frontity/wp-plugin/commit/2ca8ef9))
* **purifier:** do not override 'RemoveEmtpy.Predicate' default values ([f80b966](https://github.com/frontity/wp-plugin/commit/f80b966))

## [1.7.3](https://github.com/frontity/wp-plugin/compare/v1.7.2...v1.7.3) (2018-10-24)


### Bug Fixes

* **purifier:** add exceptions to remove empty elements ([07438e6](https://github.com/frontity/wp-plugin/commit/07438e6))

## [1.7.2](https://github.com/frontity/wp-plugin/compare/v1.7.1...v1.7.2) (2018-10-24)


### Bug Fixes

* **injector:** remove the check for the REST API base slug of cpt's ([55b21d0](https://github.com/frontity/wp-plugin/commit/55b21d0))
* **latest-link:** use home link only if the custom post type is 'post' ([5182bd5](https://github.com/frontity/wp-plugin/commit/5182bd5))

## [1.7.1](https://github.com/frontity/wp-plugin/compare/v1.7.0...v1.7.1) (2018-10-19)


### Bug Fixes

* **image-ids:** do not treat ids equal zero as a transient cache miss ([2e15a5c](https://github.com/frontity/wp-plugin/commit/2e15a5c))

# [1.7.0](https://github.com/frontity/wp-plugin/compare/v1.6.4...v1.7.0) (2018-10-19)


### Features

* **wp-pwa:** add query to disable htmlPurifier ([b515d51](https://github.com/frontity/wp-plugin/commit/b515d51))
* **wp-pwa:** use transients when getting image ids from wp-query ([a5bea25](https://github.com/frontity/wp-plugin/commit/a5bea25))

## [1.6.4](https://github.com/frontity/wp-plugin/compare/v1.6.3...v1.6.4) (2018-09-26)


### Bug Fixes

* **semantic-release:** add github back and finish automation ([825afa0](https://github.com/frontity/wp-plugin/commit/825afa0))

## [1.6.3](https://github.com/frontity/wp-plugin/compare/v1.6.2...v1.6.3) (2018-09-26)


### Bug Fixes

* **semantic-release:** add push for master as well ([d223345](https://github.com/frontity/wp-plugin/commit/d223345))
* **semantic-release:** add rebase ([4577fc8](https://github.com/frontity/wp-plugin/commit/4577fc8))
* **semantic-release:** add success cmd ([2cde44e](https://github.com/frontity/wp-plugin/commit/2cde44e))

## [1.6.2](https://github.com/frontity/wp-plugin/compare/v1.6.1...v1.6.2) (2018-09-26)


### Bug Fixes

* **semantic-release:** add wp-pwa.php to git assets ([a86fb4d](https://github.com/frontity/wp-plugin/commit/a86fb4d))

## [1.6.1](https://github.com/frontity/wp-plugin/compare/v1.6.0...v1.6.1) (2018-09-26)


### Bug Fixes

* **semantic-release:** fix json ([af0490b](https://github.com/frontity/wp-plugin/commit/af0490b))
* **semantic-release:** reorder and add empty steps ([f008b2f](https://github.com/frontity/wp-plugin/commit/f008b2f))

## [1.6.1](https://github.com/frontity/wp-plugin/compare/v1.6.0...v1.6.1) (2018-09-26)


### Bug Fixes

* **semantic-release:** fix json ([af0490b](https://github.com/frontity/wp-plugin/commit/af0490b))

# [1.6.0](https://github.com/frontity/wp-plugin/compare/v1.5.1...v1.6.0) (2018-09-25)


### Features

* **api-fields:** add option to whitelist api fields ([867d759](https://github.com/frontity/wp-plugin/commit/867d759))
* **api-fields:** change whitelist for blacklist ([a1d0811](https://github.com/frontity/wp-plugin/commit/a1d0811))

## [1.5.1](https://github.com/frontity/wp-plugin/compare/v1.5.0...v1.5.1) (2018-09-11)


### Bug Fixes

* **version:** update version in php files and use trunk ([150ddf6](https://github.com/frontity/wp-plugin/commit/150ddf6))

# [1.5.0](https://github.com/frontity/wp-plugin/compare/v1.4.15...v1.5.0) (2018-09-11)


### Bug Fixes

* **excludes:** add excludes to AMP ([b718b0e](https://github.com/frontity/wp-plugin/commit/b718b0e))
* **general:** undo manifest and service workers ([448c4dd](https://github.com/frontity/wp-plugin/commit/448c4dd))
* **html-purifier:** adds support for <audio> to htmlpurifier ([0261b70](https://github.com/frontity/wp-plugin/commit/0261b70))
* **html-purifier:** install htmlpurifier-html5 library for html5 support ([bd7013f](https://github.com/frontity/wp-plugin/commit/bd7013f))
* **image-ids:** support image-attributes hook ([d7a7f22](https://github.com/frontity/wp-plugin/commit/d7a7f22))
* **image-ids:** support image-attributes hook ([635a31b](https://github.com/frontity/wp-plugin/commit/635a31b))
* **image-ids:** support local urls of images ([ecc47fe](https://github.com/frontity/wp-plugin/commit/ecc47fe))
* **image-ids:** use proper attribute name ([7d07089](https://github.com/frontity/wp-plugin/commit/7d07089))
* **injector:** use array if excludes is null ([0357caa](https://github.com/frontity/wp-plugin/commit/0357caa))
* **latest:** use 'home' url if 'forceFrontPage' is enabled ([a254a1a](https://github.com/frontity/wp-plugin/commit/a254a1a)), closes [#5](https://github.com/frontity/wp-plugin/issues/5)
* **latest-from-cpt:** use quotes in array ([820f3b0](https://github.com/frontity/wp-plugin/commit/820f3b0))
* **purifier:** add text field for title and excerpt ([a01fde3](https://github.com/frontity/wp-plugin/commit/a01fde3)), closes [#10](https://github.com/frontity/wp-plugin/issues/10)
* **semantic-release:** add env-cmd for environment variables ([4bddc08](https://github.com/frontity/wp-plugin/commit/4bddc08))
* **semantic-release:** add github and trigger a new release ([8de6f2f](https://github.com/frontity/wp-plugin/commit/8de6f2f)), closes [#3](https://github.com/frontity/wp-plugin/issues/3)
* **semantic-release:** change commit message to pass conventional ([8042dd7](https://github.com/frontity/wp-plugin/commit/8042dd7))
* **semantic-release:** test without github ([6216b4b](https://github.com/frontity/wp-plugin/commit/6216b4b))


### Features

* **htmlpurifier:** add option to purge cache ([c3d6051](https://github.com/frontity/wp-plugin/commit/c3d6051))
* **htmlpurifier:** add UI button for purge ([518772e](https://github.com/frontity/wp-plugin/commit/518772e))
* **image-ids:** add ids to gallery images using wp_get_attachment_link ([145c235](https://github.com/frontity/wp-plugin/commit/145c235))
* **image-ids:** use classes to get ids when possible ([5088f86](https://github.com/frontity/wp-plugin/commit/5088f86))

## [1.4.12](https://github.com/frontity/wp-plugin/compare/v1.4.11...v1.4.12) (2018-07-11)


### Bug Fixes

* **semantic-release:** add github and trigger a new release ([8de6f2f](https://github.com/frontity/wp-plugin/commit/8de6f2f)), closes [#3](https://github.com/frontity/wp-plugin/issues/3)
* **semantic-release:** change commit message to pass conventional ([8042dd7](https://github.com/frontity/wp-plugin/commit/8042dd7))

## [1.4.11](https://github.com/frontity/wp-plugin/compare/v1.4.10...v1.4.11) (2018-07-11)


### Bug Fixes

* **semantic-release:** test without github ([6216b4b](https://github.com/frontity/wp-plugin/commit/6216b4b))

## [1.4.11](https://github.com/frontity/wp-plugin/compare/v1.4.10...v1.4.11) (2018-07-11)


### Bug Fixes

* **semantic-release:** test without github ([6216b4b](https://github.com/frontity/wp-plugin/commit/6216b4b))

## [1.4.11](https://github.com/frontity/wp-plugin/compare/v1.4.10...v1.4.11) (2018-07-11)


### Bug Fixes

* **semantic-release:** test without github ([6216b4b](https://github.com/frontity/wp-plugin/commit/6216b4b))
