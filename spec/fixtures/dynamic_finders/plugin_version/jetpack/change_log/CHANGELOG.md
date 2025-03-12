# Changelog

### This is a list detailing changes for all Jetpack releases.

## 11.0-a.1 - 2022-05-04
### Enhancements
- WAF: add settings UI for Jetpack Firewall [#23769]
- Google Fonts: add additional fonts to the list of available fonts. [#24098]
- Payment Block: refactors the donation block by unifying Stripe Nudge component. [#24177]

### Improved compatibility
- Contact Form: ensure the option to export forms to a csv file works with the upcoming version of WordPress, 6.0. [#24173]
- General: Jetpack is now fully compatible with the upcoming version of WordPress, 6.0. [#24083]
- General: Jetpack now requires a more recent version of WordPress (5.9), since a new version of WordPress (6.0) will be available soon. [#24083]
- General: remove backwards compatibility code now that Jetpack requires WordPress 5.9. [#24086]

### Bug fixes
- Custom CSS: avoid PHP notice when using the Sass preprocessor on PHP 7.4+. [#24135]
- VaultPress: fixes a bug that caused certain cards in the Dashboard to flicker in some circumstances when VaultPress is active. [#24194]

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Activity: Removed commented-out code [#24126]
- Add missing JavaScript dependencies. [#24096]
- Client: Removed unused planClass props [#24195]
- Custom Content Types: bring changes from WordPress.com to Jetpack to keep the files in sync. [#24150]
- Custom Content Types: fix PHPCS linting errors in CPT module files, part 2 [#24154]
- Custom Content Types: solve PHPCS errors for Portfolios. [#23848]
- Init 11.0-a.0 [#24087]
- Moved the Options class to Connection package. [#24095]
- My Plan: Use feature check for search card [#24166]
- One Click Restores: Uses feature checks to determine backup type [#24131]
- Performance-Search: Converts plan checks to feature checks [#24162]
- PHPCS: changes for endpoints, root functions [#24029]
- Recommendations: Use feature check for one-click restores [#24165]
- Remove use of `pnpx` in preparation for pnpm 7.0. [#24210]
- Renaming class file to comply with class naming rules in phpcs. [#24136]
- Replace uses of `create-react-class` with modern syntax. [#24055]
- Rewind: Remove unused sitePlan information [#24128]
- Search: Converted At a Glance search box to using feature checks. [#24127]
- Security Settings: Use feature checks for backup and scan [#24163]
- Settings: Display upsells using feature checks [#24180]
- Updated package dependencies. [#24095]
- Updating 10.9 beta changelog and readme [#24091]
- Updating to-test.md [#24088]
- Updated Backups box in At a Glance to use feature checks [#24121]
- We now lock the execution of get products in a non blocking way for the execution thread. [#24140]

## [10.9] - 2022-05-03
### Enhancements
- Dashboard: update the recommendation flow to include recommendations for VideoPress as well as discounts.
- Google Fonts: update the Google Fonts module to be compatible with the most recent version of the WP_Webfonts API.
- Payments Block: add additional features to the payment management control block (ability to mark as donation, and enabling customers to pick own amount).
- Payments Block: add new property that establishes if the membership is editable by the site editor.
- VideoPress: improve upload spreed, by increasing chunk size to 10Mb for resumable uploads.

### Bug fixes
- Assistant: style and CTA changes plus introductory offer fixes.
- Payments Block: change the sidebar display when clicking 'add new subscription', as well as using an external link in the Customizer.
- Payments Block: remove the dropdown icon from the product management control subscription selector.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add checks to eliminate warnings in PHP log.
- Added analytics events for enabling condtional recommendations and viewing conditional recommendations.
- Converted BackupUpgrade and BarChart to TypeScript.
- E2E tests: add extra checks in connection tests.
- E2E tests: improve connection tests.
- Fix failing tests because of an editor type mismatch caused by imported packages side-effects.
- Init 10.9-a.8
- Load block editor styles inline for iframed editors on WoA sites.
- Move RecordMeterBar to js-packages.
- My Jetpack: Updated to require licensing package when licensing UI enabled.
- Nav-unification: Update nudge to support Pro plan.
- Payments Block: Display the product manager on free plan sites connected to Stripe.
- Premium Content blocks: subscription button from emails and notifications opens the checkout dialog  (WordPress.com specific).
- Remove code in native files that was causing the rnmobile build to fail.
- Revert Jetpack not hard disconnecting on deactivation
- Updated package dependencies.
- Update package.json metadata.
- Updating changelog and readme for 10.9-a.7
- VideoPress: Fixing issue in apiFetch middleware where request bodies were assumed to always be objects with a "file" property; this is only true for requests to the media endpoint.

## 10.9-a.7 - 2022-04-19
### Enhancements
- Connection: Preventing other Jeptpack-connected plugins from disconnecting when deactivating Jetpack from the plugins screen.
- Recommendations: Add recommendation for anti-spam.

### Improved compatibility
- WordAds: Remove the suggestion to use the ad widget from the dashboard.
- WordAds: Change Jetpack Ads wording to be WordAds.

### Bug fixes
- Publicize: Ensure bulk publishing posts wonâ€™t publicize those posts.
- Random Redirect: Fixes 'set author name' functionality on author archives.
- VideoPress: Fixes issue adding video descriptions and metadata via the WordPress.com dashboard.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Added TypeScript support.
- Dashboard: Update copy to reflect new WordPress.com Pro plan.
- Jetpack Connection: Remove any remaining in-place flows.
- Moved licensing endpoints from the Jetpack plugin to the Licensing package.
- Moved enhanced-open-graph.php out of the Publicize module.
- Moved gutenberg-base-styles.scss file to js-packages/base-styles and updated its imports in the Jetpack plugin directory.
- Moved images that are used for licensing components to licensing package to minimize external dependencies.
- Refactor Jetpack class to move some functions into Modules and File packages.
- Security Settings: convert plan checks to be feature checks.
- Stats: Add individual filters for JS and AMP stat footer data.
- Updated jetpack-waf package version.
- Updated package dependencies.
- Updated Sync tests.
- Various PHPCS changes.

## 10.9-a.5 - 2022-04-14
### Bug fixes
- Comments: Checking that Jetpack comments are supported before requiring nonce verification.

## 10.9-a.3 - 2022-04-12
### Major Enhancements
- VideoPress: add settings for controlling VideoPress video privacy.

### Enhancements
- Dashboard: Various improvements to recommendations.
- Payments block: Improves block selection behavior.
- Protect: Renamed to "Brute Force Protection" in the UI.
- VideoPress: Enable the resumable uploader.

### Improved compatibility
- Custom CSS: Improve saving for legacy Custom CSS.
- Improvements to backwards compatibility with other Jetpack plugins.

### Bug fixes
- Button block: Removes default CSS that would overwrite core and theme styles.
- Payments block: Makes the â€˜one timeâ€™ subscription recurrence always available.
- Payments block: Fixes bug regarding creation of new Payment blocks.
- Pay with PayPal: Fixes issue with saving widget in Customizer.
- Slideshow block: Fix grid blowout when Slideshow block is inserted inside a Layout Grid block (in editor).
- Top Posts Widget: ensure hooks retain existing behavior when adding extra data before or after each post.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Assistant: add timed discount card.
- Build sass files with Webpack.
- Customizer messages: adjust messaging for new plan.
- Fix an invalid JavaScript `typeof` check.
- Fix e2e tests.
- Init 10.9-a.2
- Minifiy non-sass css with Webpack.
- Move and update postcss config.
- PHPCS changes for JSON endpoint.
- Remove indirect dependency on an obselete version of the `core-js` package.
- Remove use of `gulp` for the build.
- Updated a composer package version.
- Updated package dependencies.

## 10.9-a.1 - 2022-04-06
### Enhancements
- Payments Block: Re-loading the page will not cause payment form to open again.

### Improved compatibility
- Dashboard: Display block settings even when the Classic Editor plugin is active.
- Mailchimp Popup widget: Widget deprecation.

### Bug fixes
- Contact Form: Ensure the form's input fields inherit a default font size.
- Subscribe Block: Fix default styles block setting selection to "Split".

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Blocks: Add Pocket Casts dev block (for internal use only).
- Creating and verifying a nonce for the Jetpack comments form.
- E2E tests - bumped dependencies versions.
- E2E tests: added custom error messages to the expect functions.
- Janitorial: Refactor classes into shared package.
- Re-added the jetpack-waf package to update the autoloader files in the composer.lock.
- Removed eslint dependency which will now be loaded from root directory.
- Updated package dependencies.
- PHPCS updates to bring in line with WordPress standards. Files affected include SAL, lib, Custom CSS, JSON endpoints.
- SEO Tools: Use the new feature eligibility checks for WordPress.com sites.
- Made changes updating WordPress.com Personal plans to Pro.

## [10.8] - 2022-04-05
### Enhancements
- Blocks: make settings discoverable and toggleable, and add a card to highlight the blocks available from Jetpack on the dashboard.
- Form Block: offer option to install/activate the Jetpack CRM plugin from the Form block settings panel.
- Payments Block: introduce new post-publish panel to highlight the options available with Payments blocks.
- VideoPress: added support for the `muted`, `controls` and `playsinline` properties on the 'wpvideo' and VideoPress shortcodes.

### Improved compatibility
- Shortcodes: adds the Jetpack namespace to slideshow shortcode CSS class names.

### Bug fixes
- Carousel: fix nonce check issue with Carousel comments
- Form Block: do not display the CRM integration option to non-admins.
- Subscribe Block: ensure subscription panels are not shown in the page editor, or when the site is private.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Adding language attributes to code blocks.
- Add support for WordPress.com Pro plan.
- Add uloggedin parameter for reporting.
- Assistant: make call-to-actions point to checkout page.
- Block Form: update required Jetpack CRM version.
- Documented the `rna` prop of the Button component.
- E2E tests: improve assertions for sync tests.
- Fix ProductManagementControls not being able to open the block settings sidebar on site and widgets editor.
- Fix VS Code ESLint and prettier config.
- Google Fonts: mark the feature as Beta, and remove toggle from dashboard.
- Jetpack CRM: adjust banner's wording.
- Payment Blocks: Added links to manage subscriptions and fees to the Product Management controls.
- Payments Block: use the product management controls to manage subscriptions. Migrated the Payments Block to a functional component and cleaned up code.
- Payments Block: we now provide a way in which we can propagate the controls to the child blocks.
- Payments Button Block: add back the upgrade nudge.
- Removed unneeded calls to Atomic_Plan_Manager.
- Search: Add search feature to benefits API.
- Search: removed migrated tests.
- Subscriptions Block: make the block messages clearer.
- Updated package dependencies.
- Various PHPCS updates.
- WordPress.com Toolbar: avoid PHP notices when locale is not defined.
- WordPress.com Toolbar: check if function exists before use.

## 10.8-a.11 - 2022-03-25

## 10.8-a.9 - 2022-03-23
### Major Enhancements
- QR Post: add new feature which automatically generates QR codes for published posts. When scanned, the QR code will link visitors to the post. If a site has a custom logo set, it will be shown in the generated QR code image.

### Enhancements
- External Media: add Openverse as an external Media provider.
- Payment Block: clicking on payment links from email or WordPress.com Notifications/Reader will correctly open the corresponding payment form.
- Dashboard: show Search benefits on the Jetpack disconnection screen.

### Improved compatibility
- Sharing: avoid warnings when the feature is not active on a site that uses the AMP plugin.

### Bug fixes
- Calendly Block: ensure it can be displayed inline when using a block enabled theme.
- VideoPress: fix broken styles on resumable uploader component.
- Pay with Paypal Block: fix inconsistent currency formatting.
- WordAds: fix defaulting to "house ad" mode for new activations.
- Publicize: prevent newlines from being stripped from a custom Publicize message in the classic editor.
- QR Post: improve the inner logo sizing.
- Shortlinks: display the shortlinks interface in the block editor for all post types that support shortlinks.
- Top Posts Widget: display a fallback list of posts to admins when there are no popular posts to display.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- AAG: add Backup storage info.
- Added tracking for backup storage info bar chart.
- Connection: Jetpack now relies on the Connection package webhooks for 'authorize' and 'authorize_redirect' actions.
- E2E tests: move search tests into search plugin folder
- PHPCS changes for the related posts module.
- Remove use of `strptime`, which was only used in a branch for compatibility with PHP before 5.3.
- Search: use config package to initialize the search package.
- Licenses: show the product name if there is only one user license to be activated.
- Unit tests: Update Sync related unit test.
- Updated package dependencies.
- WP API endpoints: fix PHPCS linting errors, part 1.
- Moved plan-utils.js file from Jetpack folder to shared-extension-utils. Also moved requiresPaidPlan from register-jetpack-block to plan-utils.
- Payments: move the Stripe Connect toolbar button into a shared component, and add event tracking on it.
- Premium Content Block: move the product management system to a shared component.
- WPcom: hijack feature eligibility checks on WP.com sites, since they use an independent gateway system.
- WPcom: optimize user blog counting on admin menu for better performance.
- WPcom: sync class.json-api-endpoints.php changes from D76475.
- Premium Content Block: fix a Redux store middleware regression on older Gutenberg versions.

## 10.8-a.7 - 2022-03-15
### Enhancements
- Dashboard: add toggle to enable new Google Fonts feature.
- Jetpack: add QRPost feature which generates QR codes for published posts. Currently a JETPACK_BETA_BLOCKS feature.
- Premium Content block: use a drop down menu rather than two buttons to switch between the guest/subscriber views.
- VideoPress: updated design of resumable uploader block.

### Improved compatibility
- General: clean up use of deprecated FILTER_SANITIZE_STRING constant. Also mark WPCom_Markdown::get_post_screen_post_type as deprecated due to lack of use.

### Bug fixes
- Google Analytics: fix showing an upgrade button with the latest Jetpack security plans.
- Jetpack: fix missing "Connect User" button after restoring a connection.
- Pay with PayPal widget: enable widget to work in block-based widget editor and full site editor.
- SEO Tools: ensure Twitter cards get correct description when a site has a blank tagline.
- Payments: swap JETPACK_VERSION for the correct JETPACK__VERSION.
- Premium Content block: when a visitor subscribes, they now see the premium content without needing to reload the page.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Admin Page: use a dynamic version in cache buster on dev environment.
- Admin Page: remove wp_kses() as it's not needed for static.html.
- Fix Sync related flaky test.
- Google Fonts: update the method used to preconnect Fonts source domain.
- If the mapbox API call returns a completely invalid response, treat it as a failure rather than a success.
- Moved with-has-warning-is-interactive-class-names folder to js-package/shared-extension-utils and updated imports.
- PHPCS changes for the Pay with Paypal feature.
- Search: improve Search E2E tests stability.
- Search: moved globals to a class for sake of autoloading correctly.
- Updated package dependencies.

## 10.8-a.5 - 2022-03-08
### Bug Fixes
- Fixes an issue preventing WooCommerce from upgrading to 6.3.0.

## 10.8-a.3 - 2022-03-08
### Enhancements
- Jetpack: assistant style updates and other improvements.
- Jetpack: using the new Webfont API in Gutenberg, registers a selection of Google fonts for use with block and Global styles.
- Markdown block: add default spacing controls.
- Masterbar: make the Desktop Switcher look the same between Calypso and wp-admin.
- Payments Block: adds a link to the support reference page on the block configuration panel.
- Payment Button Block: make Stripe connection button visible from child block elements.

### Improved compatibility
- Premium Content Block: prevent block from being nested inside itself.
- Various Blocks: remove deprecated attributes from Button components.
- CLI Tools: ensure WP CLI is present before extending the class.

### Bug fixes
- Jetpack: remove the duplicated `jetpack_relatedposts_returned_results filter`.
- Premium Content Block: login button now redirects to the correct post instead of to a 404 page when the URL contains characters that have been previously encoded.
- Payment Blocks: fixes an issue with the upgrade banner being obscured from all payment blocks.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Jetpack: added jetpack_upload_handler_can_upload filter for blocking specific file uploads.
- Admin pages: reverting code added in #23219 to fix a bug.
- Fix newly-detected PHPCS sniffs in some tests. Also fix a test mock that was returning false rather than null like the class it's mocking would.
- PHPCS errors and notices fixed for admin pages
- Protect: simplify the transient clean up process preparation.
- QR Plugin: update registration
- Refactor ExternalLink to use core package
- Search: Move customizer integration into search package
- Stats: improve accessibility and performance for the admin dashboard widget.
- Update `@size-limit/preset-app` dependency to match `size-limit`.
- Jetpack: add post-publish-qr-post-panel block editor plugin.

## 10.8-a.1 - 2022-03-02
### Enhancements
- Payment Blocks: add a unified introduction to payment blocks to make it easier to select the correct one.
- Payment Blocks: add more keywords to payments blocks so they're easier to find.
- Subscribe Block: add pre/post-publish notices.
- Subscribe Block: block setting updates including name change, display of current subscribers, and a new style option.
- Tiled Gallery: add background color block setting.
- Various Blocks: update Contact Info, Markdown, and Tiled Gallery blocks to include margin design tools.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- E2E: add tests for clicking link to open overlay.
- E2E: restore plugin update test.
- WAF: include the dependency of the WAF package in the plugin zip.
- Moved site benefits request out of PHP to React, and guard against no connected plugins.
- My Jetpack: do not add My Jetpack action link to plugins page.
- Search E2E: support block themes.
- Sync: changes added to wpcom to Jetpack.
- Sync: integration tests optimization.
- Updated package dependencies.
- WoA: add missing plugins sidebar menu for Atomic site with unsupported plan.

## [10.7] - 2022-02-28
### Enhancements
- Dashboard: improve performance of plugins page.
- Subscribe block: various changes, including a name change, how the display for current subscribers is shown, and new styling options and enhancements.

### Improved compatibility
- Performance: improve performance of Jetpack dashboard for sites without VideoPress enabled.

### Bug fixes
- Dashboard: show Jetpack stats Screen Options label properly.
- Publicize: fixed bugs when using Publicize with the Classic Editor.
- Subscribe block: address front-end rendering issues.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add Sync related unit tests.
- Bump package versions.
- Dashboard: remove marketplace related add plugins menu redirect.
- E2E tests: update readme.
- Fix double escaping of connections in Classic Editor.
- Fix fatal error in the WP.com customizer while in sandbox mode.
- Fix PHPCS violations for the Publicize module.
- Fix WPCOM-specific linting errors.
- Init 10.7-a.6 cycle.
- Memoize calls to store_subscription when setting available features for site in order to reduce duplicate uncached queries.
- PHPCS Changes for json-get endpoint files.
- Re-introduce CRM card on At A Glance page for Jetpack.
- Remove Jetpack settings submenu from general settings menu when site doesn't have atomic supported plan.
- Subscribe block: Fix color serialization.
- Take pre_update_option filter into account when firing active module hooks
- Updated package dependencies.
- Update to-test.md.
- WordPress.com REST API: avoid errors when restoring the previous version of an image from the WordPress.com dashboard.
- WordPress.com REST API: avoid PHP warnings when accessing videos from the WordPress.com dashboard.

## 10.7-a.5 - 2022-02-16
### Enhancements
- Blocks: add support for color and spacing block options for Form, Mailchimp, Podcast Player, and Related Posts blocks.
- Blocks: add alignment block option for Form, Mailchimp, Podcast Player, Related Posts, and Repeat Visitor blocks.
- Dashboard: update the Free plan description to consider the currently active products.

### Improved compatibility
- Image CDN: ensure that SVG images added to posts thanks to the SVG Support plugin can be displayed even when Jetpack's Image CDN is active.
- Search: Add deprecated class to prevent third-party integrations from failing after 10.6 updates.

### Bug fixes
- Blocks: cron requests are now considered frontend requests, so blocks will no longer be rendered as fallbacks on those.
- Form Block: custom CSS classes added to the block are now applied on the frontend.
- Media Buttons: Fix issue where external medial modal cannot be closed.
- Search: Make debug bar more reliable.
- SSO: fix a bug with SSO not cleaning up wpcom_user_id.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add note for translators.
- Add executing the WAF as part of the Jetpack plugin.
- Init 10.7-a.4 cycle
- PHPCS Changes for the first handful of JSON endpoints.
- PHPCS: Gravatar Hovercards
- Premium Content Block: restrict registration to WPcom.
- Premium Content Block: add a "Remove block and keep content" settings menu item and fixed transformations to groups.
- Premium Content Block: don't allow core markup blocks to be transformed to Premium Content block (e.g. core/nextpage, core/spacer).
- Premium Content Block: when content within a premium-content view is selected in the editor, switch to that view.
- Premium Content Block: fix accidental inversion of the block tabs.
- Remove the unused can_connect_service method
- Reworked the redeem partner coupon component implementation to match latest requirements for post-connection display
- Unroll Twitter Threads: revert endpoint to public.
- Update the path to the extension-availability util function on native mobile, after it has been updated for the web.
- About page: only fetch a11n data when page is active.

## 10.7-a.3 - 2022-02-09
### Enhancements
- Dashboard: the Backup banner CTA on the At-a-Glance page will now be replaced with a "Redeem Coupon" CTA when a partner coupon is detected.
- Dashboard: updated the logic for "Activate a Product" button in "My Plan" to be always visible.
- Payment Block: updated the Payment block Upgrade nudge description to include the plan name that's required to use the block.
- Premium Content Block: remove option to transform a premium content block to a premium content block.
- Premium Content Block: use 'Guest' rather than visitor/Logged-out.

### Improved compatibility
- Internet Defense League widget: Widget deprecation.
- VideoPress: Added title and aria-label to VideoPress iframe embeds for better screen reader support.
- WordAds: deprecate the legacy Ad Widget in favor of the Ad Block when adding new Ad Widgets via the block-based widget editor.

### Bug fixes
- Block Editor: cast selectedPlanId to boolean to remove a "0" character after block upgrade nudge.
- Contact Form: ensure form validation uses the correct variable types.
- Dashboard: fix broken image in plan loading placeholder in "My Plan"
- Tiled Gallery Block: Fix performance issue affecting page views that use the Tiled Gallery.
- Unroll Twitter Threads: ensure that only contributors can access the endpoint to unroll threads.
- Widget Visibility: update to match new user query parameter introduced in WordPress 5.9.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Added Jetpack Partner Coupon banner on My Plan page
- Blocks: move plugin registering utility to standalone package.
- Blocks: remove BlockIcon wrapper for multiple blocks.
- Changes the default for the `Match video` setting to `true` for VideoPress videos.
- Dashboard: hide the Scan card on Atomic sites.
- E2E tests: merged Github workflows
- E2E tests: update eslint configuration
- Fixed some new PHPCS warnings.
- Fix potential use of unexisting "allow_download" property in VideoPress media modal
- Init Jetpack 10.7-a.2 cycle
- Moved get-jetpack-data file to js-package/shared-extension-utils and updated imports
- Moved get-jetpack-extension-availability file to js-package/shared-extension-utils and updated imports
- Moved get-site-fragment file to js-package/shared-extension-utils and updated imports
- Moved site-tyoe-utils file to js-package/shared-extension-utils and updated imports
- Removed separate pnpm workspace for e2e tests.
- Removed duplicate docblock for jetpack_relatedposts_returned_results filter and updated $post_id type to int
- Search: move search widget to the search pacakge
- Updated package dependencies.
- Update lock file
- Widget Visibility: switch to using shared js package utility instead of built-in site type check.
- Added a new method to inline styles in the site editor.

## 10.7-a.1 - 2022-02-02
### Enhancements
- Add an AMP-compatible version of the email share button.
- Add transformation from core/buttons to jetpack/recurring-payments block (requires gutenberg >= 11.5.0).
- Business Hours: Add support for color & spacing design tool.
- Changed the plan description for invalid plans and added a Warning message for Premium content blocks with invalid plans.
- Dashboard: update the links used to purchase plans when in Jetpack settings.

### Improved compatibility
- My Community widget: Hide widget from the block inserter and Legacy widget block drop-down menu

### Bug fixes
- Fixed several React warnings shown on the console when SCRIPT_DEBUG is active
- Search: avoid PHP warning when using Search widget.
- Widget Visibility: ensure role and logged in features are available.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Added 'jetpack_related_posts_display_markup' filter to update the output HTML of Related Posts module
- Extract Jetpack_Plugins class to its own package
- Blocks: Update block fixture docs for running phpunit tests.
- Build: remove unneeded files from production build.
- Payments Block: remove wrapper around icons.
- Updated package dependencies
- Reduced the data set for the Search Sync tests to speed up the process.
- Update internal logic for rendering Dashboard sections.

## [10.6] - 2022-02-01
### Enhancements
- Contact Info and Markdown Blocks: add color, typography and spacing features.
- Dashboard: support Beta versions of Automattic plugins in plugin cards.
- Search: improve accessibility via headings hierarchy and aria roles.
- Tiled Gallery Block: improve the block so it can be used within the mobile applications.

### Improved compatibility
- Instant Search: synchronize more meta data so the search feature can be used with more third-party plugins.
- Sharing / AMP plugin: avoid adding sharing's CSS on AMP pages when the sharing feature is not active.

### Bug fixes
- Backups: hide backup preparation message for sites without backup.
- Connection: correctly request list of active features so they can be activated on a reconnection.
- Pay with Paypal Block: properly display the card icons below the button.
- Scan: avoid PHP notice when non-admin users access the dashboard.
- Search: Initialize debug bar using correct class
- Widget Visibility: ensure it remains possible to edit visibility for legacy widgets in the block-based widget editor.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add a comment to explain the reasoning behind an empty scss file.
- Change usage of filter_var to filter_input in markdown file.
- Comment: phpcs linting cleanup.
- Cover block: avoid the block's placeholder rendering on top of other blocks.
- Dashboard: update CTAs (wording, layout) in the At A Glance section.
- Fixed development mode prop type warning in UserLicenseActivationNotice component.
- Fix PHPCS sniffs in root classes.
- PHPCS fixes for site verification tools.
- phpcs fixes for the markdown module
- Search: add E2E tests for Customberg
- Search: added E2E tests for the search dashboard
- Updated package dependencies.
- Use new Visitor class for determining IP address.

## 10.6-a.3 - 2022-01-18
### Enhancements
- Embeds: add support for Descript.com embeds.
- Image Compare Block: Add `wide` and `full` alignment options
- Pay with PayPal Block: do not display the block on the frontend if PayPal is misconfigured.
- Stats: add new filter allowing site owners to exclude IP addresses from being tracked in stats.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Adds WooCommerce settings to the /v1.4/sites/$site/settings endpoint.
- Changes the default value of woocommerce_onboarding_profile from array( 0 => false ) to array()
- Fix various PHPCS warnings and errors in root classes.
- General: update required node version to v16.13.2
- Subscription Form block: hide custom success message setting for WordPress.com simple sites.
- Update composer.lock
- Update package dependencies

## 10.6-a.1 - 2022-01-11
### Improved compatibility
- Subscription form: update the placeholder color to be the same as the text color of the site.

### Bug fixes
- Donations block: add a missing closing div for the front-end rendering.
- Donations block: don't display the donations block to visitors unless Stripe is connected.
- Donations block: fixed an issue which was invalidating existing blocks if they were edited by non-plan owners.
- Donations block: tweak currency display for the edit control.
- Protect: fixed math fallback's input accessibility and display.
- Subscription form: adding a default line-height to avoid differences using different font-faces on input and button elements

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Dashboard: update the links to different Jetpack features in the dashboard.
- Moved numberFormat component into components js package.
- Refactor PluginDashItem component to be functional and add README.
- Remove use of deprecated `~` in sass-loader imports.
- Search: migrate Classic and Instant Search code to Search package.
- Search: move search dashboard to the search package.
- Social Menu: remove role navigation attribute from nav item.
- VideoPress: change allow_download data path from API (wpcom compat).

## 10.5.1 - 2022-01-24
### Bug fixes
- General: avoid Fatal Errors that may happen during the plugin update process.

## [10.5] - 2022-01-11
### Enhancements
- Print Styles: additional interactive elements are now hidden when printing posts (e.g. Likes, Recommended Posts, Share this).
- VideoPress: add "allow download" option on videos to allow viewers to download the video.
- WordAds: add hook for header ad placement, and allow 'leaderboard' size when displaying an ad widget.

### Improved compatibility
- General: update WordPress version requirements to WordPress 5.8.
- Pay with PayPal: update the name of the script enqueued when using the Pay with PayPal button as to avoid conflicts with other plugins that may use a similar script tag.
- Stats: remove legacy option to display a Smiley face used for the tracking pixel since the pixel is hidden by default.
- VideoPress: classic block embeds with old flash URLs can now be properly converted to VideoPress blocks.
- VideoPress: hide the dedicated VideoPress embed block in favor of Video block.

### Bug fixes
- Cookies & Consents Banner: fix preview in Customizer and block widget editor.
- Dashboard: fix logic that blocked one from enabling searchable features from the Jetpack settings.
- General: prevent an E_NOTICE when running in non-web context.
- Instant Search: ensure the hidden overlay doesn't add whitespace to printed pages.
- Jetpack: activate the default modules when the site has already been connected before plugin activation.
- Jetpack: do not display recommendations during an identity crisis.
- Search: fix styling conflict for Blank Canvas theme.
- Security: PDF embeds now only display a link, to avoid issues with malicious PDFss that may run arbitrary code.
- Settings menu: add Jetpack item for sites with Scan product.
- Sharing Buttons: rely on official sharing buttons only for Facebook share counts.
- Stats: do not trigger views when post is embedded into another site.
- VideoPress: reload embed preview on creation until the video size is known.
- Vimeo Embeds: support more URL formats, such as videos in playlists.
- WhatsApp block: fix country code for Cyprus.
- Widget Visibility: fix "Match All" setting being overwritten on save in the block widget editor.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- AAG upgrade banner: do not display on WoA sites
- Add get_current_plan() to the WPcom_Admin_Menu.
- Admin Page: remove CRM card for now.
- Dashboard: add Jetpack Security Bundle upsell to AAG.
- Dashboard: add new cards to AAG Dashboard for Boost and CRM plugins.
- Dashboard: updates the Apps card on the At a Glance page to display links to the Jetpack mobile apps.
- E2E tests: update readme docs.
- E2E tests renovate: bump dependencies.
- Fix a legacy sync test in PHPUnit 9.5.
- Fix modules using `this` to mean `window`.
- Hide irrelevant menu items for P2 sites
- Instant Search: Add missing translator comments and use ordered placeholders in JS sprintf.
- Janitorial: fix phpcs warnings in multiple widget files.
- Jetpack: provide recommendation step parameter to external package.
- Load the Composer package assets i18n map.
- Switch to pcov for code coverage.
- Sync some E2E deps with the rest of the monorepo to avoid breaking eslint tests.
- Updated package dependencies
- Updated package dependencies.
- Use `@automattic/i18n-loader-webpack-plugin` to remove the hack for Instant Search's lazy-loaded bundle.
- VideoPress: add support for old v.wordpress.com URLs in VideoPress embed block.
- Vimeo: tweak the regex used to fetch the Vimeo videos.
- WordPress.com: identify admin menu dashicons that won't be rendered in Calypso and provide a default icon for them.
- WordPress.com: provide a different support link for sites on the Atomic platform.

## 10.5-a.3 - 2021-12-14
### Enhancements
- Secure Sign On: add filters for the error text when a local user cannot be found for a given WP.com account and for when SSO is disallowed when on a staging site.
- Subscription Block: add 'Success Message Text' to the block settings.

### Improved compatibility
- General: ensure Jetpack options are properly deleted when the plugin is deactivated.
- Media Extractor: add support for alt_text in extract.
- Notifications: remove legacy code supporting IE versions older than 9.
- Pay with PayPal Widget: hide widget from Legacy Widget block.

### Bug fixes
- Contact Form: avoid PHP notices in submitted forms in some cases.
- Internationalization: ensure that all text, including text added via JavaScript, can be translated.
- Milestone widget: fix issue that prevented styles from loading until the widget is saved.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Admin Menu: add support for WPML menu structure.
- ConnectionBanner: allow "icon" prop type to be an element.
- JITM: allow sidebar JITMs marked as dismissible to be dismissed.
- Nav-unification: add a CSS class to the HTML body when nav-unification is enabled.
- Update introductory discount percentages from 40% to 50%, to reflect new pricing structure..
- Use `automattic/jetpack-composer-plugin` to move Jetpack libraries from `vendor/` to `jetpack_vendor/` for i18n.
- [WP.com sites only) Exposes the My Home menu item to all roles

## 10.5-a.1 - 2021-12-07
### Enhancements
- Sharing: hide sharing buttons when printing a post or page.
- VideoPress Block: add adaptive progress bar color settings

### Improved compatibility
- Twitter Timeline widget: Hide widget from the block inserter and Legacy widget block drop-down menu (WPCOM)

### Bug fixes
- Dashboard: hide licensing interface from users who did not link their account to WordPress.com yet, or who are not the main Jetpack connection owner.
- VideoPress: avoid errors when copying and pasting empty video blocks.
- VideoPress Block: maintain the state of different settings panels when reloading the video preview.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Added Jetpack Installer package.
- Atomic Menu: prevent notice for users without access to the plugins menu item.
- Blog Subscription widget: Fix the comment block on the `hide_widget_in_block_editor()` to follow the DocBlock standards
- Build modules with Webpack, so they benefit from our toolchain improvements.
- DIFM: Conditionally hide admin menu and expose is_difm_lite_in_progress in the get site API
- Fix the comment block on the `hide_widget_in_block_editor()` to follow the DocBlock standards
- Rewrote tracks-events.js without jQuery.
- Start an initial full sync if the site is connected when Jetpack is activated.
- Start new Jetpack cycle 10.5-a.0
- Switched Jetpack plugin to always use `s0.wp.com` and `i0.wp.com` for external resources
- Updated package dependencies.

## [10.4] - 2021-12-07
### Enhancements
- Connection: additional messaging for both connection and disconnection flows.
- Dashboard: add option to add Jetpack product using a license key.
- Publicize: enable the RePublicize UI in the block editor.
- VideoPress: add captions and subtitle support.

### Bug fixes
- Custom CSS: disable CSSTidy shorthand optimizations to prevent block validation issues.
- Dashboard: hide license activation route if user is not linked and connection owner.
- Search: avoid fatal errors when the feature is inactive, but Extra Sidebar Widgets are active.
- Sharing: ask search engines to not index pages with sharing query string.
- VideoPress: fix various validation errors.
- VideoPress: keep expanded/collapsed state of settings panel when reloading video preview.
- Widgets: allow customizer preview to show widget visibility rules properly.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Avoid generating unused assets in the static-site-generator builds.
- Build: remove obsolete package gulp task.
- Bump stat on plugin installs.
- Colors: update Jetpack Primary color reference to match latest brand book.
- E2E tests: Migrate from Jest to Playwright test runner.
- Expose site intent from get site API to show different content in the future.
- Fixed an issue with the mobile nav unification menu caused by fixing the collapse.
- Fixed nav-unification on lower resolutions for wp-admin.
- Fixes the URL of JITMs rendered in the unified sidebar when an absolute URL is given. This only affects WP.com sites.
- JITM: Add ability to sideload Jetpack Boost and Backup plugins.
- Made admin menu API tests compatible with WPCOM environment.
- Refresh the site's modules and settings after successful product activation.
- Search: forward wpcom/v2/search request to search package rest controller.
- Search: Migrate more helper classes to package.
- Search: update jetpack-search and search package versions
- Sharing: update to use Recaptcha's modern key names.
- Switched external media API tests to short-circuit API calls before they're being dispatched.
- Updated package dependencies.
- Update filenames of Webpack-built files.
- Use correct user capability for the Inbox menu item in Nav Unification
- Uses the Connection Initial State for the React app

## 10.4-a.9 - 2021-11-23
### Enhancements
- Dashboard: add option to add a license key via the Jetpack dashboard.
- Verification tools: remove old interface in the Tools menu, in favor of the newer settings in the Jetpack dashboard.

### Bug fixes
- Stats: remove ASCII art from the tracking pixel's alt attribute, to improve accessibility.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add consumer_slug config to webpack
- Ensure that a new object references are created after the API request.
- Fixed admin menu tests on WP.com
- Gist unit tests: refactor to simplify and make future maintenance easier.
- Manually dismiss license activation notice when license activated.
- Remove the Connection UI activation.
- REST API Return user ID for comment author if present
- Skips redirect tests for admin menu in wpcom environment.
- Updated package dependencies.

## 10.4-a.7 - 2021-11-17
### Enhancements
- Podcast Player block: add 'jetpack_podcast_helper_tracks_quantity' filter to control number of tracks fetched. Deprecate the 'jetpack_podcast_helper_list_quantity' filter.

### Bug fixes
- VideoPress: fix VideoPress load for old videos in Gutenberg
- SSO: fix button content alignment for small screens

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Adding My Jetpack
- Update phpunit tests so they can be executed again on wpcom without fatal errors.

## 10.4-a.5 - 2021-11-16
### Enhancements
- Dashboard: display a notice when you have unactivated product licence keys linked to your WordPress.com account.
- Likes: refactor Likes in posts to improve performance and avoid loading additional libraries.
- VideoPress: add handles to resize the Video Block in the editor.

### Bug fixes
- Dashboard: fix some layout and display issues in the Recommendations panel.
- Dashboard: ensure plan information is properly displayed when using Backup and Security plans.
- Instant Search: restore filter query string functionality.
- VideoPress: reload block when updating video rating in the editor, and ensure rating meta data is updated.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Allow /sites/$site/external-media/copy/pexels to insert post meta data
- Change the way we interact with RNA Connection Screen.
- Don't set Webpack's `output.pathinfo` in production builds.
- Fix some code where the minifier loses the translator comments.
- Nav Unification: map new Site Editor location from Gutenberg 11.9 to Calypso
- Nav Unification: Display the stats sparkline on WP Admin for Atomic sites. This fix only affects WP.com sites.
- Updated package dependencies.
- Update link for Backup and Security product cards to point to checkout for new real-time products
- Use monorepo `validate-es` script to validate Webpack builds.

## 10.4-a.3 - 2021-11-09
### Enhancements
- Publicize: always add an Open Graph image alt text if an Open Graph image is present.
- VideoPress: do not display thumbnails in the media library, in the WordPress.com dashboard.

### Improved compatibility
- Contact Info and Map widget: hide widget from the block inserter and Legacy widget block drop-down menu.

### Bug fixes
- Block Editor: avoid issues when searching for free Pexels images via Jetpack's External Media feature.
- Contact Form: prevent multiple button clicks from submitting multiple form submissions.
- VideoPress: display "File Name" in the Media Library.
- VideoPress: display all video meta immediately after upload. A page refresh is no longer needed to view VideoPress-specific fields.
- VideoPress: no longer play videos in the background when the Media Item modal is closed in the media library.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Display Nav Unification Quick switcher in edit.php?post_type=post page for sites with Nav unification enabled.
- E2E tests: cleaned up some unused dependencies
- E2E tests: remove jest setup in favor of e2e-commons setup file
- E2E tests: update docs
- Fixed Jetpack Dashboard submenu highlight for the Settings page for sites with Nav unification enabled.
- Fix PHP 8.1 deprecation warnings.
- Nav Unification: Removes the `preferred-view` param from the URL after changing the preferred view. This fix only affects WP.com sites.
- Nav Unification: Replaces the AJAX request for changing the preferred view with a direct server request to bypass security restrictions enforced by some browsers. This fix only affects WP.com sites.
- P2: Hide Inbox admin menu link on all P2s.
- Publicize: handle plan upgrade considering feature availability, whether the nudge is enable, and post status
- Search: Migrate helper classes to Search package
- Unit Tests : Update Full Sync tests to align with limitation on users that are synced.
- Updated package dependencies
- Update webpack build config.

## 10.4-a.1 - 2021-11-02
### Enhancements
- Publicize: update the interface and include a profile picture for each service.

### Bug fixes
- Image CDN: ensure that Wikipedia URLs are not served via our image CDN.
- Publicize: make the default publicize social media message blank.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Allow /wp/v2/sites/1234/batch endpoint to process widget updates
- E2E tests: update pnpm commands to use new tunnel wrapper script
- Fix `@covers` directives in various tests.
- Publicize: check feature chen hitting publicize endpoint
- Publicize: show/hide main toggle control depending on post state (published)
- Search: hide Calypso Jetpack Search menu item for Atomic sites.
- Set `convertDeprecationsToExceptions` true in PHPUnit config.
- Updated package dependencies.

## [10.3] - 2021-11-02
### Enhancements
- Dashboard: add a new screen to provide more information about the VideoPress feature.
- Dashboard: optimize the size of all product images displayed in the dashboard, to improve overall performance.
- Instagram Widget: improve the connection flow when the widget has not been connected to WordPress.com yet.
- Map Block: Add address attribute to the block.
- Social Icons Widget: Added Strava icon to Social Icons Widget.
- Stats: add information about the VideoPress feature at the bottom of the page.
- VideoPress: add tooltips to video block settings in the block editor.
- VideoPress: remove X-18 rating from the block settings.

### Improved compatibility
- Contact Info & Map widget: allow transforming this widget into a block in Block-based widget editor.
- General: ensure that no notices are output when Jetpack is used alongside plugins that modify the output of core comments.
- VideoPress: improve handling of Video files when using a third-party video player.

### Bug fixes
- Dashboard: ensure feature cards display the right information when the site uses Jetpack's Offline mode.
- Dashboard: fix the display of currencies to be based on user WordPress.com preferences.
- Markdown: add title attributes to footnotes to improve accessibility.
- Publicize: fix visual issue when the panel shows in the pre publish step of the post.
- Stats: remove extra request to WordPress.com that occurs when the stats feature is first activated.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add Tracks events when clicking or viewing upgrade buttons on the At a Glance page
- Adjust test which relies on the "remoteRegister" XMLRPC method now being registered by the Connection package
- Changed the class variable to a const
- Deprecate `jetpack_is_atomic` for the new Automattic\Jetpack\Status\Host->is_woa_site() function.
- Displays realtime backups in AAG for tiered backup products (Not yet user facing)
- E2E tests: renamed test
- Make the Backups only settings card show for tiered backup products (not yet user facing)
- Moves Add New (plugin) submenu to the top (valid only for Atomic sites).
- PHPUnit tests will now catch `exit` calls, instead of exiting PHPUnit.
- Publicize: add useSharePost() hook
- Publicize: clean and tidy code
- Publicize: do not disable message text control when RePublicize is enabled
- Publicize: Handle properly error handling when publizicing
- Removed filters from Jetpack that were used to test the Inbox menu prior to its official release.
- RePublicize: add Share Post button
- RePublicize: enable/disable feature according to the site plan
- Update "Appearance > Widgets" and "Appearance > Menus" links back to classic wp-admin destination for Atomic and Simple sites.
- Updated package dependencies
- Updates the display of Jetpack Backup storage amounts. (Not yet user facing.)

## 10.3-a.3 - 2021-10-19
### Enhancements
- Dashboard: add a new view that shortly summarizes available Jetpack products and facilitates the purchase process.
- Publicize editor settings: refactor, improve layout and wording in preparation for the addition of RePublicize.
- Stats: remove some upgrade notifications.
- Subscriptions: add an option to transform the Legacy Subscription Widget into a Subscription Block in the new block-based Widget editor.
- WordAds: update handling and setting CCPA related cookies.

### Improved compatibility
- VideoPress: avoid video upload issues when other plugins modify WordPress' API fetching features in the block editor.

### Bug fixes
- Dashboard: fix the connection flow for non-admin users.
- External Media block options: fix a bug where the external media modal collapsed on larger screens and did not leave enough whitespace.
- Instant Search: fix translations not available for minified Instant Search Modal assets.
- Widgets: fix styles of the Milestone widget fields.
- VideoPress: add a "cover" option to the VideoPress iframe and shortcode to handle video resizing to its container.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Blocks: update how block editor plugins are loaded.
- Build: do not include Instant Search Settings raw files in production build
- E2E tests: move search helpers from e2e-commons to plugin e2e checks project
- E2E tests: named exports for pages
- Fix spelling of 'deprecated' in pnpm tasks
- Flag for weekly Atomic releases ("dev-releases" in composer.json).
- General: remove numerous long-deprecated functions.
- Improve e2e tooling for better support from other plugins making use of the Jetpack e2e framework
- Masterbar: update default link in Upgrades > Plans to "Plans" instead of "My Plan".
- Remove "download" mentions from the VideoPress share option
- Sharing: hide sharing buttons on password protected posts unless password provided.
- Updated package dependencies.
- WordPress.com API: add site_owner to sites API endpoint.

## 10.2.1 - 2021-10-19
### Enhancements
- VideoPress: improve the display of upload errors in the Media Library and the block editor.

### Improved compatibility
- VideoPress: avoid video upload issues when other plugins modify WordPress' API fetching features in the block editor.

### Bug fixes
- Dashboard: fix the connection flow for non-admin users.
- Instant Search: fix translations not available for minified Instant Search Modal assets.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Init the identity-crisis package using the Config package
- Update Sync Unit Tests to reset settings modified during tests.

## 10.3-a.1 - 2021-10-12
### Enhancements
- Instant Search: always show the save button on the mobile view of the Search Settings dashboard.
- Secure Sign On: add new filter allowing one to customize the explanation displayed next to the SSO button.
- VideoPress: improve the display of upload errors in the Media Library and the block editor.

### Improved compatibility
- Jetpack Backup: improve the display of the different plugin menus when using both Jetpack and Jetpack Backup.
- Social Icons Widget: deprecate widget and offer the option to transform into a Social Links block.

### Bug fixes
- Calendly block: fix the preview in the block inserter.
- Eventbrite Block: improve the event URL detection and avoid errors when using links without an event ID.
- General: avoid PHP notices that may happen when installing the plugin.
- Instant Search: fix the display of filters when there are no results to display for a query.
- Instant Search: fix the preview of the infinite scroll option in the Search Settings dashboard.
- Instant Search: reduce browser history noise as search is being typed in the form.
- Publicize: refresh connections only when the post publishes.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add Publicize Share POST endpoint
- Open Jetpack plugin sidebar by default when URL includes query param.
- Correct AMP validation errors.
- Publicize: use post metadata to store publicize data
- Add a wpcom menu item linking to wordpess.com/woocommerce-installation/
- Add click tracking for Widget Visibility
- Added an admin notice to media-new.php notifying the user that videos uploaded here will not be sent to VideoPress.
- Allow empty string in message parameter.
- Bump the RNA API version.
- E2E tests: extract shared e2e tools
- E2E tests: updated dependencies
- Embed block: Add native version of index file to control the available variations.
- Exclude `vendor/` from code coverage.
- Init Jetpack 10.3 release cycle.
- Init the identity-crisis package using the Config package
- Nav Unification feature flag check. It only affects WPCOM Atomic sites.
- P2: Conditionally hide Pattern admin menu items for hubs/spaces
- Remove "beta testing" item from the menu for all users
- Updated package dependencies
- Update Jetpack 10.2 to-test.md
- Update Sync Unit Tests to reset settings modified during tests.

## [10.2] - 2021-10-05
### Enhancements
- Contact Form: add filter to allow customizing email headers.
- Contact Form: add two filters to improve anti-spam functionality.
- Related Posts: enable lazy loading for images.
- Search: improve filter label formatting for longer text entries.
- Search: title customization improvements.
- SEO Tools: add "Archive Title" option for custom archive page titles.
- SmartFrame Embeds: add support for SmartFrame embed using URLs, embed code, and shortcodes.
- VideoPress: add new VideoPress product and enables VideoPress to be used for free for 1 video upload.
- Widgets: add visibility settings to widgets using the block editor, under the advanced section of the sidebar.

### Improved compatibility
- External Media: update verbiage around Google Photos to improve compatibility with their UX guidelines.
- Instagram Widget: remove from Legacy Widget block.
- Publicize: replace native text-area with custom/core-based component.
- Search: as IE11 support was removed in Jetpack 10.1, remove an IE11 polyfill.
- VideoPress: file url field now displays the HLS playlist if one was generated. The fragmented mp4 file is not meant to be played on its own. MP4 file will only be displayed as the video url if it was created prior to the HLS update.

### Bug fixes
- Contact Form: make sure the set height of the Spacer block nested inside a Contact Form block is respected.
- Custom Content Type: improve the performance of the Testimonial CPT.
- Dashboard: improve the performance of the query used to display Anti-spam stats.
- Embeds: add allow-popups permission to Google Calendar embed so that links internal to the iFrame will open.
- Publicize: ensure the custom excerpt is used when sharing to Facebook.
- Publicize: improve refreshing connections list.
- Related Posts: avoid errors if main div is not in the DOM.
- Search: ensure Safari input clear button is hidden.
- Search: ensure translations are available for lazy-loaded payloads.
- Search: fix dashboard buttons too big on Safari.
- Sharing: fix the icon position in icon-only button style.
- Shortcodes: remove Hulu from available embeds.
- Slideshow: fix fade transition background.
- Theme Tools: remove unnecessary extra Social Menu added in the Twenty Twenty theme.
- VideoPress: fix a bug related to deleting VideoPress videos.
- Widgets: fix a conflict between various Jetpack blocks and some WordPress core legacy widgets.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add back skipped tests checking the Screen Options functionality of Nav Unification.
- Add wp-block-button__link to the button on the subscription widget.
- Admin menu: improve security by sanitizing return value of get_current_screen function.
- Dashboard: do not display Jetpack version on WoA sites.
- Dashboard: show the Connect button on the Media card in site-only mode.
- Disable webpack's concatenateModules optimization, it can break WordPress's translation extraction.
- E2e tests: fixed logged Jetpack version.
- E2E tests: fixed stacktrace sometimes missing from Slack notification.
- E2E tests: generate application password at environment start.
- E2E tests: include Github commit SHA in Jetpack version for local dev sites.
- E2E tests: make sure videos are saved for all opened tabs.
- E2E tests: support user mentions in Slack based on report name and branch name.
- Fix failing phpunit test on multisite installation.
- Fix tests after WordPress backported polyfill stuff to WP 5.7 and 5.8.
- Fix typo in Jetpack ad banner.
- Improve Mailchimp test stability.
- Move analytics library into a package.
- Move the Jetpack stats widget for the WordPress dashboard into its own class.
- Multisite settings: remove old commented out code and fix PHPCS linting errors.
- Publicize: plugin to the proper extension folder.
- Publicize: re-implement main form, add React hooks.
- Refactor extract() usage used in the monorepo.
- Remove ajax callback for Tracks within the Jetpack plugin since it is set up in jetpack-tracking library.
- Remove Custom CSS placeholder text to stay in sync with wpcom. The placeholder was only displaying on Simple Sites.
- Replace `page` library with equivalent plain JavaScript.
- Search: remove @wordpress/interface dependency for new configurator.
- Sharing: refactor sharing plugin, replace HOC with hooks.
- Skip test_get_user_connection_data_with_connected_user for multisite.
- Updated Google Photos logo and icon.
- Updated package dependencies.
- Updated scss files for sass division deprecation.
- Update `copy-webpack-plugin` dep.
- Use `[contenthash]` in Webpack chunk names for better long-term caching.
- VideoPress: can now be managed on the Modules page for any plan type.
- VideoPress: update the edit icon design in the VideoPress block toolbar.
- Widget Visibility: Restrict to top level blocks in each widget.
- WPcom: added a new "Inbox" menu item in the left side menu, just after Upgrades item. Only visible for wpcom and atomic sites.
- WPcom: fix various shortcode rendering in notifications.

## [10.1] - 2021-09-07
### Major Enhancements
- Search: add a Gutenberg powered customization interface.

### Enhancements
- Carousel: photo info and comment sections stay open once toggled on.
- Carousel: show image info icon even if Exif metadata option is off.
- Carousel: use photo description as caption if caption and title fields are blank.
- Form Block: scroll to subscription message after submitting the form.
- Jetpack Assistant: introduce a new "Product Suggestion" step to inform new users of relevant Jetpack services.
- Search: greater theme compatibility, including label coloring and custom checkbox margins.
- Search: improves handling of breadcrumb display.
- Search: visual, functional, and accessibility improvements to new wp-admin section and customization interface.
- Secure Sign On: remove additional redirect during sign in process.
- Shortcodes: allow wrapping quizzes together with the Quiz shortcode.
- Spotify Shortcode: add lazy loading support.
- Stats: add the ability to collapse the nudges UI.
- Tiled Gallery Block: ensure it can be used when in Offline Mode.
- Widget Visibility: rename taxonomy label "All Pages" in dropdown.

### Improved compatibility
- Browser Compatibility: allow use of new JavaScript features not supported by Internet Explorer 11.
- Image CDN: added support for the WEBP format.
- Mailchimp Block: updates terminology to use "Audience" instead of "Lists".
- Media: allow ZIP files to be uploaded to sites via WordPress.com.
- Related Posts: allow shortcodes in Related Posts titles.

### Bug fixes
- Blocks: fix HTML markup of buttons added to blocks.
- Carousel: fix a bug that changes the cursor to a pointer over all nested blocks.
- Carousel: fix bug preventing user from swiping in gallery when images are configured to link to Attachment Page.
- Carousel: hide UI controls in the carousel for single images.
- Contact Form: disable the Block Editor for contact form submissions.
- Custom CSS: ensure that short CSS is added inline instead of via an external file.
- Dashboard: add a new message to the backup card if the site is too new to have an accurate status.
- Dashboard: ensure that the image CDN does not get enabled by default when using the Site Accelerator toggle while in Offline mode.
- Facebook Page Widget: fix a bug that prevented widget from being added in the wp-admin widget editor.
- Form Block: fix form button alignment in editor.
- Instant Search: ensure box-shadow and text-shadow aren't applied to search buttons.
- Search: fix search widgets not saving in block widget editor.
- Search: fix various issues with scrolling on both desktop and mobile devices.
- Search: fix wrapping issue on super wide screens.
- Search: hide search sub menu on site disconnection.
- Search: improve style specificity for result highlights in Customberg.
- Slideshow Block: fix intermittent issue where next/prev buttons sometimes don't respond to clicks.
- Social Icons: fix being unable to remove icons from widget.
- Social Icons Widget: fix issue in wp-admin widget editor where icons don't save on refresh.
- Stats: allow better translations of page view counts in the Stats widget.
- Video Block: fix resizing so that video block doesn't display black bars on the sides.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Adapt the test to recent changes to connection banner.
- Add additional event properties to woocommerceanalytics_product_checkout and woocommerceanalytics_product_purchase events.
- Adds a navigation link to Beta Testing page for WPCOM sites.
- Add wordpress/babel-preset-default package for use by Instant Search customization.
- Add `wpcom_is_fse_activated` to sync list.
- Blocks: fixes previews in block editor by working around incorrect Calypso build configuration
- Bump changelogger version.
- Carousel: Replace color CSS with CSS variables to simplify theming.
- Classic views are now forced for Customizer screens (WP.com only).
- Connection: remove in-place connection for secondary flows.
- Correct REQUEST_URI checking to work for wp.com as well as .org endpoints.
- E2E tests: add option to pass test report name in Slack notifications.
- E2E tests: add tests prerequisites abstraction.
- E2E tests: clean-up wp-env leftovers.
- E2E tests: don't throw when get debug log from docker fails.
- E2E tests: Expect `jetpack docker exec` to pass through exit statuses.
- E2E tests: fix mailchimp tests failing after a button label change.
- E2E tests: fix missing action for e2e on atomic workflow.
- E2E tests: fix PayPal block fields not getting filled.
- E2E tests: fix selector for block editor search field.
- E2E tests: optimize specs prerequisites.
- E2E tests: run tests against an arbitrary site.
- E2E tests: scheduled test runs on atomic test site.
- E2E tests: send report name for atomic test runs.
- E2E Tests: switch to Jetpack Docker.
- E2E tests: temporarily disable plugin updater test.
- E2E tests: use Allure test steps for better reporting.
- Fix broken SSO sync test.
- Fix Mailchimp test.
- Fix some issues in Docker cli.
- Fix submenu positioning issue for Nav-Unification in WP-Admin.
- Improve test robustness and tooling for extensions.
- Init Jetpack 10.1 release cycle.
- Integrate RNA connection screen into the main connection flow.
- Jetpack 10.0: update beta testing instructions.
- Masterbar: show Beta Testing link on Atomic Sites and hide it on P2.
- Move API calls to jetpack-api package.
- Move a test out of Jetpack's test init.
- Move Jetpack-specific JS test init into Jetpack's test init.
- Multi-site: list sites will show based on current network id.
- Related Posts: Fix issue with dequeueing scripts and styles.
- Rename a generated js file to avoid triggering an outdated minifier on WordPress.com's cdn.
- Responsive Videos: account for newer embed block format when detecting videos in post content.
- Search: Backports Customberg babel configuration from WordPress.com.
- Search: Fix search E2E test failure caused by new block widgets in WP 5.8.
- Updated package dependencies
- Updated product slugs for new/imminent real-time Backup and Security products.
- Update Jest dependencies to fix Jetpack JS tests.
- Update to latest webpack, webpack-cli and calypso-build.
- Upgrade to Webpack 5.
- Use Node 16.7.0 in tooling.
- Widget Visibility: fix undefined property reference.
- WordPress.com REST API: Add new field to comment endpoint response.

## [10.0] - 2021-08-03
### Enhancements
- Carousel: add JS-based smooth scroll behavior for the footer buttons.
- Carousel: on image zoom, fade out controls. Fade them back in when sized back to original, or the slide is advanced.

### Improved compatibility
- Carousel: add a Swiper JS param to prevent interaction on the carousel while transitioning between slides.
- Map Block: ensure theme styles do not override map button background colors.
- Search: remove required attribute from search inputs.

### Bug fixes
- Carousel: fix carousel title formatting to prevent issues with quote conversion.
- Comments: fix subsequent commenting when using a social profile.
- Contact Form Block: remove specific form colors to prevent theme style clash.
- Instant Search: fix visual glitch on breadcrumb in Firefox.
- Instant Search: make sure ?s= is set when using filter links.
- Like Button: add title and aria-hidden attributes to the Like button iframe.
- OpenTable Block: fix input width when used in block editor.
- Publicize: avoid PHP notices in edge-cases where no info about a post can be found.
- Search: fix notice issue with WP 5.8's widget editor.
- Select Dropdown Component: add content-box box sizing to prevent global box-sizing conflict.
- SEO Tools: ensure functions are loaded before API endpoint attempts to use them.
- Tiled Gallery: fix blurry display of images much wider than they are high.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add admin / frontend CSS files to the build watcher.
- Add event tracking for the Dashboard Quick Switcher.
- Add field for Zendesk meta in /sites/id for Jetpack sites.
- Add jetpack_connection_active_plugins option in JSON API site endpoint response options.
- Add tracks event when the Stats page upgrade nudges are displayed.
- Add upgrade nudges to the Site Stats page.
- Admin menu: move site editor menu item and add beta badge.
- Comments: refactor jQuery usage.
- Development: soft-fail if Jetpack is not built.
- Dev Tools: add list items to the Dev Tools card for new Backup and Security products.
- E2E tests: add listeners for page errors and request failed.
- E2E tests: require local node to match one defined in package.json file.
- Fail build if the php:module-headings step fails.
- Heartbeat: calculate media library size.
- Init 10.0 release cycle.
- Modules: include all module info in the module-headings.php file during the build step.
- Move connection/data endpoint to Connection package.
- Move site disconnection endpoint to Connection package.
- My Plan: recognize and display new Backup, Security plans.
- Nav Unification: ensure on pageload that the active menu item is keyboard focused in nav unification so its consistent with Calypso.
- Nav Unification: fix the condition that disables Nav-unification when SSO is disabled and the admin-menu class is overridden in jetpack_admin_menu_class filter.
- Plans: add slugs for new real-time Backup and Security offerings.
- Search: add footer for search dashboard.
- Search: add instant search upsell nudge for Business plan.
- Search: add mocked legacy search interface for admin page.
- Search: add scaffolding for Gutenberg-enabled Customizer (Customberg).
- Search: add search setting dashboard with toggle controls.
- Search: add widgets editor and search customizer buttons for search admin page.
- Support coming soon v2 sites with the coming soon badge in the admin menu.
- Update contributor list.
- Update package dependencies.
- WoA: add security nav item to the Atomic admin menu only if the site has the security-settings feature.
- WoA: fix My Sites navigation in WP-Admin for Atomic sites with SSO disabled (and nav-unification disabled).
- WoA: force Calypso interfaces for Atomic sites that have Jetpack SSO disabled.

## 9.9.1 - 2021-07-20
### Enhancements
- Carousel: improve carousel icons.

### Improved compatibility
- Carousel: ensure that arrows look and work correctly in right-to-left languages.

### Bug fixes
- Carousel: prevent comments indicator from bumping icon width of comments button.
- Carousel: CSS tweaks to ensure text and comment loader spinners dislay correctly in dark and light theme views.
- Carousel: ensures caption is shown in carousel images.
- Carousel: ensure carousel CSS doesn't override other non-Jetpack carousel styling.
- Widgets: allow the use of widget visibility conditions in gutenberg based widget editing.
- Widgets: ensure block previews display in customizer for multiple blocks.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Updated package dependencies.
- Compatibility: adds support for block_editor_settings_all when running WordPress 5.8 or higher.
- WordPress.com Block Editor: do not use in the upcoming Block-based Widgets Editor
- Nav Unification: stores the preferred view after a page switch using the new WP.com quick switcher
- Symc: update Sync tests to include case for jetpack_sync_settings options.

## [9.9] - 2021-07-06
### Major Enhancements
- Carousel: improve carousel usability, performance, accessibility, mobile friendliness.
- Carousel: improve stability, fixes multiple bugs.

### Enhancements
- Blocks: additional automated tests to improve reliability.
- Carousel: Add comment indicator icon to carousel comments icon.
- Dashboard: provide more useful information and an option to contact support when there are display issues in the Jetpack dashboard.
- Editor: added Social Preview panel to the pre-publish sidebar to increase visibility.
- Instant Search: improve modal animation and transition speed.

### Improved compatibility
- Blocks: make sure connection notices in blocks work with the widget and customizer block editors.
- Carousel: Ensure refactored carousel is compatible with Twenty Nineteen theme styles.
- Full Site Editing: disable admin bar in Jetpack notifications to prevent keystroke hijacking in the Site Editor.
- Podcast Block: Ensure compatability with latest version of Gutenberg plugin and WordPress 5.8.
- Search: improve Search Widget compatibility with WordPress 5.8 widget editor.
- Shortcode Embeds: enable compatibility with WordPress' "Lazy Loading".
- Site Logo: improve compatibility with WordPress 5.8's new Site Logo block.
- Slideshow Block: update icon.

### Bug fixes
- AMP: Fix top AMP ad unit from being cropped on mobile devices
- Blocks: GIF block supports the widget editor and customizer preview pane.
- Carousel: Fix intermittent issue with unresponsive prev button.
- Carousel: Fix image quality on carousel zoom.
- Carousel: Set pagination font weight to normal to avoid conflicts with theme styles.
- Carousel: disable transitions on prev/next images to prevent flash effect on pinch, zoom and swipe.
- Custom CSS: allow leading decimal zeros.
- Inline PDFs: Fix height of PDF embeds for greater theme compatability.
- Instant Search: ensure alt text does not contain mark element.
- Instant Search: fix render-breaking typo for Expanded search results.
- Instant Search: prevent overlay from opening when composing text using an input method editor for Chinese, Japanese, Korean, and Indic languages.
- Instant Search: prevent theme from overriding modal close button styles.
- Instant Search: show correct count for paginated results.
- Payments Block: prevent hiding block configuration instructions when block is nested.
- Shortcode Embeds: correctly handle YouTube URLs that include a start time.
- Story Block: improve navigation, fix issues with long press to pause and exiting story on last tap.
- Widgets: avoid PHP notice when using the Milestone Widget within the upcoming widget management screen in WordPress 5.8.
- WordPress.com API: properly allow requests to upgrade a plugin outside of autoupdates.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add 'purchasetoken' query param to all url's leading to checkout for allowing logged out purchases on WordPress.com.
- Added a Dashboard Switcher in screen options so that WordPress.com users can switch between WP Admin & WordPress.com screens.
- Added a nudge for Atomic and WPCOM that is loaded in Customizer's "Additional CSS" section.
- Added display_embed and rating properties from VideoPress in the update and get media API endpoints.
- Add support for choosing a preferred view on individual screens accessed from the WP.com sidebar menu
- Add support for multi site search results for p2 theme.
- Add Sync Unit Tests.
- Add two jetpack/v4 endpoints to retrieve and delete a site's purchase token.
- Admin menu: Register Calypso settings pages as independent submenus
- Admin Page: Modularize Redux initialization into a separate helper class.
- Bump jetpack-backup package version.
- Business Hours Block: refactor PHP server-rendered fixture test to use parent class.
- Change redirect library to accept any parameter.
- Change the main connection flow and choose between in-place or Calypso flows only after the site registration.
- E2E test reports: send more information about PR to test reporter.
- E2E tests: add missing direct dependencies, and remove a few unnecessary ones.
- E2E tests: add test report in Slack notification.
- E2E tests: attach video recordings to test reports.
- E2E tests: change build and E2E tests to use pnpm rather than yarn.
- E2E tests: do no save videos for passed tests.
- E2E tests: fix tunnel log not being written.
- E2E tests: remove call to missing function.
- E2E tests: trigger workflow dispatch to generate test reports.
- E2E tests: updated readme with reporting info.
- E2E tests reports: send PR number to test reporter.
- Edit User: hide profile fields ( First Name, Last Name, Display Name, About, Email, Website ) for WordPress.com users. These fields can be edited in WordPress.com from user account settings.
- Extract JetpackLogo component into RNA Components package.
- Fix building with calypso-build 6.5.0.
- Fix the Jetpack menu settings link on Atomic sites.
- Handle blavatar_url case for story playback site icon.
- Identity Crisis: Replace the usage of Jetpack_IDC with Identity_Crisis.
- Init 9.9 release cycle.
- Instant Search: prevent standard sidebar widgets showing in the search modal sidebar when switching themes for WPCOM sites.
- Instant Search: support for searching by group id
- Migrate identity-crisis/migrate and identity-crisis/confirm-safe-mode endpoints to Identity Crisis package.
- Modified swiper to use svg icons on carousel instead of font icons
- Move connection/owner endpoint to Connection package.
- New "disconnect" route to open the "Disconnect" modal.
- P2: Conditionally hide admin menu items for hubs/spaces.
- Plugins Modify endpoint now supports per plugin locks.
- Publicly includes whether the site is a WP.com Atomic one as part of the Sites API.
- Remove jetpack_idc_disconnect hook as functionality has been migrated to packages.
- Remove premium theme info.
- Removes dashboard switcher from index.php to improve parity with Calypso.
- Remove unneeded "test-spelling" script with a vulnerable dependency.
- Repeat Visitor Block: Add JS and PHP block fixture tests.
- Replace hardcoded redirect link to use the library instead.
- Search: Modularize Customizer and DOM integration.
- Search: Prepare application for Gutenberg customization.
- Search: Use aliased Preact imports.
- Story block: Fix (server-side) rendering of external stories.
- Sync tests for get_objects_by_id implementation for themes.
- Sync Unit Test for options get_objects_by_id.
- Sync unit tests for get_object_by_id methods in Updates module.
- Temp: Remove sync tests to unblock dev.
- Unit Tests for Sync constants.
- Update lock file.
- Update package dependencies.
- Updates To Test file for 9.9 beta
- Update Sync test_get_post_types_method test.
- Update the webpack configuration for extensions to prevent JS conflicts with other plugins.
- VideoPress: do not allow video files in WoA sites with Free plan.

### General
- Jetpack now requires WordPress 5.7 in anticipation of WordPress 5.8 coming later this month.

## 9.8.1 - 2021-06-08
### Bug fixes
- Carousel: avoid JavaScript errors when trying to load the Carousel view when logged out of your WordPress site.
- Related Posts: avoid squished images when image height isn't defined.
- Story Block: allow multiple stories per post.
- Story Block: allow selecting additional media items in media picker instead of only replacing the existing selection.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Obtain lock before performing autoupdates.

## [9.8] - 2021-06-01
### Enhancements
- Contact Form: the "Feedback > Export CSV" submenu entry has been removed. The export functionality is still available in "Feedback > Form Responses".
- Form block: allow replacing the "Message Sent" heading with custom phrase.
- Instagram Reel: add oEmbed support for Instagram Reel posts.
- Instant Search: add 'open when visitor submits the form' overlay trigger.
- Instant Search: apply configured highlight color to text highlights.
- Site Verification Tools: adds an option for Facebook domain verification.
- Story Block: add new block that enables you to use photos and videos to create engaging and tappable fullscreen slideshows.

### Improved compatibility
- Blocks: ensure blocks are compatible with upcoming Full Site Editor feature.
- Blocks: ensure tiled gallery and slideshow blocks do not output invalid CSS when used with AMP plugin.
- Dashboard: hide Settings page for non-admin users when in site-only connection.
- Instant Search: ensure search input is the correct width if an input max-width has been specified in the theme.
- Related Posts: add height attribute to post images for better compatibility with page performance analysis tools.
- Related Posts: avoid Fatal Errors when using plugins that may interact with WordPress' customizer in specific ways.
- SEO Tools: ensure Jetpack SEO does not conflict with SEOPress.
- Story Block: Improve accessibility and resolve z-index issues when playing in fullscreen.

### Bug fixes
- Carousel: harden fetching comments in Carousel view.
- Contact Form: remove double quotes from names in email headers to improve compatibility with different emailing solutions for WordPress.
- Dashboard: display the Sharing settings tab when editors only need to customize Publicize settings for their own account.
- Dashboard: do not display Protect card for non-admin users while in site-only connection.
- Dashboard: do not show multiple connection prompts in the Publicize settings card.
- Dashboard: ensure connected user details properly displayed.
- Dashboard: ensure that the Jetpack settings page can be accessed when using Jetpack's Offline mode.
- Fixed regression introduced in posts page icon notification WP-Admin edit.php page.
- General: ensures that the send_auth_cookies filter is respected.
- Instant Search: don't photon-ize SVG images as they're not supported by Photon
- Instant Search: fixes for design conflicts.
- Instant Search: prevent standard sidebar widgets ending up in the search modal sidebar when switching themes.
- Social Previews: don't show duplicate buttons when a featured image is selected.
- Stats: fixes the date used to fetch the Top posts in the Top posts dashboard widget.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Add an API function to get hub a P2 hub id.
- Add a way to connect E2E sites headlessly
- Add REST API v2 endpoint for editing transients.
- Adds Advanced General menu item that points to WP Admin regardless of whether the Advanced Dashboard toggle is enabled or not.
- Add upsell nudges in sidebar for WordPress.com users.
- Add userless and classic connection tests
- Admin Pages: prompt connect instead of upgrade when WordPress.com account is not connected
- Business Hours Block: Add server rendered PHP fixtures test.
- Calendly block: add target existence check before running init scripts
- Changing the WPCOM subscription email control type from 'text' to 'email'.
- Clicking the Write button in masterbar will now use WP Admin block editor.
- Comment: Story block: Add more media options to choose from in the editor
- Comment: Story Block: Improve rendering in email notifications
- Comment: Story Block: Use CSS scale3d() instead of scale()
- Connection package independence: Filters the remote_register XMLRPC endpoint redirect URI
- Connection package independence: Move a Jetpack specfic connection routine out of the package and into the plugin
- Disabled editing and deleting pages in WP-Admin Pages list screen for the page that is configured as a Posts page.
- E2E: Fix wp-config setup script to match latest core changes
- E2E tests: Change the timeout to wait for loading animation in connection frame, before the approve button is displayed.
- E2E tests: fixed typo in help of infrastructure script
- E2E tests: fix for failing test when Mailchimp is already set up
- E2E tests: fix Slack notification for scheduled jobs
- E2E tests: generate Allure results
- E2E tests: group test runs in CI
- E2E tests: improved Slack notifications
- E2E tests: Increase timeout for loading animation on connection flow
- E2E tests: runner groups
- E2E tests: use github object to get context info for slack notification
- Enable the Plans tab for unlinked users
- Ensure that the WPCOM toolbar remains enabled with AMP in wp-admin
- Ensure video/videopress mime type is set on attachments when a videopress update xmlrpc call is received
- Fixed compatibility issue with Page Optimize plugin for RTL layouts for jetpack-admin-menu and colors stylesheets
- Fixed new PHPCS errors.
- Fixed the Upgrades, Jetpack and Settings menu item slugs in WP-Admin
- Fix LEGACY_META_OPTION handling for WPcom simple sites
- Fix Notice: Undefined variable: poster_url
- Fix plan name display in Upgrades menu entry for translations with spaces or non-Latin characters
- Fix the height of the User Authentication Dialog on the dashboard
- For users that are able to update the `LEGACY_META_OPTION` option, avoid trying to update `TITLE_FORMATS_OPTION` which would display an 403 in Calypso.
- Hide plan links for P2 sites that can't have plans
- Hide plan link to email plan for P2 sites
- Hide the FAB icon on Yoast admin pages to avoid overlap with the Yoast help icon.
- Hook into the Connection package remote_connect to perform Jetpack specific routines
- Increase the priority of the Subscriptions block
- jetpack disconnect CLI command: Add support to delete the connection owner and improve error message
- JITM: remove unnecessary add_filter calls for the JITM filters.
- jp-tracks-functions script moved to Tracking package.
- No changelog needed, this is a fix for a Calypso feature that has not been enabled yet
- Offer features depending on the current plan of the site rather on the current platform of the site.
- Paid blocks: Remove nested upgrade nudges on the frontend.
- Premium Content blocks: Fix parent block selector button when premium content blocks are nested within other blocks.
- Refactored to improve testability. No functionality is affected.
- Remove "user-less" jargon from code
- Remove CodeClimate
- Removed the carousel reblog functionality (unused in Jetpack).
- Removed use of experimental feature and replaced with new `useBlockProps` hook to ensure video block continues to function correctly
- Remove onboarding_token logic in the Remote provision XMLRPC method from the Connection package and add it to the Jetpack plugin
- Replace user locale with WordPress.com user locale on Atomic.
- Search: added search happy route E2E tests
- Simplify wpcom/v2 delete transient endpoint logic.
- Standardize wording for connecting the user.
- Story block: address minor display issues
- Story block: fix edit button in the block's toolbar to use the pencil icon instead of Select Media text
- Story Block: Fix syncing muted state
- Story Block: Fix video not loading on safari and Chrome iOS
- Turns off css tidy shorthand optimization to prevent clashes with gutenberg block validation
- Updated Jetpack_Google_Analytics to use static property $analytics
- Updated package dependencies
- update jetpack-redirect dependency
- Update logic for showing a Redirect flag in the sidebar
- Update Sync Connection Tests to utilize fix nomenclature
- Update Sync unit tests to align with new return format of get_object_by_id.
- Update the priority for overriding unified nav styles.
- Update the required version of "connection-ui" package.
- WordPress.com API: allow switching from locale variant to primary in Site Settings endpoint.

## [9.7] - 2021-05-04
### Enhancements
- Blocks: improve test coverage for better reliability of each one of Jetpack's blocks.
- Carousel: improve general performance.
- Dashboard: add explanation when a feature is unavailable.
- Dashboard: improve the display of buttons in the update modal.
- Jetpack Videos: add "Play Inline" setting to play a video inline instead of full-screen on mobile devices when enabled.
- SEO Tools: improve usability of settings interface.
- Widgets: improve message displayed in Blog Stats Widget when there are no stats to display.
- WordAds: add Global Privacy Control (GPC) support to CCPA.

### Improved compatibility
- Blocks: continous work to ensure full compatibility between Jetpack's Blocks and WordPress' upcoming Full Site Editing feature.
- Featured Content: avoid PHP warnings when terms are fetched without a taxonomy to filter by.
- Feature Hints: avoid Fatal errors when other plugins filter the plugin list.
- General: improvements to bring multiple features up to WordPress coding standards.
- Publicize: update Twitter text processing library to avoid errors when using PHP 8.
- Sharing: avoid broken sharing icons when using IE11 and the legacy AMP plugin's theme.

### Bug fixes
- Image CDN: correct image URLs in srcset in certain cases.
- Instant Search: enable link filtering on built-in WordPress taxonomies.
- Instant Search: fix handling of customizer controls using refresh.
- Instant Search: fix race condition for API responses.
- Instant Search: improve settings interface usability.
- Instant Search: prevent excluding all post types.
- Instant Search: set the number of returned posts using the query's `posts_per_page` value.
- Markdown: fix regression that broke links with single-quoted href attributes.
- Sharing / Publicize: properly encode URLs in Open Graph tags.

### Other changes <!-- Non-user-facing changes go here. This section will not be copied to readme.txt. -->
- Account for Categories and Tags in nav unification
- Add e2e test to cover Jetpack Assistant's (Recommendations) main flow
- Add field for zendesk meta in /me/sites API for mobile apps
- Add REST API v2 endpoint for editing transients.
- Adds segmentation "from" parameter to the registration request
- Add unit tests to cover the functionality of each step of the assistant
- Always use WP Admin for comments in Atomic sites.
- Autoloader: Use a different suffix for each release to fix #19472.
- Avoid PHP Notices in jetpack_blog_display_custom_excerpt() when run outside of the loop / without post context.
- Calypso's Tool -> Export menu now honors the 'Show advanced dashboard pages' setting
- Change copy on in-place connection title to match user-less behavior
- Changelog: update with latest changes that were cherry-picked to 9.6 during Beta period.
- Change the command to build Jetpack in E2E tests Github action workflow
- Connection: moving the registration REST endpoint to the Connection package.
- Docs: fix typos in E2E README
- Do not display Protect card for non-admin users while in site-only connection
- Do not load modules that require a user when in user-less state
- Do not show multiple connection prompts in the Publicize settings card.
- E2E tests: fixed hover action
- E2E tests: publish Testspace results in folders
- Fixed the Upgrades, Jetpack and Settings menu item slugs in WP-Admin
- Fix the height of the User Authentication Dialog on the dashboard
- Enable the Plans tab for unlinked users
- Hide Settings page for non-admin users when in site-only connection
- In-Place Connection: partially replace the secondary users connection flow with `InPlaceConnection` component from `@automattic/jetpack-connection` package.
- Jetpack Assistant: Add the product slug to the events dispatched when users see and click the product being upsold
- Licenses: hide the Recommendations banner when the Connection banner is visible.
- Licenses: show the license-aware version of the Connection banner when there is a userless connection established and there are stored licenses.
- Move JITM's REST API endpoints into the package
- Nav Unification: Always show the Theme Showcase (wordpress.com/themes) to WP.com free sites.
- Nav Unification: Remove Sharing submenu option from settings menu for wpcom sites.
- Nav Unification: remove the box-shadow at the top of the Sidebar.
- Nav unification: sync sidebar collapsed state with wpcom.
- Nav unification: updated the Jetpack admin menu logo SVG for increased compatibility with colour schemes
- Reassign $submenu_file value as null for theme-install.php so correct menu item Add New Theme is highlighted in admin menu.
- Record stat of the first time the site is registered
- Refactored the menu and submenu items replacement for nav unification
- Remove broken link to Scan details on Atomic sites
- Removing the password-checker package from the Jetpack plugin composer.json file.
- Replaced the string "Add new site" to "Add new site" on masterbar and corrected the unit tests.
- Replace fragile element selectors with a more robust version of themselves
- REST API: Add list modules v1.2 endpoint.
- REST API: Allow site-level authentication on plugins, themes, modules endpoints
- Sanitize the hookname used to generate menu item IDs
- Show current WPCOM plan in sidebar menu item "Upgrades" when nav unification is enabled.
- Standardize wording for connecting the user.
- Updated package dependencies.
- Update prepare_menu_item_url in admin menu API to replace special characters in URLs with their HTML entities such as ampersand (e.g. convert &amp; to &).
- WordAds: add translated text for use with inline and sticky slots
- WordAds: use WPCOM hosting type for Atomic sites

## 9.6.1 - 2021-04-13
### Bug fixes
- Connection tools: safeguard cleanup tool against accidental option removal.
- Dashboard: fix loading indicator styles by deprecating our custom solution in favor of WordPress Core's Spinner.
- Instant Search: fix Customizer and styling bugs introduced in 9.6.
- Instant Search: Handle pagination edge-case with excluded post types.
- Sharing: ensure the feature can be used when Jetpack is used in Offline mode.
- Stats: Fix time period selection on the stats page.

### Other
- Admin Menu: Centralize class loading in Jetpack codebase.
- Admin Menu: Fix the display of the Links Manager.
- Cover block: fix paid-block-media-placeholder interference with flex positioning.
- Remove outdated reference to SEO as a paid feature in readme.txt.

## [9.6] - 2021-04-06
### Enhancements
- Beautiful Math: remove title attribute from generated image.
- Blocks: add width option to buttons in Subscriptions, Revue, Form, Calendly, and Payments blocks.
- Blocks: improve reliability of all blocks via unit tests.
- Dashboard: add new options to customize SEO settings.
- Dashboard: add new option to input license key.
- Dashboard: update recommmendations notice to improve accessibility.
- General: allow the use of some Jetpack features without connecting to a WordPress.com account.
- Instant Search: add a new result format layout, for sites using WooCommerce.
- Instant Search: improve performance thanks to lazily loading.
- Instant Search: only use site accelerator for displaying images if it is enabled on the site.
- Instant Search: update the search modal design.
- Jetpack Videos: improve the display of transcoding status for newly uploaded videos.
- Podcast Player Block: improve fetching of the podcast description.
- Syncrhonization: add new sync/health endpoint to allow update of the sync health options.

### Improved compatibility
- Auto-updates: respect auto-update constant/filters in plugin API endpoints.
- Autoloader: fix uninstallation fatal.
- General: update colors to match dashboard color changes in WordPress 5.7.
- Gravatar Hovercards: fix compatibility with the AMP plugin for Pingbacks and Trackbacks.
- Latest Instagram Posts Block: improve compatibility with Gutenberg 10.1.0.
- Markdown: avoid processing URLs that may include Markdown syntax.
- Opentable Block: improve compatibility with Gutenberg 10.1.0.
- Podcast Player Block: fix compatibility with the AMP plugin in the Customizer preview.
- Podcast Player Block: improve compatibility with Gutenberg 10.1.0.
- Synchronization: avoid issues with themes or plugins using anonymous functions within hooks.

### Bug fixes
- Connection Flow: resolve issue that prevented connections from the Opera browser.
- Custom Content Types: fix inline quick editing of Restaurant menu items.
- Instant Search: ensure Escape key always closes search modal.
- Instant Search: fix an issue that led to a PHP notice for undefined index.
- Instant Search: Fix modal opening bug within the Customizer.
- Instant Search: fix handling of Customizer controls using refresh.
- Instant Search: fix visibility of filter checkboxes in Safari on Twenty Twenty and Twenty Twenty One themes.
- Instant Search: hide "filters" menu on mobile if there are no filters to display.
- Instant Search: prevent IE11 from spawning overlay on load.
- Publicize: avoid notices as embeds are added to a post.
- Recommendations: when enabling Site Accelerator, also enable Tiled Galleries.
- Sharing: omit Open Graph description tag from posts with Premium Content.
- Site Logo: fix issues when updating logo in the Customizer.
- Star Rating Block: allow 0 stars to be selected.
- Subscriptions Block: allow block to override color styles, falling back to theme defaults.
- Tiled Gallery: prevent block validation errors for mosaic and column layouts.
- Video Block: display fallback when fetching videos that have been deleted.
- WordPress.com Block Editor: disable if all Jetpack blocks are disabled via a filter.
- WordPress.com REST API: make sure post metadata is always an array.

### Other
- Admin Page: Do not show an error message with JSONP is disabled. The admin page does not use it.
- Readme: update link to changelog file. No changelog entry necessary.

## 9.5.2 - 2021-03-16
### Improved compatibility
- Block Editor: avoid conflicts between multiple Jetpack blocks and Gutenberg version 10.1.0.

### Bug fixes
- Instant Search: prevent IE11 from spawning overlay on load.
- WordPress.com Toolbar and customizations: fix multiple issues causing navigation panel discrepancies between the WP-Admin dashboard and the WordPress.com dashboard.

## 9.5.1 - 2021-03-04
### Bug fixes
- Sharing: avoid potential conflicts with the Blog Posts Block from Newspack.
- Subscriptions Block: avoid validation errors when customizing font size on a site using the Gutenberg plugin.

## [9.5] - 2021-03-02
### Enhancements
- Carousel: improve the experience on mobile devices by allowing touch events (pinch, zoom).
- Instant Search: improve the design of the Search modal.
- Instant Search: open search result links in the current window rather than opening a new one.
- Podcast Player Block: allow filtering the number of tracks returned when fetching new podcast episodes.
- Podcast Player Block: add publication date to the data returned when fetching new podcast episodes.
- Recommendations: add a dashboard banner to help users discover the best Jetpack features.
- Related Posts: improve performance by removing jQuery dependency.
- SEO Tools: make the feature available for all sites.
- Social Icons Widget: add new icons.
- Social Menu: add new icons.
- Synchronization: improve reliability of data by excluding blocked taxonomies.
- Tiled Galleries: improve performance by removing jQuery dependency.
- Video Block: add support for custom video player progress bar colors.
- Widgets: display notice in the customizer when one needs to connect their account before using the Instagram widget.

### Improved compatibility
- Block Editor: update all blocks to be fully compatible with WordPress 5.7.
- General: Jetpack now requires WordPress 5.6, and is fully compatible with WordPress 5.7.
- Protect: ensure that the blocked login page is fully compatible with the Robots API changes introduced in WordPress 5.7.

### Bug fixes
- Autoloader: prevent transitive plugin execution.
- Carousel: ensure that the Carousel view is available regardless of your gallery's link settings.
- Comments: improve respect for the Core moderation option in particular cases.
- Connection flow: ensuring Jetpack Dashboard successfully loads after reconnect.
- Cookies & Consent Widget: ensure the widget can be edited from the new block-based widget editor.
- Custom Content Types: allow Newspack's Blog Posts block to display Testimonial and Portfolio posts.
- Dashboard: improve performance by reducing excessive API calls.
- Dashboard: improve product upgrade flow for non-connected Jetpack users.
- Instant Search: fix closing of the overlay using the Escape key in IE11.
- Instant Search: improve compatibility with browser forward/back navigation.
- Instant Search: avoid issues when changes made in customizer would not immediately appear in preview.
- Jetpack Videos: fix responsiveness of Video poster images.
- Map Block: avoid issues when resize event listener was not removed when the component was unmounted.
- Markdown: avoid filters loading too early when creating a new site within a Multisite network.
- Payments Block: avoid layout issues when setting up a new payment plan.
- Pay With Paypal Block: ensure that line breaks can be used in product description.
- Secure Sign On: improve the connection flow when users first log in via SSO.
- Sharing: avoid displaying block content in Open Graph Meta tags when not needed.
- Sharing: ensure that sharing popup opens properly in Firefox.
- Shortcodes: use arguments provided by shortcode attributes for the Instagram embeds.
- Video Block: avoid potential PHP notice when working with Jetpack Videos.
- WhatsApp block: adjust width of block options toolbar.

## 9.4.1 - 2021-02-16
### Bug fixes
- Carousel: ensure that the Carousel view is available regardless of your gallery's link settings.
- Dashboard: improve performance by reducing excessive API calls.
- Payments Block: avoid layout issues when setting up a new payment plan.

## [9.4] - 2021-02-02
### Enhancements
- Dashboard: add new Recommendations page to help you get started with recommended features of Jetpack.
- Dashboard: change the development notice link to an external link.
- Podcast Player Block: add skip back/forward buttons.
- Podcast Player Block: improve RSS feed detection.
- Sharing: remove jQuery dependency to improve performance of the sharing buttons.
- Sharing: improve performance of the Email Sharing button by lazy-loading the Google reCAPTCHA when necessary.
- Social Menu: add Patreon icon.
- Synchronization with WordPress.com: improve the validation of field names when calculating checksums on tables.
- Synchronization Performance: reduce concurrency of requests by implementation of Retry-After for concurrent requests.
- Widgets: add Patreon icon to Social Icons Widget.
- WordPress.com REST API: add new Cloudflare Analytics field option.

### Improved compatibility
- Form Block: avoid display issues when submitting a form within an AMP view.
- Instant Search: improve support for older browsers such as Internet Explorer 11.
- Secure Sign On: support custom login page plugins such as WPS Hide Login.
- Tiled Gallery Block: add additional CSS classes to improve compatibility with the Core Gallery block.

### Bug fixes
- Autoloader: resolve inconsistencies when including a cache supporting autoloader from one without cache support.
- Contact Form: prevent post status transition actions from firing twice when the post status is changed.
- Crowdsignal: avoid issues when using a Crowdsignal shortcode in the block editor.
- Jetpack Video Block: avoid block validation errors when editing existing content.
- Jetpack Video Block: add missing alignment classes.
- Publicize: allow clearing Publicize custom message if a post title has been set.
- Stats: update dashboard widget to respect new dashboard widget markup.
- Subcriptions Block: avoid errors when displayed within a Disabled context, such as a block or pattern preview.
- Synchronization with WordPress.com: avoid PHP warnings.
- Synchronization with WordPress.com: fix potential PHP notices when making XMLRPC requests.
- WordPress.com REST API: fix PHP notice when fetching user connection data without a connection owner.

## 9.3.1 - 2021-01-14
### Bug fixes
- Multisite: avoid Fatals on sites using the WPMUDEV domain mapping plugin.
- SEO Tools: prevent a PHP notice in some situations involving taxonomy or author pages.

## [9.3] - 2021-01-12
### Enhancements
- Autoloader: improve performance by caching known plugins.
- Instant Search: improve compatibility with IE11.
- Related Posts: use the semantic time element when displaying dates.
- Sharing: defer loading of the reCAPTCHA library by default.

### Improved compatibility
- AMP: avoid PHP notice on sites using legacy versions of the AMP plugin.
- Dashboard: avoid errors on sites using PHP 8.
- General: use modern JavaScript best practices for loading scripts.
- Infinite Scroll: add compatibility for the TwentyTwentyOne theme.
- Search: improve styling for the TwentyTwenty theme.
- Synchronization: improve integrity of synchronization between your site and WordPress.com.
- WordPress.com Toolbar: iterate on the design and functionality of the toolbar to match the toolbar in use on WordPress.com.

### Bug fixes
- Autoloader: resolve symbolic links in active plugin paths.
- Autoloader: ensure deactivating plugins aren't cached.
- Blocks: improve sidebar display in non-fullscreen mode.
- Content Options: do not output CSS when it is not needed.
- Instant Search: improve display of tags and categories in search results.
- Lazy Images: attempt to load all images when printing a post, and inform the user when printing if images haven't been loaded.
- Podcast Player Block: avoid PHP notices in some scenarios.
- Search: limit number of filters automatically set up.
- Slideshow Block: ensure that image captions are always shown, regardless of the theme you're using.
- Subscription Block: display the correct default placeholder and button text strings in the post editor.
- Subscriptions: fix the behavior of the toggle switches for the comment subscription settings.
- Twitter Threads: improve how Twitter Cards are generated for embeds in the thread preview.
- VideoPress: detect aspect ratios rounding to both 1.77 and 1.78 as 16:9.
- Widgets: avoid JavaScript errors when displaying the Cookies & Consent Widget.
- WordPress.com REST API: avoid fatal errors in some scenarios, when updating a post's metadata.

## 9.2.1 - 2020-12-10
### Improved compatibility
- Site Health Tools: improve PHP 8 compatibility.
- Twenty Twenty One: add support for Jetpack's Content Options.

### Bug fixes
- Instant Search: fix layout issues with filtering checkboxes with some themes.
- WordPress.com Toolbar: avoid Fatal errors when the feature is not active.
- WordPress.com Toolbar: avoid 404 errors when loading the toolbar.

## [9.2] - 2020-12-01
### Enhancements
- Connection Flow: clarify error message when the options table is not writable.
- Contact Form Block: display fallback link when the block is rendered in non-WordPress contexts, such as subscription emails.
- Contact Form Block: display the correct default email address and subject in the form block settings.
- Dashboard: clarify language around support options.
- Instagram Embeds: add support for embed parameters supported by Instagram.
- Payments Block: move unreadable notice to the sidebar.
- Pinterest Block: ensure that Pinterest embeds are displayed nicely in non-WordPress contexts, such as subscription emails.
- Podcast Block: display fallback link when the block is rendered in non-WordPress contexts, such as RSS feeds.
- Search: improve URL formatting for the expanded search layout.
- Sharing: ensure the first suitable image found in a post is always the one used in Open Graph Image meta tags.
- Site Health Tools: update description of Synchronization issues for better usability.
- Slideshow Block: ensure that slideshows are displayed nicely in subscription emails.
- Status: improve detection of staging servers.
- Story Block: improve display of the block.
- Synchronization: improve synchronization of comment status, taxononmies, and terms between your site and WordPress.com.
- Tiled Gallery Block: improve rendering when the block is rendered in non-WordPress contexts, such as subscription emails.
- WhatsApp button Block: improve text alignment on mobile devices.
- WordPress.com Toolbar: include admin color in user's REST API output.

### Improved compatibility
- Autoloader: support Composer 2.0.7.
- General: continued work towards ensuring that Jetpack is fully compatible with the upcoming version of PHP, PHP 8.
- General: ensure Jetpack's full compatibility with the upcoming WordPress 5.6 release.
- General: update Jetpack's minimum required WordPress version to 5.5, in anticipation of the upcoming WordPress 5.6 release.
- Sharing: disable Open Graph Meta tags added by the Web Stories plugin when Jetpack's tags are active.
- Stats: support Web Stories plugin.
- Synchronization: ensure better synchronization of post meta data (used by Publicize, Subscriptions, Search) in WordPress 5.6.

### Bug fixes
- Connection: handle XMLRPC requests when SERVER_PORT is not defined.
- External Media: fix a conflict with CoBlock's image replace feature.
- Dashboard: fix incorrect links to Jetpack credentials form.
- Google Analytics: ensure compatibility with Google Analytics 4 (GA4).
- Sitemaps: ensure that the Home URL is slashed on subdirectory websites.
- Social Icons widget: display only one icon when a URL matches both a domain and the feed URL match.
- Sync: avoid trying to sync when something else disabled syncing a request.
- Whatsapp Button Block: fix Guyana country code metadata.
- WordPress.com REST API: restore post comments when untrashing a post, such as via the mobile apps.

## [9.1] - 2020-11-10
### Enhancements
- Button Block: add a center alignment option to all Jetpack button blocks.
- Content Options: add new filter to allow theme and plugin authors to disable featured image removal for their Custom Post Types.
- Dashboard: improve the display of dates in the Jetpack Plan screen and in the Stats graph.
- Dashboard: improve the display of numbers in all languages.
- Donations Block: improve the display of the block outside WordPress (in subscription emails, for example).
- Embeds: update Loom logo.
- External Media: add feature to the Cover block.
- Google Calendar Block: improve the display of the block in the editor.
- Image Compare Block: accessibility improvements.
- Instant Search: improve accessibility of the Search modal.
- Likes: remove jQuery dependency where possible.
- Pay with PayPal Block: improve the styling of the buttons in subscription emails.
- Pay with PayPal Block: improve the display of currencies.
- Podcast Player Block: add option to hide the episode title.
- Podcast Player Block: display more helpful error messages when a podcast cannot be embedded.
- Publicize: improve the usability of the Twitter thread options.
- REST API: support needed capabilities in Jetpack REST API endpoints that allow site based authentication.
- Social Menu & Social Media Icons: add support for Telegram profiles.
- Synchronization: improve reliability of synchronization of theme changes.
- WhatsApp Block: add option to change the alignment of the button.
- Widget Visibility: improve performance on sites with a large number of pages.
- WordPress.com Block Editor: add option to add metadata to a post indicating the last editor used.
- WordPress.com REST API: remove outdated code that allowed non-secure requests to the API, as such requests are no longer accepted.

### Improved compatibility
- Comments: avoid AMP validation errors when using Jetpack's Comments feature and the AMP plugin.
- Dashboard: better support all states available when using one of Jetpack's Security solutions.
- Embeds: improve compatibility between Jetpack's Instagram embed and WordPress' own embed.
- Embeds: ensure Facebook Embeds work well with the AMP plugin.
- External Media: update iconography and improve forward compatibility.
- General: better detect local development environments.
- Google Analytics: add support for the AMP plugin to track WooCommerce events.
- OpenTable Block: ensure full compatibility with the AMP plugin.
- Pay with PayPal Block: ensure full compatibility with the AMP plugin.
- Sharing: add support for the Google Web Stories plugin.
- Slideshow Block: ensure that the block can be displayed using the Full Width alignment setting when using the Gutenberg plugin.
- Widget Visibility: avoid performance impact it may have on the block editor when used with the Gutenberg plugin.
- YouTube embeds: ensure that all YouTube video embeds work well when using the AMP plugin.

### Bug fixes
- Calendly and Eventbrite Blocks: fix layout issue when selecting block styles in the editor.
- Contact Form: selection widgets, radio buttons, and checkboxes can now use commas, brackets, and backslashes in the labels and values without breaking the form.
- Donations / Payments Block: fix visual bug in Stripe connection banner.
- Embeds: ensure Facebook videos are centered properly with the Twenty Twenty theme.
- Google Analytics: support updated Google Analytics 4 properties.
- Image CDN: the CDN will now ignore attempts to specify percentages for width or height in an image tag.
- Infinite Scroll: ensure the number of posts loaded when using Infinite Scroll respects posts per page settings.
- Latest Instagram Posts Block: avoid PHP warning when no images can be retrieved from Instagram.
- Lazy Images: attempt to load all images when printing a post, and inform the user when printing if images haven't been loaded.
- Pay with PayPal Block: add default price value.
- Pay with PayPal Block: ensure currencies are displayed properly in the editor.
- Protect: fix handling of IPv6 addresses.
- Publicize: ensure that custom messages can be saved when using the Portfolio Custom Post Type.
- Publicize: ensure that tweets consisting only of whitespace aren't added to Twitter threads.
- Publicize: when generating Twitter threads, allow text to be split at line breaks where appropriate.
- Security / Contact Form: add additional checks before checking submitted forms for spam.
- Security / WordPress.com REST API: improve authentication checks when making proxied requests to a site's API endpoints.
- Slideshow Block: fix a bug that prevented the first and last images from displaying when the slideshow loops.
- Stats: no longer incorrectly report a term ID as a post ID in some rare cases.
- Videos: ensure Jetpack videos use the correct aspect ratio in both the editor and the frontend, even when used within column blocks.
- WhatsApp Block: fix issue when the text color would not be correct.

## 9.0.2 - 2020-10-09
### Enhancements
- Publicize: improve handling of URLs when generating Twitter threads.

### Bug fixes
- Instagram Embeds: ensure that Instagram URLs with additional URL parameters can be embedded as well.
- Media Extractor: prevent PHP notice for some URLs.
- Publicize: avoid block editor errors when no Publicize connections are available.
- Synchronization flow: avoid potential fatal errors when updating the plugin from the Dashboard > Updates screen.
- Sharing: avoid PHP notices when a post object is invalid.
- WordPress.com REST API: avoid errors when uploading images from a URL.

## 9.0.1 - 2020-10-06
### Bug fixes
- General: remove a database optimization task that could potentially cause database issues.

## [9.0] - 2020-10-06
### Major Enhancements
- Publicize: add the ability to publish the entire content of posts to Twitter as threads.

### Enhancements
- Blocks: update icon color for all blocks provided by Jetpack.
- Custom CSS: add support for the `clip-path` property.
- Custom CSS: add rebeccapurple color to the list of colors that can be processed by the SCSS and LESS preprocessors.
- Dashboard: clarify Backup & Scan settings and alerts.
- Dashboard: improve the reconnecting process for site owners willing to disconnect and then reconnect Jetpack to WordPress.com.
- Dashboard: do not display option to purchase a plan when in Offline mode.
- Embeds: add Loom.com as a new embed option.
- Embeds: update song.link oEmbed to support more formats.
- Embeds: allow Instagram embeds to keep working via the WordPress.com REST API.
- Google Analytics: move the legacy variant from the HTML body to head.
- Instant Search: optimize images displayed in Search results thanks to Jetpack's Image CDN.
- Instant Search: improve layout of search results on mobile devices.
- Instant Search: trigger the search overlay upon typing into the search input.
- Pay with PayPal Block: display more helpful content in subscription emails.
- OpenTable Block: display wide style widget as standard on mobile.
- Site Health: add new test for testing blog and current user's token health.
- Site Health: refine information shared when using the "Copy site info to clipboard" button.
- Site Health: offer more information and help in failing tests.
- Slideshow Block: remove the default background color.
- Synchronization: improve performance of synchronization of term changes.

### Improved compatibility
- Autoloader: add support for non-optimized PSR-4 namespace loading.
- Autoloader: add PSR-0 support.
- Autoloader: add handling for filtered `active_plugins` options that would otherwise have left classes out.
- Contact Form: add more integration settings for a better compatibility with Jetpack CRM.
- Contact Form: ensure that forms are displayed correctly in legacy AMP Reader views.
- Dashboard: remove plugin autoupdate settings from the dashboard now that WordPress itself handles this feature.
- Embeds: ensure that Instagram and Facebook embeds are always available, to avoid breaking embeds on existing posts.
- Embeds: solve PHP 8 compatibility issues with Crowdsignal embeds.
- EventBrite Block: ensure full compatibility with the AMP plugin.
- Google Calendar Block: ensure full compatibility with the AMP plugin.
- Image Compare Block: improve display on AMP views.
- Infinite Scroll: ensure Infinite Scroll works on AMP views as well for the Twenty Nineteen and Twenty Twenty themes.
- Infinite Scroll: add tools allowing theme authors to implement Infinite Scroll on AMP views in their own theme.
- Pinterest Block: ensure full compatibility with the AMP plugin.
- Security Scanning: avoid validation issues when using the AMP plugin and when notified of a security threat on your site.
- Slideshow Block: ensure images are displayed properly when using the Swell theme.
- Synchronization: ensure review comments are properly synchronized with WordPress.com.
- Twitter Threads Block: add support for unrolling threads when Gutenberg 8.8+ is activated.
- WordPress.com REST API: improved PHP 8.0 support.

### Bug fixes
- Activity Log: avoid potential duplicate entries.
- Beautiful Math: resolve incorrectly rendered LaTeX images cached during a server migration.
- Connection Flow: resolve conflicts where "staging" connection errors were wrongly detected for some sites.
- Copy Post: ensure categories can be copied properly on sites using an old database schema.
- Donations / Payments: fix link to WordPress.com on sites where WordPress is installed in a subdirectory.
- Image CDN: ensure Wikimedia-hosted images are correctly handled by the CDN.
- Infinity Scroll: remove the loading spinner when loading an extra set of posts and receiving an empty response.
- Stats: do not track visits when site is in staging mode.
- Synchronization: ensure theme information is correctly synchronized with WordPress.com.
- WordPress.com Block Editor: ensure that "Code Editor" menu item is available on mobile devices.
- WordPress.com REST API: improve messaging when uploading a media file via the API fails.

## 8.9.1 - 2020-09-16
### Enhancements
- Jetpack Dashboard: add support for new Jetpack plans.

### Bug fixes
- General: avoid deprecation PHP notices when used with WooCommerce 4.4+.
- Image CDN: avoid PHP warning when replacing URLs by their image CDN equivalent.
- REST API: avoid authentication issues when using a third-party plugin also using the REST API.
- Search: fix a bug where no results appear when using Jetpack's Instant Search interface.
- Site Health Tools: skip a connection status test when in offline mode.

## [8.9] - 2020-09-01
### Major Enhancements
- The new Donations Block allows you to easily accept and process donations on your site.
- You can now preview how your posts will look on Facebook, Twitter, and Google Search Results even before you hit the Publish button.

### Enhancements
- Blocks: add "Edit" button to the Calendly block toolbar.
- Blocks: add new "Consent" field option to the Form block.
- Connection: improve the reconnection process when your site is not properly connected to WordPress.com anymore.
- Connection: improve messaging offered and displayed in the dashboard when there are connection issues between your site and WordPress.com.
- Contact Form: put feedback that matches the disallowed list in trash.
- Dashboard: improved legibility across all Jetpack interfaces.
- External Media: improve keyboard navigation in the media modal.
- External Media: offer a way to disconnect Google Photos accounts from within the media modal.
- Sharing: add spacing around customization link.
- Search: improve styling of expanded results in the Instant Search interface.
- Shortcodes: remove jQuery dependency from Gist shortcode.

### Improved compatibility
- Anti-Spam: better handle globally-configured Akismet API keys in the Jetpack dashboard.
- Blocks: update to use latest colors defined by WordPress.
- Blocks: ensure our External Media option is compatible with other plugins that also make changes to the Media Library options in the block editor.
- Connection: ensure better compatibility of the Monitor, Protect, Secure Sign In, Stats, and Subscription features with your site's connection to WordPress.com.
- General: remove references to pre-PHP 5.6 code.
- Sharing: improve accessibility of the sharing butttons in AMP views.
- Shortcode Embeds: ensure compatibility of the Instagram embeds with upcoming Instagram API changes.
- Third-party plugin compatibility: add new compatibility file for the Creative Mail plugin.
- Third-party plugin compatibility: add Slim SEO to the list of plugins compatible with Jetpack's Open Graph and Twitter Cards Meta tags.

### Bug fixes
- Autoloader: avoid issues when updating plugins using the Autoloader in environments using OPCache.
- Autoloader: remove the map regeneration that occurs after a plugin update.
- Activity Log: ensure that theme changes are mentioned in the Activity Log.
- Blocks: ensure alignment options are respected for the Video block in the editor.
- Blocks: avoid accidental disconnections of the Payments block in the editor.
- Blocks: bug fixes and improvement of consistency of block style implementation in the OpenTable block.
- Blocks: avoid duplicate navigation arrows in the Slideshow block.
- CLI tools: avoid notices when using Synchronization CLI tools.
- Connection: ensure that secondary users can connect their own account to their WordPress.com account.
- Dashboard: fix missing card for Backups in some error cases.
- Protect: avoid displaying HTML markup on blocked login screen.
- Protect: avoid Fatal errors when trying to update Protect options from the REST API.
- Search: ensure that Instant Search options are properly saved in the Customizer.
- Search: avoid errors when searching for a term and including the "%" symbol.
- Shortcodes: avoid Fatal errors when receiving unexpected response from Flickr.
- Theme Tools: resolve a PHP notice in PHP 7.4.
- Video: ensure that videos uploaded with Jetpack Videos are assigned to the correct author.
- Widgets: ensure that the Instagram Widget is properly styled when previewed in the customizer.
- Widgets: do not hide accepted cookie widget to allow visual customization in the Customizer.

## 8.8.2 - 2020-08-17
### Bug fixes
- Infinite Scroll: avoid loading issues with some themes using Infinite Scroll.

## 8.8.1 - 2020-08-10
### Improved compatibility
- WordPress 5.5: ensure that Jetpack's Autoupdate feature is fully compatible with the autoupdate feature introduced in the new version of WordPress.

### Bug fixes
- Admin Page: avoid blank dashboard when some specific notices (such as Offline mode) are displayed.
- Synchronization with WordPress.com: resolve errors triggered from not properly sanitizing/verifying inputs.

## [8.8] - 2020-08-04
### Enhancements
- Blocks: update categories to improve discoverability.
- Connection Flow: improve experience of any additional users of your site that may want to link their WordPress.com account.
- Dashboard: add Jetpack Anti-spam to the product list in the dashboard.
- External Media: add ability to show google photos for a specific month or year.
- Infinite Scroll: improve accessibility of the "Load More" behavior.
- Instant Search: add support for excluding certain post types from search results.
- Mailchimp Block: show error message on email validation error.
- Markdown block: improve handling of long links with custom characters, as well as em- and en- dashes.
- Payments block: add extra customization options to the Submit button.
- Performance: use WordPress-provided wp_resource_hints for DNS prefetching.
- Podcast Player block: start saving content in post content for better compatibility with non-WordPress tools.
- Sharing: add direct link to share button customization for logged-in admins.
- Widgets: introduce new Instagram Widget.
- Widgets: add additional options to the Twitter Timeline widget.
- Widgets: add the rel attribute to links with target=â€_blankâ€ in the Social Icons widget.
- WordAds: update ad units to be more flexible and dynamic.

### Improved compatibility
- Blocks: add default text color to all buttons in AMP mode.
- Connection Flow: improve the display of any connection errors, and provide more tools to help fix those connection errors.
- Contact Form: updates based on language improvements in WordPress 5.5.
- Deprecated hooks: Use native WordPress functionality for deprecated hooks.
- Deprecation Notices: provide more information about deprecated files and functions.
- General: ensure Jetpack's full compatibility with the upcoming WordPress 5.5 release.
- General: update Jetpack's minimum required WordPress version to 5.4, in anticipation of the upcoming WordPress 5.5 release.
- General: update Jetpack to support new environment type features introduced in WordPress 5.5.
- Infinite Scroll: fix layout issue when used with the P2 theme.
- Latest Instagram Posts block: fix layout when used with the AMP plugin.
- Synchronization: improve stability of the connection between your site and WordPress.com.
- WordPress.com REST API: adjust API response based on language improvements in WordPress 5.5.

### Bug fixes
- Asset CDN: avoid returning a directory when setting the local path for translation files.
- Carousel: ensure jQuery is loaded when using the Carousel feature.
- Contact Form: fix alignment of radio and checkbox items.
- External Media: ensure that images inserted from Pexels or Google Photos are attached to the post you're composing.
- General: avoid issues on sites hosted on a Windows server environment.
- General: avoid PHP notices when managing your site via the WordPress Desktop app.
- Gathering Tweetstorms: don't enable the Unroll button until after a Twitter URL has been entered and verified.
- Latest Instagram Posts block: stop showing cached galleries after the Instagram connection has been deleted.
- Likes: resolve a potential PHP notice.
- Media Tools: resolve potential PHP notice.
- OpenTable block: ensure additional CSS classes are populated correctly.
- Subscriptions block: Stop saving localized attributes defaults in the block content.
- Tiled Gallery block: do not load the block when your site is not connected to WordPress.com.
- Twitter Cards: resolve potential PHP notice.

## 8.7.1 - 2020-07-14
### Bug fixes
- Autoloader: avoid PHP warning on sites with an invalid `active_plugins` option.
- Backwards Compatibility: Prevent fatal errors on themes relying on a deprecated static method.
- Blocks: show a loading spinner when unrolling Twitter threads on WordPress 5.3.
- General: prevent PHP notices with the Contact Form feature, Sharing feature, and the Latest Instagram Galleries block.
- Sharing: create proper Open Graph Description tag when a post starts with an image.

## [8.7] - 2020-07-07
### Major Enhancements
- When inserting images into your posts, you can now choose images from your Google Photos account, or from the Pexels Free Photos library.
- WhatsApp block: this new block adds a button so your site's visitors can contact you via WhatsApp with the tap of a button.
- You can now import Twitter threads into a post with the click of a button.
- Jetpack Search now includes more options to customize the look of the Search overlay: you can choose between minimal and expanded results, you can hide the Sort option, or change the default sorting option.
- Jetpack Ads: you can now enable a "Do Not Sell My Personal Information" link as specified in the California Consumer Privacy Act (CCPA) for California site visitors to opt-out of targeted advertising.

### Enhancements
- Blocks: add more options to customize the look of the Payments block.
- Blocks: allowing playing a Jetpack video in the block editor.
- Blocks: add episode link and improve the look of the Podcast player when displaying only one episode.
- Blocks: add more customization options to the buttons offered by the following blocks: Calendly, Mailchimp, Eventbrite.
- Blocks: rename "Earn" blocks: "Simple Payments" becomes "Pay with Paypal"; "Recurring Payments" becomes "Payments".
- Connection Flow: improve the display of connection errors when a site cannot be connected to WordPress.com.
- Contact Form: improve the "Empty Spam" process to better handle large amount of Spam.
- Jetpack Search: use the full width of the browser when the site does not use any Jetpack Search Sidebar.
- Performance: switch from JavaScript library to CSS animations to display loading spinners.
- Related Posts: improve accessibility of the titles of each Related Post.
- Site Stats: improve accessibility of the Stats dashboard.
- Social Logos: update Facebook Logo design.
- Widgets: improve accessibility of the Contact Info Widget as well as the Blog Stats Widget.
- Widgets: improve performance of the Display Posts widget by fetching less data.

### Improved compatibility
- Autoloader: improve the way Jetpack librairies are loaded when used in multiple plugins.
- Blocks: improve the display of the Tiled Gallery block when used with the AMP plugin.
- Custom Content Types: ensure that the Comic Post Type is compatible with the AMP plugin.
- Custom Content Types: allow third-party themes to enqueue their own Portfolio styles.
- Gravatar Hovercards: avoid validation errors when used with the AMP plugin.
- Open Graph Meta Tags: avoid displaying Jetpack's Tags when the Rank Math plugin is active.
- Shortcodes / Embeds: ensure better compatibility of multiple embeds with the AMP plugin.
- Sharing: ensure that all button styles can be used with the AMP plugin.
- Sitemaps: avoid conflicts with the Sitemap option that will be available in the upcoming version of WordPress.
- WordPress.com Toolbar: ensure it is accessible when using the Twenty Twenty theme.
- WooCommerce: avoid broken resources when using the WooCommerce plugin alongside Jetpack.

### Bug fixes
- Blocks: avoid layout issues when using the Image Compare block alongside older themes.
- Blocks: ensure the Eventbrite button can be centered.
- Blocks: ensure the Podcast block can be loaded when the page is loaded via Infinite Scroll.
- Blocks: do not render the Slideshow block's markup when no images have been added to the block.
- Blocks: avoid errors when one adds and edits 2 Image Compare Blocks in a single post.
- Blocks: fix Form block issues with checkbox fields not being checked by default when the option is selected.
- Blocks: add missing "Required" option to the Form block's Checkbox field settings.
- Blocks: avoid caching results from the Latest Instagram Posts block when there are errors with the fetched data.
- Forms: improve accessibility of the "Required" text used in form fields.
- Image CDN: avoid using CDN image URL when inserting an image using the image block.
- Jetpack Search: load translations in the Search overlay on International sites.
- Publicize: avoid layout issues when displaying broken connections in the Publicize block toolbar.
- Sharing: avoid relying on jQuery for the official Facebook button.
- Shortcodes / Embeds: fix the Twitch embed according to new Twitch embed requirements.
- SEO Tools / Open Graph: improve cleaning up of description meta tags.

## 8.6.1 - 2020-06-02
### Bug Fixes
- Resolves PHP notice when generating Twitter Cards for posts with images without saved size information.
- Resolves an issue that can lead to excessive SQL queries.

## [8.6] - 2020-06-02
### Major Enhancements
- Image Compare Block: show off your before / after pictures! This new block allows you to easily compare two images with a slider.
- Latest Instagram Posts Block: this new block allows you to insert lists of the latest posts from your Instagram feed, on any post or page of your site.

### Enhancements
- Blocks: add new RSVP, Registration, Appointment, and Feedback form options to the existing Form block.
- Blocks: add new width option to Form block fields.
- Blocks: add more customization options to the Subscriptions block.
- Blocks: use the Mailchimp logo for the Mailchimp block icon.
- Blocks: add Schema.org metadata to the Star Rating block.
- Blocks: add alignment options to the Revue block's button.
- Blocks: add an example usage of the Podcast Player Block.
- Carousel: new option to remove the Comment form area from the Carousel view.
- Connection Flow: add new tools allowing for a better Jetpack onboarding for new Jetpack site owners.
- Connection Flow: ensure connection can happen on sites that can be a bit slower.
- Dashboard: add new sections for the upcoming Scan feature.
- Dashboard: allow for easy copying of Sitemap URLs from within the dashboard.
- Infinite Scroll: add support for running inline scripts.
- Performance: improve autoloading of Jetpack options.
- Twitter Cards: use additional post-specific media for Twitter card tags.
- Synchronization: new experimental feature aiming to minimize the impact of Sync on servers, by having Synchronization actions processed by WordPress.com asynchronously.
- WordPress.com Toolbar: remove retired "Recommendations" link.
- WordPress.com Block Editor: offer an option to "Switch to Classic Editor".

### Improved compatibility
- Blocks: ensure that the Video block can still be used to upload videos with the latest version of the Gutenberg plugin.
- Connection tools: ensure better compatibility with other plugins that may rely on a Jetpack connection.
- Contact Form: improve compatibility with the Akismet service.
- Google Analytics: ensure compatibility with the AMP plugin.
- Shortcodes & Embeds: ensure that the slideshow and TED shortcodes are compatible with the AMP plugin.
- SSO: allow third-party plugins to hook into Jetpack's Secure Sign On login form.
- Widgets: ensure that the Cookies & Consent widget is compatible with the AMP plugin.
- WordPress.com REST API: improve compatibility with the block editor.

### Bug fixes
- Blocks: avoid layout issues with the OpenTable block's button.
- Blocks: fix SVG attributes naming.
- Blocks: fix infinite scroll compatibility.
- Blocks: improve the display of currencies in Recurring Payments block.
- Blocks: ensure Podcast Player icons are always visible, even on sites where WordPress lives in a subdirectory.
- Dashboard: avoid broken profile image in the Jetpack Dashboard.
- Embeds: stop using deprecated WordPress option.
- Embeds: ensure that all valid Spotify embeds are being rendered.
- Infinite Scroll: fix issues with sites that may customize post queries.
- Related posts: avoid making requests for Related posts in embedded posts.
- Search: fix issues with the Instant Search layout when the number of posts per page is set to more than 20.
- Site Accelerator: avoid breaking links when linking to Wikimedia images.
- Site Health Tools: correct issue that prevented the WordPress Site Health area from completing all checks.
- Synchronization: ensure data is properly handled when customizing the Sync experience.
- Theme Tools: add correct schema.org value for Jetpack Breadcrumbs.

## [8.5] - 2020-05-05
### Major Enhancements
- Podcast Player: you can now embed and play recent podcast episodes in any post or page.

### Enhancements
- Comments: update how comment types are stored to be fully compatible with upcoming WordPress Core changes.
- OpenTable Block: add a warning notice when their selected combination of style and align options may cause display issues.
- Publicize: allow site owners to set a filter to enable embedding media directly into Twitter embeds.
- Revue Block: add new customization options.
- Search: add new option to configure the Instant Search overlay.
- Sync: improve performance of the synchronization process on sites with plugins generating an important amount of posts.

### Improved compatibility
- Ad Block: ensure full compatibility of the feature with the AMP plugin.
- Carousel: ensure full compatibility of the feature with the AMP plugin.
- Embeds: ensure that all recipes, as well as Google Maps embeds and Scribd embeds, can be viewed with no errors in AMP views.
- General: when using a beta version of Jetpack via the Jetpack Beta Plugin, allow Multisite connections to be managed in Network Admin.
- Shortcodes: improve behavior of the Archives shortcode in AMP views.
- Widgets: ensure that the Twitter Timeline and Internet Defense League widgets are compatible with the AMP plugin.

### Bug fixes
- Dashboard: fix layout issue when using the monthly / yearly toggle in the Jetpack dashboard.
- Contact Form: avoid making unnecessary requests to the Akismet API.
- Crowdsignal: fix survey embeds when posts are loaded via Infinite Scroll.
- Embeds: provide helpful feedback when inline PDFs cannot be displayed in mobile browsers.
- General: fix comment notification overrides that direct moderation links to the WordPress.com interface.
- General: improve deprecated hook notices to handle anonymous functions.
- Site Health Tools: reduce false positives in Jetpack connection tests.
- Slideshow Block: avoid layout issues when a block is added to a column block.
- Subscriptions Block: fix layout issue in email input box.
- Sync: improve performance of the synchronization process when processing a large amount of Akismet feedback.

## 8.4.2 - 2020-04-14
### Bug Fixes
- General: avoid conflicts with other plugins interacting with the AMP plugin and the admin bar.
- Infinite Scroll: avoid breaking functionality on sites without any footer.
- Infinite Scroll: avoid any conflict that may cause some posts to be missing from Infinite Scroll load.
- Site Health Tools: improve messaging to make translations easier.
- Contact Info Widget: avoid the display of notices in the widget settings when an API key is set via a filter.
- Top Posts Widget: provide default for newly added parameter to avoid errors when using third-party plugins interacting with stats.

## 8.4.1 - 2020-04-07
### Bug Fixes
- Secure Sign On: fix conflict that would block one from logging in to their site via the Secure Sign On option.

## [8.4] - 2020-04-07
### Major Enhancements
- Search: our new Instant search experience will allow your visitors to get search results as soon as they start typing.

### Enhancements
- Autoloader: improve performance when loading a large number of files.
- Blocks: improve discoverability of multiple blocks by reviewing keywords used in the block search.
- Blocks: improve the display of error notices in Jetpack's embed blocks.
- Blocks: better differentiate paid blocks from free ones.
- Blocks: improve layout of block style previews.
- Calendly block: display an error when the embed URL is not found.
- Comment Likes: improve performance by removing dependency on Noticons.
- Contact Info Widget: improve the display of Map API key notices.
- Custom CSS: add support for more CSS 3.0 properties: mask , scroll, and object-fit.
- Dashboard notices: allow the use of different Jetpack logos.
- Embeds: enable inline PDF previews.
- Eventbrite Block: offer additional alignment options.
- Facebook Embeds and Facebook Page Plugin Widget: improve performance and compatibility with caching plugins.
- Facebook Page Plugin Widget: add new layout options (Cover Photo and Call To Action).
- Gravatar Hovercards: avoid loading Gravatar assets when not needed on the page.
- Gravatar Hovercards: improve performance of the feature by avoiding the use of jQuery.
- Infinite Scroll: improve performance of the feature by avoiding the use of jQuery.
- Jetpack Videos: improve performance of Video queries with better caching.
- Lazy Images: improve performance of the feature by avoiding the use of jQuery.
- Likes: improve performance when loading resources used by the Likes feature on the front-end of your site.
- Map Block: slightly decrease Zoom on maps with multiple points.
- Map Block: improve the look of the map style picker.
- Protect: improve detection of IP on servers using custom IP Headers.
- Revue Block: update the layout of the default placeholder appearing when you first insert the block.
- Site Health: add new card informing you of your site's synchronization status with WordPress.com.
- Social Menus: add Ravelry support.
- Widgets: add Ravelry support to Social Icons widget.
- Widgets: improve performance of the Search and Milestone widgets.
- WooCommerce Analytics: add additional information to events (plugin version, information about blocks and shortcodes).
- WordAds Block: update "hide on mobile" toggle layout.
- WordAds: update ad loader support for Google Chrome.
- WordAds: improve performance of the display of all ads.
- WordPress.com Toolbar: log user out of WordPress.com when attempting to log out from the site.

### Improved compatibility
- Blocks: ensure that all blocks are displayed nicely, even when using the latest version of the Gutenberg plugin.
- Blocks on International sites: ensure that blocks can be translated when using Jetpack's Site Accelerator feature.
- Comment Likes / AMP Plugin: avoid loading Likes on AMP views.
- General: Jetpack now requires WordPress 5.3 and newer.
- Multisite Networks: better detect the main site of a network when synchronizing data with WordPress.com.
- Recurring Payments Block: implement AMP view for full compatibility with the AMP plugin.

### Bug fixes
- Connection: ensure that the "Disconnect" button is easily accessible on mobile.
- Connection: fix connection issues for sites with a plan in a "pending" state.
- Connection: improve connection flow when starting to connect your site from the WordPress.com dashboard.
- Dashboard: clarify wording and display of the Backup & Scan cards.
- Dashboard: fix layout issues within the Stats Widget in the dashboard.
- Form Block: fix button colors not saving correctly.
- Google Calendar Block: ensure calendars are properly displayed regardless of the width option picked in block styles.
- Publicize Block: update wording in custom message field to clarify how the feature works.
- Pinterest Block: check for valid Pinterest URLs when embedding them into a new block.
- OpenTable Block: fix layout issue when using Wide and Full-width sizes.
- OpenTable Block: fix PHP warning occuring when a block is created but not configured.
- Recurring Payments Block: ensure that the minimum payment option respects the chosen currency for the button.
- Shortcodes: Fix Crowdsignal poll embeds when using the P2 theme.
- Simple Payments Block: avoid issues when pasting email addresses into the email field.
- Site Logo: avoid PHP notices in the Customizer, when no logo is set yet.
- Widgets: fix conflicts between some themes and the live countdown feature in the Milestone Widget.
- Widgets: avoid display issues in the Top Posts Widget, when displaying posts from Custom Post Types.

## [8.3] - 2020-03-03
### Major Enhancements
- Google Calendar Block: a simple way to embed Google Calendars into your posts.
- Revue Block: allow your readers to subscribe to your Revue newsletter right from your site.

### Enhancements
- Dashboard widget: clarify wording in Anti-spam and Protect sections.
- Dashboard notices: allow permanent notices.
- Dashboard notices: add option to provide action button for a notice.
- Map block: add the ability to set the size of the map.
- Map block: add a zoom control to the block sidebar.
- Map block: add a fullscreen option.
- Map block: add an option for toggling zoom to scroll behaviour in the published post.
- Mobile Theme: sunset feature. We originally created the mobile theme feature as a fall-back when the regular theme did not include a mobile view. Most themes include a mobile view by default now, so the feature is no longer necessary.
- OpenTable block: offer more embedding options.
- Search: improvements to layout options when using the Search widget.
- Security Scanning tool: improve message about threats found in dashboard.
- Sharing: improve Open Graph Meta Tags on search result pages.
- Shortcodes: improve accessibility of navigation buttons for the Slideshow shortcode.
- Site Health Tests: improve ability to add additional tests.
- Site Health Tests: Update Connection test with detailed descriptions and actions to resolve failing tests.
- Synchronization: increase reliability of sync by not sending wp-rest-api-log posts.
- Synchronization: increase reliability when synchronizing term IDs.
- Tiled Gallery block: add a Rounded Corners option.
- Tiled Gallery block: add an option to easily rearrange images within a gallery.
- Cookies & Consents Banner widget: improve performance by removing reliance on jQuery.
- Twitter widget: remove deprecated link color parameter.

### Improved compatibility
- Autoloader: avoid conflicts when other plugins rely on the Autoloader to load Jetpack packages.
- Beautiful Math: avoid layout issues with inline images when using the Twenty Twenty theme.
- Blocks: improve compatibility with theme colors for block buttons.
- Blocks: improve the layout of the blocks' placeholders when using the Gutenberg plugin.
- Blocks: allow defining a minimum WordPress version or minimum Gutenberg plugin version when registering a block.
- Lazy Images: add option to skip images with the `data-skip-lazy` attribute.
- SSO: Add error argument for compatibility with a WordPress 5.4 hook change.

### Bug fixes
- Blocks: fix layout issues with previews in block sidebar.
- Blocks: fix layout issues when using a custom CSS class for a block using the option in the block sidebar.
- Calendly block: fix overlay to render properly in the editor.
- Dashboard: remove Backups information from the Jetpack dashboard when on a Multisite network. Those do not support the Backup feature at this point.
- Map block: only show the Add Marker UI if there are no markers.
- Map block: prevent an unselected block from accidentally capturing scrolling.
- Map block: fix the styling of the map theme buttons.
- Mobile Apps: remove the edit post link when in app.
- OpenTable block: avoid error when inserting some specific embed codes.
- OpenTable block: fix alignment issues when center-aligning the block.
- Secure Sign On: do not display feature message when logging in to WordPress.com's central dashboard.
- Stats: hide Stats smiley in post embeds.
- WooCommerce Analytics: improve product checks to avoid errors on order pages.
- Wufoo shortcode: Security fix return early when invalid parameters.

## 8.2.3 - 2020-02-20

- General: fix compatibility issues with other plugins relying on the REST API to communicate with Jetpack, or on the Jetpack registration process.
- Multisite: resolve issue with Jetpack's loading sequence that would fatal subsites that did not have any individually activated plugins.

## 8.2.1 - 2020-02-17
### Bug fixes
- Block Editor: avoid errors when uploading additional media to the Slideshow, Tiled Gallery, and Video blocks.
- Synchronization: address issues that would cause delayed synchronization of your posts to WordPress.com.

## [8.2] - 2020-02-11
### Major Enhancements
- Calendly Block: a useful tool for all coaches, consultants, therapistsâ€¦ Add the block to a post or page and anyone can then book appointments, meetings, and classes right from your website.
- EventBrite Block: allow your visitors to register to events right from your site with this new block.
- OpenTable Block: restaurant owners, you can now add a reservation form to your site to make it easy for anyone to book a table online, via your site.

### Enhancements
- Contact Form: add IP and Feedback date to data that can be exported via the CSV tool.
- Dashboard: display a notice when a site uses conflicting plans.
- Map Block: improve the calculation and persistence of maps' center points.
- Map Block: improve the generation of an access token on WordPress.com sites.
- Map Block: update Mapbox GL library to opt into map load based billing.
- Shortcodes: add new Vimeo shortcode format.
- Subscriptions: display a clear error message when you try to subscribe to a site where you've already subscribed but did not validate your subscription.
- Subscriptions: display a clear message when an email having many pending confirmations tries to subscribe to a site.
- Synchronization: improve performance of data synchronization with WordPress.com.

### Improved compatibility
- Connnection Flow: ongoing work to improve the reliability of the connection between your site and WordPress.com.
- Connection Flow: improve detection of hosting environments for better communication with WordPress.com.
- General: avoid any login issues when using other plugins that may interact with cookies on your site.
- Gutenberg: avoid any layout issues that may appear in the block editor when using the latest version of the Gutenberg plugin.
- Related Posts: ensure that any filters customizing the display of Related Posts also apply to posts displayed with the AMP plugin.
- Sharing: do not output Jetpack's Open Graph Meta Tags if the Complete Open Graph plugin is present on your site.

### Bug fixes
- Blocks / Dashboard: ensure that blocks as well as Jetpack's dashboard can be used even in older browsers such as Internet Explorer 11.
- Contact Info Block: ensure that Google's Structured Data tool can recognize phone numbers added to the block.
- Copy Post: ensure correct sharing and like settings are copied when posts are duplicated.
- Subscriptions: maintain email subscription settings when deactivating and reactivating the feature.
- WordPress.com REST API: avoid PHP notices when a media file is edited via the API.
- WordPress.com REST API: ensure that image URLs are currently set when uploading an image multiple times.

## [8.1.1] - 2020-01-23
### Bug fixes
- Dashboard: ensure that connection issues with WordPress.com are displayed in the Jetpack dashboard.
- Block Editor: ensure that the Jetpack block sidebar icon is properly displayed, even with the latest version of the Gutenberg plugin.
- WordPress.com Block Editor: fix compatibility issues with Chrome's upcoming cross-site cookie changes.

## [8.1] - 2020-01-14
### Enhancements
- Dashboard: preload connection flow script to improve performance.
- Dashboard: improvements to backup interface.
- Mobile Theme: allow one to temporary disable Jetpack's Mobile Theme for testing.
- Mobile Theme: disable settings when feature is inactive.
- Site Accelerator: disable a helper library by default and allow themes to enable it when required.
- Subscriptions: add a wp-admin setting to alert the admin when someone follows the blog.
- WordPress.com REST API: add flag to determine site eligibility for Full Site Editing.
- WordPress.com synchronization: improve the reliability of the synchronization events triggered to keep your site up to date with WordPress.com.
- WordPress.com Toolbar: update the link directing to the WordPress.com Reader.
- WordPress.com Toolbar: add "My Home" link to the toolbar.

### Improved compatibility
- General: improvements to Coding Standards for plugin compatibility files.
- Notifications: avoid conflicts with Twenty Twenty's instrinsic video resizes.
- PHP 7.4: fix PHP warnings that may appear on sites running PHP 7.4.
- Sharing: avoid errors when using the Thrive Architect plugin.
- Tiled Galleries: fix layout when using a gallery inside a Classic block with the Twenty Twenty theme.
- Twenty Twenty: improve the display of the Authors and Flickr widget.
- Twenty Twenty: add Content Options to the Customizer.
- Twenty Twenty: ensure that Infinite Scroll does not suppress the display of footer widgets.
- Videos: automatically convert old Flash Jetpack Video embeds so they can use the new player.
- WooCommerce Services: avoid issues when installing plugin from notification message.

### Bug fixes
- CLI: prevent a PHP notice when running some Jetpack CLI commands.
- Map Block: fix layout issue when selecting a marker in a map and then scrolling down.
- Map Block: avoid errors when adding more than 2 points on a map.
- REST API: correctly validate on/off values for booleans.
- Star Rating Block: translate block title.
- Widget Visibility: ensure that the visibility options always appear on old Widgets Options screen.
- WordAds: ensure that the ads.txt file created by the feature returns a correct HTTP response code.
- WordPress.com Block Editor: exclude WordPress.com features from Jetpack sites.

## [8.0] - 2019-12-03
### Major enhancements
- Block Editor: new Pinterest block allowing you to easily embed boards, profiles, and pins.
- Block Editor: new Ratings block allowing you to add star ratings any post or page.
- Mailchimp block: you can now create forms for a subset (group) of your Mailchimp list, and add a field to track which form the signups are coming from.

### Enhancements
- Blocks: start using the @wordpress/block-editor package introduced in WordPress 5.2.
- Contact Form: make the Form block reusable on a single post / page.
- Dashboard: add support for Jetpack Backup display.
- Image CDN: expand number of images using the new subdomain determination function.
- Recurring Payments block: improve display of buttons inside the block in the editor.
- Shortcodes: add new customization options and improve Schema.org markup of the Recipe shortcode.
- Shortcodes: add AMP views for 5 shortcodes: `vimeo`, `instagram`, `dailymotion`, `tweet`, and `soundcloud`.
- Support Tools: improve the reliability of the tools on slower sites.

### Improved compatibility
- AMP: improve display of the Map block on AMP views.
- General: As WordPress 5.3 is now available, Jetpack now requires WordPress 5.2.
- Shortcodes: ensure Vimeo videos can be displayed properly when using the AMP plugin.

### Bug fixes
- Connection: fix communication between Jetpack sites and WordPress.com for some sites hosted on non-standard ports.
- Connection management: fix issue that prevented the Connection transfer banner from appearing in some situations.
- Feature Hints: disable when plugins cannot be installed on site.
- Image CDN: avoid blurry images when using Jetpack's Image CDN alongside other image-focussed blocks.
- SEO Tools: do not display any HTML tags in title meta tags.
- Sharing: improve accessibility of the sharing buttons by updating the buttons' color.
- Sync: avoid conflicts when two processes are synchronized to WordPress.com at the same time.
- WordPress.com Block Editor: ensure that the Justify button works well on any paragraph using that button.

## [7.9.1] - 2019-11-19
### Bug fixes
- Security: fix vulnerability in the way Jetpack processes embed codes.
- Verification Tools: avoid PHP warnings when using plugins to modify the WordPress admin menu.
- Widgets: ensure opening hours can be displayed properly in the Contact Info Widget.

### Improved compatibility
- Twenty Twenty: ensure that Related Posts and Jetpack Blocks are displayed nicely in the new default theme.

## [7.9] - 2019-11-05
### Major enhancements
- Block Editor: allow authors to upload videos to our Jetpack Videos service from the Video Block.
- Block Editor: add new post-submission settings to the Form block.
- Twenty Twenty: Ensure full compatibility with the upcoming default theme.

### Enhancements
- Admin Page: update icons for security settings.
- Backup: support for Jetpack Backup functionality with simpler configuration.
- Block Editor: provide block previews for Jetpack blocks.
- Block Editor: add image size option to the Slideshow block.
- Block Editor: improve the display of opening hours when using the Business Hours block.
- CLI: no longer return exit code 1 if trying to disconnect a site that's already disconnected.
- Connection flow: update connect buttons on main dashboard page and plugins page to use the new connection flow.
- Connection flow: add plan billing period toggle.
- Contact Form: synchronize form data with WordPress.com when submitting a form via the Form block.
- Dashboard: update styles for visual parity with the WordPress.com dashboard.
- Dashboard: improve performance of the Jetpack dashboard when the plugin is not connected to WordPress.com yet.
- Dashboard: add new plans' information to Plans pages.
- Dashboard: update design to better integrate with the updated design of the WordPress dashboard in WordPress 5.3.
- Dashboard: improve experience for site owners looking to disconnect their site from WordPress.com.
- Debug: provide additional information in Tools > Site Health when a site's connection to WordPress.com is broken.
- Performance: modernize various parts of the code to use PHP 5.6+ functionality.
- Progressive Web Apps: sunset feature. If you wish to continue to use that feature on your site, we recommend installing another plugin that offers the functionality you need.
- Related Posts: remove nofollow attribute from links.
- Related Posts: add Posts to the REST API response for all post types that support them.
- Search: add new filter allowing one to adjuct Jetpack Search's ES query languages.
- Search: continued work on upcoming Instant Search features.
- Shortcodes: add support for tab sizing to Gist shortcodes and embeds.
- Social Networks: update Facebook logo to match new color.
- Sync: improve reliability of the information synchronized back to your site when connecting to WordPress.com.
- Tiled Galleries: ensure that color profile information is retained for all images in Tiled Galleries.
- Widgets: add aria-current attribute to links when on same page.
- WordAds: improve speed & resource use of Ads' loading scripts.

### Improved compatibility
- AMP: ensure that one can use the Slideshow and the MailChimp blocks when using the AMP plugin.
- AMP: support the new Dev mode for Notifications and Stats features.
- Admin Page: improve compatibility with themes and plugins that insert CSS in the dashboard.
- Blocks: ensure that all blocks display well in the editor when using WordPress 5.3.
- Carousel: ensure that the feature works with the new gallery markup introduced in WordPress 5.3.
- Dashboard Notices: ensure that all notices redirect to the right page, including on WooCommerce dashboard pages.
- General: use new functionality available in WordPress 5.3.
- PHP: resolve deprecation warnings in anticipation of PHP 7.4.
- Related Posts: avoid conflicts with other plugins adding elements below the post content, especially when the AMP plugin is active on the site.
- SSO: ensure that the Secure Sign In Form is displayed properly when using WordPress 5.3.
- Widgets: update deprecated option in the Facebook Page Plugin widget.
- WordPress.com REST API: ensure compatibility with WordPress 5.3.

### Bug fixes
- Admin Page: remove Jetpack dashboard link for registered users (non admins) when the site is not connected to WordPress.com.
- Admin Page: translate empty Stats chart's message.
- Admin Page: change default settings tab depending on your role.
- Admin Page: do not display Composing header for editors.
- Block Editor: ensure that the Ad block is compatible with dark themes.
- Contact Form: revise the email validation function to include length limit.
- Debug: reduce instances when an inconclusive response would result in an error.
- Geo-Location: fix spacing for RSS geo-location namespaces.
- Image CDN: remove wp-dom-ready dependency to improve performance on the frontend.
- Search: add hooks for when Search falls back to using the local database.
- Site Logo: ensure that the right stylesheet is loaded depending on your site's language.
- Site Verification Tools: ensure that you can connect your site to Google Search Console even when Publicize is disabled.
- Sync: prevent a PHP Notice in some cases where a post isn't actually a post.
- Widgets: ensure that the Google Maps API key in the Contact Info widget can be set to only work on your domain.
- Widgets: fix timeout issues that may sometimes occur in the GoodReads widget when user has added lots of books to their account.
- WordPress.com REST API: better site preview support for sites using WordPress in a subdirectory.

## [7.8] - 2019-10-01
### Enhancements
- Connection flow: remove some of the text from the connection prompt.
- Dashboard: remove custom About menu page ordering.
- Dashboard: review and remove unnecessary queries.
- General: remove files that were deprecated in Jetpack 7.5.
- General: remove outdated pre-PHP 5.6 era code.
- Image CDN: check for local file upload before processing post images.
- Markdown Block: display in the block picker even if the classic Markdown feature is disabled.
- Recurring Payments: add an alignment option to the button.
- Recurring Payments: improve the display of connection notifications.
- Tiled Galleries: the block is now available even if you've disable the "Image Accelerator" feature.
- WordPress.com REST API: improve detection of the Full Site Editing feature.

### Improved compatibility
- AMP / Sharing: include Open Graph metadata to AMP Story posts.
- General: avoid conflicts when using Jetpack alongside other plugins or services that rely on an Autoloader.

### Bug fixes
- Activity Log: avoid displaying events from the Action Scheduler.
- Ads Block: avoid PHP errors when loading posts via the WordPress.com interface.
- Blocks: ensure that all blocks are properly translated when a translation is available.
- Dashboard: do not display Plans page to non-connected admins.
- Post Images: look for representative images in inner blocks as well.
- Shortcodes: add title attribute to Archive.org and Archive.org Book embeds.
- Sync: avoid issues when using deprecated Sync functions.
- WordPress.com dashboard styles: fix layout on Plugins > Add New Page, on mobile devices.

## 7.7.2 - 2019-09-23
### Bug fixes
- General: fix connection issues when attempting to install and connect Jetpack from a mobile app.

## 7.7.1 - 2019-09-06
### Bug fixes
- Connection Flow: avoid any errors linked to browser cookie policies during connection request.
- General: additional check to avoid warnings on plugin update.
- SSO: avoid Fatal errors happening during some log in attempts.
- Sync: check if IXR client exists to prevent errors when updating the plugin.

## [7.7] - 2019-09-03
### Major Enhancements
- This release brings in multiple improvements to the WordPress.com connection process, to fix issues site owners may experience when first connecting their site to WordPress.com.

### Enhancements
- Anti-spam: improve the flow to configure Akismet from Jetpack's Dashboard.
- Blocks: add new utility to get all CSS classes for a given block.
- Bruteforce Login Protection: improve Network Activation detection on Multisite networks.
- Dashboard: update all illustrations to use new color scheme.
- General: log XML-RPC communication errors between the site and WordPress.com.
- General: use HTTPS URLs when linking to external sites when possible.
- General: warn admins when about to delete another admin user that happens to be the main Jetpack admin on the site.
- Sharing / Publicize: add Open Graph Meta Tags to archive pages.
- Sitemaps: reduce sitemap cache duration when using Jetpack's Development mode.
- Social menus: replace the outdated Medium icon with updated logo.
- Stats: improve method used to enqueue JavaScript when the feature is active.
- Videos: Add video settings to Jetpack's enhanced video block.
- Widgets: improve the creation process and display of maps inside the Contact Info Widget.
- Widgets: add more RSS feed patterns to the Social Icons Widget.
- Widgets: add new `jetpack_widget_authors_params` filter to the Authors widget, to allow site owners to customize the list of authors.
- WordPress.com API: add option to manage Full Site Editing.
- WordPress.com Interface: allow language to be changed even if `WPLANG` constant is defined.
- WooCommerce Analytics: use core WordPress function to enqueue script asynchronously.

### Improved compatibility
- Ads: make sure the Ad block generates ads that are compatible with the AMP plugin.
- Image CDN: update the size of images used in AMP Stories when using the AMP plugin.
- Responsive Videos: improve compatibility and avoid validation errors when using the AMP plugin.
- WordPress.com API: avoid errors when used in combination with the Polylang plugin.
- WordPress.com API: improve compatibility with plugins that alter the behavior of search queries.

### Bug fixes
- Bruteforce Login Protection: fix the display of the admin notice displayed on Multisite networks.
- Contact Form: update the feedback post type capability to a valid value.
- Dashboard: improve the layout of the Connection modal on mobile devices.
- General: do not redirect during automatic upgrades.
- Image CDN: support the `medium_large` image sizes.
- Related Posts: ensure Related Posts can be displayed when using the AMP plugin and Jetpack's Sharing feature.
- Search: authenticated search requests will now display non-public content.
- Sitemaps: improve the display of descriptions in video sitemaps, when they include HTML content.
- Stats: load RTL stylesheet for dashboard widget, to fix layout issues on RTL language sites.
- WordPress.com API: fix API responses which contain malformed (non-UTF-8) data.
- WordPress.com Toolbar: limit access to Stats and Plan menu items.

## [7.6] - 2019-08-06
### Enhancements
- Backups: add ability to send SSH credentials.
- Blocks: allow the insertion and preview of any Jetpack block in the editor, even when the block is only available via a Paid plan.
- Carousel: use a pointer cursor when hovering over galleries that utilise the Carousel feature.
- Dashboard: improve the display of the feature cards in the main Jetpack dashboard.
- General: hide edit post link on your site when viewing it via the WordPress mobile app.
- oEmbeds: add support for Song.link service.
- Stats: improve performance of the Stats tracking pixel by eliminating blocking JavaScript.
- Stats: improve Cache performance by switching from the WordPress Options API to the WordPress Transient API.
- Support links: use the Beta support form when on a development version.
- Sync: add a term taxonomy blacklist option, and start blacklisting taxonomies that do not need to be synchronized with WordPress.com.
- Sync: improve reliability of the synchronization of taxonomies.
- Videos: ensure any deprecations added in the core video block are not overwritten.
- Widgets: allow the customization of avatar image options in the Top Posts Widget, via a filter.
- Widgets: add option to open Flickr gallery images in a new tab.
- WordPress.com Activity Log: avoid display issues with WooCommerce Product Reviews.

### Improved compatibility
- AMP: ensure CSS compatibility with the Sharing buttons.
- AMP: ensure full compatibility with Jetpack's Image CDN.
- Dashboard: fix layout issues when viewing the dashboard on WordPress.com Business sites.
- Compatibility suite for shared libraries: fix PHP notice when running suite.
- Contact Form: ensure the Date picker field does not cause any AMP validation errors.

### Bug fixes
- Admin Page: fix the behaviour of the Jetpack Videos button in the "My Plan" tab.
- Admin Page: fix a typo in the Magic Links modal.
- Connection process: bring back the ability to connect to WordPress.com via XML-RPC or REST API.
- Custom CSS: fix Media Width label layout issue in Firefox.
- Dashboard Notices: fix layout issues on sites using an RTL language.
- Sync: fix home and Site URL synchronization issues on sites with custom Cron implementations.
- WordPress.com Activity Log: add Action Scheduler to the list of blacklisted post types

## [7.5.3] - 2019-07-17
### Bug fixes
- General: Fixes plugin activation/deactivation hooks that were accidentally disabled.
- General: Fixes fatal errors that were possible when using pre-7.5 Jetpack internal API.

## [7.5.2] - 2019-07-04
### Bug fixes
- General: Fixes an error when a site's connection to WordPress.com is set to "Safe Mode".

## [7.5.1] - 2019-07-02
### Bug fixes
- General: Fixes an error when trying to delete the Jetpack plugin.
- General: Fixes supported PHP version declaration.

## [7.5] - 2019-07-02
### Enhancements
- Admin Page: add an option to send a magic link that will help you log in to the mobile apps in one click.
- Admin Page: improve style and wording of many different sections of the dashboard to clarify the role of each feature.
- Admin Page: remove feature that would offer you to activate a list of recommended features upon connecting your site to WordPress.com.
- Backups: include updates to term relationships when backing up Post object changes.
- Backups: synchronize ABSPATH value to help setting up SSH credentials when using Jetpack Backups.
- Faceboook Embeds: support new video URL format.
- Lazy Load: allow adding event handlers to images.
- Recurring Payments Block: improve the display of the block in the editor.
- WordAds: update link to daily earnings stats on WordPress.com.
- WordAds: provide additional details for custom ads.txt entries in the Jetpack dashboard.
- WordPress.com Toolbar: add colors to Recovery Mode button.

### Improved compatibility
- Admin Page: improve display of the Jetpack Dashboard in IE11.
- Sharing: avoid displaying extra list items below the sharing buttons when using the AMP plugin.
- Staging enviroments: add staging enviroment detection for DreamPress sites.

### Bug fixes
- Admin Page: fix display of backup details in the Jetpack dashboard.
- Admin Page: do not disable Widget Visibility and Widgets toggles in Development mode.
- Sitemaps: ensure links to sitemaps appear in robots.txt
- Slideshow Block: fix CSS class name.
- Videos: ensure that Video Poster images are always displayed properly.

## [7.4.1] - 2019-06-17
### Bug fix
- Contact Form Block: avoid errors when trying to edit a form block, when using the Gutenberg plugin.

## [7.4] - 2019-06-04
### Enhancements
- About Page: remove submenu and add link to page in the footer of Jetpack's dashboard.
- Admin Page: remove Themes card on Plans tab.
- Admin Page: consolidate the look of the different discussion settings.
- Admin Page: add Security Checklist information.
- Business Hours Block: improve the display of Business Hours.
- Business Hours Block: Simplify hours format.
- Comment Form: use HTTP 4xx status codes for comment errors.
- Contact Form Block: improve styles for better display on mobile devices.
- General: introduce a new Jetpack Logo package, to make it easier to share and re-use.
- Multisite: Use modern `wp_initialize_site` hook when automatically connecting new sites.
- Recurring Payments Block: automatically add button to the post content once you create it.
- Recurring Payments Block: improve the display of the renewal frequency in button list.
- Recurring Payments Block: require a paid plan to use the button.
- Recurring Payments Block: improve the look of the payment modal on mobile devices.
- Search: add new option for cross-site search permissions.
- Sharing: update default sharing settings to include buttons.
- Sitemaps: rename the `jetpack_sitemap_generate` and `jetpack_news_sitemap_generate` filters to the more accurate `jetpack_sitemap_include_in_robotstxt` and `jetpack_news_sitemap_include_in_robotstxt`.
- Slideshow Block: depending on viewport, display prev/next arrows.
- Slideshow Block: remove outline when focussing on the block.
- Sync: offer posts, comments, and comment meta checksums when providing sync status.
- Tiled Galleries: add `srcset` in the editor for an improved editing experience.
- WordPress.com Block Editor: allow managing reusable blocks in the WordPress.com interface.
- WordPress.com Toolbar: display hamburger icon in toolbar when in the block editor.
- WordPress.com Toolbar: display a link to exit recovery mode when it is active on the site.

### Improved compatibility
- Display Posts Widget: remove overly opinionated CSS.
- General: Jetpack now requires PHP 5.3.2, and will display a notice if your site uses an older version of PHP.
- General: display a notice and log an error if your version of WordPress is not supported by Jetpack.
- General: Update `Jetpack::get_content_width()` to ensure that only numeric values are used.
- GIF Block: improve compatibility with the AMP plugin.
- Shortcodes: bring more of our shortcodes to meet current WordPress Coding Standards to help us maintain these features in the future.
- Site Health: improve Jetpack errors' messaging in WordPress' new Site Health tools.

### Bug fixes
- Admin Page: make sure the Jetpack Dashboard is displayed properly in IE11.
- Admin Page: do not show Plugin Autoupdates card on admin searches.
- Carousel: avoid scrolling back to the top of the page when you close the Carousel view.
- Connect Flow: sanitize from parameter when building connection URL.
- Mobile Themes: fix "View Full Site" and "View Mobile Site" links when WordPress lives in a subdirectory.
- Recurring Payments Block: avoid invalid subscription amounts.
- Recurring Payments Block: allow line breaks in the payment button.
- Related Posts: do not add markup to attachment pages by default.
- SEO Tools: support taxonomy archive pages in page titles.
- Sharing: make sure the Whatsapp button works well in all browsers, including Firefox on desktop.
- Shortcodes: update embed type detection for Medium Collections.
- Social Icons SVG: switch to the presentation role for better accessibility.
- Subscriptions: display checkboxes above the comment submit button.
- Sync: add new WP Cli commands to help in monitoring and updating sync settings.
- Tracks: limit the length of the strings saved for feature searches.
- Unit Tests: add support for testing using VVV 3.0.
- Verification Tools: make sure the feature can be disabled by override.
- WooCommerce Analytics: remove duplicate self-executing anonymous function.
- WordPress.com Interface: make sure navigation menu items match the one available in the WordPress.com interface.
- WordPress.com Toolbar: restore the previous layout.
- WordPress.com Toolbar: ensure you are properly logged out of your WordPress.com account when you sign out of your site using the toolbar.
- WP Cli: ensure that WP Cli commands added by Jetpack include translator comments when necessary, to help with translations.

## [7.3.1] - 2019-05-14
### Bug fixes
- Admin Experience: Correct underline location under a dollar sign.
- Deprecated Hooks: Do not offer a replacement for jetpack_json_manage_api_enabled since there isn't an equal replacement.
- Debugger: Clarify labels in the Site Health Info section.
- Likes and Sharing: Remove duplicate control in the block editor for Likes/Sharing. We added a native block editor plugin, but left the old fallback.
- WordPress.com Editor: Redirect to a login page when logging out from the block editor on WordPress.com.
- WordPress.com Toolbar: Add menu icon for smaller screen widths to restore wp-admin navigation menu.

## [7.3] - 2019-05-07
### Major Enhancements
- We streamlined the default features of Jetpack to make the "out of the box" experience better.
- WordPress 5.2 will add a new Site Health section to your dashboard. Jetpack already integrates with it, letting you know that your Jetpack features are working!

### Enhancements
- Admin Experience: Improve our "just in time messages" and "Recommended Features" for new sites setting up Jetpack for the first time.
- Admin Experience: Add an "About Jetpack" page to let folks know more about Automattic, the company behind WordPress.com and Jetpack.
- Admin Experience: Add a link to the full list of Jetpack features in the footer of Jetpack dashboard pages.
- Backups: Add SSH CLI command for hosting integration support.
- Block Editor: Compose posts with the Block Editor posts via WordPress.com for their Jetpack sites!
- Block Editor: Transform core images to Tiled Galleries or Slideshow blocks and back!
- Block Editor: Provide an option to disable particular extensions.
- Contact Form: Add a "grunion_after_message_sent" hook for after a form submission is e-mailed. Thanks Tim Nolte for contributing to Jetpack!
- Contact Form: Do not prefill for administrators on their own sites.
- Grammar and Spelling: Remove from Jetpack. We've chekced the spelling alot over the years, but now time to retire.
- Membership Block: Add a new block behind the JETPACK_BETA_BLOCKS constant. Stay tuned!
- Photon: Remove jQuery dependency for photon.js. Same Image CDN awesomeness with less overhead.
- Portfolios: Remove the "Portfolio Items" description that would display on some themes.
- Sharing: Add a "sharing_ajax_action" to to allow other plugins and scripts to render sharing buttons. Thanks Darren Cooney!
- Social Icons: Add Stack Overflow support. Welcome to the Jetpack contributor ranks Muhammad Osama Arshad!
- Sync: Report details on what is queued up to sync on the status endpoint.
- Sync: Improve importer detection so we can better handle cases of imported content.
- Sync: Add an option to disable sync for an entire network.
- Sync: Adds new WP-CLI Jetpack Sync commands: settings, enable, disable, reset.
- Testimonials: Sort by menu order to give site owners more flexibility for display. Thanks Felipe Elia!
- Tiled Galleries: Add improved layout for when images are in the process of uploading.
- Tiled Galleries: Add responsive imaging (srcset) support to the Tiled Gallery block.
- WordAds: Add location id (e.g. under the post) to the ad calls.
- WordPress.com API: Add behind the scene improvements to support the WordPress.com site management experience.
- WordPress.com API: Add the public property to the Post Types endpoint response.
- WordPress.com Menu Bar: Redesign to direct navigation items to WordPress.com instead of duplicating experiences.

### Improved compatibility
- Blocks: Use the Editor's "BlockIcon" for native placeholder icons instead of custom CSS.
- Blocks: Drop i18n wrapper, use @wordpress/i18n directly. This means it will be easier and faster to provide translated bits of text.
- Blocks: Move block development to the Jetpack repo. You shouldn't see any changes, but this helps us make Jetpack Blocks better faster.
- Block Editor: Improve the experience of using the Block Editor via the WordPress.com dashboard.
- Browser Compatibility: Remove legacy code for Internet Explorer 10.
- Coding Standards: Update our code to match the latest WordPress coding standards in various places.
- Likes and Sharing: Add Likes and Sharing settings as a Block Editor extension.
- Related Posts: Improve the internationalization of the "in X category" text.
- Simple Payments: Easily convert old shortcode-style Simple Payment buttons to a block.

### Bug fixes
- Admin Dashboard: Improve headings when searching for Jetpack features.
- Admin Dashboard: Remove legacy views no longer used in Jetpack.
- Blocks: Fix some design oddities in Form and Contact Info blocks.
- Carousel: Allow any title to be displayed. We used to try to be smart about default file names, but that caused some problems.
- Development Mode: Display fewer sections of the Admin Dashboard. Some simply don't apply in Development Mode.
- Google Plus: Remove from Social Icons and Sharing since the service has retired.
- Internationalization: Translate various sections missed, such as "just in time messages" and block search keywords.
- Manage: Remove Manage as an independent module. These features have been fully integrated for a few versions now.
- Multisite: Restore ability to connect subsites via the Network Admin.
- Open Graph Tags: Prevent a PHP notice on some author pages.
- Sharing: Improve accessibility of sharing buttons by increasing contrast ratio. Props https://titan.as
- Sharing: Fix the alignment of the official buttons for LinkedIn and Pinterest.
- Shortcodes: Retire the Google Video, Jetpack Subscribe, and Digg shortcodes.
- Slideshow: Fix a JavaScript error that occurs when block is first added.
- Slideshow: Add slideshow images to Open Graph tags when using the Slideshow block.
- Social Icons: Remove Google+, uses the generic Google now.
- Subscriptions: Correct conflicts that were possible with the checkboxes after a comment submission form.
- Theme Tools: Ensure Featured Content tag is retained on a post after saving. Thanks Anis Ladram, you're a Jetpack contributor now!
- Uninstalling Jetpack: Prevent notice about JETPACK__PLUGIN_DIR already being defined when programmatically uninstalling Jetpack. (But why would you uninstall?)
- Widgets: Remove the Cookies & Consents Banner (not just hide it) after consenting. Thanks Tony Tettinger!

## [7.2.1] - 2019-04-04

- Feature Hints: display suggestions only for features available under the site's current plan.
- Feature Hints: improve visual display to make more distinct from search results.
- Feature Hints: disable hints once administrators have dismissed three hints.
- Slideshow Block: resolve an issue that broke navigating between images.

## [7.2] - 2019-04-02
### Major Enhancements
- Adds a Repeat Visitor block that controls block visibility based on how often a visitor has viewed the page.
- New option to disable Ads blocks for visitors on mobile devices.

### Enhancements
- Admin Dashboard: improve text and design to make your administration experience all the better.
- Jumpstart: streamline what features are suggested to be activated when setting up Jetpack for the first time.
- Password Checker: adds a password checker class that will help Jetpack let you know if you're using a weak password. More about this coming in a future release!
- Plans: refactor how Jetpack Plans are coded within Jetpack to improve performance and help prevent any future bugs.
- Post Images: provide the image itself when requesting an attachment's post image.
- REST API: Enable Likes and Sharing meta field for all post types.
- Related Posts: improve HTML markup for related posts, with emphasis on accessibility.
- Search: add an easy way to see the raw Jetpack Search query results in the search page's source code.
- Shortcodes: allow links in Quiz shortcode explanations.
- Widgets: improve the text for the Blog Stats widget when stats data can not be retrieved from WordPress.com.

### Improved compatibility
- General: require WordPress 5.0! To celebrate, we cleaned out some compatibility code that supported older versions. We know how to party.
- General: update various parts of Jetpack to fully align with WordPress coding standards to make developing Jetpack easier!
- Connection: notify site owners when a plugin or theme is double-encoding URL redirects.
- Shortcodes: update the Ustream shortcode to use the HTML5 player for a better experience on all browsers.
- Shortcodes: add AMP support for Crowdsignal polls and shortcodes.
- Sitemaps: add thumbnails to video sitemaps to improve compatibility with Google Search Console. Props Adam Heckler!
- Sync: improve performance when using the VIP Legacy Redirect plugin.
- Twenty Nineteen Compatibility: prevent sharing buttons overlapping with the Like button. Props Torres!
- VideoPress: update right-to-left language CSS to remove extra styles only used on browsers no longer supported.
- Widgets: improve rendering of Contact Info widget map when using the AMP plugin.

### Bug fixes
- Admin Dashboard: fix an error that you'd see in the console when changing your Carousel settings.
- Blocks: fix an issue where sometimes we would attempt to register a particular block twice. I'm looking at you, Related Posts.
- Blocks: display all Business Hours details, even if they're the default set.
- Blocks: fix an error that occurred when loading some translations in the Block Editor.
- Blocks: resolve a conflict between the Ads block and infinite scroll that would cause new posts to sometimes not load.
- General: ensure the proper Jetpack plan is reflected throughout Jetpack and the administrative dashboard.
- Plugin Search: display Akismet and VaultPress plugin cards when WordPress.org suggests them.
- Publicize: remove unused assets, like images and JavaScript that aren't needed anymore.
- Related Posts: restore use of the jetpack_relatedposts_filter_options filter.
- Security: Improvements to the Likes feature and the Slideshow block.
- Sharing: update WhatsApp to be more consistent with the other sharing buttons.
- Shortcodes: remove Lytro service, which closed in March.
- Stats: properly handle an error from the REST API that sometimes caused issues with the Stats Dashboard.
- Widgets: display all characters in an address from Contact Info correctly when sometimes we encoded those that we'd expect in an URL.
- Widgets: improve the performance of the Contact Info widget by eliminating unused JavaScript.

## [7.1.1] - 2019-03-06
### Bug fixes
- General: avoid conflicting with other plugins when suggesting Jetpack features on the Plugins screen.
- Publicize: avoid errors when the feature is not active on a site.
- Widgets: improve performance of the Top Posts and the Blog Stats widgets on high-traffic sites.
- Subscriptions: fix an issue that prevented displaying subscribers count in the subscription forms.
- Tiled Galleries / Slideshows: ensure they can be displayed properly in Internet Explorer 11.

## [7.1] - 2019-03-05
### Major Enhancements
- Block Editor: this release introduces 6 new blocks:
  - the Ads block allows you to insert different ads from [our WordAds program](https://jetpack.com/support/ads/) within your posts and pages.
  - the Mailchimp block allows your readers to easily subscribe to your Mailchimp newsletter.
  - the Video block supports VideoPress videos if you've purchased our Premium or Professional plan.
  - the Slideshow block allows you to insert beautiful slideshows in your posts and pages.
  - The Business Hours blocks is useful for companies who want to display their business's Opening Hours on their site.
  - The Contact Info block is useful for any business who may want to display useful information on a post or page.

### Enhancements
- Admin Page: move Carousel settings from Performance to Writing section.
- Ads: include search results pages under the `Archive` toggle.
- Block Editor: improve block registration structure for better management of block availability.
- General: remove IE8 support fallbacks.
- General: add feature suggestions to the plugin search screen.
- Image CDN: add new mode that disables the creation of resized images, thus saving disk space.
- Instagram: update embed to support Instagram TV URLs.
- Post Images detection: add support for alt text.
- Plans: clarify upgrade prompts in the Jetpack dashboard's Plans page.
- Publicize: remove the Google+ interface as the Social Network is now deprecated.
- Related Posts: update block to allow for up to 6 related posts.
- Social Menus & Icons: add Discord Support.
- Support: add additional tests to check when Jetpack isn't working as expected and ensures all current debugging platforms use the same testing list.
- Simple Payments: add generic currency fallback symbol.
- Sync: further performance improvements in PHP 7+ environments.
- Woocommerce Analytics: include product type with analytics data.

### Improved compatibility
- General: replace all .dev TLD references by .test as the .dev TLD will soon become available for registration.
- PHP 7.3: introduce automated testing for PHP 7.3.
- Site Accelerator: ensure compatibility with the AMP plugin.
- Twenty Nineteen: fix Top Posts and Pages Widget image list margins.
- WordPress 5.1 Compatibility: update usage of `wp_schedule_single_event` to match changes in WordPress.

### Bug fixes
- Copy Post: ensure the feature can be used when using non-standard post formats.
- Infinite Scroll: fix vertical spacing for new posts loaded with Infinite Scroll.
- Internationalization: fix minor problem affecting translations in the block editor.
- Mobile Theme: fix PHP notices when trying to display gallery images.
- Mobile Theme: fix redirection issues when clicking on the "Desktop version" links.
- Photon: add paypalobjects.com to the list of banned domains, as this domain already relies on a CDN.
- Publicize / Subscriptions: do not show message at the top of the editor when creating a private post.
- Spelling / Grammar: fix error when spellchecking the contents of a Classic block in the block editor.
- Top Posts: allow fetching posts from a long timeframe when using the `jetpack_top_posts_days` filter.
- Related Posts: avoid display a dulplicated set of related posts when using the Related Posts block.
- REST API: fix a bug causing Likes settings on a post to sometimes be flipped.
- Security: fix an XSS vulnerability in the "My Community" widget.
- Security: avoid bypassing Protect's Math Fallback challenge.
- Site Stats: do not show the Jetpack logo in the Stats dashboard widget title in the Screen Options tab.
- Theme Tools: support alternative Pinterest domain extensions in the Social Menus tool.
- Widgets: support alternative Pinterest domain extensions in the Social Icons Widget.
- Widgets: update the Cookies & Consents Banner to be fully accessible on mobile devices.

## [7.0.1] - 2019-02-14
### Improved compatibility
- Publicize: update LinkedIn connections to use newer API, anticipating changes with LinkedIn's API v1 on March 1st.
- Publicize: display a message inviting site owners to reconnect their site to their LinkedIn profile.
- Publicize: remove section in Settings > Sharing in the dashboard.

### Bug fixes
- Tiled Galleries: avoid errors when converting a tiled gallery into a block.
- Security: ensure json_encode()d data safely output to the page.
- Shortlinks: do not show Jetpack Sidebar in the block editor if Shortlinks are not available.
- Sync: avoid errors in WordPress' code editor, for sites using PHP 7 with `fastcgi_finish_request` enabled.

## [7.0] - 2019-02-05
### Major Enhancements
- Block Editor: introduce a new Gif block to help you quickly search and add Gif images to your posts.
- Copy Post: this new feature allows you to quickly create a new draft based on a post that's already published.

### Enhancements
- Block Editor: update the way we check for available blocks and extensions.
- Connection flow: display a notice upon connection when the site is suspended.
- Contact Form: add more options to customize the look of the submit button.
- Likes / Publicize: in the Jetpack Dashboard, add explanation to clarify the role of the features.
- REST API: add likes and sharing settings to the REST API Post response.
- Sharing: deprecate the Google+ sharing Button.
- Sharing: deprecate the Google+ embed shortcode.
- Shortcodes: rely on WordPress Core to handle SlideShare slideshow embeds.
- Shortcodes: cache the output of the Twitter shortcode.
- Subscriptions: remove obsolete polyfill JavaScript from the Subscriptions form.
- Subscriptions: allow more customization of the subscription form's submit button.
- Sync: improvements to the synchronization of plugin and theme updates.
- Sync: improve performance for sites using PHP 7, with `fastcgi_finish_request` enabled.
- Sync: synchronize plugin and theme fatal errors reported by WordPress 5.1.
- Widgets: deprecate the Google+ widgets.
- WordPress.com: allow the display of plugin action links in the WordPress.com plugins' interface.

### Improved compatibility
- Lazy Images: fix a compatibility issue with themes that overwrite classes on html.
- Contact Form: ensure contact form submissions with long words do not break the site layout, regardless of the theme.
- Publicize: remove the option to connect your site to a Google+ account, in anticipation of the service's shutdown.

### Bug fixes
- Admin Page: avoid PHP notices when looking at non-Jetpack admin pages.
- Carousel: fix display issue when viewing images with long captions.
- Carousel: avoid errors when fetching comments in the Carousel modal.
- CSS: fix the behavior of the CSS concatenation filter.
- Multisite: fix the display of the main connection banner.
- Protect: ensure the Math fallback is displayed when necessary.
- Publicize: avoid Fatal Errors on sites using Development Mode.
- Responsive videos: do not apply for videos that benefit from WordPress' own Responsive Embeds solution.
- Shortcodes: only load Mailchimp CSS when needed.
- Subscriptions: display subscription options below the comment form, even when you are logged in to your WordPress account.
- WordPress.com REST API: add new endpoint to allow the creation of a WooCommerce connection via the API.

## [6.9] - 2019-01-10
### Major Enhancements
- Block Editor: this release introduces new blocks: a Subcription form block, a Tiled Gallery block, and a Related Posts block.

### Enhancements
- Admin Page: several changes to improve navigation and connection flows for new and existing Jetpack site owners.
- Admin Page: make the Jetpack dashboard wider on large screens for a better experience.
- Affiliate tools: offer options for affiliate partners to manage affiliation links on their site.
- Carousel: add support for the new Tiled Gallery block.
- Contact Form: use the comment blacklist to filter contact form submissions.
- Dashboard notices: automatically dismiss notices once a feature has been activated.
- Dashboard notices: fix styling to work better with the Hello Dolly plugin.
- Internationalization: add new locales, ensure existing ones are up to date.
- REST API: new endpoint to expose Gutenberg block and plugin availabilty.
- Search: add hook to get_filters() to allow the use of custom filters.
- Shortcodes: add new Mailchimp shortcode to insert Mailchimp subscription forms anywhere in your posts and pages.
- SSO: offer message introducing the feature to new users.
- Stats: improve the design of the Stats dashboard widget.
- Widgets: add filter to set DoNotTrack in Twitter Timeline widget.
- WordPress.com REST API: add new option to set sites to private.

### Improved compatibility
- AMP: ensure that all Jetpack features are compatible with the latest version of the AMP plugin. Solves issues previously encountered with sharing buttons and stats.
- Images: ensure that images inserted with new block editor can be used in Open Graph Meta tags, Related Posts, and Publicized posts.
- PHP 7.3: avoid PHP warnings so the plugin can be fully compatible with the latest version of PHP.
- Sharing: do not add Jetpack's Twitter Meta Tags when the WP To Twitter plugin is active.
- Twenty Nineteen: additional style adjustments to make sure all Jetpack widgets look good with the theme.
- WooCommerce: do not include product reviews in comment counts in the WordPress.com REST API.

### Bug fixes
- Admin Page: update feature limits mentioned when disconnecting Jetpack from WordPress.com
- Block Editor: fix loading of translations in the editor when Jetpack's Site Accelerator feature is active.
- Carousel: ensure that Carousel works well with the Gallery block in the new block editor.
- Carousel: do not open modal when clicking on a link in a caption
- Publicize: improve synchronization of sharing settings with WordPress.com.
- Publicize: only display Gutenberg Publicize UI to users with the correct permissions.
- Responsive videos: don't load if theme supports core responsive embeds.
- Search: fix fatal error when the Search Widget is enabled while the site is in Development Mode.
- Sharing: update Tumblr official sharing button.
- Shortcodes: update YouTube shortcode to support more video link formats.
- Shortlinks: add the option to view shortlinks in the block editor.
- Simple Payments: only register block when all needed data is available.
- Widgets: only load Social Icons widget scripts and styles when necessary.
- WooCommerce Analytics: avoid Fatal Errors in some specific site setups.
- WooCommerce Analytics: improve performance by avoiding unnecessary calls to the feature when it is not needed.

## [6.8.1] - 2018-12-06
### Bug fixes
- Contact Form: security changes to improve the display of success messages after submitting a form.
- Publicize: avoid Fatal errors when trying to create or edit posts from a Custom Post Type that supports Publicize.
- Sync: improve synchronization of WooCommerce events.
- WordPress.com REST API: handle WooCommerce Product reviews for a better display in apps that use the API.

## [6.8] - 2018-11-27
### Major Enhancements
- This release introduces the first wave of Jetpack blocks built for the new block editor, available in WordPress 5.0.

### Enhancements
- General: improve ability to create and troubleshoot Jetpack connections.
- REST API: new endpoint for testing the Jetpack connection.

### Improved compatibility
- Akismet: improve caching of all queries for Akismet status.
- Spellcheck / Grammar: we've made sure the Jetpack feature did not create any error when using the block editor.
- Twenty Nineteen: ensure compatibility with Jetpack's widgets.

### Bug fixes
- Asset CDN: do not try to serve assets from non-public versions.
- Carousel: handle galleries created via the Gallery block in the new block editor.
- Photon: make sure our image CDN is fully compatible with the block editor.

## [6.7] - 2018-11-06
### Major Enhancements
- Site acceleration: new toggle to serve both your images and static files (like CSS and JavaScript) from our CDN.
- Activity: update Jetpack dashboard to include links to our Activity page, where you can view a record of every change and update on your site.

### Enhancements
- Admin page: add site Activity card.
- Blocks: provide a mechanism so editor blocks can be translated.
- Blocks: enqueue Jetpack blocks in the block editor when blocks are available.
- Debug tools: add information about missing XML extension in self-help tools.
- REST API: introduce endpoint for retrieving related posts of a particular post.
- Search: add an advanced `excess_boost` param which can be adjusted with filters to fine tune query scoring.
- Sharing / Publicize: change the icons used in the Jetpack dashboard to clarify where the configuration links lead.
- Secure Sign On: update wording on admin pages to avoid confusion.
- Shortcodes: update the Polldaddy shortcode to use the new brand, Crowdsignal.
- Sitemaps: coding standards changes.
- Site Verification Tools: improve display of the tool's description on mobile devices.
- Unit Tests: improve process for faster tests.

### Improved compatibility
- Themes: ensure compatibility between Jetpack features and the new WordPress default theme, Twenty Nineteen.
- AMP: add support for GitHub's Gist shortcodes.
- PHP 7.3: update Infinite Scroll to avoid PHP warnings when using the latest version of PHP.
- Protect: fix output of Protect's Math challenge on login forms created by third-party plugins.
- Plugins: add a WordPress.com themed plugins page for users managing their plugins via the WordPress.com interface.
- Site Verification Tools: do not enable Google's Auto-verification option when a site using a maintenance / coming soon plugin.

### Bug fixes
- Blocks: update the VR block to be fully compatible with the latest version of WordPress and Gutenberg.
- Comment Likes: only prefetch domains used by the feature.
- CSS Concatenation: make sure all concatenated CSS is up to date.
- Featured Content: no longer hides the "featured" tag from the WordPress.com Editor or the mobile apps.
- Geolocation: avoid a PHP notice when setting location for a post in the WordPress.com post editor.
- Likes: ensure that the Likes column is accessible.
- REST API: Ensure only strings as escaped as URLs.
- Search: avoid PHP warning with Search widget.
- Sharing: improve accessibility of email sharing button.
- Simple Payments / Widget Visibility: avoid potential Fatal errors on some specific server configurations when updating Jetpack.
- Sitemaps: remove double encoding of site name in news sitemap.
- Sitemaps: ensure homepage is only included once.
- Sitemaps: provide richer "not found" message to site admins.
- Sitemaps: ensure sitemap is refreshed faster after upgrading Jetpack.
- Sitemaps: avoid protocol mismatches between the sitemaps and the site.
- Site Verification Tools: make sure we validate meta tags when saving.

## [6.6.1] - 2018-10-10
### Bug fixes
- Sitemaps: improve initial sitemap creation process.
- Widgets: fix missing CSS for the Social Icons Widgets.

## [6.6] - 2018-10-09
### Major Enhancements
- Verification Tools: enable one-click site verification and sitemap.xml registration with Google.

### Enhancements
- Admin Interface: update all Jetpack settings screens to use a similar design.
- API: add flags to determine if Jetpack Search is enabled and supported.
- CDN: First Beta version of the Photon CDN -- Speed up sites and increase max concurrent connections through Photon by cloud-hosting Jetpack and WordPress Core scripts, styles, and assets.
- Contact Form: add filters to allow customizing the class attributes of inputs and buttons.
- General: add more constants to error log for the Jetpack test suite.
- Gutenberg: add infrastructure necessary to add new blocks via Jetpack.
- Lazy Images: load the placeholder via the `srcset` attribute instead of the `src` attribute.
- Masterbar: add link to Activity Log.
- Publicize: the Path Social Network is closing in October. The option has consequently been removed from the Publicize interface.
- Search: improve the feature activation process.
- Search: update the admin interface to give more information about what the feature does and how it can be used.
- Simple Payments: update all mentions of the product for a more consistent naming convention and less confusion for both site owners and translators.
- Sync: log action when an attachment is added to a post for the first time.
- Sync: add URL details to synchronization requests.
- Sync: detect if a post is saved via Gutenberg when synchronizing post events.

### Improved compatibility
- Shortcodes: update Mailchimp shortcode to match the new format offered by Mailchimp.

### Bug fixes
- CSS Concatenation: add Authors and Social Icons widgets to concatenated styles.
- Featured Content: avoid registering duplicate Post Types.
- Geo Location: only enqueue Dashicons when necessary.
- Google Analytics: do not output tracking code when the "Enhanced eCommerce" option is active, but the WooCommerce plugin is not.
- Infinite Scroll: add a Privacy Link to the site's footer if a Privacy Policy was set up via WordPress's privacy options.
- Infinite Scroll: fix video playback of VideoPress videos loaded via Infinite Scroll.
- Protect: fix layout of legend that prompts the user to solve the math fallback so it works better in all languages.
- Responsive Videos: avoid PHP notice.
- Sharing: do not record stats if the stats module is disabled.
- Sharing: allow saving sharing button options on media edit page as well.
- Shortcodes: ensure we build minified and RTL stylesheets for slideshows.
- Simple Payments: Stop contributors from creating inaccessible buttons with a "pending" post status.
- Sitemaps: no longer add images attached to non-published posts to the image sitemap.
- Slideshows: ensure arrows point in the right direction for RTL Languages.
- Sync: avoid PHP notices when synchronizing user information.
- VideoPress: avoid duplicate rel attributes in links.
- VideoPress: do not block access to the Video settings for our customers using a 2-year plan.

## [6.5] - 2018-09-04
### Major Enhancements
- WordAds: Added ability to include custom ads.txt entries in the ads module.

### Enhancements
- Admin Page: Added ability to disable backups UI by filter when VaultPress is not activated.
- Comments: Moved the Subscription checkboxes on a comment form from after the submit button to before the submit button.
- General: Removed the outdated "Site Verification Services" card in Tools.
- General: Removed jetpack_enable_site_verification filter. We recommend filtering access to verification tools using jetpack_get_available_modules instead.
- General: Simplified the logic of Jetpack's signed HTTP requests code.
- Lazy Images: Updated lazy images to use a default base64 encoded transparent to reduce a network request.

### Improved compatibility
- Geo Location: Fixed a compatibility issue with other plugins that added meta attributes to site feeds with the `rss2_ns`, `atom_ns` or `rdf_ns` filters.

### Bug fixes
- AMP: Fix PHP notice when rendering AMP images with unknown width and height.
- Contact Forms: We fixed an issue where personal data eraser requests didn't erase all requested feedback.
- General: Improves compatibility with the upcoming PHP 7.3.
- General: Updated input validation for meta tags given in site verification.
- Lazy Images: Deprecated jetpack_lazy_images_skip_image_with_atttributes filter in favor of jetpack_lazy_images_skip_image_with_attributes to address typo.
- Sharing: Fixed duplicate rel tags on Sharing links.
- Search: Fixed an issue where a CSS and JavaScript file could be enqueued unnecessarily if the Search module was activated and if the site was using the Query Monitor plugin.
- Shortcodes: Updated Wufoo Shortcode to always load over https and use async form embed.
- Widgets: Fixed excessive logging issue with Twitter Timeline widget.
- Widgets: Removed cutoff date check for Twitter Timeline widget as it is no longer necessary.
- Widgets: Added decimal precision validator to Simple Payments Widget price field on the Customizer for supporting Japanese Yen.

## [6.4.2] - 2018-08-10
### Bug fixes
- Comments: We fixed an error that broke functionality of Social Login for comments.

## [6.4.1] - 2018-08-08
### Bug fixes
- Comments: We fixed an error that broke functionality of nested comments.

## [6.4] - 2018-08-07
### Enhancements
- Connection: Updated connect splash screen with new content.
- Sharing: Sharing section in wp-admin will now redirect to Calypso instead.
- Docs: Added documentation for retrieving provision status of a site.
- Shortcodes: Added oEmbed support for flat.io.
- Widgets: Added `jetpack_top_posts_widget_layout` filter that allows you to create a custom display layout for the Top posts widget.
- Privacy tools: Identify the data export/erasure callbacks for Feedback posts using associative keys, to better match the convention in Core.
- Privacy tools: Added the `grunion_contact_form_delete_feedback_post` filter hook to allow specific Feedback posts to be bypassed during data erasure requests, similar to the `wp_anonymize_comment` filter in Core.
- Contact Fork: Disabled random table optimizations on core tables.

### Improved compatibility
- AMP: Improved AMP compatibility for Comments iframe.
- General: The SEO Framework is no longer a conflicting Open Graph plugin and is now better compatible with Jetpack.

### Bug fixes
- Shortcodes: Removed extra black bars from YouTube embeds as controls are inside the container now.
- Simple Payments: Fixed the custom post type bug that affected Simple Payments widget for 2 year subscriptions.
- Simple Payments: Fixed site failure which happens on Multisite installation with Simple Payments widget.
- Simple Payments: Fixed syntax and misc compatibility issues with Simple Payments widget on PHP 5.2.
- Simple Payments: Added warning for admin users if Simple Payments is not enabled but there are products published on pages/posts as a widget.
- Lazy Images: Fixed an issue with images not loading while updating quantity in WooCommerce shopping cart.
- Lazy Images: Fixed centered images that do not crop properly when no JavaScript is enabled.
- General: Fixed auto scrolling to top when following the Quick Tour buttons.
- General: Removed ability to set custom name for Site Identity section.
- General: Added advanced control capabilities to image extraction from posts.

## [6.3.3] - 2018-07-30
### Facebook API Maintenance
- On the 1st of August, 2018 Facebook sunsets its API allowing to post updates to your Profile Page. Only the API allowing to post to Facebook Pages will remain. This required several changes to Jetpack that we are presenting in this release:
  - Publicize: making sure we are handling existing connections gracefully.
  - Publicize: using logo font instead of images to make the UI up to date and mobile ready.
  - Publicize: removing the ability to select Facebook Profile connections in the UI.

### Bug fixes
- General: properly handle Jetpack connection owner transition process.

## [6.3.2] - 2018-07-04
### Bug fixes
- Simple Payment: Fix compatibility issues with PHP versions 5.3 and below

## [6.3] - 2018-07-03
### Major Enhancements
- Simple Payment: Added Simple Payment Products as Widgets, with the option to manage them via the Customizer.

### Enhancements
- Connection: Added a new connect splash screen content.
- Jetpack Dashboard: We removed the labels reading 'PAID' in order to introduce a better way to remark paid features.
- General: Added support to display geo-location data added to posts and pages with Calypso.

### Improved compatibility
- Protect: We solved an issue related to interaction with bbPress when trying to log in via a bbPress login widget. You would get redirected a few times to log in again after solving the math puzzle.

### Bug fixes
- Comments: Implemented Core WordPress' Comment Cookie Consent Checkbox in Jetpack Comments.
- General: We solved an issue that arised when using the Front End Editor feature plugin. A fatal error wass thrown due to us assuming the `enter_title_here` filter would only run within wp-admin.
- General: Fixed a compatibility problem between WordPress TinyMCE and Jetpack Markdown when visiting the WordPress Dashboard.
- Lazy Images: Fixed behavior for when JavaScript is disabled.
- Markdown: We fixed the naming of the class used for code blocks that specify a language.
- Simple Payments: Fixed an error when the user had published Simple Payment Products but their Professional Subscription had expired.
- Sitemap: We fixed the format of the date shown for videos on the video sitemap.
- Stats: We fixed the width of the Stats page for wide screens.

## [6.2.1] - 2018-06-08
### Bug fixes
- AMP: We fixed the rendering of the stats pixel for legacy, non-paired, non-canonical AMP pages.
- Shortcodes: Fixed a fatal coming form the VR shortcode when using the Gutenberg editor in the frontend.

## [6.2] - 2018-06-05
### Major Enhancements
- Shortcodes: Added Gutenberg block for the [vr] shortcode.

### Enhancements
- AMP: Allow Jetpack features to work on AMP pages, and prevent Jetpack features from rendering to the front end at all.
- Content Options: We now exclude Custom Post Types like Portfolio and Testimonial when we toggle content/excerpt via the Blog Display option in the customizer.
- Cookies & Consent Widget: Added a "top" option for the cookie widget position. The existing bottom of the screen position is the default.
- Tiled Galleries: use Photon if active when a Tiled Gallery links to media file.

### Improved compatibility
- Widgets: Deprecated the use of Widget IDs in the Twitter Timeline Widget given that Twitter deprecates Widget IDs on July, 27th 2018.

### Bug fixes
- Contact Form: Fixed an issue with undefined variables and a warning being logged when submitting the Contact Form.
- Contact Form: Fixed scrolling/height for very large contact forms.
- Widgets: Fixed Cookies & Consent Widget's bottom margin for themes that set a specific margin for forms.
- Related Posts: Made it not try to fetch related posts for an unpublished post.
- Sharing: Fixed an issue that resulted in wrong URLs for sharing on WhatsApp.
- Sharing: Fixed the way we check if Akismet is active and has a valid key by caching the result of the verification.
- Shortcodes: Fixed the Facebook shortcode in wp-admin.
- Widget Visibility: Fixed styling for MS Edge.
- Widgets: Removed .widget class from Cookies and Consent widget styles since .widget is not used in every theme.

## [6.1.1] - 2018-05-22
### Enhancements
- Ads: Added new setting for Banner consent expiration. Added new filter jetpack_disable_eu_cookie_law_widget, which can be used to disable the banner.
- Ads: Added a new personalized-ads-consent cookie for ads-enabled sites.
- Ads: Added requirement and notice, and button-click opt-in for ads module users.
- Ads: When a user site has a Privacy Policy page set (introduced in 4.9.6), we now default to using that privacy policy as a custom policy URL.
- GDPR: A new warning is displayed while configuring an instance of the EU Cookie Law widget: "Caution: The default policy URL only covers cookies set by Jetpack. If you're running other plugins, custom cookies, or third-party tracking technologies, you should create and link to your own cookie statement."
- GDPR: Added Feedback data (i.e., Contact Form Submissions) to the Personal Data exported and/or erased by the latest version of WordPress core.

### Bug fixes
- Ads: We updated Ads behavior to not show unless the visitor is on the main query within the loop.
- General: We fixed a bug that resulted in an alert box showing for sites set to languages deriving from main ones.
- Lazy Images: Fixed a bug where images would disappear when scrolling.
- Sharing: make sure JS files can be loaded on development sites.
- Sharing: Added check for validating Akismet key before allowing sharing by email.
- WooCommerce Analytics: Fixed PHP warning when attemping to get a list of plugins.

## [6.1] - 2018-05-01
### Major Enhancements
- WordAds: Introduced shortcode for inline Ad placement.
- WordAds: Added support for the ads.txt file.

### Enhancements
- Dashboard: We improved the styles of status numbers so it doesn't look like floating.
- JSON API: Added support for Google My Business integration available on WordPress.com.
- Masterbar: We removed the Next Steps link from the Account sidebar.
- Publicize: Let the user know that we are going to send emails to subscribers and publicize to the different accounts.
- Settings: Added  "Privacy Information" links to each Jetpack module/feature card.
- Shortcodes: Mixcloud shortcode now uses oEmbed.
- Stats: Added a new filter jetpack_honor_dnt_header_for_stats, which if enabled would not track stats for visitors with DNT enabled.
- Sync: Removed requirement for gzencode.
- Widgets: always load script via HTTPS for Gravatar Hovercards.

### Improved compatibility
- Social Icons Widget: Improved support on screen reader text for themes that do not provide support out of the box.
- Sharing: Removed the sharing and like display functionality from Cart, Checkout, and Account WooCommerce pages.

### Bug fixes
- Admin Page: We fixed the internationalization of the plans page.
- Ads: We fixed a problem that impeded Premium Plan customers to activate Google Analytics.
- Auto Updates: We fixed a warning being thrown due to a bad concatenation of strings.
- General: Fixed a warning that was being logged due to attempting to use in_array() over a variable that didn't always contain an array.
- General: Fixed Warning: count(): Parameter must be an array or an object that implements Countable showing on PHP 7.x.
- JSON API: Fixed internationalization on embed endpoint.
- Theme Tools: Show featured images in WooCommerce pages when Display on blog and archives is turned off for Themes that support this feature.
- Publicize: Avoid adding Publicize post meta when a post transitions to publish and it is not a publicize-able post type.
- Settings: Fixed the icon representing the minimum plan needed for SEO and Google Analytics features.
- Slideshow: Fixed an invalid argument supplied for foreach() warning.
- SSO: We fixed the name of a filter which contained a typo before. The filter is now named: `jetpack_sso_auth_cookie_expiration`.
- SSO: Fixed some cases where we were not handling secure cookies for sites running over https.
- Sync: Fixed Warning: Invalid argument supplied for foreach().
- Sync: Fixed Warning: Warning: json_encode(): recursion detected.
- WooCommerce Analytics: fixed broken Remove From Cart link.

## [6.0] - 2018-04-03
### Major Enhancements
- Admin Page: Introduced a new Privacy admin page linked at the bottom of the Jetpack dashboard.
- Admin Page: Introduced a Privacy toggle that allows the user to disable event tracking.
- Widgets: Added new Social Icons widget and deprecated old Social Media Icons widget.

### Enhancements
- Activity Log: Started syncing comment untrashed and comment unspammed events.
- Admin Page: Added inline module settings for plan welcome page.
- Admin Page: Removed Javascript patterns previously used in the Admin Page that should improve performance lightly (bind pattern).
- Admin Page: Made Jetpack Monitor setting management easier by adding a simple toggle.
- Admin Page: Moved the button for closing the Jumpstart modal closer to the dialog so it's more visible.
- Admin Page: Updated the "install and activate" link in the Backups card to be a functional link matching the "Set up" button.
- Admin Page: Updated notices style to be more accessible.
- Admin Page: We now show a link to see all plans on small screens.
- Admin Page: Settings in Jetpack dashboard now feature contextual help and a link to learn more about it.
- Ads: Added site id to head meta.
- Comments: Improved accessibility of comments form by adding title attributes.
- Connect: Removed account creation links from below the Set Up Jetpack buttons.
- General: Show correct available status in Jetpack modules list if module is not supported by current plan.
- General: Removed holiday snow module.
- General: Return error in wp-cli if activating a module that is not supported by the current plan.
- Google Translate Widget: Made sure the widget is responsive by default.
- JITM: We now allow specifying that a jitm can be opened in a new window, or the same window.
- JITM: We now don't use all caps for buttons text.
- Likes: Removed Likes from Jumpstart.
- Likes/Sharing: Moved metabox in post editor to the right side for a better fit.
- Masterbar: Made the Sign Out link in the Master always log you out from WordPress.com.
- Publicize: Made styling of Publicize more consistent with wp-admin.
- Protect: Started blocking XML RPC requests when they get marked as blocked by Protect.
- Search: Made the Search widget available whether or not Extra Sidebar Widgets is enabled.
- SEO Tools: Removed SEO Tools from Jumpstart
- Shortcodes: We now load Twitters widget.js over https.
- Subscriptions: We've made it a better experience if you try to subscribe to a site you are already subscribed to.
- Sync: Stopped syncing personal data coming from WooCommerce orders.
- VideoPress: Default to grid view when linking to upload videos
- Warm Welcome: Added Search to the features listed on the Warm Welcome dialog for Professional Plan.
- Widgets: Added rel=noopener attribute to links in the Display WordPress Posts widget if set to open in a new window.

### Improved compatibility
- bbPress: Markdown support added for bbPress CPTs.
- PHP 7.1: Fixed an error coming from one of our json-api endpoints.

### Bug fixes
- Admin Page: Fixed Dashboard connection card from showing text that overflows the card.
- Admin Page: Fixed directory separator character used when displaying the site URL on the disconnect dialog.
- Admin Page: Fixed an issue by which clicking the back button on a page visited after the Admin Page would result in the Admin Page being rendered with cached data.
- Admin Page: Don't show a Set Up button when searching for modules that are inactive in Jetpack Settings page. The Set Up button is meant for paid features coming from plugins.
- Admin Page: Make it clear when tracking begins in the connetion dialog.
- Admin Page: Hide the date range tabs when the initial dialog is shown.
- Admin Page: Fixed the positioning of popovers in the Jetpack Settings page.
- Admin Page: Fixed a bug with the Ads settings toggle.
- Admin Page: Fixed a display issue for the custom user capability "jetpack_connect".
- Admin Page: Made sure translations are properly applied to several phrases.
- Connection Banner: Updated style to better fit wide screens.
- Connection Banner: Added illustration SVGs.
- Contact Form: Fixed width style of input for Website address.
- Google Analytics: fix PHP notice on search pages.
- Infinite Scroll: Fixed issues where the first was being duplicated on scroll.
- Likes: Made manually enabled likes remain being likeable if Likes are enabled for all posts
- Masterbar: Fixed a javascript error that would pop up with the Grammarly extension enabled on Chrome macOS.
- Search: Added default values for the Search widget so it can be added from the Customizer.
- Settings: Fixed overflow/overlap when there are many ignored phrases in spelling options.
- Settings: Updated SEO/analytics links to avoid unnecessary redirects.
- Stats: Fixed column spacing styling issues in WP Dashboard box for Jetpack stats.
- VaultPress: Remove menu item that links nowhere when Rewind is enabled.
- Widgets: Fixed issue with custom URL choice and selective refresh in the EU Cookie Law widget.
- WooCommerce Analytics: Fixed PHP warning coming from str_replace usage.
- WooCommerce Analytics: Started tracking all possible ways to add a product to a cart.

## [5.9] - 2018-03-06
### Major Enhancements
- WooCommerce Analytics: Added a new module for WooCommerce analytics that will use Jetpack's analytics functionality to help you track activity on your WooCommerce store.
- Custom Content Types: Added support for excerpts on Testimonial and Portfolio.

### Enhancements
- Activity Log: Improved the way we show failed login attempts in Jetpack's Activity Log.
- Admin Page: We now hide settings for Lazy Images and Photon in the Admin page when the modules are not enabled due to being filtered out by jetpack_get_available_modules.
- Admin Page: Now we only show the dismissal button in Apps card of the Jetpack Dashboard for admin users.
- Build: Added a pre-commit hook for linting the Jetpack Admin Page source code. This aids in finding common syntax and style problems before having to wait for automated tests to run.
- JSON API: We removed an obsolete endpoint for updating invites.
- Onboarding: Added the ability to configure the country for a business address the using the Onboarding functionality of Jetpack.
- Onboarding: Added the ability to enable the stats module when using the Onboarding functionality.
- Onboarding: We now delete the onboarding token when the site gets connected.
- Jetpack Start: Updated scripts for partners allowing to pass a tracking ID when provisioning or cancelling a plan which will help in debugging.
- Jetpack Start: Improved the documentation for partners so they're now able to get them right on the Jetpack's Github repository under the docs/partners directory.
- Plans: Correctly forward the client IP address for currency localization.
- Plans: Updated the copy-text on Jetpack's Admin page for plans to be more concise on the features of each plan.
- REST API: Added a plans endpoint to Jetpack's REST API to better handle the features of each Jetpack plan internally.
- Search Implicitly activate Jetpack Search when attempting to add the Jetpack Search widget.
- Search: Updated the Jetpack Search settings card to be more helpful in setting up the widget.
- Search: We made the "Add Jetpack Search Widget" link in the Search module settings card open the widgets section of the customizer.
- Search: Move any active search widgets to the inactive list if you disable the search module.
- Search: Only log mysql and ES query times that are less than 60 seconds.  There are some outliers that mess up our stats.
- Sync: Improved the way widget titles are synchronized to WordPress.com servers when widgets are saved or updated.
- Twitter Cards: Added new jetpack_twitter_image_default filter to allow themes and plugins to customize twitter:image when no suitable image is found automatically.
- We updated the way we handle Jetpack's green color in out stylesheets for better compatibility with Jetpack's new logo.

### Improved compatibility
- Admin Page: Jetpack's Admin Page javascript code is now fully compatible with React 16.
- JSON API: Updated the modules endpoint Jetpack's JSON API to reply with a new property `override` that indicates if a module was either enabled or disabled by a filter.
- Lazy Images: Updated the library used as IntersectionObserver for Lazy Images. We now use the W3C IntersectionObserver polyfill.
- Lazy Images: Jetpack now allows the lazy images module to skip images with the skip-lazy css class or any given class of your choice by using the jetpack_lazy_images_blacklisted_classes filter.
- Masterbar: Updated the sign out button behavior of the Masterbar to not sign you out of WordPress.com when you sign out of your site for regular Jetpack sites.
- REST API: Updated the modules endpoint in Jetpack's REST API to be aware of modules that have been filtered through option_jetpack_active_modules allowing for better compatibility with custom Jetpack installation where the administrator decides to filter out specific Jetpack modules.
- Sync: Added the jetpack_sync_action_before_enqueue action that's done when anything gets enqueued before being synchronized to WordPress.com servers.

### Bug fixes
- Admin Page: Removed all linting warnings for the JS code of the Admin page.  These were only shown in development builds.
- Connect: Fixed an issue that sometimes resulted in a notice being shown about another user already having connected a Jetpack site when attempting to connect your site to WordPress.com
- General: Added suppress_filters param to get_posts / get_children function calls.
- Markdown: Updated WordAds code to not use create_function which is getting deprecated in PHP 7.2.
- Sync: Fixed a problem in Jetpack Sync code when trying to get property of non-object in the post syncing file.
- Sync: Stopped synchronizing the sitemap post types to WordPress.com servers as it was an issue given the size of these.
- Tracks events: Track events are logged now only if the user has accepted ToS and not just if Jetpack is connected.
- Widget Visibility: Added a decodeEntities function in widget-conditions.js to handle entity decoding for the minor conditions dropdown.
- WordAds: Updated WordAds code to not use create_function which is getting deprecated in PHP 7.2.

## [5.8] - 2018-02-06
### Major Enhancements
- [Lazy Images](https://jetpack.com/support/lazy-images/): after a Beta
  period, you can now enable this new feature from Jetpack > Settings in your
  dashboard.
- [Elasticsearch-powered search](https://jetpack.com/features/design/elasticsearch-powered-search/):
  also out of Beta! We've improved the way data is indexed behind the scenes,
  and made changes to the Search widget and its filters. (Elasticsearch is a
  trademark of Elasticsearch BV, registered in the U.S. and in other countries.)

### Enhancements
- Comment moderation tools: moderation emails now point to WordPress.com when
  using the `edit_links_calypso_redirect` option.
- Custom CSS: add CSS Grid Layout support.
- Dashboard: update list of features available in Paid plans.
- Dashboard: improve the display of notices inside the Jetpack dashboard.
- Dashboard: update content displayed in the Jetpack dashboard when not
  connected to WordPress.com.
- Development mode: improve the display of the development notice.
- General: add a new filter, `jetpack_active_modules`, allowing site owners to
  filter the list of active modules.
- Notices: add rel tags to notice links to avoid issues when links open in a
  new window.
- Onboarding: add functionality for saving Business Address in the Contact
  Info widget.
- Onboarding: save site type during site setup process.
- Onboarding: enable loading of specific modules when using the Onboarding
  process.
- Post Images: allow passing size when searching for images in HTML.
- REST API: update the plugin installation process to use a new library.
- REST API: allow changing the number of posts displayed in the RSS feed, and
  whether feeds display full text or a summary.
- REST API: simplify our invites endpoint.
- Sharing: make sure the Whatsapp button works on mobile and on desktop.
- Sharing: add new filter, `wp_sharing_email_send_post_subject`, to allow
  modifying the email sharing subject line.
- Shortcodes: update the GettyImages shortcode to use the new format required
  by GettyImages.
- Site Settings: add support for site language and timezone settings.
- Sync: improve synchronization of user actions, theme and plugin edits /
  updates, post status, updates on Multisite networks, Protect events, and
  WooCommerce's meta data.
- WordAds: enable the Ads in the header by default.
- WordAds: add filters so site owners can control the display of the ads via
  code as well.

### Improved compatibility
- Lazy Images: fix issues with the Gazette theme.
- Open Graph: add Open Graph Metabox to the list of conflicting plugins.
- Masterbar: fix incompatibility with BeaverBuilder plugin.
- PHP 7.2: fix issues when running Jetpack with PHP 7.2.

### Bug fixes
- Carousel: fix PHP Notice with images using custom meta.
- Dashboard: make sure all links to WordPress.com point to the right site's
  settings on WordPress.com.
- Dashboard: update links to the plugin interface on WordPress.com to load the
  full plugin management page.
- General: fix images shown in the dashboard when Jetpack is installed in a
  directory different than `jetpack`.
- Lazy Images: make sure Lazy Load can be triggered even when images are added
  to the content very late.
- Stats: make sure the Stats script is XHTML compliant.
- Widgets: Mailchimp - avoid conflicts with jQuery UI.

## [5.7.1] - 2018-01-16
### Bug Fixes
- Protect: Fixed the math problem fallback for logging into Multisite installations.
- Settings: Made sure that the Security tab is no longer constantly updating the displayed information.

## [5.7] - 2018-01-02
### Enhancements
- Added ability to create revisions of Portfolio Projects.
- Users hosting their sites with our Pressable partner who have Rewind access can now jump from the new Activity card in the Jetpack dashboard to the Activity Log in WordPress.com and restore or download backups for the site.
- Comments: Edit links for comments in the frontend can redirect to calypso if the Jetpack option `edit_links_calypso_redirect` is enabled.
- Protect: Updated the styling of the Protect page for recovering access to your site when you're locked out of it.
- Search: Improved the UI for customizing the Search widget.

### Improved compatibility
- Comments: Updated our filtering behavior for Jetpack comments so other plugins appending html to the comments section are able to do it instead of being filtered out by Jetpack.
- Widgets: We updated Goodreads URLs to support https schema.
- Masterbar: We now hide the Masterbar settings card in Jetpackâ€™s Admin Page for sites that are set to always show the Masterbar.
- Lazy Images: Added a callback for processing image attributes array when attempting to lazy load images are loaded via `wp_get_attachment_image`.
- Search: Added hooks to the search filters widget so that other plugins/themes can hook in and change its output.

### Bug fixes
- REST API: Added a check for avoiding a fatal error when attempting to include Akismet class files in case the Akismet plugin files are present but the permissions on the files there are set to be not readable
- Markdown: Fixed bug where code inside shortcodes wasn't correctly restored from the hash.
- Search: Fixed the link that acts as a month and year filter removal toggle.

## [5.6.1] - 2017-12-14
### Security Improvements
- Contact Forms: Hardened security in Contact Form processing.

### Enhancements
- Sharing: Bumped the character limit to 280 when sharing a post to Twitter.

### Bug fixes
- Widget Visibility: Fixed a bug that disabled "saving" the widget when removing a Widget Visibility rule.

## [5.6] - 2017-12-05
### Major Enhancements
- Google Analytics: Add support for universal analytics for WooCommerce.
- Performance: minify all JavaScript files used in the plugin.
- Performance: add new Lazy Images module.
- Protect: add new mechanism allowing you to send yourself an email with a
  link to the form when you are locked out of your site.

### Enhancements
- Custom CSS: add new set of font properties that can be used in the CSS
  editor.
- Photon: do not remove `width` and `height` attributes from image tags when
  known.
- Sitemaps: add CLI commands to purge and built the sitemaps.
- Sitemaps: only display the reporter log success messages if
  `JETPACK_DEV_DEBUG` is defined.
- WordPress.com API: add new endpoints to allow for better comment management
  in third party interfaces like WordPress.com.
- WordPress.com Toolbar: prevent dns prefetching for logged out users.

### Improved compatibility
- Stats: remove function deprecated in PHP 7.2.

### Bug fixes
- Comment Likes: make sure Like text is properly translated.
- General: only load stats code when necessary.
- Related Posts: allow site owners to exclude multiple blog posts from the
  list of Related Posts.
- Sharing: remove inline JavaScript used in the email sharing form.
- Search: Maintain ordering of the search filters in the widget.
- Sync: avoid PHP notices during the synchronization process.

## [5.5.1] - 2017-11-21
### Bug fixes
- In Jetpack 5.5 we made some changes that created errors if you were using other plugins that added custom links to the Plugins menu. This is now fixed.
- We have fixed a problem that did not allow to upload plugins using API requests.
- Open Graph links in post headers are no longer invalid in some special cases.
- We fixed warnings happening when syncing users with WordPress.com.
- We updated the way the Google+ button is loaded to match changes made by Google, to ensure the button is always displayed properly.
- We fixed conflicts between Jetpack's Responsive Videos and the updates made to Video players in WordPress 4.9.
- We updated Publicize's message length to match Twitter's new 280 character limit.

## [5.5] - 2017-11-07
### Major Enhancements
- Jetpack is now fully compatible with WordPress's [new Gallery Widget](https://make.wordpress.org/core/2017/09/25/introducing-the-gallery-widget/). Your old Gallery widgets powered by Jetpack will switch to the new Widget when you update to WordPress 4.9.

### Enhancements
- We have improved the performance when loading the Jetpack Settings in the dashboard by optimizing the number of calls made when loading the page.
- We have updated the plugin to do a better job of cleaning up after itself whenever you decide to remove Jetpack from your site.
- We made some changes to reduce the number of connection issues that may happen on a site when switching from HTTP to HTTPs.
- We made some performance improvements to the Jetpack dashboard interface, to make sure your options and settings are loaded faster there.
- Error messages are also better in the Jetpack Dashboard; whenever you can't update settings, Jetpack will provide you with more information about why.
- We improved the Jetpack update process to make sure updating Jetpack does not stress your database during it, even on high-traffic sites.
- The next version of WordPress, 4.9, will be released very soon and will include [a lot of changes to its code editors](https://make.wordpress.org/core/2017/10/22/code-editing-improvements-in-wordpress-4-9/). Jetpack's Custom CSS will be fully compatible with the new editors and their syntax highlighting feature.
- We also made changes to make sure Jetpack was fully compatible with the [role and capability changes](https://make.wordpress.org/core/2017/10/15/improvements-for-roles-and-capabilities-in-4-9/) in WordPress 4.9.
- We have made some performance improvements to the Carousel feature.
- Contact Form: do not process shortcodes in widgets when WordPress itself does, starting in 4.9.
- Contact Form: we have improved the "website" field to display better error messages when you don't supply a URL. We have also improved the look of the date picker for the date field.
- Contact Form: avoid duplicate slashes when loading editor style.
- Masterbar: update the "Plugins" menu item to match the updated design on WordPress.com.
- Open Graph: do not display images smaller than Facebook's required size.
- Sharing: use Google's minified libraries to improve performance when loading Google buttons.
- Sharing: update Open Graph Image tags appearing on the home page to offer better alternatives based on your site settings in Appearance > Customize.
- We improved the way sitemaps are built so they do not consume too much memory when they are generated.
- WP.me Shorlinks: those links will now always use HTTPS.
- Spellchecker: we improved the admin interface to make it more clear when adding ignored phrases and saving them.
- Subscriptions: we added a filter so third party developers can track comment subscription activations.
- Sync: synchronize plugin action links to add that information to WordPress.com.
- Sync: improvements to better track theme and widget changes.
- VideoPress: we removed Jetpack version locking for directly embedded VideoPress videos to ensure all users receive the newest version of the player.
- We added a new filter (`jetpack_google_translate_widget_layout`) to the Google Translate Widget to allow you to change its layout.
- WordPress.com REST API: improve comment management for all roles, including post authors.
- WordPress.com REST API: allow site owners to manage comments on attachment pages from WordPress.com.
- WordPress.com REST API: improve the response from the API when WordPress' autoupdates are disabled.

### Improved compatibility
- You can now use Jetpack's contact form and Yoast SEO's Focus keywords on the same page without any issues in the editor.
- Top Posts Widget: avoid Fatal Errors when the widget is used on a site using WPML, and when a popular post cannot be found by WPML.
- Sync: add more Custom Post Types from third-party plugins to the list of things we do not synchronize with WordPress.com, to improve sync performance.
- Sharing: since [Press This is now a plugin and not part of WordPress itself](https://make.wordpress.org/core/2017/11/02/press-this-in-4-9/), we removed the Press This sharing button if you are not using the plugin.

### Bug fixes
- We now avoid displaying notices to user roles that cannot benefit or act based on the info in the notices.
- Gravatar Hovercards: avoid PHP Notices when the user info is an object.
- Infinite Scroll: avoid PHP notices when a site customizes galleries thanks to the `post_gallery` filter.
- Mailchimp: make sure subscription forms can still be embedded in posts and pages.
- Mailchimp: do not require the use of the shortcodes feature to use the Mailchimp widget.
- Mailchimp: fix issue where Mailchimp form code could not be added to the Mailchimp widget.
- Masterbar: avoid JavaScript errors by always loading jQuery.
- Post By Email: do not display any content in the email address field if no email address has ever been set before.
- Publicize: avoid errors when DOMDocument is not available.
- Publicize: we now hide the feature activation toggle if you are not allowed to manage Jetpack features.
- Search: make sure module cannot be activated when the site does not use a Plan.
- SEO Tools: do not output any custom meta tags if another SEO plugin is already active.
- Sharing: make sure Twitter Cards can be displayed even when a post does not include a title.
- Sharing: fix alignment of sharing buttons in the admin preview when using custom sharing buttons.
- Sitemaps: wait a minute before to generate sitemaps when the feature is activated, to avoid performance issues.
- Sync: avoid synchronization issues on Multisite networks using custom domains.
- Top Posts Widget: display the default title when it is set to empty.
- Milestone Widget: make sure the widget is displayed properly and can easily be translated into other languages.
- Verification Tools: avoid notices when saving changes on a Multisite network admin page.
- VideoPress: avoid missing file warning in the editor when using an RTL language.
- Upcoming events Widget: avoid PHP notices on sites using a custom timezone setting.
- WordPress.com REST API: avoid errors when installing plugins via the WordPress.com API.

## [5.4] - 2017-10-03
### Major Enhancements
- Multiple improvements to the connection process, to allow more people to use the Jetpack plugin, even on very specific server configurations.
- Add a new Welcome screen to guide site owners after they have purchased a Jetpack plan.

### Enhancements
- Add Schema.org markup to the Contact Info Widget.
- Add a new "Date" field to the Contact Form.
- Do not show any update notices when in [development mode](http://jetpack.com/support/development-mode).
- Improve our documentation to help contributors set up a unit testing environment.
- Avoid conflicts between Jetpack's Infinite Scroll and other Infinite Scroll plugins.
- Improvements to the WordPress.com REST API to avoid issues when interacting with your site's categories and tags on WordPress.com.
- Allow third party plugin and theme authors to add new menu items to the WordPress.com toolbar.
- Improve the Content Options panel displayed in the Customizer with certain themes.
- Add architecture for the Jetpack Search feature, available for Jetpack Professional users.
- Simple Payments: improve the display of the payment items when used on your site.
- Ensure a proper display of the Recipe shortcode on sites using an RTL language.
- Improve the display of the Facebook posts, images, and all other Facebook embeds in your posts.
- Synchronize the author information for all published posts.
- Record how Jetpack was discovered and activated to better understand how site owners first discover Jetpack.
- Improve the display and options offered with the Milestone Widget.

### Bug fixes
- We fixed layout issues appearing in the admin interface for IE11 users.
- Comment Form: avoid whitespace sometimes appearing below the form with some themes.
- Contact Form: avoid errors in the post editor on sites using RTL languages.
- Toolbar: always display the Toolbar when it's active, regardless of other admin bar settings.
- Widget Visibility: make sure rules are correctly migrated from the old Jetpack image widget to the new WordPress Image Widget.
- Avoid errors showing that Jetpack is out of date on WordPress.com, when running a Multisite network.
- WP CLI: avoid warnings when using the `wp jetpack protect whitelist list` command to list the whitelisted IP addresses in the Protect feature.
- Avoid displaying raw HTML in the Stats Configuration screen.
- Comment edits are reflected properly in wordpress.com.

## [5.3] - 2017-09-05
### Major Enhancements
- Full PHP 7.1 compatibility.
- It's now possible to preview your site within WordPress.com.

### Enhancements
- The Ads feature now gives you more options and control over the ads displayed on your site.
- Increased performance in the admin by cutting back on unnecessary requests.
- Loading comment avatars from Facebook and Twitter through a more secure https.
- Admin UI is much friendlier on initial activation when there are no stats to display.
- You're now able to stop VideoPress from looping a video during autoplay through the shortcode.
- Made some optimizations to the Jetpack connection process which means connecting your site more is more reliable.
- The EU Cookie Law widget got some styling improvements and looks better in any theme.
- There's a new Jetpack CLI command to allow testing of the Jetpack connection.
- Added the Likes and Monitor features to our recommended features list, making it easier to activate for new sites.
- Improvements made that makes sure we have the most up-to-date version of your site when managing from WordPress.com.
- Added a link to view your Comments in the WordPress.com toolbar.
- Lots of minor design improvements to the Jetpack admin area.
- We've found a few places where we were able to optimize the loading of css files.
- Removed the Omnisearch feature.

### Bug fixes
- Fixed compatibility issues with plugins using TinyMCE.
- Contact Form submission emails have been fixed for sites hosted on SiteGround.
- Updating WordPress.com themes will no longer have any problems.
- The Sitemaps feature will no longer error with posts/images with special characters in the title.
- There are no more conflicts with the ACF plugin when adding a new custom field.
- Fixed a bug that would cause some plugins to throw warnings with the Shortcode feature.
- We're no longer loading a font on the front-end for the Likes feature, which will also have some performance benefits.
- The Jetpack admin UI had some bugs that were causing some features to not display the correct active status, which are squashed now.
- Cleaned up our markup to avoid XHTML validation errors.
- Brought back a filter for the Widget Visibility feature that was accidentally removed.
- Managing your comments and comment authors more reliable from WordPress.com.

## [5.2.1] - 2017-08-02
### Bug fixes
- Solves an issue that caused widgets to lose their content when saved in WP Admin or Customizer.

## [5.2] - 2017-08-01
### Major Enhancements
- Contact Forms now sports a fancy new interface that allows you to visually compose your form in the editor.
- We have a new and slick way to showcase and explain the features we recommend to activate to new users.

### Enhancements
- Reduced 500kb from plugin zip file, which means faster updates.
- Refactored and reduced code for Comment Likes so it's faster and lighter.

### Bug fixes
- An inconsistency experienced in WordPress.com dashboard when Related Posts settings were set in the local site's WP Admin is now fixed.
- Fixed a 404 when loading Open Sans font from a stylesheet plus now it's only enqueued if it will be used.
- Solve PHP warnings when Image widget wasn't migrated.

## [5.1] - 2017-07-05
### Major Enhancements
- You and your readers can now show appreciation to particularly clever comments with the new Comment Likes feature.

### Enhancements
- Quickly visit your current site's front-end directly from the Masterbar's new "View Site" item.
- Site data fetch from /me/sites REST API endpoint now includes `blog_public` in the list of returned options.
- The Flickr widget now automatically displays images in a grid if there's enough room.
- E-mail sharing is now disabled by default unless it's explicitly enabled by a filter or Akismet is active.

### Compatibility Improvements
- Updated instructions in Flickr widget to reflect recent changes to the Flickr UI.

### Bug fixes
- EU Cookie Law Banner cookie no longer cached.
- WP Admin menu can now be accessed in mobile when Masterbar is displayed.
- We now sync the `order_id` for `order_items` in older WooCommerce versions.
- UI now handles VaultPress connection or registration problems gracefully.
- Photon now works correctly with images uploaded before WordPress 2.7.

## [5.0] - 2017-06-06
### Enhancements
- Several changes to the Jetpack dashboard and notices: alignment tweaks, code refactor, text simplification, and more.
- Changes to the communication layer between your site and WordPress.com, to improve performance and allow you to do more to manage your site from WordPress.com.
- Social menu gets icons for Etsy, Meetup, 500px, and Goodreads.
- Jetpack data sync now better supports WordPress updates, themes changes, widgets, and multisite networks.
- Video is updated to be fully compatible with the upcoming Media Widget.
- Force secure WordPress.com API requests for request body, remove deprecated stats methods, and add new endpoints for post listing and user invitations.
- Jetpack's Command Line tools can now output information about the primary Jetpack site owner. Try `wp jetpack status`!
- Custom CSS now supports the `animation-fill-mode`, `fill`, and `stroke` properties.
- Remove the "Menus" item from the WordPress.com toolbar for parity with the toolbar on WordPress.com.
- Improve the display of the Omnisearch results page on sites using an RTL language.
- Trim any white space when adding new email address in the Contact Info Widget.
- Improve the look of your recipes in search engine result pages, when you use the Recipe shortcode.

### Compatibility Improvements
- Improve the connection process for end users and hosts.
- Improve compatibility of Jetpack data sync with WooCommerce and Pet Manager plugins.
- Make sure Jetpack's SEO Tools don't conflict with other SEO plugins that may already be active on the site, like Yoast SEO or All In One SEO Pack.

### Bug Fixes
- Add a "Set Up" button when a Personal plan is purchased, but VaultPress isn't active yet.
- When the Ads feature is active, do not display Ads in RSS feeds.
- Comments do not use Photon for Facebook and Twitter avatars and now avoid non-secure warnings when submitting comments on a HTTP site in Safari.
- Contact form emails are now sent in a way that ensures they are correctly rendered as HTML.
- Properly print the full list of modules when using the sync command in Jetpack's Command Line Interface (CLI).
- Avoid errors when reordering a lot of Restaurant menu items at once.
- Add a mechanism to detect broken connection states and resolve them.
- Autosaves can now be restored as Markdown.
- Photon no longer conflicts with Facebook's CDN, local images, and plugins that customize reponsive images.
- Avoid potential PHP notice in Publicize.
- Fix bad jQuery selector in Presentations shortcode.
- Avoid fatal errors for Social Links on sites running PHP 7.1.
- Properly escape button attribute in spellchecker.
- Avoid PHP notices for stats on some sites when user roles are not attributed properly.
- No longer attempt to sync options that do not exist and avoid fatal errors when de/activating plugins.
- Avoid errors when Social Menu functions have already been defined in the theme or in another plugin.
- VideoPress media items now always return their unique ID, and do not trigger any PHP notice.
- Fix style of the EU Cookie Law Widget on themes with specific positioning.
- Use correct time constant to define an hour in Upcoming Events Widget.
- Avoid HTML encoding issues in sitemaps.

## [4.9] - 2017-05-02
### Major Enhancements
- New "EU Cookie Law Banner", Flickr, and "Internet Defense League" widgets.

### Slightly Less Exciting Enhancements
- Success notices are automatically dismissed after a short period.
- Removed unused code from "My Jetpack" interface and deprecated an XML-RPC method.
- Contact Form now adds display names to email addresses in the `To` header.
- Added an updated multiple unit tests increasing code coverage.
- Development mode now also shows module list.
- Updated the list of locales available in Jetpack.
- Plugin auto-updates only triggered from WordPress.com and now trigger WordPress' maintenance mode.

### Performance Improvements
- Record comment content modifications and moderation events to make sure comments are always up to date on WordPress.com.
- Sync post deletions, changes to sidebar, user events (addition, removal, and update) and theme installation.
- We now distinguish between a new and an updated attachment.
- Sync plugin and theme names when a related event is triggered including theme updates.

### Compatibility Improvements
- Protect avoid conflicts with other plugins hooking into the log in form.
- Contact Form not auto-activated when Ninja Forms is active.
- WordPess.com REST API now allows `HTTP PUT` requests.

### Bug Fixes
- Fixed wording in Post By Email button when no email address has been generated.
- Fixed a notice in the subscription widget in PHP 7.1
- Properly display VaultPress notices in the Jetpack dashboard.
- VideoPress now included in search results for "video" and fixed positioning of search icon on mobile screens.
- Protect supports IPv6 addresses properly.
- Dashboard avoids API requests being cached on some hosts and avoids errors when Spellchecker is inactive.
- Contact Form message content type is now set properly to restore compatibility with email plugins.
- Ads not displayed in the portfolio projects custom content type.
- Display all sites available in a network, even on large multisite installations.
- Featured Image is always used in tweets posted via Publicize.
- Avoid fatal errors when the exclusion parameter in Related Posts is not a string.
- Allow the removal of all custom title settings in the SEO feature.
- Make sure images are not distorted when Tiled Galleries uses Photon.
- Avoid PHP warnings and errors in the Stats dashboard on Multisite.
- Avoid errors when the Jetpack plugin is deleted.

## [4.8.2] - 2017-04-07
### Bug Fixes
- Fixed a bug that prevented activating/deactivating of some features in PHP versions below 5.4.
- Removed an unused function that was also incompatible with PHP versions below 5.4.
- Fixed a bug that was causing a blank Jetpack admin area.

## [4.8.1] - 2017-04-05
### Bug Fixes
- An incompatibility with PHP versions lower than 5.4 was introduced in the last release, causing a fatal error and we've immediately fixed this.
- Sitemaps: Some plugins were relying on a function that was removed in the last release, which has been fixed.
- General: Clicking on the info icon in the settings area will no longer jump to the top of the page.
- General: The Anti-spam card will always display the correct status in the Jetpack dashboard.

## [4.8] - 2017-04-04
### Major Enhancements
- Easier to navigate Jetpack's feature settings in your dashboard and WordPress.com.
- New WordPress.com Toolbar provides quick access to site management, stats, and other services.
- New MailChimp Subscribe Popup widget.
- Sitemaps are faster and now support sites with a very large amount of posts.
- Contact Form now has a plain-text alternative and better avoids spam filters.
- Debug form includes extra information to better prioritize your support requests.
- Photon can now be used within the dashboard, and supports bbPress topics and replies.

### Slightly Less Exciting Enhancements
- Improved previously confusing wording in Stats dashboard, and Featured Content options.
- You can now embed Apple Keynotes straight from icloud.com in your posts and pages.
- Changed Infinite Scroll button text on taxonomy page and added a new filter to short-circuit the `is_last_batch()` method.
- Open Graph now uses transients to save image IDs.
- You can now use full URLs in the Social Media Icons widget.
- Milestone widget now allows custom links to open in a new window.
- VideoPress videos can be used as headers in themes that support it, like Twenty Seventeen.
- Extracted the timezone offset method from the Upcoming Events widget so it can be used by other features.

### Performance Improvements
- Database load is reduced during updates on large sites with multiple servers by retaining hashes for current and current-1 versions.
- Disk storage is reduced on large multisite networks by storing the `jetpack_file_data` option in the `wp_sitemeta` table.
- Jetpack plan data now uses the WordPress.com REST API.
- Slovakian language files now rely on WordPress.org's language packs.

### Accessibility Improvements
- Improved post details clipping for better screen reader support.
- Updated custom language packs for multiple languages.

### Security Improvements
- We now avoid path disclosure via cookies in PHP error messages.

### Compatibility Improvements
- Removed deprecated functions `get_theme` and `get_current_theme`.
- Publicize now works with third-party plugins like WP Recipe Maker.
- Open Graph Meta Tags are now enabled when you use the "Head, Footer and Post Injections" plugin.
- Better support for WooCommerce data sync and backup.
- We now also sync the `sync_via_cron` setting, the user's chosen language, and WP Super Cache's globals and constants.
- We no longer sync post types from the WordPress Automatic Plugin and RSS AutoPilot to avoid synchronization issues.
- Sync settings can now be edited from the WordPress.com REST API to better troubleshoot sync issues.

### Bug Fixes
- Gravatar is always displayed in Settings.
- Submenu items always use relative links.
- Contact Form avoids PHP notices when using the form in a Text widget.
- Content Options now correctly displays single characters word count on sites with multibyte languages.
- Administrator area translations fixed for several languages.
- Added proper support for Formal/Informal translation versions for languages that support them.
- Site Icons are always used as fallback Open Graph Image tags.
- Protect removes port number when server returns a port alongside a stored IP address.
- Filters ensure that more than 1,024 posts can be excluded from Related Posts.
- When the email is already subscribed we now show the correct notification in the subscription form.
- When using the Email sharing button, we now avoid syntax errors due to unexpected characters in the from name.
- Remove deprecated `jetpack_publicize_post` action.
- VideoPress now avoids PHP Notices when fetching video information.
- Instagram base URL now uses `www` in the Social Media Icons widget.
- All values entered in Facebook Page Plugin widget settings are now escaped.
- Widget Visibility now avoids memory issues on sites with a lot of registered users.

## [4.7.1] - 2017-03-14
### Bug Fixes
- Carousel: avoid javascript errors that may cause issues with Slideshows or Tiled Galleries.
- Markdown: always enable Markdown for posts whenever the module is active.
- Sharing: make sure that sharing buttons open in a small pop-up instead of a separate window.
- SSO: Avoid token or nonce errors when trying to log in to your site via the Secure Sign On option.
- VideoPress: add in the ability to get video thumbnails from the WordPress.com REST API.
- Widgets: improve rendering of the Image Widget via Photon.
- Widget Visibility: avoid empty widget visibility rules after updating to Jetpack 4.7.
- Widget Visibility: restore the option to make widgets appear on archive pages of different Custom Post Types.
- Widget Visibility: migrate widget visibility settings to the new major Page rule for Custom Post Types.
- Widget Visibility: add missing CSS for widget visibility settings on sites using an RTL language.

## [4.7] - 2017-03-07
### Enhancements
- Quickly jump to post specific stats on WordPress.com with a new link.
- We've added more information to our debug tools to improve your support experience.
- New HTML5 versions of our house ads are out.
- Display custom copyright EXIF information in the Carousel with this new filter.
- We've highlighted the ability to export Contact Form feedback as it was being overlooked.
- If you have images on WordPress.com we're going to skip using Photon when the images include resize parameters.
- It is now possible to use the Sharing filter to customize the emails sent from the Email Sharing button.
- We've updated the library powering the Print link in the Recipe shortcode.
- Customize the speed and display of your slideshows with new Slideshow shortcode filters.
- The Twitch.tv shortcode now uses Twitch's new embedded player.
- Social Menus now come with the option to use SVG icons.
- Customize the content of the Display Posts Widget with a new filter.
- We've added a new email field to the Contact Info Widget.
- The Image and the Text widgets now use Photon if it is enabled.
- The WordPress.com REST API got several updates including using `register_rest_route()` consistently for registering, new date and time format settings, a filter for theme info results, new links and endpoints, and more.
- We cleaned up the Google+ Shortcode JS library and added a way to filter the SlideShare shortcode.

### Performance Improvements
- Experience better performance with single page load caching of the media summary.
- We made some improvements to avoid slow queries on sites with thousands of images.
- The Top Posts widget now utilizes an endpoint from the WP.com REST API improving performance.
- Improve development mode performance by only calling `site_url()` once.
- We rewrote the way major/minor rules lists are generated to save bandwidth, and memory for sites using Widget Visibility.
- We've removed sync options that weren't needed to save memory during the sync process.

### Accessibility
- We've improved the highlight of the stats range for a better visual experience and to make it consistent with other areas of the dashboard.
- Added a missing label to one of the fields in the Email sharing dialog.
- We've enabled keyboard focus styling in the new admin interface.
- Increased padding to sharing buttons on mobile to avoid usability issues.
- We've replaced Widget Visibility text labels with icons to improve usability on smaller devices.

### Slightly Less Exciting Enhancements
- We've added a filter to allow you to remove the Comment Form title.
- The Development Mode notice got an update to include all possible options to activate Development mode.
- Jetpack registration function got an update and cleanup.
- A notice displayed to WooCommerce store owners now detects when WooCommerce Services is installed, but not active.
- We've removed the Holiday Snow settings until you need them.
- Improved Infinite Scroll settings to reduce confusion.
- The HTML classes `infinite-scroll` and `neverending` are now applied using JS instead of PHP.
- We've updated the support link appearing when you're locked out of your site.
- New Unit Tests were added to make sure Publicize doesn't break when making changes to the Publicize process.
- We've added a sync filter to allow customizing timeout.
- The Top Posts widget now supports non-square image sizes.
- Added the Video GUID to the media API endpoint.

### Improved Compatibility
- Fixed some W3C validation errors in Comments.
- Infinite Scroll now works beautifully with the Twenty Seventeen Theme.
- Translate new terms easier with an improvement to the translator comments.
- We switched to use Core functions to retrieve the list of sites in a multisite network for more accurate results.
- We added Product visibility to post meta whitelist, for better control of products displayed in Related Posts.
- We no longer sync specific post meta data added by Postman or WP RSS Multi Importer to avoid performance issues during the sync process.
- We're now avoiding conflicts with plugins adding the core Video upload library to the post editor.
- Removed deprecated compatibility code for older versions of WordPress.
- We had some Shortcode conflicts with WordPress Post embeds, but that's been fixed.

### Bug Fixes
- The Carousel `jp_carousel_load_for_images_linked_to_file` filter wasn't working well with Photon, this has been fixed.
- Carousel is now working well when loaded from infinite scroll.
- We removed double slashes from file paths in the Contact Form to avoid errors in specific server environments.
- Fixed a problem where CSS was being stripped when migrating from Jetpack's Custom CSS to Core's CSS editor.
- Our Debug Tool is now reporting the correct URL when WordPress lives in a subdirectory.
- Found and fixed a PHP error when uninstalling Jetpack.
- Infinite Scroll is no longer buggy when displaying the last page, and is more compatible with certain themes that were returning posts when there were none left to show.
- We're now skipping Photon for .ashx files.
- The Twitter character counter in Publicize got a fix to display info correctly.
- Related Posts are now displaying correctly for everyone, and we brought back the `jetpack_sharing_headline_html` filter.
- We've improved Sharing to render custom sharing services correctly, include Open Graph Meta Tags, and avoid JavaScript errors when jQuery is enqueued in the footer.
- Synchronization scheduling issues have been resolved.
- We're now trimming spaces in URLs for Image and Display Posts Widgets.
- Widget Visibility wasn't playing nice on taxonomy pages, this is no longer the case.
- The WordPress.com REST API received a couple of fixes to remove PHP errors when editing via the WordPress.com interface, authentication errors when using third-party apps, and permission errors when trying to preview edited posts in the WordPress.com editor.

## [4.6] - 2017-02-07
### New Features and Improvements
- Enable Google Analytics without touching a line of code with this new Jetpack feature.

### Performance Improvements
- We've updated all outbound links to use HTTPS to improve performance and security.
- Photon now leverages a new WordPress core function to improve performance a bit.

### Enhancements
- Keep an eye out for a note from WooCommerce on how your e-commerce store may benefit from our new USPS and CanadaPost shipping functionality.
- We've added an error message if Publicize isn't functioning as it should be.
- The Twitter Widget timeline now displays the tweet limit count as 20, prior to this it appeared to have no limit.

### Slightly Less Exciting Enhancements
- In an effort to help us better understand features that are being used, Twitter's timeline widget and Twitter's shortcodes now pass Jetpack's partner ID.
- We've added new API endpoints allowing us to enable translation auto-updates and pull post rows and metadata for backups.
- We're now retrieving all feature settings in the readable `/settings` endpoint.

### Improved Compatibility
- We've eliminated some notices and warnings when using Jetpack on a server running PHP 7.1 or on servers where `print_r()` is disabled.
- Photon now avoids PHP notices when your site is using plugins that do srcset CDN replacement.
- When the sharing options appear to be incorrect due to site configuration issues we force it to retrieve the right options avoiding potential fatal errors.
- We've added some shortcode CSS and widget class names prefixes to avoid conflicts with other plugins.

### Bug Fixes
- Some sites were using illegal multibyte characters and failing to sync posts, this has been fixed.
- IE11 was giving our admin layout a bit of a problem but we rectified that.
- There were some PHP notices popping up when a site has no posts so we got rid of them.
- The new Jetpack Ads feature will auto disable itself if your Jetpack plan doesn't support the feature.
- We fixed a few PHP notices and warnings related to the Custom CSS feature.
- The connection banner's "dismiss" icon was giving us a little trouble, but we got it fixed right up.
- The Likes feature was showing a PHP notice when there was no $post object, this has been fixed.
- We've brought back the Twitter Widget "noscrollbar" option.
- We're now forcing only Photon URLs to HTTPS as your custom CDN URLs may use a different protocol.
- If a Publicize connection is not shared with all users on the site, do not trigger Publicize for the other users.
- Publicize was having trouble working with scheduled posts, this should be fixed now.
- SSO may not have been displaying the login form when using JSON API authorization.  Sorry about that, we've fixed it.
- We've eliminated some PHP notices that were showing with some Shortcodes.
- There was a Top Posts Widget image size issue when using list layouts, but is no longer causing issues.
- We fixed some notices and warnings when updating data from the WordPress.com central interface.

## [4.5] - 2017-01-17

This release introduces a brand-new module, Jetpack Ads, a brand-new VideoPress feature, and a lot of new shortcodes and widgets.

### Exciting New Features and Improvements
- Generate revenue from your site with an all-new WordAds feature, which when enabled displays high-quality ads for your visitors.
- Today we are proud to release a fully redesigned VideoPress interface for easy uploading, management, and add-free playback of your fantastic videos now fully integrated with your Jetpack Premium or Professional plans.
- Spice up your sidebar with new widgets that display blog stats, author info, "Follow my blog" buttons, and even an event countdown.
- Embed your amazing 360Â° photos with the VR shortcode
- Link your visitors to your Tumblr or Twitch pages using the new icons in the Social Media Icons Widget.

### Enhancements
- Use the beautiful Jetpack carousel feature to display single images.
- Turn on and update Related Posts right from the Customizer.
- Customize the output of the Related Posts headline using a new filter.

### Performance and Security Improvements
- Your Custom CSS will now be served in a separate stylesheet when it is more than 2,000 characters.
- Your Stats queries are now always being made over HTTPS.
- Holiday Snow files now load in the footer, but rest assured the snow still falls from above.
- We have improved Jetpack's synchronization process to support more plugins and use less resources.
- The jQuery Cycle script used by slideshow galleries is now minified, resulting in faster loading times.

### Slightly Less Exciting Enhancements
- The JSON API now allows updating translations and alternative theme installation methods.
- Public Custom Post Types are now automatically available via the WordPress.com REST API.
- We've added a token-based authentication mechanism to the REST API in order for the site to be able to receive authenticated requests from WordPress.com.
- Use `sync` commands in Jetpack's WP CLI.
- You can now set the value for options directly in the Contact Form shortcode.
- Updated some verbiage around IP Whitelisting on the Protect settings screen.
- Custom sharing buttons got some new variables.
- RIP blip.tv â€” we've removed your shortcode.
- Improved Image and Display Posts Widget settings to provide more explanation and better error messages.
- We've added a few new Content Options to the Customizer for supported themes.
- Improved the Facebook Widget to avoid confusion when editing width and height settings.
- Added and improved a few shortcodes.

### Improved Compatibility
- If your server is misconfigured and we can't get an IP address we're going to deactivate Protect and send you a notice so you're in the loop.
- The WPML compatibility file wasn't loading at the right time, but we've fixed that.
- We've improved compatibility with tools like Cavalcade to avoid stuck Cron jobs.
- Some selected WooCommerce data (order items and order item meta) are now syncing to WordPress.com.

### Bug Fixes
- You'll notice numerous design improvements to the Jetpack UI.
- Accessibility is important to us so we've made some improvements there.
- Missing attachments in the Carousel were causing an infinite loop, but we've corrected that.
- Eliminated a PHP Notice when running the CLI `wp jetpack` command.
- PHP warnings in the Restaurant Menu Post type have seen their last day with us.
- Fixed a bug that displayed the wrong connected user for up to 24 hours after they disconnected.
- Removed a deprecated function to prevent notices when using Infinite Scroll in the Customizer.
- Long titles in Jetpack widgets weren't looking so great, so we cleaned them up.
- Before now you weren't able to create a child category from WordPress.com. Now you can!
- Rogue colons were showing up in the related posts area on sites with the Twenty Fourteen and Twenty Sixteen themes.
- Fixed a ReCaptcha error on the Email sharing button.
- Confirmed Instagram embeds actually load when using Infinite Scroll.
- Site Icons now display on the WordPress.com site management interface.
- Set a default time limit of 30 seconds when sending sync requests via Cron.
- Synchronized supported shortcodes on a site.
- Fixed an issue where empty categories weren't showing with the Widget Visibility feature dropdown.
- Fixed various little bugs when working with multiple widgets in the Customizer and in the Widgets admin screen.
- Added a Translate Widget default title in case you haven't defined one.
- The Top Posts Widget now avoids layout issues when using the Grid layout while displaying a post without an image.

## [4.4.2] - 2016-12-06

This release improves Jetpack compatibility with WordPress 4.7.

### Compatibility changes
- Custom CSS: Made the Custom CSS feature of Jetpack compatible with the CSS Customizer editor in WordPress 4.7.
- Sync: improved compatibility with the wp-missed-schedule plugin.

### Bug fixes
- Featured Content: made sure there is no infinite loop when removing the featured tag from the tag list.
- Admin: made sure help tabs are not being hidden.
- Admin: made At a Glance page work nicely when there is no backup data yet.
- Sync: now making sure that needed classes are loaded, preventing errors.
- Sync: cleared out unneeded scheduled jobs.

## [4.4.1] - 2016-11-22
### Bug Fixes
- Fixed an issue where some users with slower servers would get an error on
  the Jetpack dashboard when `WP_DEBUG` was enabled.
- Fixed an issue where users on a Jetpack Professional plan who were paying
  monthly (as opposed to annually) wouldnâ€™t be able to enable SEO Tools.

## [4.4] - 2016-11-21
### Enhancements
- Additional unit tests have been added to improve Jetpack's development process and stability.
- Custom post types have been added to the WP REST API output.
- Many of the screenshots throughout the plugin have been replaced by SVGs in order to make Jetpack smaller.
- New endpoints have been added to allow the installation of plugin and theme zip files via the API.
- Twelve new filters to make Jetpack more extensible!  See: http://wp.me/p5U9nj-2Ow.
- New widget: "Google Translate" to allow users to translate your site into their own language.
- New widget: "My Community" where you can see who recently interacted with your site.
- One of the biggest issues facing Jetpack users for years now has been difficulties in moving sites from one domain name to another. This update makes strides towards improving that process.
- Photon now uses HTTPS by default. Secure all the things!
- There are now helpful hints throughout the admin interface to make Jetpack easier to use.
- We now allow you to embed pins, boards and profiles from Pinterest.
- We've added a new feature: SEO Tools, available to Jetpack Professional subscribers. You can read more about our plans here: https://jetpack.com/features/
- We've made numerous improvements to the data sync process.

### Bug Fixes
- Fixed link to Akismet settings.
- Improved compatibility between Infinite Scroll and WPML.
- Move email notification settings back with the other email settings in the Discussion Settings.
- Various minor performance/compatibility fixes.

## 4.3.2 - 2016-10-13
### Enhancements
- Unsaved changes were getting lost when users were navigating away from settings so we put in a confirmation message to prevent this from happening.
- We've stopped counting carousel views in stats by default, you can use the `jetpack_enable_carousel_stats` filter to enable counting them again.
- Stats are now responding faster.
- There were several improvements and repairs made to sync including additional endpoints, performance enhancements, whitelisted data, better decision making around when to sync information, and more.
- Markdown now has a CSS class on footnotes.

### Improved Compatibility
- We've improved compatibility with Kinsta by automatically turning on Staging Mode for Jetpack when in a staging environment.

### Bug Fixes
- Several fixes have been made to sync to repair issues with Publicize, Notifications, and Subscriptions.
- We removed PHP warnings by checking to make sure json language files like jetpack-en_US.json are readable before we load them.
- We found an unused option in Gravatar Hovercard settings and removed it.
- The correct support link is now being used to make it easier for you to connect with the Jetpack team if you need us.
- The permissions check for plugin information retrieval was fixed as well.
- Some plugins were adding content on outbound http requests causing an infinite loop we fixed this right up.
- We removed some warnings that were occurring when translations didn't exist by adding a fallback.
- We've added Moroccan Arabic translations, and switched to language packs for Croatian, Spanish (Chile) and Greek.
- Sync was running into issues so we've limited dequeue time to 1/3 of PHP's max execution time, which has unclogged the problem.
- We're now sending full and incremental queues separately so that a failure in one doesn't block the other.
- There was a JavaScript enqueuing error with our Sharing feature that has been repaired.
- The Top Posts widget now includes the ability to list attachment (media) pages.
- We weren't building CPT links correctly resulting in bad navigation, which is now fixed.
- We removed the form legend for default Tiled Gallery settings as it doesn't relate.
- With shortcodes we now return early from processing them if no string is passed, as they are required.

## 4.3.1 - 2016-09-08
### Support Enhancements
- We're now syncing data about hosts so that we can provide better support
  when needed.
- Minor update to inline docs to match version numbers.

### Bug Fixes
- Admin Page: fix error when Admin Page resources could not be fetched with
  `wp_remote_get` due to unique host configurations.
- Admin Page: fix error when Post By Email could not be enabled when the
  browser's dev console was enabled.
- Admin Page: make sure all translated strings are encoded properly.
- Admin Page: only use POST requests for updating the state of Jetpack, to
  avoid issues on servers not allowing PUT requests.
- Admin Page: search icon no longer overlaps the global notices.
- Admin Page: make sure that non-admins can also modify Spellchecking
  settings.
- Admin Page: check that a json language file like jetpack-en_US.json is
  readable before loading its contents and thus avoid a PHP warning.
- General: Improve random number generation for compatibility with more hosts.
- General: Add deprecated PHP file (class.jetpack-landing-page.php) back as an
  empty file, to avoid generating fatal errors on sites with aggressive caching.
- General: Ensure concatenated CSS is generated for RTL languages.
- Security: Ensure that all options are included on the security tab.
- Stats: fix display for sites with pretty permalinks disabled.
- Subscriptions: ensure that no email is sent when updating a published post.
- Sync: To improve performance, add snapTW to the list of post meta data that
  won't be synchronized for each post.
- Sync: do not schedule a full sync after each import.
- Verification Tools: in the Settings card, use appropriate link for each
  service.

## 4.3 - 2016-09-06
### Exciting Performance and UI Improvements
- We have launched the all new React powered interface, a year in the making,
  designed to give you better control of your favorite Jetpack features.

## 4.2.2 - 2016-08-19
### Bug Fixes
- We fixed the code which displays the Facebook share count to accomodate
  Facebook's new data structure.
- We fixed an issue which caused PHP notices to get logged for users of the
  Twenty Fourteen theme.
- We fixed an issue with the Minileven mobile theme which was preventing it
  from loading.
- Improved Sync performance.
- Increase security by sanitizing a URL used in the SSO process.

## 4.2.1 - 2016-08-17
### Bug Fixes
- We fixed a conflict between Jetpack and W3 Total Cache.
- We fixed some issues with Publicize and Custom Post Types.
- Very large Multisite networks with lots of users can now be synchronized
  with WordPress.com.
- We improved the synchronization process between your site and WordPress.com.

## 4.2 - 2016-08-10
### Performance Enhancements
- Weâ€™ve improved Jetpackâ€™s performance by making calls to the database more
  efficient; essentially, Jetpack is doing less on each page load, making things
  faster. #4281, #4316
- Weâ€™ve ensured that every feature uses information that is up to date by
  completely refactoring the way information was synchronized between your site
  and WordPress.com.
- We've improved the way Jetpack queries for information about features, which
  results in less overall queries.

### Exciting Feature and UI Improvements
- We now track your visitor views of Carousel images in stats.
- You can now customize advanced typographic settings like ligatures in the
  Custom CSS editor with new support for the `font-feature-settings` property.
- Weâ€™ve improved the experience when you donâ€™t actually have enough posts to
  Infinitely Scroll.
- Our Contact Info Widget allows you to enter a Google Maps API Key which is
  now required by Google if you want to display a map.

### Security
- Weâ€™re continuing our efforts to harden Jetpack security, by implementing the
  `hash_equals()` function to avoid timing attacks when comparing strings. We
  also improved security on CSVs exported from your contact form.

### Slightly Less Exciting Feature Improvements
- The Cartodb shortcode has been changed to match the new product name, Carto.
- The YouTube shortcode now uses the content width defined by the theme when
  available, even if an embed size was defined in an old version of WordPress.
- Breadcrumbs now support hierarchical post types and taxonomies.
- Weâ€™ve added the Portfolio Post Type to the WordPress.com REST API whitelist.
- There are a few new parameters for the Dailymotion shortcode.

### Improved Compatibility
- We now work well with WP Stagecoach staging sites, so you should not see any
  future impact on production sites.
- We had some PHP notices popping up in the WooCommerce plugin wizard screen,
  these are gone.

### Bug Fixes
- We stopped loading compatibility stylesheets on the default theme's singular
  views for Infinite Scroll.
- Debug tests forwarded through the contact form in the Jetpack Debug menu are
  now successfully sent to the support team.
- Weâ€™ve removed the PHP notices you might have seen when moderating comments.
- There are no longer PHP notices cropping up when publishing via Cron.
- Weâ€™ve fixed the official Sharing buttons so they now line up just right.
- The PHP warnings of Sitemaps stylesheets have been eliminated.
- Weâ€™ve done away with the warnings that appeared when Tonesque processes a
  file which claims to be one filetype, but is actually another.
- Weâ€™ve exterminated PHP notices that appeared when using Random Redirect, as
  well as when the author wasn't set.

## 4.1.1 - 2016-07-07
### Bug Fixes
- SSO: Use high-resolution Gravatar images on the log-in form on Retina
  devices.
- Publicize: improve reliability of Publicize when publishing new posts.

## [4.1] - 2016-07-06
### Performance Enhancements
- Carousel no longer loads full-size images in the previous and next previews,
  increasing the speed and performance of slideshows.
- Weâ€™ve improved Jetpackâ€™s performance by making calls to the database more
  efficient; essentially, Jetpack is doing less on each page load, making things
  faster.
- Weâ€™ve improved Photon dev mode, eliminating unnecessary attempts to sync
  images.

### Exciting Feature and UI Improvements
- A new look: SSO, redesigned and refactored, provides a new and improved
  experience.
- Tracking made simple: quickly view the number of unread feedback submissions
  in your sidebar.
- Getting support just got easier! Access improved self-help tools in the
  Jetpack Debug menu.
- Greater control over Infinite Scroll: pause and resume Infinite Scroll with
  two new JavaScript methods.
- Improved Sharing: weâ€™ve swapped image icons for icon fonts and added
  Telegram and WhatsApp buttons.
- Untappd shortcode: now you can sip and share your favorite craft brews.
  Cheers!
- Recipes, revamped: weâ€™ve added new recipe shortcodes and options to create
  more detailed recipes.
- Improved Gallery Widgets now use Photon to resize and serve images.

### Security
- Weâ€™re continuing our efforts to harden Jetpack security by implementing the
  `hash_equals()` function in an effort to avoid timing attacks when comparing
  strings.
- Weâ€™ve made it easier to use SSL connections on ports `80` and `443`,
  improving our ability to communicate with an increased number of secure
  websites.
- You will now receive a warning for any failed attempts when connecting your
  website via SSL.

### Slightly Less Exciting Feature Improvements
- Updated the Infinite Scroll settings verbiage, which was a bit confusing.
- Removed Jetpack Audio Shortcode, which is no longer in use.
- Redesigned Jetpack banner notices to match core notification styles.
- Added an icon on a connected Jetpack userâ€™s profile page, next to their
  name.
- Added the ability to edit Portfolio custom-post-type options in the
  Customizer.
- Added a new filter called `jetpack_publicize_capability` which allows you to
  override user role restrictions for Publicize.
- Improved the connection process between Jetpack and WordPress.com making it
  easier to start using Manage.
- Updated the Top Posts Widget so you can use and display posts that are older
  than 10 days.
- Updated the Twitter Timeline Widget to support updates made by Twitter.
- Improved the VideoPress Shortcode modal.
- Updated VideoPress, which now defaults to HTML5 videos when the `freedom`
  shortcode parameter is in use.
- Improved how Jetpack syncs by removing mock options.
- Updated the naming convention for feedback posts.
- Updated several JSON API endpoints to match WordPress.com endpoints, added
  support for custom taxonomies, and enabled trash as a valid status for the
  post update endpoint.

### Improved Compatibility
- A community member found and fixed a compatibility issue with our Open Graph
  Meta Tags and Bitlyâ€™s older plugin -- we now check to make sure we donâ€™t
  create conflicts.
- Weâ€™ve fixed a rare scenario where an error would occur when other plugins or
  sites were using the `JETPACK__GLOTPRESS_LOCALES_PATH` constant.

### Bug Fixes
- Comment avatars are now retrieved in a manner more consistent with the login
  avatar, improving consistency and eliminating the possibility of a future bug.
- We eliminated PHP notices that were appearing when Custom Content Types were
  defined without labels or sections.
- PHP memory limits were reached in rare cases when a website had thousands of
  revisions of their Custom CSS. The issue is fixed -- happy editing!
- jQuery deprecated the `size()` function -- as a result, weâ€™ve stopped using
  it as well.
- A PHP notice popped up when plugins were updated from the WordPress.com
  plugin management interface -- these notices will no longer appear.
- We fixed a bug where Photon wasnâ€™t providing the original size for images
  that were being used outside of the post content.
- We eliminated the PHP notices that displayed when posts with slideshows were
  added to a sitemap.
- We fixed an error that was showing up in Sitemaps when a website permalink
  structure used `index.php`.
- We eliminated JavaScript errors that displayed when tiled galleries were
  viewed.
- We fixed an issue where image dimensions werenâ€™t properly saved when added
  to a new widget.
- Since Google Maps API keys are now required to use maps, weâ€™ve updated the
  Contact Info Widget to allow site owners to set up their keys.
- We fixed a bug where multiple `display` properties werenâ€™t able to be saved
  in Custom CSS.

## [4.0.4] - 2016-06-20
### Security
- Post By Email: Added an additional layer of security to prevent unauthorized
  changes to Post By Email settings.
- Likes: Fixed an XSS vulnerability in the Likes module.
- REST API/Contact Form:  We've eliminated unauthenticated access to Feedback
  posts.

### Feature Improvements
- Customizing Protect: We've increased Protectâ€™s response time and added a new
  filter, `jetpack_protect_connect_timeout`, reducing the likelihood of seeing
  the fall back form.
- Connection Process: Your site url and icon are displayed on the Jetpack
  connection screens to help improve communication.
- Jetpack for Multisite: Itâ€™s now easier to manage your Jetpack connections on
  the network admin screen.
- Photon Responsive Image Improvements: Weâ€™re now auto-generating new scrset
  options, improving how images served from Photon are handled.
- Developing on Kinsta: A new constant has been added to improve developing
  with Jetpack on a staging environment hosted with Kinsta.

### Jetpack UI Improvements
- Better Access to Our Support Team: We wanted to make it easier for you to
  get help so we added a contact form in the admin that links directly to our
  Jetpack Support Team.

### Improved Compatibility
- Weâ€™ve stopped adding Open Graph Meta tags if youâ€™re using the SEO Framework
  plugin.
- Having both GlotPress and Jetpack active at the same time was causing
  errors, weâ€™ve eliminated them.

### Bug Fixes
- Fixed the handling of special characters like ampersands in Carousel Titles
  and Descriptions.
- When visitors tried to view a Carousel image with a hash in the URL, a
  JavaScript error would occur; weâ€™ve fixed that.
- Jetpack Comment form fields now use the default language youâ€™ve set for
  WordPress, previously the verbiage was always in English.
- Custom CSS wasnâ€™t handling slashes and quotes properly; weâ€™ve squashed that
  bug.
- There were some rare cases where PHP notices were popping up when a Contact
  Form was submitted. These instances have been identified and eliminated.
- Weâ€™ve replaced a bit of code with a Jetpack native function to fix a bug
  that was breaking things during an API request for available updates.
- We accidentally removed the ability for Open Graph to select images from
  slideshows, itâ€™s up and running again.
- There was an issue where Open Graph meta tags werenâ€™t being set when your
  homepage is a â€œStatic Front Pageâ€, itâ€™s working again.
- In rare cases when developers were customizing Photon they were seeing a PHP
  notice when arguments were passed as a string rather than an array. This has
  been fixed.
- Weâ€™ve fixed an issue where Protectâ€™s backup math form wasnâ€™t showing on
  custom front end login forms.
- When setting up WooCommerce you might have seen a Related Posts notice which
  didnâ€™t belong. Weâ€™ve eliminated them.
- If youâ€™ve been using our sharing tool with unofficial sharing buttons you
  might have noticed your sharing numbers were missing. Theyâ€™re now back.
- In unique situations where special characters were used in sitemap
  stylesheets an error would occur; that has been remedied.
- Weâ€™ve fixed a problem with mismatching HTML tags in our Spelling and Grammar
  feature.
- Weâ€™ve ensured that the `jetpack_disable_twitter_cards` filter actually
  removes Twitter cards.
- Weâ€™ve fixed some JavaScript errors that would crop up if you were editing a
  custom-post-type post that didnâ€™t support the core media editor â€” say that 10
  times fast.
- We had some JavaScript errors when you were using the customizer to modify
  widgets. They are no longer with us.

## [4.0.3] - 2016-05-26

- Important security update. Please upgrade immediately.

## 4.0.2 - 2016-04-21
### Bug Fix
- Addresses an issue where Jetpack 4.0 caused a fatal error on sites with
  specific configurations.

## [4.0] - 2016-04-20
### Performance Enhancements
- Protect: the routine that verifies your site is protected from brute-force
  attacks got some love and is more efficient.
- Contact Forms: cleaning the database of spam form submission records is more
  efficient.

### Feature Improvements
- VideoPress: edit your VideoPress shortcode in the editor with a fancy new
  modal options window.
- Custom Content Types are now classier: a new CSS class on Testimonial
  featured images â€” has-testimonial-thumbnail â€” allows you to customize Jetpack
  custom post types as you see fit.
- Sharing: social icons are now placed under the "add to cartâ€ singular
  product views in WooCommerce, making it easier for customers to share your
  products on social media.
- Theme Tools: search engines will now have an easier time knowing what page
  they are on, and how that page relates to the other pages in your site
  hierarchy with improved schema.org microdata for breadcrumbs.
- Widget Visibility: now you can select widgets and when to show or hide them
  right from custom post type single and archive views.

### Jetpack UI Improvements
- Whatâ€™s in it for me? Weâ€™ve done a better job explaining the benefits of
  Jetpack and connecting it to WordPress.com.
- Shortcodes: handy links to shortcode documentation convey the types of media
  you can quickly and safely embed.
- Widgets: As of WordPress 4.5, Jetpack widgets now refresh in the customizer
  without making you refresh the entire page. Live previews, yes indeed.

### Bug Fixes
- Comments: we fixed a mistake where a comment subscription checkbox appeared
  on custom post types â€” despite the fact you couldnâ€™t actually subscribe to
  those types of comments. Our bad.
- Contact Forms: we fixed a bug where the telephone field (which can only be
  added manually) rendered incorrectly â€” breaking some forms in the process.
- General: we blocked direct access to the Jetpack_IXR_Client class which
  caused fatal PHP errors in some server setups.
- Shortcodes: we removed the frameborder attribute in the YouTube embed code.
  It was deprecated in HTML 5.
- Unminified responsive-videos.min.js in order to address a false positive
  virus alert in ClamAV. Expect it to be re-minified in 4.0.3 once we resolve
  the issue with ClamAV.

## [3.9.6] - 2016-03-31

Bug fix: Shortcodes: fixed incorrect Vimeo embed logic.

## [3.9.5] - 2016-03-31

This release features several WordPress 4.5 compatibility changes that make
several Jetpack features work properly in the Customizer view. Big thanks to
@westonruter for contributing the code!

### Other enhancements and bug fixes
- Contact Form: no longer calling the datepicker method if it's not available.
- SSO: settings checkboxes now honor filters and constants that restrict
  certain sign-in modes.
- Shortcodes: fixed a problem with Gist fetching.
- Shortcodes: fixed invalid HTML5 markup in YouTube embed code.
- Shortcodes: made the Vimeo links work properly in case of multiple mixed
  uses in one post.

## [3.9.4] - 2016-03-10

Bug fix: Shortcodes: Addresses an issue with embedded Vimeo content

## [3.9.3] - 2016-03-09
### Featured
- Site Logo now supports Custom Logo - a theme tool to be introduced in
  WordPress 4.5.

### Enhancements
- Carousel: Made the full size image URL use a Photon URL if enabled.
- Comments: Removed an unnecessary redirect by always connecting via HTTPS.
- General: Added new actions that fire before automatic updates.
- Infinite Scroll: Introduced a later filter for settings.
- Infinite Scroll: Removed code that is now redundant due to WordPress Core.
- Markdown: Removed deprecated markup from the output.
- Publicize: Improved handling of featured images in posts.
- Shortcodes: Added houzz.com support.
- Sitemaps: Added a language attribute to the news sitemap.
- Sitemaps: Improved the image retrieval mechanism for posts.
- Widgets: Added new filters in the Top Posts Widget code.
- Widgets: Cleaned up the CSS for the Subscription widget.

### Bug Fixes
- Comments: No longer reloading the page on clicking the reply button.
- Contact Forms: Fixed a fatal error on missing metadata.
- Contact Forms: Fixed message formatting for plaintext email clients.
- Shortcodes: Fixed dimensions of Vimeo embeds in certain cases.
- Shortcodes: Fixed warnings and allowed shorter style Vimeo embeds.
- Shortcodes: Removed alignment markup from feeds for YouTube embeds.
- Sitemaps: Made URLs display properly according to the permalink structure.
- Stats: Fixed non-XHTML-valid markup.
- Widgets: No longer showing errors when adding new instances of the Display
  Post Widget.

## [3.9.2] - 2016-02-25

Maintenance and Security Release

### Featured
- Beautiful Math: fix XSS vulnerability when parsing LaTeX markup within HTML
  elements.
- Contact Form: do not save private site credentials in post meta. Thanks to
  @visualdatasolutions.

### Enhancements
- Contact Info: Added two hooks for adding arbitrary information to the
  widget.
- Development: Added new possibilities for REST API debugging.
- Embeds: Added Codepen embeds support.
- Embeds: Added Sketchfab embeds support.
- I18n: Added support for translation packages for the Finnish language.
- Markdown: Added a filter to enable skipping processing of developer supplied
  patterns.
- Related Posts: Added a filter to change heading markup.
- Staging: Added a constant to force staging mode.
- Staging: Added a notice to make staging mode more obvious.
- Top Posts Widget: Added a new `[jetpack_top_posts_widget]` shortcode.

### Bug Fixes
- Custom Post Types: Nova: Fixed a JavaScript bug on adding multiple items.
- Embeds: Allowing embeds from Instagram with a www in an URL.
- General: Fixed untranslated module names on the Settings screen.
- General: Improved module descriptions and fixed misleading or broken links
  in descriptions.
- General: No more notices on module deprecation on older installations.
- General: Only showing one prompt to enable Photon when uploading several new
  images.
- Multisite: Fixed a problem with site lists for older WordPress
  installations.
- OpenGraph: Fixed a bug to properly fallback to a WordPress Site Icon image.
- Photon: Improve performance for images over a secure connection.
- Photon: No longer including links from data attributes.
- Publicize: Fixed problems for en_AU and en_CA locales with Facebook.
- Related Posts: Fixed a notice on certain requests.
- Site Logo: It's no longer possible to choose a non-image.
- Widget Visibility: No longer confusing page IDs and titles in certain cases.

## 3.9.1 - 2016-01-21
### Bug Fixes
- General: Addresses a namespacing issue which was causing conflicts on some
  hosting providers.
- Sitemaps: Added MSM-Sitemap to the list of plugins which, if installed, will
  prevent Jetpack Sitemaps from being used

## [3.9] - 2016-01-20
### Featured
- New sharing button: let users share your content using Skype.
- New "Social Menu" theme tool that uses Genericons to display Social Links.
- Sitemap support for better search engine indexing.

### Enhancements
- Contact Form: Added a new filter that allows you to change the "Required"
  text.
- General: Hidden archived sites in multisite site list.
- General: Removed several function calls that would be deprecated in
  WordPress 4.5.
- Infinite Scroll: Added a new filter to check if Infinite Scroll has been
  triggered.
- Likes: Added a conditional to ensure WordPress 4.5 compatibility.
- Photon: Improved compatibility with responsive images feature added in
  WordPress 4.4.
- Photon: Now enabled by default on sites using HTTPS.
- REST API: Extended the ability to manage users from WordPress.com.
- REST API: Increased the performance of the plugin update endpoint.
- Responsive Videos: Centering videos when they are wrapped in a centered
  paragraph.
- Sharing: Added a new filter to customize the default OpenGraph description.
- Shortcodes: Added Wistia oEmbed support.
- Shortcodes: Bandcamp: Added support for new attributes for tracks approved
  by artists.
- Shortcodes: Improved Medium path format recognition.
- Slideshow: Improved compatibility with older IE versions.
- Staging: Improved staging environment detection.
- Widgets: Added "width" option to the Facebook Page widget.
- Widgets: Added size parameters to tags in Top Posts to avoid warnings.
- Widgets: Introduced major performance and stability improvements to the
  Display Posts Widget.
- Widgets: Refactored to remove deprecated code patterns.

### Bug Fixes
- AtD: Fixed replacing emojis with images in the text editor in Chrome.
- AtD: Made pre tags be excluded from spell-checking.
- CPT: Not registering Nova if it is already registered.
- Carousel: Fixed a bug where full size images were not always served by
  Photon.
- Carousel: Reverted a change that broke direct link to carousel image.
- Contact Form: Fixed a CSV export bug with multiple choice questions.
- Contact Form: Fixed notices when creating feedback entries without a contact
  form.
- General: Fixed a scrolling bug on modal window closing.
- Infinite Scroll: Disabled in the Customizer when previewing a non-active
  theme.
- Publicize: Fixed notices appearing with bbPress or BuddyPress installed.
- Publicize: Showing options only to users that can change them.
- Related Posts: Fixed incorrect URLs generated for posts.
- Responsive Videos: Fixed warnings in debug mode.
- Shortcodes: Bandcamp: Fixed a problem with large track IDs.
- Shortcodes: Fixed a problem with dynamic Gist embeds.
- Stats: Fixed dashboard widget resize problem.
- Widgets: Added a fallback to English US when a locale isn't supported by
  Facebook.
- Widgets: Fixed layout for Twenty Sixteen.

## [3.8.2] - 2015-12-17

Jetpack 3.8.2 is here to squash a few annoying bugs.

### Bug Fixes
- Photon: Fixed a bug where some custom thumbnail image sizes weren't being
  sized properly.
- Shortcodes: Fixed an incompatibility with how WordPress renders the YouTube
  shortcode.
- Shortcodes: Tightened up security in the Wufoo shortcode.
- Image Widget: Now shows the caption.
- Fixed typos in inline docs.
- Very minor fixes to: Carousel, Publicize, Google+, and Infinite Scroll.

## [3.8.1] - 2015-12-01

Jetpack 3.8.1 is here and is fully compatible with WordPress 4.4.

### Featured
- Photon + Responsive Images FTW.
- Fully compatible with Twenty Sixteen.
- More accessibility enhancements.
- Dropped some weight by optimizing Jetpack's plugin images.

### Enhancements
- Comments: filter to allow disabling comments per post type.

### Bug Fixes
- Carousel: Stop page from scrolling to top when Carousel is closed.
- Carousel: Browser compatibility fixes with older version of IE.
- Markdown: Fixed a bug that would strip markdown when saving in "Quick Edit"
  mode.
- Single Sign On: Fixed login always redirecting to the admin dashboard.
- Subscriptions: Filter to allow per-post emails fixed for use in themes.

## [3.8.0] - 2015-11-04

We're happy to introduce Jetpack 3.8, which has significant contributions from
the Jetpack community. Read more about it here: http://wp.me/p1moTy-1VN

### Feature enhancements
- New Google+ Badge Widget. Display your profile, page, or community Google+
  badge.
- New twitch.tv shortcode embeds. Display a Twitch.tv stream in your posts.
- Accessibility enhancements.
- A handful of new filters to allow further customization of Jetpack.

### Other enhancements
- Carousel: Added support to retrieve image dimensions from an image url.
- Carousel: Simpler algorithm to detect shutter speeds.
- Contact Form: New "Checkbox with Multiple Items" field available in the
  Contact Form.
- Contact Form: Allow pre-filling form fields with URL parameters.
- Contact Form: Better styling of the emailed form responses.
- Performance: Replaced some custom-built functions with core's native
  functions.
- Related Posts: New filter to add post classes to post's container class.
- Sharing: New filter to choose if sharing meta box should be shown.
- Sharing: New filter to allow sharing button markup to be editable.
- Sharing: New filter to allow you to specify a custom Facebook app ID.
- Social Media Icons Widget: Added option for YouTube username as well as
  Channel ID.
- Social Media Icons Widget: Added Google+ icon.
- Social Media Icons Widget: New filter to allow you to add your own social
  media icons and links.
- Subscriptions: Better errors to your visitors if their subscription sign-up
  fails.
- Subscriptions: Removed "widget" class from Subs shortcode form.

### Bug fixes
- Carousel: Fixed browser back/forward button behavior.
- Contact Form: Allow the email field to be set to empty when building form in
  post editor.
- Facebook Likebox Widget: Fixed an issue where some languages were not
  translating.
- Facebook Likebox Widget: Return a language when none found.
- General: Fixed some minor styling issues in the Jetpack admin areas.
- General: Add missing parameter to the_title filter call.
- General: Prevent scrolling of body when the Jetpack admin modals are opened.
- General: Update doc to reflect that Open Graph filter
  jetpack_enable_opengraph has been deprecated in favor of
  jetpack_enable_open_graph.
- Infinite Scroll: Fixed an error that sometimes occurred that would stop
  posts from loading.
- JSON API: Fixed some undefined notices when publishing a post with the API.
- Open Graph: Fixed bug where facebook description content was sometimes being
  polluted by a filter.
- Sharing: Use full SSL Pinterest url instead of protocol relative.
- Sharing: Fixed plus signs appearing in tweets shared from iOS.
- Shortcodes: Prefer HTTPS for video embeds to avoid mixed content warnings.
- Subscriptions Widget: Fix HTML Validation error.
- Theme Tools: Check oEmbeds for the presence of a video before adding the
  responsive videos filter.
- Tiled Galleries: Add image alt attribute if there is a title set. This was
  breaking some screen reader functionality.

## [3.7.2] - 2015-09-29

- Bug Fix: REST API: Fixed an error when saving drafts and publishing posts

## [3.7.1] - 2015-09-28

- Enhancement: General: Added inline documentation for various filters and
  functions
- Enhancement: General: Added custom capabilities for module management on
  multi-site installs
- Enhancement: General: Cleaned up old changelog entries from readme
- Enhancement: General: Cleaned up unused i18n textdomains
- Enhancement: General: Updated the new settings page to look better in
  various translations
- Enhancement: REST API: Added new endpoints to manage users
- Enhancement: Sharing: Updated the Google logo
- Bug Fix: Carousel: Page scroll no longer disappears after closing the
  carousel
- Bug Fix: Contact Form: Fields are sent and displayed in the correct order
- Bug Fix: Contact Form: No longer showing a notice on AJAX actions in
  feedback lists
- Bug Fix: Contact Form: Made using more than two notification emails possible
- Bug Fix: Contact Form: Mitigate a potential stored XSS vulnerability. Thanks
  to Marc-Alexandre Montpas (Sucuri)
- Bug Fix: General: Mitigate a potential information disclosure. Thanks to
  Jaime Delgado Horna
- Bug Fix: General: Fixed a locale error in the notifications popout
- Bug Fix: General: Fixed a possible fatal error in the client area
- Bug Fix: General: Fixed compatibility issues with certain use cases
- Bug Fix: General: Disabled connection warnings for multisites with domain
  mapping
- Bug Fix: General: Updated translations for correct link display in admin
  notices
- Bug Fix: REST API: Fixed a fatal error in one of the endpoints
- Bug Fix: Sharing: Fixed OpenGraph tags for Instagram embeds
- Bug Fix: Sharing: Fixed compatibility issues with bbPress
- Bug Fix: Widget Visibility: Fixed a fatal error in case of a missing tag

## [3.7.0] - 2015-09-09
### Feature Enhancements
- New admin page interface to easily configure Jetpack
- Added staging site support for testing a connected Jetpack site

### Additional changes
- Enhancement: CLI: Added a possibility to change all options with
  confirmation for some of them
- Enhancement: Gallery: Added filters to allow new gallery types to be
  declared
- Enhancement: General: Added inline documentation for actions, filters, etc.
- Enhancement: General: Changed class variable declarations keyword from var
  to public
- Enhancement: General: Made the Settings page module toggle buttons more
  accessible
- Enhancement: General: The admin bar now loads new notifications popout
- Enhancement: General: Renamed some modules to avoid redundant prefixes
- Enhancement: General: Switched to the WordPress Core's spinner image
- Enhancement: General: Updated the bot list
- Enhancement: Manage: Added the ability to activate a network-wide plugin on
  a single site from WordPress.com
- Enhancement: Photon: Added a way to check image URLs against custom domains
- Enhancement: Photon: Added prompts on the media upload page telling the user
  about Photon
- Enhancement: Publicize: Added width and height values to OpenGraph tags for
  default images
- Enhancement: Related Posts: Added a filter to allow disabling nofollow
- Enhancement: REST API: Added new API endpoints to extend API functionality
- Enhancement: REST API: Added new fields to existing API endpoints
- Enhancement: Sharing: Added a possibility to opt-out of sharing for a single
  post
- Enhancement: Sharing: Added bbPress support
- Enhancement: Sharing: Added more configuration to the Likes modal
- Enhancement: Sharing: Made the reddit button open a new tab
- Enhancement: Sharing: Removed unused files
- Enhancement: Shortcodes: Added auto embed option inside comments
- Enhancement: Shortcodes: Added autohide parameter to the YouTube shortcode
- Enhancement: Subscriptions: added an action that triggers at the end of the
  subscription process
- Enhancement: VideoPress: Videos are now embedded using a new player
- Enhancement: Widget Visibility: Added parent page logic
- Enhancement: Widget Visibility: Added support for split terms
- Enhancement: Widgets: Added actions to the Social Media widget
- Enhancement: Widgets: Switched the Display Posts widget to the new API
  version
- Bug Fix: General: Fixed scrolling to top after modal window closing
- Bug Fix: Infinite Scroll: Added a check for cases when output buffering is
  disabled
- Bug Fix: Infinite Scroll: Added translation to the copyright message
- Bug Fix: Manage: Fixed automatic update synchronization on WordPress
  multisite network admin
- Bug Fix: Manage: Redirects back to WordPress.com are allowed from the
  customizer view
- Bug Fix: Media: Fixed duplicate images bug in the Media Extractor
- Bug Fix: Publicize: Made it possible to remove previously set message
- Bug Fix: Sharing: Added a thumbnail image to OpenGraph tags on pages with
  DailyMotion embeds
- Bug Fix: Sharing: Fixed Twitter Cards tags escaping
- Bug Fix: Sharing: Made OpenGraph tags for title and description use proper
  punctuation
- Bug Fix: Sharing: Made sure Likes can be disabled on the front page
- Bug Fix: Shortcodes: Fixed Facebook embeds by placing the scipt in the
  footer
- Bug Fix: Shortcodes: Fixed PollDaddy shortcode issues over SSL connections
- Bug Fix: Shortcodes: Made responsive video wrappers only wrap video embeds
- Bug Fix: Shortcodes: Made SoundCloud accept percents for dimensions
- Bug Fix: Social Links: Fixed a possible conflict with another class
- Bug Fix: Stats: Made sure the Stats URL is always escaped properly

## 3.6.1 - 2015-07-24

- Enhancement: Fully compatible with upcoming WordPress 4.3
- Enhancement: Site Icon: Start to deprecate Site Icon in favor of Core's
  version (if available)
- Bug Fix: Subscriptions: You can now use more than one Subscription form on a
  single page
- Bug Fix: Quieted PHP notices and warnings with the JSON API, Display Posts
  Widget and Gallery Widget (slideshow mode)
- Bug Fix: Correct permissions check for connection panel
- Hardening: Increase permissions checks

## [3.6] - 2015-07-06
### Feature Enhancements
- CLI: Add a number of Jetpack CLI improvements: see
  http://jetpack.com/support/jetpack-cli
- New Jetpack admin page for connection management
- New Social Media Icons widget
- FB Like Box: A visual refresh of the Facebook likebox widget
- Protect: When your IP is blocked, use a math captcha as a fallback instead
  of a complete block

### Additional changes
- Enhancement: Custom CSS: Add more Flexbox support and other enhancements
- Enhancement: Extra Sidebar Widgets: Top Posts Widget: Choose what Post Types
  to display
- Enhancement: General: Save on some requests! print CSS inline when there
  isn't much of it
- Enhancement: Likes: Likes can now be shown on all post types
- Enhancement: Minileven: Add Featured Image to Gallery Post Format and Pages
- Enhancement: Mobile Theme: Add div wrapping View Mobile Site link to allow
  for easier CSS customizations
- Enhancement: Omnisearch: Link to edit post in titles
- Enhancement: Protect: Learn Trusted Headers locally and cache blocks
  properly
- Enhancement: REST API: Add locale support
- Enhancement: Sharing: Retire StumbleUpon
- Enhancement: Sharing: Upgrade to reCAPTCHA 2.0 for Email Sharing
- Enhancement: Shortcode Embeds: Add Mesh oembed support
- Enhancement: Shortcode Embeds: New Wufoo Shortcode from WordPress.com
- Enhancement: Shortcode Embeds: Mixcloud: handle accented characters in URLs
- Enhancement: Site Logo: Adding itemprops to support logo schema.
- Enhancement: Slideshow Gallery: New parameters *size* and *autostart*
- Enhancement: Slideshow Gallery: Use more reliable CSS for resizing instead
  of js
- Enhancement: Stats: No longer track stats for preview pages
- Enhancement: Tiled Gallery: Improve the shapes and distributions of shapes
  in the Tiled Gallery, based on observations for its usage.
- Enhancement: Protect: Whitelist for multisite globally and locally
- Enhancement: Sharing: LinkedIn always uses https for share counts. (saved
  extra http request)
- Bug Fix: Carousel: Jetpack Carousel now supports HTML5 gallery
- Bug Fix: Extra Sidebar Widgets: Choose Images button works in accessibility
  mode
- Bug Fix: General: Fix: Cannot remove hooks from filter
  'jetpack_get_available_modules'
- Bug Fix: Infinite Scroll: Check that search terms exist before matching
  against post title. fixes #2075
- Bug Fix: Likes: Never double show on search results
- Bug Fix: Notifications: Notifications didn't load on wp-admin/network pages
- Bug Fix: Sharing: Fix Facebook share button not showing for Australian &
  Canadian locale
- Bug Fix: Shortcode Embed: Slideshare Shortcode now fixed
- Bug Fix: SSO: Hide login no matter what when using the filter to do so
- Bug Fix: Subs Widget: Don't hide email input if submit failed
- Bug Fix: Tiled Gallery: Show columns setting for Thumbnail Grid when Tiled
  Mosaic galleries are the default
- Bug Fix: Twitter Cards: Remove deprecated card types

## 3.5.3 - 2015-05-06

- Security Hardening: Remove Genericons example.html file.

## 3.5.2 - 2015-05-05

- Bug Fix: Sharing: Changes Facebook share count endpoint

## 3.5.1 - 2015-05-05

- Enhancement: Sharing: Changes Facebook share count method per Facebook API
  change
- Enhancement: General: Remove .po files to reduce plugin size
- Bug Fix: General: Remove identity crisis notification
- Bug Fix: Subscriptions: Correct required input validation
- Security hardening

## [3.5] - 2015-04-23

Jetpack 3.5 introduces the ability to manage your site's menus directly from
WordPress.com and several bug fixes and enhancements. This upgrade is
recommended for all users.

- Enhancement: General: Change security reporting to use a transient instead
  of option to reduce backup load
- Enhancement: General: Improve module search
- Enhancement: JSON API: Allow users to manage menus through WordPress.com
- Enhancement: Sharing: Reduce spam through email sharing
- Bug Fix: Custom CSS: Improve recall of CSS revisions
- Bug Fix: Extra Sidebar Widgets: Change class name for Contact Info widget
- Bug Fix: Extra Sidebar Widgets: Fix errors when adding widgets via the
  customizer
- Bug Fix: Extra Sidebar Widgets: Fix PHP notices in RSS widget
- Bug Fix: General: Fix redirect loop on activation
- Bug Fix: General: Styling fixes
- Bug Fix: Protect: Add IP translation fallback when inet_pton is not
  available
- Bug Fix: Protect: Always allow login from local IDs
- Bug Fix: Protect: Sanitize displayed IP after block
- Bug Fix: Publicize: Prevent generating Facebook profile links for app-scoped
  user IDs
- Bug Fix: Subscriptions: Improve error handling
- Bug Fix: Theme Tools: Include breadcrumb code
- Misc: Extra Sidebar Widgets: Remove Readmill Widget

## [3.4.3] - 2015-04-20

- Security hardening.

## [3.4.2] - 2015-04-19

- Bug Fix: Contact info widget namespacing
- Bug Fix: Javascript errors on wp-admin due to stats display code
- Bug Fix: Potential fatal error from improperly called function
- Bug Fix: Potential fatal error when protect servers are unreachable for
  WordPress Multisite

## 3.4.1 - 2015-03-19

- Bug Fix: General: Modules not displaying properly in non-English installs
- Bug Fix: Manage: Some installs showing a transient fatal error
- Bug Fix: Protect: Protect module not auto-activating for users who upgrade
- Bug Fix: Omnisearch: Some installs not properly reporting WP version number,
  causing Omnisearch error
- Bug Fix: Stats: Top posts/pages widget not loading
- Bug Fix: Contact Info Widget: Fix conflict with Avada theme

## [3.4] - 2015-03-18

- Enhancement: Config Settings: provide a notification for users that update
  features settings
- Enhancement: Config Settings: provide a notification for users that update
  features settings
- Enhancement: Contact Form: Use the predefined $title variable in the anchor
  tag in grunion contact form button
- Enhancement: Contact Form: Use the predefined $title variable in the anchor
  tag in the button on admin
- Enhancement: Custom Content Type: Add all Custom Post Types to Omnisearch
- Enhancement: Custom Content Type: Add option to add Testimonial Custom
  Content Type in admin
- Enhancement: Custom Content Type: bring consistency between the portfolio
  and testimonial shared codebase
- Enhancement: Custom Content Type: code cleanup
- Enhancement: Custom Content Type: register namespaced 'jetpack_portfolio'
  shortcode/use a prefix for shortcode for Portfolio
- Enhancement: Custom Content Type: set shortcode image size to 'large' and
  add jetpack_portfolio_thumbnail_size filter to allow themes to set their own
  size for Portfolio
- Enhancement: Custom Content Type: testimonial shortcode enhancement
- Enhancement: Extra Sidebar Widgets: Add subscription widget wildcard
- Enhancement: Extra Sidebar Widgets: Likes and Sharing Shortcodes
- Enhancement: Extra Sidebar Widgets: Minor fixes to Facebook widget plugin
  for SSL
- Enhancement: Fix/update jetpack version
- Enhancement: General: Add DNS Prefetching
- Enhancement: General: Add Jetpack admin dashboard widget
- Enhancement: GlotPress: Update GP_Locales and GP_Locale classes
- Enhancement: Improved control over Nova Theme Menu output markup
- Enhancement: Infinite Scroll: Adds a `button` wrapper for the infinity
  handle.
- Enhancement: Infinite Scroll: Check for response.html before using indexOf
- Enhancement: Integrate BruteProtect for protection against Brute Force
  attacks
- Enhancement: JSON API Manage: Added Mock Jetpack Option to Sync options that
  don't have to live in the Database
- Enhancement: JSON API: Add/empty trash days option to sync
- Enhancement: Jump Start: Add "Jump Start" interface for new users
- Enhancement: Manage: Add "modified_before" and "modified_after" parameters
  to /sites/%s/posts/ via JSON API
- Enhancement: Mobile Theme: Add filter for choosing mobile theme menu
- Enhancement: Notifications: Changes to load the new notifications client.
- Enhancement: Protect: Add a filter so that user can add thier own bots
- Enhancement: Protect: Add security reporting
- Enhancement: Protect: Add/whitelist endpoints via JSON API for Jetpack
  Protect
- Enhancement: Publicize: update connection confirmation message
- Enhancement: Sharing: Add custom service name as a class
- Enhancement: Sharing: display name of custom service in link title
- Enhancement: Sharing: Remove default post types for showing share links
- Enhancement: Sharing: use Jetpack version number when enqueing sharing.js
- Enhancement: Shortcodes Team Partnerships: Backport fixes from SoundCloud
  2.3.1 through 3.0.2
- Enhancement: Shortlinks: use HTTPS when possible
- Enhancement: Stats: Make loading of stats async
- Enhancement: Subscriptions: Added settings field for comment sub text
- Enhancement: Subscriptions: Hide Form After Submit
- Enhancement: Subscriptions: remove label from widget title
- Enhancement: Subscriptions: Update subscriptions.php
- Bug Fix: Contact form: Increase CSS specificity for Contact Forms in widgets
- Bug Fix: Custom Content Type: Testimonial Custom Content Type: use core
  `WP_Customize_Image_Control` instead of custom...
- Bug Fix: Extra Sidebar Widgets: add missing & to if statement for widget
  visibility
- Bug Fix: Extra Sidebar Widgets: Don't require height/width values in the
  Twitter Timeline widget
- Bug Fix: Extra Sidebar Widgets: Upload images from the customizer/Extra
  Sidebar Widgets Tiled Galleries for Gallery Widget
- Bug Fix: General: Fix bug that was preventing modules from displaying
  properly
- Bug Fix: Manage: When calling /sites/%s/posts/ include all attachments not
  just the first five via JSON API
- Bug Fix: Mobile Theme: Minileven; Start after DOM ready
- Bug Fix: Sharing: Open sharing in same window
- Bug Fix: Stats language
- Bug Fix: Subscritpions: fix invalid field when no email address

## 3.3.2 - 2015-02-19

- Enhancement: Updated translation files.
- Enhancement: Heartbeat: Correctly stat new datasets.
- Bug Fix: Widget Visibility: Correct some caching of visibility results that
  may get evaluated too soon.
- Bug Fix: Contact Form: Hardening.
- Bug Fix: Photon: Make sure our gallery filter can parse array inputs as well
  as the default html.

## 3.3.1 - 2015-02-11

- Bug Fix: JSON API: Minor versioning data.
- Bug Fix: Markdown: Re-run KSES after processing to account for syntax
  changes.
- Bug Fix: Media Extractor: Don't call a gallery a gallery if it hasn't got
  any pictures!
- Bug Fix: Module Management: Handle a core api change for folks running
  trunk.
- Bug Fix: Related Posts: CSS -- better clear rows.
- Bug Fix: Sharing: Including sharing account on Pinterest unofficial buttons
  as well.
- Bug Fix: Sharing: Properly version external assets by Jetpack release
  version.
- Bug Fix: Shortcodes: Soundcloud: Backport API compatibility fixes.
- Bug Fix: Shortcodes: Flickr: Tidy up our regex url pattern matching.
- Bug Fix: Subscriptions: Don't add 'Email Address' as the value -- we have
  placeholders!
- Bug Fix: Widgets: Gallery Widget: Allow folks to upload images from the
  widget area in the customizer.

## [3.3] - 2014-12-15

- Enhancement: Adds responsive video support to BuddyPress.
- Enhancement: Custom Content Types: Added 'order' and 'orderby' options to
  portfolio shortcode.
- Enhancement: Display notice when Jetpack Development Mode is on.
- Enhancement: General: Update compatibility with Twenty Fifteen.
- Enhancement: Image URL can now be overwritten with the
  `jetpack_images_fit_image_url_override` filter after dimensions are set by
  Photon.
- Enhancement: JSON API: Add Endpoint for trigger Plugin Autoupdates.
- Enhancement: JSON API: General Improvements. Documentation on
  http://developer.wordpress.com/
- Enhancement: Likes: Updated the code to accept arbitrary CPTs.
- Enhancement: Related Posts: Allow filter by `post_format`.
- Enhancement: Sharing: add new `jetpack_sharing_counts` filter for option to
  turn off sharing counts.
- Enhancement: Sharing: Use the Site Logo Theme Tool and the Site Icon as
  fallbacks for image tags.
- Enhancement: Shortcodes: Made the code more readable by using output buffers
  instead of string concatenation.
- Enhancement: Site Logo: Add alias functions to provide backward
  compatibility for themes expecting the old function calls.
- Enhancement: Slideshow: Add title and alt text to images.
- Enhancement: Subscription Form: Do not display the logged in user's email
  address by default.
- Enhancement: Top Posts Widget: Refactor to allow conditional loading of the
  css.
- Enhancement: Top Posts: Add `jetpack_top_posts_widget_count` filter to
  control number of displayed posts.
- Bug Fix: Change subscribe_text from `p` to `div` so that it can contain
  block-level elements.
- Bug Fix: Fonts: Change path to look for the svg in the right directory.
- Bug Fix: Increase CSS specificity for Contact Forms in widgets.
- Bug Fix: JSON API: Plugins Update: Make sure the plugin doesn't get
  deactivated.
- Bug Fix: Likes: Fixes issues where likes don't load, load master iframe
  after scripts are loaded.
- Bug Fix: Notes Module: Avoid a PHP Notice in cli scripts when the request
  doesn't contain a User-Agent header.
- Bug Fix: Nova Menu CPT: fix notice when we have no taxonomies.
- Bug Fix: Nova Menus: Use current instance to maintain object context.
- Bug Fix: Related Posts: Add filter for `_enabled_for_request()`.
- Bug Fix: Sharing: Prevent duplicate @ in shared Tweets.
- Bug Fix: Site Logo: `get_site_logo()` now properly returns the site logo ID
  when provided in the `$show` argument.
- Bug Fix: Site Logo: Correct evaluation of the Display Header Text in
  Customizer preview.

## 3.2.1 - 2014-11-14

- Enhancement: Updated translation files.
- Enhancement: JSON API: More object vars passed back to some queries.
  Documentation on http://developer.wordpress.com/
- Bug Fix: JSON API: Pass back correct author in `me/posts` data.
- Bug Fix: JSON API: Don't check if a post is freshly pressed on remote
  Jetpack sites where the function doesn't exist.
- Bug Fix: Site Logo: Add backward-compatible template tags to match the
  standalone release.
- Bug Fix: Don't use `__DIR__` -- it's 5.3+ only, and WordPress supports back to
  5.2.
- Bug Fix: Retool how we remove the source styles when using the concatenated
  version.
- Bug Fix: Shortcodes: TED: Correct default language code from `eng` to `en`.
- Bug Fix: Gallery Widget: Add a default background color.
- Bug Fix: Subscription Notifications: Remove the label.
- Bug Fix: Sharing: enqueue Genericons on static front page as well if
  selected.

## [3.2] - 2014-10-29

- Enhancement: Speed Improvements (woohoo!).
- Enhancement: Add site icons: an avatar for your blog.
- Enhancement: Improvements to API endpoints.
- Enhancement: Add oEmbed sources (Twitter, SoundCloud, Instagram,
  DailyMotion, Vine).
- Enhancement: Add indicators to make it easier to see which modules are
  active.
- Enhancement: Improve debug tool.
- Enhancement: Add new 'Site Logos' code to theme tools, for themes that opt
  in to support it.
- Enhancement: Improved caching for related posts.
- Enhancement: Added "Remember Me" functionality to Single Sign On.
- Enhancement: Improved accessibility.
- Enhancement: Added additional filters to Widget Visibility.
- Bug Fix: Fixed PHP Notice errors for Likes, Widget Visibility.
- Bug Fix: Improvements to the testimonials CPT.
- Bug Fix: Improved RTL on VideoPress admin.
- Bug Fix: Removed Google+ Authorship module (discontinued by Google).
- Bug Fix: Fixed use of deprecated function in mobile theme.
- Bug Fix: Various fixes to Tiled Galleries.
- Bug Fix: Various fixes to Contact Form.
- Bug Fix: Various fixes to oEmbed.
- Bug Fix: Various fixes to Single Sign On.
- Bug Fix: Fixed styles in ShareDaddy.
- Bug Fix: Better match protocols (http/https) to the site.

## 3.1.1 - 2014-08-07

- Enhancement: Update translation files for strings that had been
  submitted/approved since release.
- Bug Fix: Social Links: Add a function check to better degrade if Publicize
  isn't around.
- Bug Fix: Open Graph: Add WordPress SEO back to the blacklist, until they
  update how they opt us out.
- Bug Fix: Asset Minification: Add another caveat ( empty $plugin ) to short
  out on.
- Bug Fix: Deprecated Hooks: Fixing our expectations where something that
  should be an array occasionally wasn't.
- Bug Fix: Custom CSS: Add extra whitelist rule for -o-keyframe rules.

## [3.1] - 2014-07-31

- Enhancement: New Custom Content Types module.
- Enhancement: New Jetpack Logo.
- Enhancement: New optional JSON API endpoints for viewing updates and
  managing plugins and themes.
- Enhancement: New Custom Post Type: Portfolio!
- Enhancement: Rearranged buttons on the modules modals for easier management.
- Enhancement: Jetpack Settings have improved keyboard accessibility.
- Enhancement: Improved RTL support for After the Deadline, Carousel, Contact
  Form, Comics CPT, Custom CSS, Omnisearch, Publicize, Related Posts, Slideshow
  short code, Tiled Gallery, Widget-Visibility and Widgets Gallery.
- Enhancement: Contact Form: Add an "Empty Spam" option.
- Enhancement: i18n: Change the priority of where plugin_textdomain is hooked
  so that the plugins can better translate Jetpack.
- Enhancement: Monitor: Displays how often the site is checked for downtime.
- Enhancement: Shortcode: Added Mixcloud shortcode and oEmbed support.
- Enhancement: Social Links: Improved handling of customizer hooks in
  non-admin context.
- Enhancement: Stats: The smiley image is gone by default.
- Enhancement: Stats: Added link to the configure page for stats so that the
  stats settings page is easier to find.
- Enhancement: Theme Tools: Added the responsive videos to theme tools so that
  themes can support responsive videos more easily.
- Update: Updated Genericons to version 3.1, new icons for website, ellipsis,
  foursquare, x-post, sitemap, hierarchy and paintbrush.
- Bug Fix: Contact Form: Prefix function to avoid conflicts with other
  plugins.
- Bug Fix: Custom CSS: Admin UI has a responsive layout.
- Bug Fix: Custom CSS: Custom $content_width value doesn't overwrite theme's
  $content_width.
- Bug Fix: Contact Form: Feedback link takes you to the form page.
- Bug Fix: Carousel: Confirms an avatar is returned by get_avatar before
  displaying.
- Bug Fix: Featured Content: Don't remove setting validation.
- Bug Fix: Infinite Scroll: Google Universal Analytics support added.
- Bug Fix: Multisite: Add message when updating multisite settings.
- Bug Fix: Photon: Photon will no longer upscale images larger than the
  original size.
- Bug Fix: Photon: Check that the image exists before rewriting the image URL
  to utilize Photon.
- Bug Fix: Sharing: Pinterest adds attribute to display share count.
- Bug Fix: Sharing: Respect an empty sharing title.
- Bug Fix: Sharing: Share buttons now appear in the bbPress forms.
- Bug Fix: Sharing: Support for multiple meta html tag og:image values.
- Bug Fix: Single Sign On: Logout allows override of forcing Single Sign On.
- Bug Fix: Single Sign On: Remove the lost password link on auto-forward
  logout.
- Bug Fix: Social Links: Do not use anonymous function for compatibility with
  PHP 5.2.
- Bug Fix: Tiled Galleries: Update jQuery mouseover caption effect to reduce
  flickering.
- Bug Fix: Widgets Visibility: Works better in the customizer admin view.

## 3.0.2 - 2014-06-17

- Enhancement: General: Make module categories filter more visible when
  active.
- Enhancement: General: Updated translation files with more strings added
  since the last release.
- Enhancement: General: Allow deep-linking to the Contact Support form.
- Bug Fix: General: RTL Jetpack Admin UI looks better.
- Bug Fix: General: Fixed PHP warning when bulk deactivating modules.
- Bug Fix: General: Removed an unnecessary description.
- Bug Fix: General: Resolved an SSL error on Jetpack Admin UI.
- Bug Fix: General: Fix error comparing signatures when the WordPress
  installation is using site_url filters (applied mostly to WPEngine sites).
- Bug Fix: General: Resolved PHP strict error on the mobile menu.
- Bug Fix: General: Fix timing of conditional checks, so that calling
  developer mode via a plugin works again.
- Bug Fix: General: Main page categories tab now properly translates module
  names.
- Bug Fix: Related Posts: Fix a typo, the "more info" link now works.
- Bug Fix: Likes: Improve button styling.
- Bug Fix: Likes: Remove unused UI for Reblog settings on social settings
  page.
- Bug Fix: Contact Form: Updated to no longer use a deprecated Akismet
  function.
- Bug Fix: Contact Form: Sends email to the administrator that is not marked
  as spam again.
- Bug Fix: Open Graph: Resolved PHP warning on open graph gallery pages when
  the gallery is empty.

## 3.0.1 - 2014-05-22

- Bug Fix: AtD: A wpcom-only function got synced by mistake and caused a few
  errors. Fixed.
- Bug Fix: Post By Email: Add static keyword to a function.
- Bug Fix: ShareDaddy: In the admin-side configuration of sharing links, we
  used a Path icon instead of Pinterest. Oops!
- Bug Fix: ShareDaddy: We inadvertently appended `via @jetpack` to some
  twitter shares. This is no longer the case.
- Bug Fix: Related Posts: Tidying up and relocation of the `resync` button
  formerly on the more info modal.
- Bug Fix: Infinite Scroll: Work better with core's MediaElement.js
- Bug Fix: Heartbeat: Undeclared variable fixed.

## [3.0] - 2014-05-20

- New User Interface for managing modules and settings
- New Module: Verfication Tools
- Enhancement: New look for the Sharing module
- Enhancement: Multiple improvements on which Twitter handle a Twitter card
  will display
- Enhancement: Add option to hide Google+ Authorship banner while still
  receiving the benefits
- Enhancement: Many Infinite Scroll enhancements to improve performance
- Enhancement: Infinite Scroll will use your CPT's display name instead of
  "Older Posts"
- Enhancement: JSON API added /media/new endpoint
- Enhancement: Added filter to assign new default image for Open Graph tags
- Enhancement: New [jetpack-related-posts] shortcode to add Related Posts to
  page instead of default placement
- Enhancement: Added SSO option to turn off login form completely, to use
  WordPress.com login exclusively
- Enhancement: The [googlemaps] shortcode allows for Google Maps Engine
- Enhancement: YouTube shortcode allows HD playback
- Enhancement: Smoother, Faster Tiled Galleries!
- Enhancement: New languages! Use Jetpack in Irish, Fulah, and Tigrinya
- Bug Fix: Use your browser's Back and Forward buttons when naviagating a
  Carousel
- Bug Fix: Various Related Posts fixes and improvements for added flexibility
- Bug Fix: WordPress 3.9: Restores ability to edit Contact Forms
- Bug Fix: WordPress 3.9: Restores Gallery Widget compatability
- Bug Fix: Ensure Markdown is kept when Bulk Editing posts
- Bug Fix: Improved Jetpack's Multisite Network Admin page for networks with a
  large number of sites
- Bug Fix: Ensure Sharing settings persist when Bulk Editing a post
- Bug Fix: Various other shortcode improvements

## [2.9.3] - 2014-04-10

- Important security update. CVE-2014-0173

## 2.9.2 - 2014-03-17

- Bug Fix: Publicize: When publishing from a mobile app or third-party client,
  Publicize now works again.

## 2.9.1 - 2014-03-06

- Bug Fix: After the Deadline: Fix a Javascript glitch that could prevent
  publishing of posts.
- Bug Fix: SSO: Disable the implementation of an option that had been removed
  before release. This would have only been an issue if a site administrator
  had enabled the module during an early beta of 2.9.

## [2.9] - 2014-02-26

- Added Multisite network functionality
- New Module: Related Posts
- Enhancement: Single Sign On
- Enhancement: Mixcloud shortcode and oEmbed
- Enhancement: Gist shortcode and oEmbed
- Enhancement: Modify Facebook Like Box widget to support new Facebook
  parameters
- Enhancement: Rolled the Push Notifications module into the Notes module
- Enhancement: Update kses with Markdown
- Enhancement: Adding keyboard accessibility to sharing buttons config page
- Enhancement: Pull WordPress testing bits from the new official git mirror at
  WordPress.org
- Bug Fix: Widget Visibility
- Bug Fix: Revisions box in Custom CSS
- Bug Fix: Fix several bugs in the WordPress Posts Widget so that it correctly
  updates
- Bug Fix: Limit Login Attempts no longer generates false positives from
  xmlrpc.
- Bug Fix: Clear max_posts transient on theme switch.
- Bug Fix: Lower priority of sync to allow all CPTs to be registered.
- Bug Fix: Contact form fields emailed in correct order.

Other bugfixes and enhancements at https://github.com/Automattic/jetpack/commits/2.9

## [2.8] - 2014-01-31

- New Module: Markdown
- Module Update: Jetpack Monitor
- Enhancement: Infinite Scroll: Keep track of $current_day between requests so
  the_date() works well.
- Enhancement: Embeds: New filter to turn off embeds in comments.
- Enhancement: Contact Form: Add placeholder support.
- Enhancement: Widget: Gravatar Profile: Added filters to allow users to
  customize headings and fixed output of personal links.
- Enhancement: Facebook OG Tags: Add `published_time`, `modified_time`, and
  `author` if the post type supports it.
- Enhancement: Sharing: Display buttons on CPT archive pages.
- Enhancement: Sharing: Add `get_share_title` function and filter.
- Enhancement: Sharing: Add filter `sharing_display_link`.
- Enhancement: Twitter Timeline: Flesh out tweet limit option.
- Enhancement: Social Links: Add Google+ to the list of supported services.
- Enhancement: Stats: Improve dashboard styles in 3.8.
- Enhancement: Stats: No longer use Quantcast.
- Enhancement: Top Posts: Add `jetpack_top_posts_days` filter.
- Enhancement: AtD: Add TinyMCE 4 compatibility for its pending arrival in
  WordPress 3.9
- Enhancement: Genericons: Update to v3.0.3
- Enhancement: Tiled Galleries: Add alt attributes to images.
- Enhancement: Shortcode: YouTube: Accept protocol-relative URLs.
- Enhancement: Shortcode: Slideshow: Add white background option.
- Enhancement: Shortcode: YouTube: Add support for the two closed-caption
  arguments.
- Enhancement: Shortcode: Vimeo: Update the regex to support the new embed
  code.
- Enhancement: Shortcode: Google Maps: Update the regex to handle new format
  for embeds.
- Enhancement: Likes: Avoid a PHP Notice when $_POST['post_type'] is not set
  in meta_box_save.
- Enhancement: Smush images to save on file size.
- Enhancement: Publicize: Enable opt-in publicizing of custom post types.
- Bug Fix: Random Redirect: Further namespace to avoid conflicts.
- Bug Fix: Twitter Timeline: Resolve undefined index notice.
- Bug Fix: Featured Content: Add extra class_exists() check to be extra
  careful.
- Bug Fix: Facebook OG Tags: Change OG type of Home and Front Page to
  'website'
- Bug Fix: Widget Visibility: Add support for old-style single use widgets.
- Bug Fix: Google Authorship: Support apostrophe in author names.
- Bug Fix: Media Extractor: Assorted graceful failure caveats.
- Bug Fix: Carousel: 'Link to None' bug fixed.
- Bug Fix: Embeds: Bandcamp: Switch escaping function for album and track IDs
  to handle (int)s greater than PHP_INT_MAX
- Bug Fix: Some plugins trying to catch brute-force attacks mistakenly flagged
  the Jetpack connection as one.

## [2.7] - 2013-12-11

- Enhancement: Google+ Publicize
- Enhancement: Add Cloudup as an oEmbed provider
- Enhancement: Subscriptions: Add subscribe_field_id filter to allow updated
  ids when using multiple widgets
- Enhancement: Infinite Scroll: TwentyFourteen Support
- Bug Fix: Contact Form: Fix warning when form is called outside the loop
- Bug Fix: Featured Content: Moving Settings to Customizer, provide option to
  set default tag as fallback, specify all supported post-types rather than just
  additional ones. Description Updates
- Bug Fix: Featured Content: Compat with 'additional_post_types' theme support
  argument. Comment updates
- Bug Fix: Featured Content: Make sure $term is an object before we treat it
  as one
- Bug Fix: GlotPress: Merge with latest GlotPress
- Bug Fix: Infinite Scroll: prevent Undefined index notice that can cause IS
  to fail when user has WP_DEBUG set to true
- Bug Fix: Infinite Scroll: Improved compatibility with Carousel, Tiled
  Galleries, VideoPress, and the `[audio]` and `[video]` shortcodes
- Bug Fix: Likes: Stop manually including version.php and trust the global.
  Some whitespace fixes, and if it's an attachment, follow the post_status of
  the parent post
- Bug Fix: Mobile Theme: Display password field for Gallery format protected
  posts
- Bug Fix: Sharing: Add new translation width for share button, and Google
  Plus icons
- Bug Fix: Shortcodes: Support Ineternational Google domains for maps
- Bug Fix: Shortcodes: Facebook Embeds: Register alternate permalink.php URL
  for posts
- Bug Fix: Subscriptions: Moved inline styles from widget email input to
  separate css file
- Bug Fix: Theme Tools: Fix glitch where random-redirect.php also showed as a
  plugin being deleted if you were deleting Jetpack
- Bug Fix: Misc: Internationalization & RTL updates
- Bug Fix: Misc: Prevent collisions with 'Facebook Featured Image & OG Meta
  Tags' plugin

## 2.6.1 - 2013-12-03

- Bug Fix: minor styling fix in pre- and post-MP6/3.8 UI changes.
- Bug Fix: Stats: spinner gif url fix when the user is viewing it over https.
- Bug Fix: Stats: Switch to esc_html from htmlspecialchars in error message --
  better to be native
- Bug Fix: Media Extractor: some hosts don't compile unicode for
  preg_match_all, so we temporarily removed the block that depended on it.
- Bug Fix: Media Extractor: Add in some error handling for malformed URLs.
- Bug Fix: Twitter Cards: treat single-image galleries as a photo-type.
- Bug Fix: Update conflicting plugins for OG tags and Twitter Cards.
- Bug Fix: Correct max supported version number -- had been 3.6, update to
  3.7.1

## [2.6] - 2013-11-28

- Enhancement: WPCC / now called [SSO](http://jetpack.com/support/sso/):
  refactored.
- Enhancement: Monitor: new module which will notify you if your site goes
  down(http://jetpack.com/support/monitor/).
- Enhancement: Custom CSS: replace Ace editor with Codemirror.
- Enhancement: Widgets: new â€œDisplay Postsâ€ widget.
- Enhancement: WP-CLI: add commands to disconnect a site and manage modules.
- Enhancement: Contact Form: new filters, `grunion_contact_form_field_html`
  and `grunion_should_send_email`.
- Enhancement: Custom Post Types: new restaurant post type.
- Enhancement: Genericons: update to version 3.0.2.
- Enhancement: Infinite Scroll: many improvements and fixes.
- Enhancement: Likes: performance improvements.
- Enhancement: MP6: Jetpack icons are now compatible with WordPress 3.8.
- Enhancement: Open Graph: better descriptions, fallback images, and media
  extraction from video posts.
- Enhancement: Publicize: new background token tests for connected publicize
  services and display problems on settings sharing and add new post.
- Enhancement: Shortcodes: updated Bandcamp shortcode to support the
  `tracklist` and `minimal` attributes, as well as more `artwork` attribute
  values.
- Enhancement: Shortlinks: add Custom Post Type support.
- Enhancement: Subscriptions: add more ways to customize the subscriptions
  widget.
- Enhancement: Twitter Cards: better media management and card type detection,
  and better handling of conflicts with other Twitter Cards plugins.
- Enhancement: better handling of conflicts with other plugins.
- Bug Fix: After the Deadline: add a typeof check for `tinyMCEPreInit.mceInit`
  to prevent js errors.
- Bug Fix: Carousel: speed improvements and several bugfixes.
- Bug Fix: Contact Form: remove nonce creating issues with caching plugins.
- Bug Fix: Custom Post Types: Testimonials: return if featured image is empty
  so it can be removed after itâ€™s been set.
- Bug Fix: Featured Content: add additional post type support through the
  `additional_post_types` argument.
- Bug Fix: Google Authorship: support apostrophes in Google+ profiles.
- Bug Fix: Google Authorship: use a regexp Instead of using
  `mb_convert_encoding`, which doesnâ€™t enjoy universal support.
- Bug Fix: Heartbeat: ensure that it never triggers more than once per week.
- Bug Fix: JSON API: add new `?meta=` parameter that allows you to expand the
  data found in the `meta->links` responses.
- Bug Fix: JSON API: add new `is_private` response to the sites endpoint and
  `global_ID` response to the reader and post endpoints.
- Bug Fix: Mobile Theme: allow small images to display inline.
- Bug Fix: Mobile Theme: fix fatal errors for missing `minileven_header`
  function.
- Bug Fix: Photon: fix errors when an image is not uploaded properly.
- Bug Fix: Shortcodes: improvements to Archives, Google+, Presentations, Vine
  and Youtube.
- Bug Fix: Tiled Galleries: improve display of panoramic images and fix errors
  when an image is not uploaded properly.

## [2.5] - 2013-09-19

- Enhancement: Connect your Google+ profile and WordPress site to prove
  authorship of posts.
- Enhancement: Improved sharing buttons display.
- Enhancement: Comment on your posts using Google+ to signin.
- Enhancement: Embed Google+ posts into your posts.
- Enhancement: Added event logging capabilities for debugging
- Enhancement: LaTeX is now available in dev mode
- Enhancement: Introduced gallery widget
- Enhancement: Added new module: VideoPress
- Enhancement: Updated identity crisis checker
- Enhancement: Tiled Gallery widget added
- Enhancement: Google +1 button changed to Google+ Share button, to avoid
  confusion
- Enhancement: Added check to ensure Google+ authorship accounts have
  disconnected properly
- Enhancement: Updated identity crisis checker
- Enhancement: Tiled Gallery widget added
- Enhancement: Google +1 button changed to Google+ Share button, to avoid
  confusion
- Enhancement: Added the ability to embed Facebook posts
- Bug Fix: Redirect issue with G+ authorship when WordPress is not in the root
  directory
- Enhancement: Better security if carousel to prevent self-XSS
- Enhancement: Better handling of cookies for subsites on multisite installs
- Bug Fix: Check for post in G+ authorship before accessing it

## 2.4.2 - 2013-09-05

- Enhancement: Converted to module headers to detect Auto-Activating modules.
- Enhancement: WPCC: Added 'Close' link to deactivate WPCC in the admin nag.
- Enhancement: JSON API: Add User Nicename to the user data.
- Bug Fix: Contact Form: Stopped using a short tag.
- Bug Fix: Changed CSS selector to catch MP6 stylings.
- Bug Fix: Dropped `__FILE__` references in class.jetpack.php in favor of
  JETPACK__PLUGIN_DIR constant, now code that deactivates the plugin from the
  connect nag works again.
- Bug Fix: Random Redirect: Add random-redirect to the plugins overriden list,
  in case someone is using Matt's Random Redirect plugin.
- Bug Fix: Tiled Gallery: Revert r757178 relating to tiled gallery defaults.
- Bug Fix: Return false, not zero, if $GLOBALS['content_width'] isn't defined.
- Bug Fix: WPCC: Don't call wp_login_url() in the constructor -- if someone is
  running a custom login page, that can break things if their plugin runs
  get_permalink as a filter before init.
- Bug Fix: Tiled Gallery: Add fallback if post_parent == 0 due to
  infinite_scroll_load_other_plugins_scripts.
- Bug Fix: Custom CSS: Set the ACE gutter z-index to 1.
- Bug Fix: Custom Post Types: Switch from wp_redirect() to wp_safe_redirect().
- Bug Fix: Likes: Set overflow:hidden; on the likes adminbar item.
- Bug Fix: Mobile Theme: Migrate where/when the custom header stuff is
  included.
- Bug Fix: Slideshow Shortcode: Add a height of 410px.

## 2.4.1 - 2013-09-04

- Enhancement: Don't auto-activate WPCC.

## [2.4] - 2013-08-30

- Enhancement: WordPress.com Connect (WPCC): New Module.
- Enhancement: Widget Visibility: New Module.
- Enhancement: Shortcode: Addition of new Twitter Timeline shortcode.
- Enhancement: Shortcode: Addition of new Presentation shortcode.
- Enhancement: Shortcode: Addition of new Vine shortcode.
- Enhancement: Custom Post Types: CPTs are available.
- Enhancement: Subscriptions: Add 'jetpack_is_post_mailable' filter.
- Enhancement: OpenGraph: Add Twitter Cards meta tags as well.
- Enhancement: Custom CSS: Update lessc and scssc preprocessors to 0.4.0 and
  0.0.7 respectively.
- Enhancement: Omnisearch: Add Media results.
- Enhancement: Likes: Use a protocol-agnostic iframe, instead of forced HTTPS.
- Enhancement: Top Posts: Increase post limit.
- Enhancement: Publicize: Updated JS and UI.
- Enhancement: Photon: New filter to let site admins/owners enable photon for
  HTTPS urls.
- Enhancement: New jetpack_get_available_modules filter.
- Enhancement: Subscriptions: Antispam measures.
- Bug Fix: Add inline style to keep plugins/themes from inadvertently hiding
  the Connect box.
- Bug Fix: Custom CSS: Respect the new wp_revisions_to_keep filter.
- Bug Fix: Photon: Only hook jetpack_photon_url into the filter if the user
  has Photon active.
- Bug Fix: Heartbeat: Used wrong object, occasinally fatal-erroring out for
  the cron.
- Bug Fix: Add an empty debug.php file to the /modules/ folder, to solve some
  update issues where it never got deleted.

## [2.3.5] - 2013-08-12

- Enhancement: Added Path support to Publicize.

## [2.3.4] - 2013-08-06

- Bug Fix: Correct when output occurs with CSV export for feedback.
- Bug Fix: Tidy up the Heartbeat API.
- Enhancement: User Agent: Improve detecting of bots.
- Enhancement: Genericons: Make sure we're pulling the freshest version from
  genericons.com on each release.
- Enhancement: JSON API: Open up replies/new endpoints so that users can
  comment on blogs that are not in their access token.
- Enhancement: Photon: Apply to `get_post_gallery()` function as well.
- Enhancement: Tiled Galleries: Add a default bottom margin to be more robust
  out of the box.
- Translations: Adding in fresher translation files.
- Deprecation: Removing the retinization code for 3.4, as it was included in
  WordPress trunk from 3.5 onwards.

## [2.3.3] - 2013-07-26

- Bug Fix: We were inadvertently overwriting cron schedules with our Jetpack
  heartbeat. This should now be fixed.
- Enhancement: New Facebook Sharing icons.
- Enhancement: Minor update to the Minileven stylesheet.

## [2.3.2] - 2013-07-25

- Bug Fix: Fixed an issue where Facebook Pages were not available when
  connecting a Publicize account.
- Bug Fix: For some web hosts, fixed an issue where 'Jetpack ID' error would
  occur consistently on connecting to WordPress.com.
- Enhancement: Adding some new stats and heartbeat checking to Jetpack.

## [2.3.1] - 2013-07-02

- Enhancement: Social Links: Retooling the class for better consistency and
  performance behind the scenes.
- Enhancement: Omnisearch: Make it easier to search Custom Post Types. No
  longer need to extend the class, if all you want is a basic display. Just
  call `new Jetpack_Omnisearch_Posts( 'cpt' );`
- Enhancement: Sharing Buttons: LinkedIn: Use the official button's sharing
  link on the Jetpack implementation for a more consistent sharing experience
  and produce better results on LinkedIn's end.
- Enhancement: Debug / Connection: Better logic in determining whether the
  server can use SSL to connect to WPCOM servers.
- Enhancement: Sharing: Twitter: Calculate the size of the Tweet based on the
  short URL rather than the full URL size.
- Enhancement: Debug: More readable and understandable messages.
- Enhancement: Likes: Including some MP6 styles.
- Enhancement: Comments: Add new core classes to comment form. See
  http://core.trac.wordpress.org/changeset/24525
- Bug Fix: Omnisearch: Don't load everything initially, run the providers off
  admin_init, and then issue an action for folks to hook into.
- Bug Fix: Omnisearch: Modify some child class functions to match the parent's
  parameters and avoid strict notices in newer versions of PHP.
- Bug Fix: Omnisearch: Hide the search form in the module description if the
  current user can't use it.
- Bug Fix: Comment Form: Use edit_pages, not edit_page (fixes glitch in
  previous beta, never publicly released).
- Bug Fix: Twitter Timeline Widget: Additional testing of values and casting
  to default if they are nonconforming.
- Bug Fix: Sharing: Pinterest: Make the button wider if there's a count to
  avoid overlapping with others.
- Bug Fix: Post By Email: Change configuration_redirect to static.
- Bug Fix: Likes: Don't call configuration_redirect as a static, do it as a
  method.
- Bug Fix: Add some further security measures to module activation.

## [2.3] - 2013-06-19

- Enhancement: Omnisearch: Search once, get results from everything!
  Omnisearch is a single search box that lets you search many different things
- Enhancement: Debugger: this module helps you debug connection issues right
  from your dashboard, and contact the Jetpack support team if needed
- Enhancement: Social Links: this module is a canonical source, based on
  Publicize, that themes can use to let users specify where social icons should
  link to
- Enhancement: Itâ€™s now easier to find out if a module is active or note,
  thanks to the new Jetpack::is_module_active()
- Enhancement: Contact Form: You are now able to customize the submit button
  text thanks to the submit_button_text parameter
- Enhancement: Comments: We've added a filter to let users customize the
  Comment Reply label, and users can now also customize the prompt on the
  comment form again.
- Enhancement: Mobile Theme: Add genericons.css and registering it so itâ€™s
  easily accessible to other modules that may want it
- Enhancement: Tiled Galleries: You can now customize the captions, thanks to
  the jetpack_slideshow_slide_caption filter
- Enhancement: Widgets: Twitter Timeline: Add the noscrollbar option
- Enhancement: Widgets: Facebook Like Box Widget: add a show_border attribute
- Enhancement: Widgets: FB Like Box: let Jetpack users override the iframe
  background color set in an inline style attribute by using the
  jetpack_fb_likebox_bg filter
- Bug Fix: Carousel: Fix a bug where double-clicking a gallery thumbnail broke
  the carousel functionality
- Bug Fix: Comments: Change â€œmust-log-inâ€ to class from ID
- Bug Fix: Contact Form: Make the Add Contact Form link a button, ala Add
  Media in core
- Bug Fix: Contact Form: Fix encoding of field labels
- Bug Fix: Contact Form: Remove references to missing images
- Bug Fix: Fix 2 XSS vulnerabilities
- Bug Fix: JSON API: Minor fixes for bbPress compatibility
- Bug Fix: JSON API: Fix metadata bugs
- Bug Fix: JSON API: Add a new hook that is fired when a post is posted using
  the API
- Bug Fix: JSON API: Prefork/REST: update path normalizer to accept versions
  other than 1
- Bug Fix: JSON API: Remove extra parenthesis in CSS
- Bug Fix: Custom CSS: Move content width filters higher up so that theyâ€™re
  active for all users, not just logged-in admins.
- Bug Fix: Custom CSS: All CSS properties that accept images as values need to
  be allowed to be declared multiple times so that cross-browser gradients work
- Bug Fix: Infinite Scroll: Allow themes to define a custom function to render
  the IS footer
- Bug Fix: Infinite Scroll: Fix up Twenty Thirteen styles for RTL and small
  viewports.
- Bug Fix: Likes: Fix â€˜Call to undefined functionâ€™
- Bug Fix: Likes: Add scrolling no to iframe to make sure that like button in
  admin bar does not show scrollbars
- Bug Fix: Likes: Remove setInterval( JetpackLikesWidgetQueueHandler, 250 )
  call that was causing heavy CPU load
- Bug Fix: Mobile Theme: Remove unused variable & function call
- Bug Fix: Publicize: Fix LinkedIn profile URL generation
- Bug Fix: Publicize: Better refresh handling for services such as LinkedIn
  and Facebook
- Bug Fix: Shortcodes: Audio shortcode: Treat src as element 0. Fixes audio
  shortcodes created by wp_embed_register_handler when an audio url is on a line
  by itself
- Bug Fix: Bandcamp: Updates to the Bandcamp shortcode
- Bug Fix: Stats: Fix missing function get_editable_roles on non-admin page
  loads
- Bug Fix: Widgets: Twitter Timeline: Fix HTML links in admin; set default
  values for width/height; change some of the sanitization functions
- Bug Fix: Widgets: Top Posts Widget: Exclude attachments
- Bug Fix: Widgets: Top Posts Widget: fix data validation for number of posts
- Bug Fix: Fix PHP warnings non-static method called dynamically
- Bug Fix: Fixed an issue in image extraction from HTML content
- Bug Fix: Open Graph: Change default minimum size for og:image too 200Ã—200
- Note: The old Twitter widget was removed in favour of Twitter Timeline
  widget
- Note: Add is_module_active() to make it easier to detect what is and what
  isnâ€™t
- Note: Compressing images via lossless methods
- Note: Tidying up jetpackâ€™s CSS
- Note: Set the max DB version for our retina overrides that were meant to
  stop for WordPress 3.5
- Note: Updating spin.js to the current version, and shifting to the canonical
  jquery.spin.js library
- Note: Adding Jetpack_Options class, and abstracting out options functions to
  it

## [2.2.5] - 2013-05-01

- Enhancement: Stats: Counting of registered users' views can now be enabled
  for specific roles
- Bug Fix: Security tightening for metadata support in the REST API
- Bug Fix: Update the method for checking Twitter Timeline widget_id and
  update coding standards
- Bug Fix: Custom CSS: Allow the content width setting to be larger than the
  theme's content width
- Bug Fix: Custom CSS: Fix possible missing argument warning.

## [2.2.4] - 2013-04-26

- Bug Fix: JSON API compat file include was not assigning a variable
  correctly, thus throwing errors. This has been resolved.

## [2.2.3] - 2013-04-26

- Enhancement: Comments - Add the reply-title H3 to the comment form so that
  themes or user CSS can style it
- Enhancement: Custom CSS - Support for the CSS @viewport
- Enhancement: JSON API - Support for i_like, is_following, and is_reblogged
- Enhancement: JSON API: Custom Post Type Support
- Enhancement: JSON API: Meta Data Support
- Enhancement: JSON API: Bundled Support for bbPress
- Enhancement: JSON API: Additions of following, reblog, and like status for
  post endpoints.
- Enhancement: Shortcodes - Add Bandcamp shortcode
- Enhancement: Tiled Galleries - Add code to get blog_id
- Bug Fix: Carousel - Support relative image paths incase a plugin is
  filtering attachment URLs to be relative instead of absolute
- Bug Fix: Carousel - Add likes widget to images / Respect comment settings
  for name/email
- Bug Fix: Carousel - Make name and email optional if the setting in the admin
  area says they are
- Bug Fix: Contact Form - Bug fixes, including a fix for WP-CLI
- Bug Fix: Contact Form - Remove deprecated .live calls, delegate lazily to
  jQuery(document) since it's all in an iframe modal
- Bug Fix: Contact Form - RTL styles
- Bug Fix: Contact Form - Better handle MP6 icons
- Bug Fix: Custom CSS - array_shift() took a variable by reference, so avoid
  passing it the result of a function
- Bug Fix: Custom CSS - Allow case-insensitive CSS properties (<a
  href="https://wordpress.org/support/topic/two-issues-with-jetpack-css-module?replies=9">ref</a>)
- Bug Fix: Infinite Scroll - Maintain main query's `post__not_in` values when
  querying posts for IS
- Bug Fix: Infinite Scroll - Ensure that IS's `pre_get_posts` method isn't
  applied in the admin. Also fixes an incorrect use of `add_filter()` where
  `add_action()` was meant. Fixes #1696-plugins
- Bug Fix: Infinite Scroll - CSS update - IS footer was too large in Firefox
- Bug Fix: Infinite Scroll - Add bundled support for Twenty Thirteen default
  theme
- Bug Fix: Infinite Scroll - Include posts table's prefix when modifying the
  SQL WordPress generates to retrieve posts for Infinite Scroll
- Bug Fix: JSON API - Use wp_set_comment_status to change the comment status,
  to make sure actions are run where needed
- Bug Fix: Likes - Update style and logic for matching id's
- Bug Fix: Mobile Theme - Ensure that
  <code>minileven_actual_current_theme()</code> is child-theme compatible +
  other updates
- Bug Fix: Mobile Theme - Update method for finding currently active theme.
- Bug Fix: Notifications - Remove the postmessage.js enqueue since this
  feature solely supports native postMessage
- Bug Fix: Notifications - Clean up script enqueues and use core versions of
  underscore and backbone on wpcom as fallbacks
- Bug Fix: Notifications - Enqueue v2 scripts and style
- Bug Fix: Notifications - Prefix module-specific scripts and style to prevent
  collision
- Bug Fix: Notifications - Include lang and dir attributes on
  #wpnt-notes-panel so the notifications iframe can use these to display
  correctly
- Bug Fix: Open Graph: Use the profile OG type instead of author. Add tags for
  first/last names
- Bug Fix: Publicize - Remove the Yahoo! service because they stopped
  supporting that API entirely
- Bug Fix: Publicize - fix fatal errors caused by using a method on a
  non-object. Props @ipstenu
- Bug Fix: Sharing - Adding 2x graphics for Pocket sharing service
- Bug Fix: Sharing - Bug fixes, and a new filter
- Bug Fix: Shortcodes - Audio: make sure that the Jetpack audion shortcode
  does not override the 3.6 core audio shortcode. Also, we need to filter the
  old Jetpack-style shortcode to properly set the params for the Core audio
  shortcode.
- Bug Fix: Shortcodes - Audio: Re-enable the flash player
- Bug Fix: Shortcodes - Slideshow: RTL styling update
- Bug Fix: Tiled Galleries - Fix IE8 display bug where it doesn't honor inline
  CSS for width on images
- Bug Fix: Tiled Galleries - Remove depreacted hover call, use mouseenter
  mouseleave instead
- Enhancement: Twitter Timeline Widget: New JavaScript based widget. Old one
  will discontinue May 7th.

## 2.2.2 - 2013-04-05

- Enhancement: Mobile Theme: Add controls for custom CSS.
- Enhancement: Sharing: Add Pocket to the available services.
- Bug Fix: Custom CSS: Update the method for generating content width setting.
- Bug Fix: JSON API: Security updates.
- Bug Fix: Likes: Add settings for email notifications and misc style updates.
- Bug Fix: Notifications: Add the post types to sync after init.
- Bug Fix: Publicize: RTL styling.
- Bug Fix: Shortcodes: security fixes and function prefixing.
- Bug Fix: Widgets: Update wording on the Top Posts widget for clarity.
- Bug Fix: Jetpack Post Images security fixes.

## [2.2.1] - 2013-03-28

- Enhancement: Development Mode: Define the `JETPACK_DEV_DEBUG` constant to
  `true` to enable an offline mode for localhost development. Only modules that
  don't require a WordPress.com connection can be enabled in this mode.
- Enhancement: Likes: Added the number of likes to the wp-admin/edit.php
  screens.
- Enhancement: Mobile Theme - design refresh
- Enhancement: Shortcodes - Add a filter to the shortcode loading section so
  that a plugin can override what Jetpack loads for shortcodes
- Enhancement: Widgets - Filter Jetpack's widgets so that a plugin can control
  which widgets get loaded
- Bug Fix: Comments - Add in a wrapper div with id='commentform'
- Bug Fix: Contact Form - Added date field with datepicker
- Bug Fix: Contact Form - Allowed non-text widgets to use contact forms by
  running their output through the widget_text filter
- Bug Fix: Custom CSS - Allowing color values to be defined multiple times
- Bug Fix: Custom CSS - Dynamically loading the correct CSS/LESS/SCSS mode for
  the CSS editor if the user changes the preprocessor
- Bug Fix: Custom CSS - Using the unminified worker CSS
- Bug Fix: Custom CSS - Added rule: reminder about using .custom-background on
  body selector
- Bug Fix: Custom CSS - Modified rule: Removed portion of overqualification
  rule that deems 'a.foo' overqualified if there are no other 'a' rules
- Bug Fix: Custom CSS - Ensuring that the editor and the textarea behind it
  are using the same font so that the cursor appears in the correct location
- Bug Fix: Custom CSS - Fix a bug that caused some sites to always ignore the
  base theme's CSS when in preview mode
- Bug Fix: Custom CSS - Run stripslashes() before passing CSS to save()
- Bug Fix: Custom CSS - Moving inline CSS and JavaScript into external files
- Bug Fix: Infinite Scroll - Use the `is_main_query()` function and query
  method
- Bug Fix: Infinite Scroll - Remove unused styles and an unnecessary margin
  setting
- Bug Fix: Infinite Scroll - Allow the query used with IS to be filtered, so
  IS can be applied to a new query within a page template
- Bug Fix: JSON API - Catch the 'User cannot view password protected post'
  error from can_view_post and bypass it for likes actions if the user has the
  password entered
- Bug Fix: Likes - Bump cache buster, Don't show likes for password protected
  posts
- Bug Fix: Notifications - Remove a redundant span closing tag
- Bug Fix: Photon - If an image is already served from Photon but the anchor
  tag that surrounds it hasn't had its `href` value rewritten to use Photon, do
  so. Accounts for WP galleries whose individual items are linked to the
  original image files
- Bug Fix: Publicize - Allows GLOBAL_CAP to be filtered, Adds an AYS to
  connection deletion, UI improvement for MP6 (and in general)
- Bug Fix: Sharedaddy - Fire the sharing redirect earlier for increased plugin
  compatibility
- Bug Fix: Stats - Move the display:none CSS output to wp_head so it gets
  written inside the HEAD tag if the option to hide the stats smilie is active
- Bug Fix: Tiled Galleries - A more descriptive name for the default gallery
  type
- Bug Fix: Tiled Galleries - Hide the Columns setting for gallery types that
  don't support it
- Bug Fix: Run the admin_menu action late so that plugins hooking into it get
  a chance to run
- Bug Fix: Prophylactic strict equality check

## [2.2] - 2013-02-26

- Enhancement: Likes: Allow your readers to show their appreciation of your
  posts.
- Enhancement: Shortcodes: SoundCloud: Update to version 2.3 of the SoundCloud
  plugin (HTML5 default player, various fixes).
- Enhancement: Shortcodes: Subscriptions: Add a shortcode to enable placement
  of a subscription signup form in a post or page.
- Enhancement: Sharedaddy: Allow selecting multiple images from a post using
  the Pinterest share button.
- Enhancement: Contact Form: Allow feedbacks to be marked spam in bulk.
- Enhancement: Widgets: Readmill Widget: Give your visitors a link to send
  your book to their Readmill library.
- Note: Notifications: Discontinue support for Internet Explorer 7 and below.
- Bug Fix: JSON API: Fix authorization problems that some users were
  experiencing.
- Bug Fix: JSON API: Sticky posts were not being sorted correctly in /posts
  requests.
- Bug Fix: Stats: sync stats_options so server has roles array needed for
  view_stats cap check.
- Bug Fix: Infinite Scroll: Display improvements.
- Bug Fix: Infinite Scroll: WordPress compatibility fixes.
- Bug Fix: Photon: Only rewrite iamge urls if the URL is compatible with
  Photon.
- Bug Fix: Photon: Account for registered image sizes with one or more
  dimesions set to zero.
- Bug Fix: Subscriptions: Make HTML markup more valid.
- Bug Fix: Subscriptions: Fixed notices displayed in debug mode.
- Bug Fix: Custom CSS: CSS warnings and errors should now work in environments
  where JavaScript is concatenated or otherwise modified before being served.
- Bug Fix: Hovercards: WordPress compatibility fixes.
- Bug Fix: Improved image handling for the Sharing and Publicize modules.
- Bug Fix: Carousel: Display and Scrollbar fixes.
- Bug Fix: Tiled Galleries: Restrict images in tiled galleries from being set
  larger than their containers.
- Bug Fix: Widgets: Gravatar Profile: CSS fixes.
- Bug Fix: Publicize: Strip HTML comments from the data we send to the third
  party services.
- Bug Fix: Notifications: Dropped support for IE7 and below in the
  notifications menu.
- Bug Fix: Custom CSS Editor: Allow custom themes to save CSS more easily.
- Bug Fix: Infinite Scroll: Waits until the DOM is ready before loading the
  scrolling code.
- Bug Fix: Mobile Theme: If the user has disabled the custom header text
  color, show the default black header text color.
- Bug Fix: Mobile Theme: Fix for the "View Full Site" link.
- Bug Fix: Mobile Theme: Use a filter to modify the output of wp_title().
- Bug Fix: Publicize: Twitter: Re-enable character count turning red when more
  than 140 characters are typed.

## 2.1.2 - 2013-02-05

- Enhancement: Infinite Scroll: Introduce filters for Infinite Scroll.
- Enhancement: Shortcodes: TED shortcode.
- Bug Fix: Carousel: Make sure to use large image sizes.
- Bug Fix: Carousel: Clicking the back button in your browser after exiting a
  carousel gallery brings you back to the gallery.
- Bug Fix: Carousel: Fix a scrollbar issue.
- Bug Fix: Comments: Move the get_avatar() function out of the base class.
- Bug Fix: Contact Form: Prevent the form from displaying i18n characters.
- Bug Fix: Contact Form: Remove the !important CSS rule.
- Bug Fix: Infinite Scroll: Main query arguments are not respected when using
  default permalink.
- Bug Fix: JSON API: Trap 'wp_die' for new comments and image uploads.
- Bug Fix: JSON API: Use a better array key for the user_ID.
- Bug Fix: JSON API: Make the class instantiable only once, but multi-use.
- Bug Fix: JSON API: Fix lookup of pages by page slug.
- Bug Fix: JSON API: Updates for post likes.
- Bug Fix: Mobile Theme: Remove Android download link for BB10 and Playbook.
- Bug Fix: Open Graph: Stop using Loop functions to get post data for meta
  tags.
- Bug Fix: Photon: Suppress and check for warnings when pasing_url and using
  it.
- Bug Fix: Photon: Ensure full image size can be used.
- Bug Fix: Photon: Resolve Photon / YouTube embed conflict.
- Bug Fix: Photon: Fix dimension parsing from URLs.
- Bug Fix: Photon: Make sure that width/height atts are greater than zero.
- Bug Fix: Sharedaddy: Layout fixes for share buttons.
- Bug Fix: Sharedaddy: Always send Facebook a language locale.
- Bug Fix: Sharedaddy: Don't look up share counts for empty URLs.
- Bug Fix: Shortcodes: Ensure that images don't overflow their containers in
  the slideshow shortcode.
- Bug Fix: Shortcodes: only enqueue jquery if archive supports Infinite Scroll
  in the Audio Shortcode.
- Bug Fix: Tiled Galleries: Use a more specific class for gallery item size to
  avoid conflicts.
- Bug Fix: Tiled Galleries: Fixing scrolling issue when tapping on a Tiled
  Gallery on Android.
- Bug Fix: Widgets: Gravatar profile widget typo.
- Bug Fix: Widgets: Add (Jetpack) to widget titles.
- Bug Fix: Widgets: Twitter wasn't wrapping links in the t.co shortener.
- Bug Fix: Widgets: Facebook Likebox updates to handling the language locale.
- Bug Fix: Widgets: Top Posts: Fixed a WP_DEBUG notice.
- Bug Fix: Widgets: Gravatar Profile Widget: transient names must be less than
  45 characters long.
- Bug Fix: typo in delete_post_action function.
- Bug Fix: Load rendered LaTeX image on same protocol as its page.

## [2.1.1] - 2013-01-05

- Bug Fix: Fix for an error appearing for blogs updating from Jetpack 1.9.2 or
  earlier to 2.1.

## [2.1] - 2013-01-04

- Enhancement: Tiled Galleries: Show off your photos with cool mosaic
  galleries.
- Enhancement: Slideshow gallery type: Display any gallery as a slideshow.
- Enhancement: Custom CSS: Allow zoom property.
- Enhancement: Stats: Show WordPress.com subscribers in stats.
- Bug Fix: Fix errors shown after connecting Jetpack to WordPress.com.
- Bug Fix: Photon: Fix bug causing errors to be shown in some posts.
- Bug Fix: Photon: Convert all images in posts when Photon is active.
- Bug Fix: Infinite Scroll: Improved compatibility with the other modules.
- Bug Fix: Custom CSS: Updated editor to fix missing file errors.
- Bug Fix: Publicize: Don't show the Facebook profile option if this is a
  Page-only account.
- Bug Fix: Photon: A fix for photos appearing shrunken if they didn't load
  quickly enough.
- Bug Fix: Sharing: A compatibility fix for posts that only have partial
  featured image data.
- Bug Fix: Publicize/Sharing: For sites without a static homepage, don't set
  the OpenGraph url value to the first post permalink.
- Bug Fix: Mobile Theme: Better compatibility with the customizer on mobile
  devices.
- Bug Fix: Sharing: Don't show sharing options on front page if that option is
  turned off.
- Bug Fix: Contact Form: Fix PHP warning shown when adding a Contact Form in
  WordPress 3.5.
- Bug Fix: Photon: Handle images with relative paths.
- Bug Fix: Contact Form: Fix compatibility with the Shortcode Embeds module.

## [2.0.4] - 2012-12-14

- Bug Fix: Open Graph: Correct a bug that prevents Jetpack from being
  activated if the SharePress plugin isn't installed.

## [2.0.3] - 2012-12-14

- Enhancement: Infinite Scroll: support
  [VideoPress](https://wordpress.org/plugins/video/) plugin.
- Enhancement: Photon: Apply to all images retrieved from the Media Library.
- Enhancement: Photon: Retina image support.
- Enhancement: Custom CSS: Refined editor interface.
- Enhancement: Custom CSS: Support [Sass](http://sass-lang.com/) and
  [LESS](http://lesscss.org/) with built-in preprocessors.
- Enhancement: Open Graph: Better checks for other plugins that may be loading
  Open Graph tags to prevent Jetpack from doubling meta tag output.
- Bug Fix: Infinite Scroll: Respect relative image dimensions.
- Bug Fix: Photon: Detect custom-cropped images and use those with Photon,
  rather than trying to use the original.
- Bug Fix: Custom CSS: Fix for bug preventing @import from working with
  url()-style URLs.

## [2.0.2] - 2012-11-21

- Bug Fix: Remove an erroneous PHP short open tag with the full tag to correct
  fatal errors under certain PHP configurations.

## [2.0.1] - 2012-11-21

- Enhancement: Photon: Support for the [Lazy
  Load](https://wordpress.org/plugins/lazy-load/) plugin.
- Bug Fix: Photon: Fix warped images with un- or under-specified dimensions.
- Bug Fix: Photon: Fix warped images with pre-photonized URLs; don't try to
  photonize them twice.
- Bug Fix: Infinite Scroll: Check a child theme's parent theme for infinite
  scroll support.
- Bug Fix: Infinite Scroll: Correct a bug with archives that resulted in posts
  appearing on archives that they didn't belong on.
- Bug Fix: Publicize: Send the correct shortlink to Twitter (et al.) if your
  site uses a shortener other than wp.me.
- Bug Fix: Sharing: Improved theme compatibility for the Google+ button.
- Bug Fix: Notifications: Use locally-installed Javascript libraries if
  available.

## [2.0] - 2012-11-08

- Enhancement: Publicize: Connect your site to popular social networks and
  automatically share new posts with your friends.
- Enhancement: Post By Email: Publish posts to your blog directly from your
  personal email account.
- Enhancement: Photon: Images served through the global WordPress.com cloud.
- Enhancement: Infinite Scroll: Better/faster browsing by pulling the next set
  of posts into view automatically when the reader approaches the bottom of the
  page.
- Enhancement: Open Graph: Provides more detailed information about your posts
  to social networks.
- Enhancement: JSON API: New parameters for creating and viewing posts.
- Enhancement: Improved compatibility for the upcoming WordPress 3.5.
- Bug Fix: Sharing: When you set your sharing buttons to use icon, text, or
  icon + text mode, the Google+ button will display accordingly.
- Bug Fix: Gravatar Profile Widget: Allow basic HTML to be displayed.
- Bug Fix: Twitter Widget: Error handling fixes.
- Bug Fix: Sharing: Improved theme compatibility
- Bug Fix: JSON API: Fixed error when creating some posts in some versions of
  PHP.

## 1.9.2 - 2012-10-29

- Bug Fix: Only sync options on upgrade once.

## [1.9.1] - 2012-10-29

- Enhancement: Notifications feature is enabled for logged-out users when the
  module is active & the toolbar is shown by another plugin.
- Bug Fix: Use proper CDN addresses to avoid SSL cert issues.
- Bug Fix: Prioritize syncing comments over deleting comments on
  WordPress.com. Fixes comment notifications marked as spam appearing to be
  trashed.

## [1.9] - 2012-10-26

- Enhancement: Notifications: Display Notifications in the toolbar and support
  reply/moderation of comment notifications.
- Enhancement: Mobile Push Notifications: Added support for mobile push
  notifications of new comments for users that linked their accounts to
  WordPress.com accounts.
- Enhancement: JSON API: Allows applications to send API requests via
  WordPress.com (see [the docs](http://developer.wordpress.com/docs/api/) )
- Enhancement: Sync: Modules (that require the data) sync full Post/Comment to
  ensure consistent data on WP.com (eg Stats)
- Enhancement: Sync: Improve syncing of site options to WP.com
- Enhancement: Sync: Sync attachment parents to WP.com
- Enhancement: Sync: Add signing of WP.com user ids for Jetpack Comments
- Enhancement: Sync: Mark and obfuscate private posts.
- Enhancement: Privacy: Default disable enhanced-distribution and json-api
  modules if site appears to be private.
- Enhancement: Custom CSS: allow applying Custom CSS to mobile theme.
- Enhancement: Sharing: On HTTPS pageloads, load as much of the sharing embeds
  as possible from HTTPS URLs.
- Enhancement: Contact Form: Overhaul of the contact form code to fix
  incompatibilites with other plugins.
- Bug Fix: Only allow users with manage_options permission to enable/disable
  modules
- Bug Fix: Custom CSS: allow '/' in media query units; e.g.
  (-o-min-device-pixel-ratio: 3/2)
- Bug Fix: Custom CSS: leave comments alone in CSS when editing but minify on
  the front end
- Bug Fix: Sharing: Keep "more" pane open so Google+ Button isn't obscured
- Bug Fix: Carousel: Make sure the original size is used, even when it is
  exceedingly large.
- Bug Fix: Exclude iPad from Twitter on iPhone mobile browsing
- Bug Fix: Sync: On .org user role changes synchronize the change to .com
- Bug Fix: Contact Form: Fix a bug where some web hosts would reject mail from
  the contact form due to email address spoofing.

## 1.8.3 - 2012-10-23

- Bug Fix: Subscriptions: Fix a bug where subscriptions were not being sent
  from the blog.
- Bug Fix: Twitter: Fix a bug where the Twitter username was being saved as
  blank.
- Bug Fix: Fix a bug where Contact Form notification emails were not being
  sent.

## [1.8.2] - 2012-10-04

- Bug Fix: Subscriptions: Fix a bug where subscriptions were not sent for
  posts and comments written by some authors.
- Bug Fix: Widgets: Fix CSS that was uglifying some themes (like P2).
- Bug Fix: Widgets: Improve Top Posts and Pages styling.
- Bug Fix: Custom CSS: Make the default "Welcome" message translatable.
- Bug Fix: Fix Lithuanian translation.

## [1.8.1] - 2012-09-28

- Bug Fix: Stats: Fixed a bug preventing some users from viewing stats.
- Bug Fix: Mobile Theme: Fixed some disabled toolbar buttons.
- Bug Fix: Top Posts widget: Fixed a bug preventing the usage of the Top Posts
  widget.
- Bug Fix: Mobile Theme: Fixed a bug that broke some sites when the
  Subscriptions module was not enabled and the Mobile Theme module was enabled.
- Bug Fix: Mobile Theme: Made mobile app promos in the Mobile Theme footer
  opt-in.
- Bug Fix: Twitter Widget: A fix to prevent malware warnings.
- Bug Fix: Mobile Theme: Fixed a bug that caused errors for some users with
  custom header images.

## [1.8] - 2012-09-27

- Enhancement: Mobile Theme: Automatically serve a slimmed down version of
  your site to users on mobile devices.
- Enhancement: Multiuser: Allow multiple users to link their accounts to
  WordPress.com accounts.
- Enhancement: Custom CSS: Added support for object-fit, object-position,
  transition, and filter properties.
- Enhancement: Twitter Widget: Added Follow button
- Enhancement: Widgets: Added Top Posts and Pages widget
- Enhancement: Mobile Push Notifications: Added support for mobile push
  notifications on new comments.
- Enhancement: VideoPress: Shortcodes now support the HD option, for default
  HD playback.
- Bug Fix: Twitter Widget: Fixed tweet permalinks in the Twitter widget
- Bug Fix: Custom CSS: @import rules and external images are no longer
  stripped out of custom CSS
- Bug Fix: Custom CSS: Fixed warnings and notices displayed in debug mode
- Bug Fix: Sharing: Fixed double-encoding of image URLs
- Bug Fix: Sharing: Fix Google +1 button HTML validation issues (again :))
- Bug Fix: Gravatar Profile Widget: Reduce size of header margins

## [1.7] - 2012-08-23

- Enhancement: CSS Editor: Customize your site's design without modifying your
  theme.
- Enhancement: Comments: Submit the comment within the iframe. No more full
  page load to jetpack.wordpress.com.
- Enhancement: Sharing: Share counts for Twitter, Facebook, LinkedIn
- Enhancement: Sharing: Improve styling
- Enhancement: Sharing: Add support for ReCaptcha
- Enhancement: Sharing: Better extensability through filters
- Enhancement: Widgets: Twitter: Attempt to reduce errors by storing a long
  lasting copy of the data. Thanks, kareldonk :)
- Regression Fix: Sharing: Properly store and display the sharing label
  option's default value.
- Bug Fix: Contact Form: remove worse-than-useless nonce.
- Bug Fix: Subscriptions: remove worse-than-useless nonce.
- Bug Fix: Sharing: Don't show sharing buttons twice on attachment pages.
- Bug Fix: Sharing: Increase width of Spanish Like button for Facebook.
- Bug Fix: Sharing: Use the correct URL to the throbber.
- Bug Fix: Stats: Fix notice about undefined variable $alt
- Bug Fix: Subscriptions: Make Subscriptions module obey the settings of the
  Settngs -> Discussion checkboxes for Follow Blog/Comments
- Bug Fix: Shortcodes: VideoPress: Compatibility with the latest version of
  VideoPress
- Bug Fix: Shortcodes: Audio: Include JS File for HTML5 audio player
- Bug Fix: Hovercards: Improve cache handling.
- Bug Fix: Widgets: Gravatar Profle: Correctly display service icons in edge
  cases.
- Bug Fix: Widgets: Gravatar Profle: Prevent ugly "flash" of too-large image
  when page first loads on some sites
- Bug Fix: Carousel: CSS Compatibility with more themes.

## 1.6.1 - 2012-08-04

- Bug Fix: Prevent Fatal error under certain conditions in sharing module
- Bug Fix: Add cachebuster to sharing.css
- Bug Fix: Disable via for Twitter until more robust code is in place

## [1.6] - 2012-08-02

- Enhancement: Carousel: Better image resolution selection based on available
  width/height.
- Enhancement: Carousel: Load image caption, metadata, comments, et alii when
  a slide is clicked to switch to instead of waiting.
- Enhancement: Carousel: Added a "Comment" button and handling to scroll to
  and focus on comment textarea.
- Enhancement: Widgets: Facebook Likebox now supports a height parameter and a
  better width parameter.
- Enhancement: Widgets: Better feedback when widgets are not set up properly.
- Enhancement: Shortcodes: Google Maps shortcode now supports percentages in
  the width.
- Enhancement: Shortcodes: Update Polldaddy shortcode for more efficient
  Javascript libraries.
- Enhancement: Shortcodes: Youtube shortcode now has playlist support.
- Enhancement: Add Gravatar Profile widget.
- Enhancement: Update Sharedaddy to latest version, including Pinterest
  support.
- Enhancement: Retinize Jetpack and much of WordPress.
- Bug Fix: Shortcodes: Fix Audio shortcode color parameter and rename encoding
  function.
- Bug Fix: Shortcodes: Don't output HTML 5 version of the Audio shortcode
  because of a bug with Google Reader.
- Bug Fix: Jetpack Comments: Don't overlead the addComments object if it
  doesn't exist. Fixes spacing issue with comment form.
- Bug Fix: Contact Form: If send_to_editor() exists, use it. Fixes an IE9 text
  area issue.

## [1.5] - 2012-07-31

- Enhancement: Add Gallery Carousel feature
- Note: the Carousel module bundles http://fgnass.github.com/spin.js/ (MIT
  license)

## 1.4.2 - 2012-06-20

- Bug Fix: Jetpack Comments: Add alternative Javascript event listener for
  Internet 8 users.
- Enhancement: Remove more PHP 4 backwards-compatible code (WordPress
  andJetpack only support PHP 5).
- Enhancement: Remove more WordPress 3.1 and under backwards-compatible code.

## 1.4.1 - 2012-06-15

- Bug Fix: Jetpack Comments / Subscriptions: Add checkboxes and logic control
  for the Subscription checkboxes.

## [1.4] - 2012-06-14

- Enhancement: Add Jetpack Comments feature.
- Bug Fix: Sharing: Make the sharing_label translatable.
- Bug Fix: Sharing: Fixed the file type on the LinkedIn graphic.
- Bug Fix: Sharing: Fixes for the Faceboox Like button language locales.
- Bug Fix: Sharing: Updates for the "more" button when used with touch screen
  devices.
- Bug Fix: Sharing: Properly scope the More button so that multiple More
  buttons on a page behave properly.
- Bug Fix: Shortcodes: Update the YouTube and Audio shortcodes to better
  handle spaces in the URLs.
- Bug Fix: Shortcodes: Make the YouTube shortcode respect embed settings in
  Settings -> Media when appropriate.
- Bug Fix: Shortcodes: Removed the Slide.com shortcode; Slide.com no longer
  exists.
- Bug Fix: Shortcodes: Match both http and https links in the [googlemaps]
  shortcode.
- Bug Fix: After the Deadline: Code clean up and removal of inconsistencies.

## 1.3.4 - 2012-05-24

- Bug Fix: Revert changes to the top level menu that are causing problems.

## 1.3.3 - 2012-05-22

- Bug Fix: Fix notices caused by last update

## 1.3.2 - 2012-05-22

- Bug Fix: Fix Jetpack menu so that Akismet and VaultPress submenus show up.

## 1.3.1 - 2012-05-22

- Enhancement: Add a new widget, the Facebook Likebox
- Bug Fix: Sharing: Sharing buttons can now be used on custom post types.
- Bug Fix: Contact Forms: Make Contact Forms widget shortcode less aggressive
  about the shortcodes it converts.
- Bug Fix: Ensure contact forms are parsed correctly in text widgets.
- Bug Fix: Connection notices now only appear on the Dashboard and plugin
  page.
- Bug Fix: Connection notices are now dismissable if Jetpack is not network
  activated.
- Bug Fix: Subscriptions: Fix an issue that was causing errors with new
  BuddyPress forum posts.

## [1.3] - 2012-04-25

- Enhancement: Add Contact Forms feature. Formerly Grunion Contact Forms.
- Bug Fix: Tweak YouTube autoembedder to catch more YouTube URLs.
- Bug Fix: Correctly load the Sharing CSS files.

## 1.2.4 - 2012-04-06

- Bug Fix: Fix rare bug with static front pages

## [1.2.3] - 2012-04-05

- Enhancement: Twitter Widget: Expand t.co URLs
- Bug Fix: Various PHP Notices.
- Bug Fix: WordPress Deprecated `add_contextual_help()` notices
- Bug Fix: Don't display unimportant DB errors when processing Jetpack nonces
- Bug Fix: Correctly sync data during certain MultiSite cases.
- Bug Fix: Stats: Allow sparkline img to load even when there is a DB upgrade.
- Bug Fix: Stats: Replace "loading title" with post title regardless of type
  and status.
- Bug Fix: Stats: Avoid edge case infinite redirect for `show_on_front=page`
  sites where the `home_url()` conatins uppercase letters.
- Bug Fix: Subscriptions: Don't send subscriptions if the feature is turned
  off in Jetpack.
- Bug Fix: Subscriptions: Fix pagination of subscribers.
- Bug Fix: Subscriptions: Sync data about categories/tags as well to improve
  subscription emails.
- Bug Fix: Subscriptions: Better styling for the subscription success message.
- Bug Fix: Shortcodes: Support for multiple Google Maps in one post. Support
  for all Google Maps URLs.
- Bug Fix: Shortcodes: Improved support for youtu.be URLs
- Bug Fix: Shortcodes: Improved Vimeo embeds.
- Bug Fix: Sharing: Switch to the 20px version of Google's +1 button for
  consistency.
- Bug Fix: Sharing: Fix Google +1 button HTML validation issues.
- Bug Fix: Sharing: Disable sharing buttons during preview.
- Bug Fix: Spelling and Grammar: Properly handle proofreading settings.
- Bug Fix: Spelling and Grammar: Don't prevent post save when proofreading
  service is unavailable.

## [1.2.2] - 2011-12-06

- Bug Fix: Ensure expected modules get reactivated correctly during upgrade.
- Bug Fix: Don't send subscription request during spam comment submission.
- Bug Fix: Increased theme compatibility for subscriptions.
- Bug Fix: Remove reference to unused background image.

## [1.2.1] - 2011-11-18

- Bug Fix: Ensure Site Stats menu item is accessible.
- Bug Fix: Fixed errors displayed during some upgrades.
- Bug Fix: Fix inaccurate new modules "bubble" in menu for some upgrades.
- Bug Fix: Fix VaultPress detection.
- Bug Fix: Fix link to http://jetpack.com/faq/

## [1.2] - 2011-11-17

- Enhancement: Add Subscriptions: Subscribe to site's posts and posts'
  comments.
- Enhancement: Add Google Maps shortcode.
- Enhancement: Add Image Widget.
- Enhancement: Add RSS Links Widget.
- Enhancement: Stats: More responsive stats dashboard.
- Enhancement: Shortcodes: Google Maps, VideoPress
- Enhancement: Sharing: Google+, LinkedIn
- Enhancement: Enhanced Distribution: Added Jetpack blogs to
  https://en.wordpress.com/firehose/
- Bug Fix: Spelling and Grammar: WordPress 3.3 compatibility.
- Bug Fix: Translatable module names/descriptinos.
- Bug Fix: Correctly detect host's ability to make outgoing HTTPS requests.

## [1.1.3] - 2011-07-19

- Bug Fix: Increase compatibility with WordPress 3.2's new
  `wp_remote_request()` API.
- Bug Fix: Increase compatibility with Admin Bar.
- Bug Fix: Stats: Improved performance when creating new posts.
- Bug Fix: Twitter Widget: Fix PHP Notice.
- Bug Fix: Sharedaddy: Fix PHP Warning.
- Enhancement: AtD: Add spellcheck button to Distraction Free Writing screen.
- Translations: Added: Bosnian, Danish, German, Finnish, Galician, Croatian,
  Indonesian,  Macedonian, Norwegian (BokmÃ¥l), Russian, Slovak, Serbian, Swedish
- Translations: Updated: Spanish, French, Italian, Japanese, Brazilian
  Portuguese, Portuguese

## [1.1.2] - 2011-07-06

- Bug Fix: Note, store, and keep fresh the time difference between the Jetpack
  site's host and the Jetpack servers at WordPress.com. Should fix all
  "timestamp is too old" errors.
- Bug Fix: Improve experience on hosts capable of making outgoing HTTPS
  requests but incapable of verifying SSL certificates. Fixes some
  "register_http_request_failed", "error setting certificate verify locations",
  and "error:14090086:lib(20):func(144):reason(134)" errors.
- Bug Fix: Better fallback when WordPress.com is experiencing problems.
- Bug Fix: It's Jetpack, not JetPack :)
- Bug Fix: Remove PHP Warnings/Notices.
- Bug Fix: AtD: JS based XSS bug. Props markjaquith.
- Bug Fix: AtD: Prevent stored configuration options from becoming corrupted.
- Bug Fix: Stats: Prevent missing old stats for some blogs.
- Bug Fix: Twitter Widget: Fix formatting of dates/times in PHP4.
- Bug Fix: Twitter Widget: Cache the response from Twitter to prevent "Twitter
  did not respond. Please wait a few minutes and refresh this page." errors.
- Enhancement: Slightly improved RTL experience. Jetpack 1.2 should include a
  much better fix.
- Enhancement: Sharedaddy: Improve localization for Facebook Like button.
- Enhancement: Gravatar Hovercards: Improved experience for Windows browsers.

## [1.1.1] - 2011-03-19

- Bug Fix: Improve experience on hosts capable of making outgoing HTTPS
  requests but incapable of verifying SSL certificates. Fixes most "Your Jetpack
  has a glitch. Connecting this site with WordPress.com is not possible. This
  usually means your site is not publicly accessible (localhost)." errors.
- Bug Fix: Sharedaddy: Fatal error under PHP4. Disable on PHP4 hosts.
- Bug Fix: Stats: Fatal error under PHP4. Rewrite to be PHP4 compatible.
- Bug Fix: Stats: Fatal error on some sites modifying/removing core WordPress
  user roles. Add sanity check.
- Bug Fix: Stats: Replace debug output with error message in dashboard widget.
- Bug Fix: Stats: Rework hook priorities so that stats views are always
  counted even if a plugin (such as Paginated Comments) bails early on
  template_redirect.
- Bug Fix: Identify the module that connot be activated to fatal error during
  single module activation.
- Bug Fix: `glob()` is not always available. Use `opendir()`, `readdir()`,
  `closedir()`.
- Bug Fix: Send permalink options to Stats Server for improved per post
  permalink calculation.
- Bug Fix: Do not hide Screen Options and Help links during Jetpack call to
  connect.
- Bug Fix: Improve readablitiy of text.
- Bug Fix: AtD: Correctly store/display options.
- Enhancement: Output more informative error messages.
- Enhancement: Improve CSS styling.
- Enhancement: Stats: Query all post types and statuses when getting posts for
  stats reports.
- Enhancement: Improve performance of LaTeX URLs be using cookieless CDN.

## [1.1] - 2011-03-09

- Initial release

[10.9]: https://wp.me/p1moTy-EHd
[10.8]: https://wp.me/p1moTy-CTQ
[10.7]: https://wp.me/p1moTy-AMD
[10.6]: https://wp.me/p1moTy-AES
[10.5]: https://wp.me/p1moTy-Ax4
[10.4]: https://wp.me/p1moTy-AmR
[10.3]: https://wp.me/p1moTy-z9b
[10.2]: https://wp.me/p1moTy-yvR
[10.1]: https://wp.me/p1moTy-xYy
[10.0]: https://wp.me/p1moTy-xFA
[9.9]: https://wp.me/p1moTy-xc9
[9.8]: https://wp.me/p1moTy-vGp
[9.7]: https://wp.me/p1moTy-vpN
[9.6]: https://wp.me/p1moTy-vdU
[9.5]: https://wp.me/p1moTy-uSv
[9.4]: https://wp.me/p1moTy-tOv
[9.3]: https://wp.me/p1moTy-sgZ
[9.2]: https://wp.me/p1moTy-scn
[9.1]: https://wp.me/p1moTy-s0E
[9.0]: https://wp.me/p1moTy-rLy
[8.9]: https://wp.me/p1moTy-rAs
[8.8]: https://wp.me/p1moTy-rs2
[8.7]: https://wp.me/p1moTy-qiH
[8.6]: https://wp.me/p1moTy-pb1
[8.5]: https://wp.me/p1moTy-p00
[8.4]: https://wp.me/p1moTy-oPp
[8.3]: https://wp.me/p1moTy-nZT
[8.2]: https://wp.me/p1moTy-mVu
[8.1.1]: https://wp.me/p1moTy-lJT
[8.1]: https://wp.me/p1moTy-lJT
[8.0]: https://wp.me/p1moTy-lGH
[7.9.1]: https://wp.me/p1moTy-lHA
[7.9]: https://wp.me/p1moTy-lzt
[7.8]: https://wp.me/p1moTy-lvE
[7.7]: https://wp.me/p1moTy-log
[7.6]: https://wp.me/p1moTy-ljs
[7.5.3]: https://wp.me/p1moTy-k9A
[7.5.2]: https://wp.me/p1moTy-k9A
[7.5.1]: https://wp.me/p1moTy-k9A
[7.5]: https://wp.me/p1moTy-k9A
[7.4.1]: https://wp.me/p1moTy-kvz
[7.4]: https://wp.me/p1moTy-jgZ
[7.3.1]: https://wp.me/p1moTy-jgO
[7.3]: https://wp.me/p1moTy-ipR
[7.2.1]: https://wp.me/p1moTy-h7o
[7.2]: https://wp.me/p1moTy-foe
[7.1.1]: https://wp.me/p1moTy-foJ
[7.1]: https://wp.me/p1moTy-e9x
[7.0.1]: https://wp.me/p1moTy-eFX
[7.0]: https://wp.me/p1moTy-dqO
[6.9]: https://wp.me/p1moTy-cEZ
[6.8.1]: https://wp.me/p1moTy-d3t
[6.8]: https://wp.me/p1moTy-cee
[6.7]: https://wp.me/p1moTy-aEq
[6.6.1]: https://wp.me/p1moTy-aEt
[6.6]: https://wp.me/p1moTy-aa1
[6.5]: https://wp.me/p1moTy-a7U
[6.4.2]: https://wp.me/p1moTy-9pL
[6.4.1]: https://wp.me/p1moTy-9pc
[6.4]: https://wp.me/p1moTy-9md
[6.3.3]: https://wp.me/p1moTy-9n0
[6.3.2]: https://wp.me/p1moTy-96E
[6.3]: https://wp.me/p1moTy-8ag
[6.2.1]: https://wp.me/p1moTy-8am
[6.2]: https://wp.me/p1moTy-88v
[6.1.1]: https://wp.me/p1moTy-85t
[6.1]: https://wp.me/p1moTy-7Sj
[6.0]: https://wp.me/p1moTy-7xM
[5.9]: https://wp.me/p1moTy-7mW
[5.8]: https://wp.me/p1moTy-731
[5.7.1]: https://wp.me/p1moTy-7aS
[5.7]: https://wp.me/p1moTy-6FR
[5.6.1]: https://wp.me/p1moTy-6Jk
[5.6]: https://wp.me/p1moTy-6zt
[5.5.1]: https://wp.me/p1moTy-6Bd
[5.5]: https://wp.me/p1moTy-6rk
[5.4]: http://wp.me/p1moTy-67V
[5.3]: http://wp.me/p1moTy-5Xv
[5.2.1]: https://jetpack.com/?p=22686
[5.2]: https://jetpack.com/?p=22509
[5.1]: https://jetpack.com/?p=20888
[5.0]: http://wp.me/p1moTy-5hK
[4.9]: http://wp.me/p1moTy-4Rl
[4.8.2]: http://wp.me/p1moTy-4P0
[4.8.1]: http://wp.me/p1moTy-4N5
[4.8]: http://wp.me/p1moTy-4gA
[4.7.1]: http://wp.me/p1moTy-48Y
[4.7]: http://wp.me/p1moTy-46L
[4.6]: http://wp.me/p1moTy-40g
[4.5]: http://wp.me/p1moTy-3Kc
[4.4.2]: http://wp.me/p1moTy-3JR
[4.4.1]: http://wp.me/p1moTy-3JR
[4.4]: http://wp.me/p5U9nj-2Ow
[4.1]: http://wp.me/p1moTy-3jd
[4.0.4]: http://wp.me/p1moTy-3eT
[4.0.3]: http://wp.me/p1moTy-3hm
[4.0]: http://wp.me/p1moTy-3dL
[3.9.6]: http://wp.me/p1moTy-3bz
[3.9.5]: http://wp.me/p1moTy-3bz
[3.9.4]: http://wp.me/p1moTy-396
[3.9.3]: http://wp.me/p1moTy-396
[3.9.2]: http://wp.me/p1moTy-2Ei
[3.9]: http://wp.me/p1moTy-29R
[3.8.2]: http://wp.me/p1moTy-26v
[3.8.1]: http://wp.me/p1moTy-23V
[3.8.0]: http://wp.me/p1moTy-1VN
[3.7.2]: http://wp.me/p1moTy-1LB
[3.7.1]: http://wp.me/p1moTy-1LB
[3.7.0]: http://wp.me/p1moTy-1JB
[3.6]: http://wp.me/p1moTy-1ua
[3.5]: http://wp.me/p1moTy-1jF
[3.4.3]: http://wp.me/p1moTy-1jb
[3.4.2]: http://wp.me/p1moTy-1j6
[3.4]: http://wp.me/p1moTy-1fU
[3.3]: http://wp.me/p1moTy-1aF
[3.2]: http://wp.me/p1moTy-181
[3.1]: http://wp.me/p1moTy-129
[3.0]: http://wp.me/p1moTy-Wi
[2.9.3]: http://wp.me/p1moTy-U2
[2.9]: http://wp.me/p1moTy-RN
[2.8]: http://wp.me/p1moTy-Pd
[2.7]: http://wp.me/p1moTy-Mk
[2.6]: http://wp.me/p1moTy-KE
[2.5]: http://wp.me/p1moTy-xS
[2.4]: http://wp.me/p1moTy-wv
[2.3.5]: http://wp.me/p1moTy-vf
[2.3.4]: http://wp.me/p1moTy-uL
[2.3.3]: http://wp.me/p1moTy-uv
[2.3.2]: http://wp.me/p1moTy-uv
[2.3.1]: http://wp.me/p1moTy-t9
[2.3]: http://wp.me/p1moTy-rX
[2.2.5]: http://wp.me/p1moTy-p8
[2.2.4]: http://wp.me/p1moTy-oU
[2.2.3]: http://wp.me/p1moTy-oR
[2.2.1]: http://wp.me/p1moTy-ob
[2.2]: http://wp.me/p1moTy-ns
[2.1.1]: http://wp.me/p1moTy-ng
[2.1]: http://wp.me/p1moTy-m3
[2.0.4]: http://wp.me/p1moTy-lT
[2.0.3]: http://wp.me/p1moTy-lJ
[2.0.2]: http://wp.me/p1moTy-lu
[2.0.1]: http://wp.me/p1moTy-lc
[2.0]: http://wp.me/p1moTy-jg
[1.9.1]: http://wp.me/p1moTy-iC
[1.9]: http://wp.me/p1moTy-hC
[1.8.2]: http://wp.me/p1moTy-gI
[1.8.1]: http://wp.me/p1moTy-gx
[1.8]: http://wp.me/p1moTy-fV
[1.7]: http://wp.me/p1moTy-eq
[1.6]: http://wp.me/p1moTy-e0
[1.5]: http://wp.me/p1moTy-d7
[1.4]: http://wp.me/p1moTy-cz
[1.3]: http://wp.me/p1moTy-bq
[1.2.3]: http://wp.me/p1moTy-b4
[1.2.2]: http://wp.me/p1moTy-ax
[1.2.1]: http://wp.me/p1moTy-9H
[1.2]: http://wp.me/p1moTy-8x
[1.1.3]: http://wp.me/p1moTy-90
[1.1.2]: http://wp.me/p1moTy-8B
[1.1.1]: http://wp.me/p1moTy-8i
[1.1]: http://wp.me/p1moTy-7R
