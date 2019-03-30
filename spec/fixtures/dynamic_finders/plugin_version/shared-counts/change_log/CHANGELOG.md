# Change Log
All notable changes to this project will be documented in this file, formatted via [this recommendation](http://keepachangelog.com/).

## [1.2.0] = 2018-05-23
### Added
- Support for [Pinterest Image](https://github.com/billerickson/Shared-Counts-Pinterest-Image) add-on plugin

### Fixed
- "Hide empty counts" checkbox now works correctly
- Pinterest "Pin it" JS no longer modifies our pinterest button, see #34
- Metabox is now always visible, allowing you to disable share buttons even if not collecting counts, see #33

## [1.1.1] = 2018-04-04
### Fixed
- Internal "prime the pump" method now includes all supported post types. Can be used with [this plugin](https://github.com/billerickson/Shared-Counts-Prime-Cache) to view the status of the cache and mass update posts
- Improved compatibility with Genesis theme framework

## [1.1.0] = 2018-03-21
### Added
- Yummly share count support/tracking.
- Proper `rel` tags for share buttons for security and SEO.
- Caching via transient for Most Shared Content admin dashboard widget.

### Changed
- Removed code for LinkedIn/Google+ share counts, as they are no longer supported.
- Available buttons setting description to indicate which buttons support share counts.

### Fixed
- reCAPTCHA not working correctly in the email sharing modal.
- Encoded characters in the "From Name" email setting.

## [1.0.1] = 2018-02-21
### Changed
- Email sharing modal can now be closed by clicking outside the modal or pressing the ESC key.
- The minified stylesheet has been rebuilt. It was missing some styles.

## [1.0.0] = 2018-02-09
- Initial Release
