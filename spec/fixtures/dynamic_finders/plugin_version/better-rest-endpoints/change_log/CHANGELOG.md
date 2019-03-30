# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

n/a

## [1.5.2] - 2019-02-12

### Fixed

- SVN Version

## [1.5.1] - 2019-02-12

### Fixed

- SVN Version

## [1.5.0] - 2019-02-11

### Added

- Endpoint to get menu by location

## [1.4.1] - 2019-01-23

### Added

- Functionality to get a page by slug or path for hierarchical pages
- 'modified date' to all endpoints with 'date'
- Support for ACF options pages

### Fixes

- Empty page array

## [1.3.0] - 2018-06-05

### Added

- Yoast SEO output, see docs for more information

### Updated

- Slug output in responses

## [1.2.1] - 2018-06-04

### Added

- Permalinks to all page/post endpoints

## [1.2.0] - 2018-02-07

### Added

- ACF query in endpoint url to hide acf values from the response where applicable (all collections)
- Media query in endpoint url to hide featured media from the response where applicable (all collections)

## [1.1.2] - 2018-01-25

### Update

- Fix issue where get post by slug was returning just the first post
- Fix instance of lefover \$bwe variable naming

## [1.1.1] - 2018-01-25

### Update

- Update plugin version to re-trigger build.

## [1.1.0] - 2018-01-25

### Added

- Adds post by slug endpoint

## [1.0.2] - 2018-01-19

### Fixed

- Fixed static instance warning
- Fixed failure of ACF function by including admin plugin.php

### Updates

- Updates all functions named bwe* to bre*

## [1.0.1] - 2018-01-19

### Added

- Changelog
- readme.txt for WP repo
