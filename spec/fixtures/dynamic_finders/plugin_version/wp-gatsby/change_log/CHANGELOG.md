# Change Log

## 0.4.9

### Bug Fixes

- Preview wasn't working properly for new posts that hadn't yet been published or for drafts.

## 0.4.8

Pushing release to WordPress.org

## 0.4.7

### New Features

- Added a link to the GatsbyJS settings page on how to configure this plugin.

### Bug Fixes

- Activating this plugin before WPGraphQL was causing PHP errors.

## 0.4.6

Add Wapuu Icons for display in the WordPress.org repo

## 0.4.5

Re-publish with proper package name

## 0.4.4

Testing Github Actions

## 0.4.3

New release to trigger publishing to WordPress.org!

## 0.4.2

### Bug Fixes

- Previously when a post transitioned from published to draft, it wouldn't be deleted in Gatsby

## 0.4.1

Version bump to add /vendor directory to Git so that Github releases work as WP plugins without running `composer install`. In the future there will be a better release process, but for now this works.

## 0.4.0

### Breaking Changes

- WPGraphQL was using nav_menu for it's menu relay id's instead of term. WPGQL 0.9.1 changes this from nav_menu to term. This is a breaking change because cache invalidation wont work properly if the id is incorrect. So we move to v0.4.0 so gatsby-source-wordpress-experimental can set 0.4.0 as it's min version and cache invalidation will keep working.

## 0.3.0

### Breaking Changes

- Updated Relay ids to be compatible with WPGraphQL 0.9.0. See https://github.com/wp-graphql/wp-graphql/releases/tag/v0.9.0 for more info.
- Bumped min PHP and WP versions

## 0.2.6

### Bug fixes

Fixed an issue where we were trying to access post object properties when we didn't yet have the post.

## 0.2.5

### Bug Fixes

Earlier versions of WPGatsby were recording up to 4 duplicate content saves per content change in WordPress. This release stops that from happening. WPGatsby does garbage collection, so any duplicate actions will be automatically removed from your DB.
