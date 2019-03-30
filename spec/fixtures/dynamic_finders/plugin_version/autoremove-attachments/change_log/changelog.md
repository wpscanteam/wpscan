#### Version 1.1.2
- New filter added to allow developers define custom rules for controlling when the child attachments should be removed automatically
- Removed the old 'autoremove_attachments_post_types' filter in favor of the new one - usage instructions available in the FAQ

#### Version 1.1.1
- New filter added to allow developers to change for what post types the child attachments should be removed automatically
- Fixed a minor incompatibility with WP-Sweep

#### Version 1.1.0
- Minor improvements for the admin notice

#### Version 1.0.9
- Performance improvements on websites with a large number of posts and attachments

#### Version 1.0.8
- Added extra security checks before the removal of attachments
- Added an admin notice with a warning about the limitations of this plugin and the consequences of its improper usage. ( for new users only )

#### Version 1.0.7
- Minor code refactoring
- Added full support for WordPress Multisite

#### Version 1.0.6
- Code refactored using wpcs

#### Version 1.0.5
- Improved the warning displayed when very old PHP versions are used

#### Version 1.0.4
- Remove all traces of the plugin, even on multisite installs

#### Version 1.0.3
- Added a security check to avoid deleting attachments when the ID of the parent post is invalid

#### Version 1.0.2
- Fixed a bug that was causing media files to be removed when revisions were deleted with wp-cron

#### Version 1.0.1
- Minimum required version of PHP set to 5.3

#### Version 1.0.0
- First release
