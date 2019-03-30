# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.2.2] - 2017-11-16

### Changed
- Compatible with WordPress 4.9.0

## [1.2.1] - 2017-10-25

### Changed
- Installation note on Readme.txt

## [1.2.0] - 2017-10-25

### Changed
- Minimum PHP version to 5.3
- Minimum WordPress version to 3.1.0

### Added
- `Requires PHP` tag in `readme.txt`
- `MIN_PHP_VERSION` `const` into `Ga_Tracking_Code` class
- `MIN_WP_VERSION`  `const` into `Ga_Tracking_Code` class
- `meets_requirements` `method` into `Ga_Tracking_Code` class. Check that all plugin requirements are met.
- `requirements_not_met_notice` `method` into `Ga_Tracking_Code` class. Adds a notice to the dashboard if the plugin requirements are not met.
- `deactivate_plugin` `method` into `Ga_Tracking_Code` class. The plugin can self deactivate if the minimum requirements are not met.

## [1.1.1] - 2017-10-25

### Fixed
- URL in readme.txt

## [1.1.0] - 2017-10-25

### Added
- New setting to exclude administrator from tracking
- gplv3 licence file

### Removed
- `init` `method` from `Ga_Tracking_Code` class
- `add_actions` `method` from `Ga_Tracking_Code` class
- `default_options` `method` from `Ga_Tracking_Code` class
- `set_options` `method` from `Ga_Tracking_Code` class

### Changed
- General improvement to the code base
- `sanitize_callback` `method` in `Ga_Tracking_Code` class
- `allow_tracking` `method` in `Ga_Tracking_Code` class

## [1.0.5] - 2017-10-23

### Changed
- Plugin File Header

## [1.0.4] - 2017-10-19

### Changed
- Plugin description
- Text domain slug

### Added
- Added .pot file

## [1.0.0] - 2017-07-28

### Added
- First version.