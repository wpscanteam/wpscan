# Change Log

## [2.1.0] - 2018-04-19

### Added

* `user_name` parameter for the `[members_access]` shortcode.
* `user_id` parameter for the `[members_access]` shortcode.
* `user_email` parameter for the `[members_access]` shortcode.
* `icon-members-core-create-caps.png` file for local access to the corresponding add-on thumbnail.

### Fixed

* Incorrect roles (or empty roles) appearing on sub-sites when running multisite.
* Invalid icon URL on the Settings > Members > Add-ons admin screen.
* Fix for WooCommerce empty page ID in the private site feature.

### Changed

* Bumped minimum PHP requirement to 5.6+. However, the code should still work on PHP 5.3. This is in preparation for a hard requirement of 5.6+ when version 3.0.0 is released.

## [2.0.2] - 2017-11-06

### Fixed

* Role labels should now be handled correctly where the plugin outputs them.  This was not corrected in 2.0.1 as previously thought.

### Security

* Corrected a capability escalation issue on multisite where administrators could assign themselves network caps.  Administrators are no longer given the `create_role`, `edit_role`, and `delete_role` caps on multisite.  A Super Admin must manually set these caps if they want to grant them to a site administrator.  Additionally, network caps are always blocked from being assigned.

## [2.0.1] - 2017-09-28

### Changed

* Cap groups registered by the plugin bumped up 5 in priority. Primarily, this was to make sure post type cap groups were registered earlier than the default of `10`.
* Better handling of the PHP notice.  We're going to check prior to loading any other code and add an admin notice if the site doesn't meet minimum requirements.

### Fixed

* The `show_human_caps` setting was not properly saving because it wasn't accounted for in the validation callback.
* Make sure to use the correct `$old_user_data` variable when removing all roles from a user. Otherwise, this doesn't work.
* Super admins should be able to see any private site when multisite is enabled.
* Make sure that role labels (where the plugin outputs them) are the translated version.
* Multi-role selection has been removed for the Add New User screen on multisite installs.  This was to address multiple issues in core with hardcoded values that the plugin couldn't filter.  The feature may return in the future in a different form.  Note that this doesn't change single-site installs.

## [2.0.0] - 2017-07-19

### Added

* Created a new admin view system, where there can be multiple views ("tabs", if you like) on the settings screen and other potential screens in the future.
* Added an "Add-Ons" view for the Members Settings page, which lists add-ons for the plugin.  The default add-ons are pulled from Theme Hybrid.
* Created an add-ons API for other developers to list their own add-ons.
* Created a capability registration system and API for plugin developers to register their capabilities with Members.  The major benefit of this is having internationalized labels for capabilities.
* Registered all of the core capabilities with human-readable, internationalized text labels so that users who do not speak English can benefit from capability translations.
* Added the `members_enable_{$post_type}_content_permissions` filter hook to allow developers to enable/disable content permissions per post type.
* Removed the core "Change Role" feature on the manage users screen and replaced it with an "Add Role" and "Remove Role" feature for bulk editing users.  Note that this only appears when multiple roles is enabled.
* Add a multi-role checkbox on the Add User screen when multiple roles are enabled.
* Added a `members_has_post_roles()` conditional tag for checking if a post has content permissions roles assigned to it.
* Added the `operator` parameter, which accepts a value of `!`, for the `[members_access]` shortcode.  This allows users to negate the role or cap they've passed in.

### Changed

* Roles states on the manage role screen now have array keys so they can more easily be overwritten.
* Created a `.wp-tab-panel` wrapper around the user roles checklist on the edit user screen. This is to prevent long lists of roles from taking up too much screen space.
* Moved the All capability tab to the bottom of the capability tabs list.
* Removed the All cap group, since it is not a true cap group.
* Removed the All, Mine, Active, Inactive, Editable, and Uneditable role groups.  These are merely views for the role management screen.  They are not true role groups.
* Created a new, internal registry class for storing various collections of data.  Note that this does break back-compat for developers who were directly accessing factory classes in previous versions rather than using the wrapper functions.
* Old classes were added to the `Members` namespace or `Members\Admin` namespace.  Again, this breaks back-compat for anyone not using the appropriate wrapper functions.  This also bumps the requirement to PHP 5.3.0+.
* Changed the text in the Content Permissions meta box to not specifically use the term "post".
* Changed the Content Permissions meta box to have a tabbed UI so that it doesn't take up so much screen space.
* Replaced the basic textarea with the WP editor in the Content Permissions meta box.

### Fixed

* No longer save content permissions on autosave or for post revisions.
* Prevent users from adding the internal core WP `do_not_allow` capability to their role.
* On multisite with the private site feature enabled, block access to logged-in users who do not have access to the specific blog.
* Make sure comments show an error in the comments feed if they belong to a private post.

### Security

* General hardening and use of some better functions for escaping.
* Added a private REST API option for users who are utilizing the private site feature.  Users will likely want to enable this.  Otherwise, their "private site" is exposed via the REST API endpoints.

## [1.1.3] - 2017-02-06

### Fixed

* Removes the `customize_changeset` and `custom_css` post type cap groups so that they don't appear in the capability tabs on the edit role screen.

### Security

* Added a check that the role is editable before attempting to add a new role to a user.

## [1.1.2] - 2016-06-20

### Fixed

* Bug where custom capabilities would not appear after updating role.
* Make BuddyPress activation page public in private site mode.

## [1.1.1] - 2016-01-09

### Changed

* Allows a hyphen in role names. Alphanumeric characters, underscores, and hyphens now allowed.

### Fixed

* Don't escaped allowed HTML in the login widget textarea.
* When filter `user_has_cap`, check that the role is not null.
* Remove broken property check when unregistering a cap group.
* Typo corrections in the Content Permissions meta box.
* Changed an incorrect textdomain instance.

## [1.1.0] - 2015-10-12

### Added

* `Text Domain` plugin header added.
* `Domain Path` plugin header added.
* `members_role_updated` action hook for when a role is edited/updated.
* `members_role_added` action hook for when a new role is created.
* `members_manage_roles_column_{$column_name}` filter hook for handling the output of custom manage roles screen columns.
* `members_cp_meta_box_before` action hook for hooking in before the Content Permissions meta box.
* `members_cp_meta_box_after` action hook for hooking in after the Content Permissions meta box.
* Added the `Members_Role_Factory::remove_role()` method to remove a stored role.

### Changed

* Edit/New role forms just check the nonce instead of checking for form fields + nonce to see if the form was submitted (fields can be legitimately empty).

### Fixed

* Correct "undefined index" notices with widgets.
* Make sure custom caps (post types, taxonomies, etc.) that aren't stored get saved when editing a role.
* Make sure the "All" capability group actually lists all caps from all groups.
* Use the `$user` variable instead of `$author` variable in `members_list_users()`.
* "Custom" cap group should always be added last.
* Make sure roles edited with no caps get processed. Previously, we bailed if no caps were set.
* Remove deleted roles from the manage roles screen list without having to refresh the page.

### Security

* Use `wp_strip_all_tags()` over `strip_tags()` for sanitizing the role name.
* Use `esc_url_raw()` to escape the redirect URL after creating a new role.

## [1.0.2] - 2015-09-15

### Fixed

* Make sure `$attr` is set by `shortcode_atts()` in the `[members_access]` shortcode.
* Use `members_current_user_has_role()` in the `[members_access]` shortcode.
* Use `! empty()` to validate the checkboxes when settings are saved.

## [1.0.1] - 2015-09-14

### Fixed

* Only load `edit-role.js` on the role management screens.

## [1.0.0] - 2015-09-13

### Added

* Ability to clone existing roles.
* Add multiple roles per user.
* Ability to explicitly deny capabilities to roles.
* Capability groups to find related caps when editing a role.
* Role groups to group related roles together.
* Content Permissions handles HTML, shortcodes, and auto-embeds.
* Disabled capabilities (via `wp-config.php` settings) no longer show cap lists.
* Additional role and capability functions to extend WP's existing APIs.
* Role translation filters so that plugin authors can make role names translatable.
* Uneditable roles are now shown in the UI. They can be viewed but not edited.
* `Members_Role` object and API to extend WP's existing Roles API.
* Plugin authors can now add meta boxes to the edit role screen.
* Underscore JS based capabilities editing box for roles.

### Changed

* Complete UI overhaul for all user-facing components in the plugin.
* Overhaul of all text strings in the plugin.
* Shortcodes are now prefixed with `members_`. Old shortcodes will continue to work.
* Overhauled the widgets code with new text strings and general code cleanup.
* Using the newer WP help tab functionality with custom tabs.

### Deprecated

* `members_get_active_roles()`. Replaced by `members_get_active_role_names()`.
* `members_get_inactive_roles()`. Replaced by `members_get_inactive_role_names()`.
* `members_count_roles()`. Replaced by `members_get_role_count()`.
* `members_get_default_capabilities()`. Replaced by `members_get_wp_capabilities()`.
* `members_get_additional_capabilities()`. Replaced by `members_get_plugin_capabilities()`.

### Removed

* Upgrade routine.
* All old translation files since the text strings were overhauled.
* Plugin constants in favor of `Members_Plugin` properties.
* `$members` global in favor of `Members_Plugin` properties.

### Fixed

* Content Permissions meta box now accepts HTML on the edit post screen.
* User levels are now hidden from the role capability count.
* Uses the proper path for translation files in case plugin folder name changes.
* An "Are you sure?" (AYS) popup prevents users from inadvertently deleting roles.
* Added missing `export` and `delete_themes` caps to the core caps backup function.
* Removed CSS code that was hiding the "collapse menu" button for the admin menu.

### Security

* Added the `members_sanitize_role()` function.
* Added the `members_sanitize_cap()` function.
* Security hardening by making sure all URLs are escaped.
* Security hardening by making sure all dynamic data is escaped.
* Security hardening by escaping translated text.

## [0.2.5] - 2015-07-09

### Fixed

* Deprecated old widget constructor method in favor of using `__construct()` in preparation for WP 4.3.
* Removed old `/components` folder and files that's not used.

## [0.2.4]

* Fixed content permissions not saving for attachments. Note that this only protects **content** and not media files.
* No longer runs the upgrade script when `WP_INSTALLING` is `TRUE`.

## [0.2.3]

* Fixes the strict standards notice "Redefining already defined constructor for class Members_Load".
* No longer uses `&` for passing the role name by reference on plugin activation.
* Fixes the `[feed]` shortcode, which was using the wrong callback function.

## [0.2.2]

* No longer displays non-editable roles on the edit roles screen.

## [0.2.1]

* Fixes the " Creating default object from empty value" error.

## [0.2.0]

* Updated everything.  Nearly all the code was rewritten from the ground up to make for a better user experience.
* Plugin users should check their plugin settings.

## [0.1.1]

* Fixed a bug with the Content Permissions component that restricted access to everyone.
* Added missing internationalization function call: `load_plugin_textdomain()`.
* Added new `/languages` folder for holding translations.
* Added `members-en_EN.po`, `members-en_EN.mo`, and `members.pot` to the `/languages` folder.
* Updated some non-internationalized strings.

## [0.1.0]

* Plugin launch.  Everything's new!
