# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2020-10-27

### Changed
- Updated installation instructions

## [1.0.2] - 2020-10-27

### Added
- Released to Wordpress.org directory

## [1.0.1] - 2020-10-21

### Changed
- Changed all direct curl-usages to Wordpress HTTP API-calls.
- Added sanitation for all POST/GET/SERVER-inputs.

## [1.0.0] - 2020-10-05

### Changed
- Prepared the plugin for publishing.
- Added more descriptive error message for failed Kassa connection.

## [0.8.1] - 2020-09-16

### Changed
- Added a custom system check for Polylang-plugin setting.
- Changed the method to get the site domain name. Old way had issues with url mismatches with server-variable and the url defined on Wordpress settings.
- Call kassa-oauth-delete-function to remove the sync connection entry for the domain on Kassa disconnect.

## [0.8.0] - 2020-09-11

### Changed
- Added possibility to select the target Kassa environment (test/production).
- Kassa connection is now disconnected on plugin deactivation.
- Fixed calls to wp_timezone(), which threw an error on older (< WP 5.3) WordPress versions.

## [0.7.11] - 2020-07-02

### Changed
- Prevent putting orders to 'completed'-status directly from 'pending'-status if they are Kassa-orders created via API.

## [0.7.10] - 2020-06-17

### Changed
- Disabled Stock sync direction selection. Stock sync direction is set the same as for the Product sync.

## [0.7.9] - 2020-06-01

### Changed
- Disabled all order emails for orders which are created via Rest API.

## [0.7.8] - 2020-04-15

### Changed
- Added more information on mandatory or incompatible plugins to plugin's system audit result.

## [0.7.7] - 2020-04-09

### Changed
- Fixed an issue with custom date_query timestamps

## [0.7.6] - 2020-03-25

### Changed
- Fixed issue in memory_limit-check.

## [0.7.5] - 2020-03-20

### Changed
- Fixed typo from production default URLs.

## [0.7.4] - 2020-03-20

### Changed
- Updated production default URLs.

## [0.7.3] - 2020-03-19

### Changed
- Removed redundant duplicate system audit check for a mandatory plugin.

## [0.7.2] - 2020-03-19

### Changed
- Minor bug fix
- Renamed plugin basename

## [0.7.1] - 2020-03-18

### Changed
- Replaced the system audit configuration file url to point to production environment.

## [0.7] - 2020-03-13

### Changed
- Added system audit to perform basic enviroment checks

## [0.6.0] - 2019-10-29

### Changed
- Authentication occurs on a single request chain taking the user first to Kassa and then to WooCommerce authentication.
- Kassa and WooCommerce authentications are both canceled with a single action on the OP Kassa settings page.
- Webhook secret handling updated.

## [0.5.10] - 2019-15-10

### Removed
- Removed checks to ensure only the user that created OAuth link can remove it
- Removed filters to force EAN to be a number


## [0.5.9] - 2019-27-09

### Added
- Added production endpoint urls

### Fixed
- Fixed production endpoint API paths
- Fixed a typo in the plugin name

### Removed
- Removed "Initial stock sync" -setting from the settings page since it's not used


## [0.5.8] - 2019-23-09

### Added
- Added production endpoint urls

### Removed
- Removed custom REST processing for the Kassa EAN. Will use normal metadata instead


## [0.5.7] - 2019-18-09

### Fixed

- Fixed product EAN ajax processing in while editing product variants

## [0.5.6] - 2019-18-09

### Fixed

- Fixed handling for the `kis_modified_after` query parameter if the value is `"0"` _(meaning: starting from the beggining)_.

## [0.5.5] - 2019-18-09

### Fixed

- Fixed using `get_id()` only for objects from API requests

## [0.5.4] - 2019-18-09

### Fixed

- Fixed syntax error where $metaKeyName was not defined inside `update_callback` function in ProductEAN class
- Fixed classes using `WP_Post` ID-property directly instead of using `get_id()`

## [0.5.3] - 2019-18-09

### Added

- Force ordering by modified time in ascending order for REST API requests made by KIS.

## [0.5.2] - 2019-10-09

### Added

- Added composer autoload.php require if the file exists for zip distributions
- Added zip file distribution instructions to README

## [0.5.1] - 2019-16-08

### Fixed

- Fixed EAN not saving properly with multiple product variants
- Fixed a minor style issue with the tracking code box labels

## [0.5.0] - 2019-15-08

### Added

- Added support for Kassa EAN code
- Added package slip link from Kassa

## [0.4.1] - 2019-01-08

### Added

- Added a hook to update order modified-field when order is refunded

## [0.4.0] - 2019-20-06

### Added

- Added new fields for shipping tracking code, carrier and pickup ID
- Added new functionality to track deleted produts and an JSON API endpoint to fetch them

## [0.3.0]

### Added

- Added the ability to query Woo objects with a meta data identifier. This feature can is used for fetching orders created by KIS.

### Fixed

- Fixed a bug in Kassa settings page markup.

## [0.2.0] - 2019-04-01

### Added

- Added options to define synchronizing settings on the custom settings page.

## [0.1.0] - 2019-03-25

### Fixed
- The success command is stripped in the method for getting the current admin url.
- Fixed some bugs in the custom `kis_modified_after` date query handling.

### Changed
- The KIS OAuth error command is now a class constant in the OAuth class.

### Removed
- The plugin does not include the success command in the success url. Let the Lambda function add it.

## [0.0.0] - 2019-03-14

### Added
- Initial plugin functionalities.
