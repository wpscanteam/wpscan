# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.0.0 - 2022-05-31
### Added
- Add additional tracking events
- Add Alert icon to the error admin page
- Add checks to the Site Health page
- Add custom hook to handle viewport sizes via CSS
- Add error message when adding plugin fails
- Add first approach of Interstitial page
- Add Jetpack Scan to promotion section when site doesn't have Security bundle
- Add missing prop-types module dependency
- Add Navigation dropdown mode and use it for small/medium screens
- Add ProductOffer component
- Add product offer component
- Add title and redirect for vul at wpscan
- Add 'get themes' to synced callables in Protect
- Add installedThemes to the initial state
- Add notifications to the menu item and the admin bar
- Add status polling to the Protect admin page.
- Added details to the FAQ question on how Jetpack Protect is different from other Jetpack products.
- Added Jetpack Protect readme file for the plugin listing.
- Added option to display terms of service below product activation button.
- Added Social card to My Jetpack.
- Added the list of installed plugins to the initial state
- Change ConnectScreen by the Interstitial component
- Creates Status Class
- Empty state screen
- Expose and use IconsCard component
- Flush cache on plugin deactivation
- Footer component
- Handle error in the UI
- Hooks on plugin activation and deactivation
- Hook to read data from the initial state
- Implement Footer
- Implement Add Security bundle workflow
- Introduce Accordion component
- Introduce Navigation component
- Introduce Summary component
- Introduce VulnerabilitiesList component
- JS Components: Introduce Alert component. Add error to ProductOffer components
- More options to the testing api responses
- Record admin page-view and get security from footer events
- Render Security component with data provided by wpcom
- Request and expose to the client the Security bundle data
- Update logo

### Changed
- Add empty state for no vuls
- Add popover at Badge
- Cache empty statuses for a short period of time
- Changed connection screen to the one that does not require a product
- Changed the method used to disconnect
- Changed the wording for the initial screen.
- Change expiration time of plugin cache
- Clean connection data. Update to latest connection API
- Configure Sync to only what we need to sync
- Janitorial: require a more recent version of WordPress now that WP 6.0 is coming out.
- JS Components: Add subTitle prop to ProductOffer component
- JS Components: iterate over Dialog component
- Improve Dialog layout in medium viewport size
- Move VulnerabilitiesList to section hero
- New VulsList
- Redesign Summary component
- Re-implement "Your results will be ready soon" layout
- Re-implement Admin page by using Dialog component
- Remove use of `pnpx` in preparation for pnpm 7.0.
- Replace deprecated external-link variation by using isExternalLink prop
- Require only site level connection
- Truncate items at NavigationGroup
- Tweak footer
- Update Footer and VulsList for small/medium viewport
- Update Navigation to be external controlled
- Update Protect icon
- Update VulnerabilitiesList to remove severity and add fixed in
- Updated package dependencies.
- Update package.json metadata.
- Updates CTA wording to reduce confusion when user already has Jetpack Security Bundle which includes Jetpack Scan
- Update the Status when connection is established
- Use data provided by My Jetpack to render Product offer
- Use weight Button prop to style the "learn more" footer link
- Use a different copy when there are no found vulnerabilities but there are still some unchecked items

### Removed
- Removed Full Sync from loaded modules as Full Sync Immediately is present by default now

### Fixed
- Adjust spacing and overflow properties of the navigation labels to improve display of long names.
- Fix Connectino initialization
- Fix fatal when checking whether site site has vuls
- Fix right margin in primary layout
