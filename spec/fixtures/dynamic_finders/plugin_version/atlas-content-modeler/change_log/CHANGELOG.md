# Atlas Content Modeler Changelog

## 0.8.0 - 2021-10-13

### Added
- Share models between sites using the new Export and Import models feature. Visit Content Modeler → Tools to get started.
- Added "author" support to custom post types. This unlocks new functionality such as assigning specific users to a post, and querying posts by author in WPGraphQL.

### Fixed
- Fixed bug where the model icon could not be changed when editing an existing model.
- Fixed bug in the Number field where you could not define a Step value without also defining a Max value.
- Improved duplicate field slug detection to ensure forward and reverse slugs for the Relationship field are unique in WPGraphQL.

### Changed
- The `@wordpress/i18n` package is no longer bundled in the plugin's scripts, relying on the version that ships with WordPress instead.

## 0.7.0 - 2021-10-04

### Added
- Relationship Field: one-to-one and one-to-many relationships were renamed to many-to-one and many-to-many to accurately reflect their function.
- Relationship Field: fields can now optionally include reverse references.
- Relationship Field: added [Beta] flag as the feature takes shape.
- Chore: set "Requires at least" to WordPress version 5.7
- Chore: set "Requires PHP" to version 7.2

### Fixed
- Fixed bug where the app prompted about "Unsaved changes" when no changes had been made.

## 0.6.0 - 2021-09-09

### Added
- Create one-to-one and one-to-many relationships between model entries with the new Relationship field.
- A plugin icon will appear on the plugin update page during future updates.

### Fixed
- Improved modal scroll behavior and positioning.

## 0.5.0 - 2021-08-12

### Added
- You can now add custom Taxonomies and assign them to your models. Visit Atlas Content Modeler → Taxonomies to get started.
- Models and Taxonomies submenu items now appear in the admin sidebar below Atlas Content Modeler.

### Changed
- Refactored PHP tests.

## 0.4.2 - 2021-08-04

### Added
- Ability to choose an icon when creating or editing a model.
- Option to restrict file types for the media field.
- Generate WordPress changelog from the Markdown changelog so that changes are visible from the WordPress changes modal.
- Plugin developer improvements: GitHub Pull Request template; Code Climate configuration; Makefile for test environments.

### Changed
- Change “API Identifier” field title on model entry forms to “Model ID” with a new description to better reflect its use.
- Continuous Integration: the generated plugin zip is now tested and verified before deploying.

### Fixed
- Improve query generation for “Open in GraphiQL” to include lowercase model names and models with the same plural and singular name.
- Improve sanitization of model slugs. Includes safe migration of existing model slugs.
- Prevent a PHP warning during title filtering if post info can not be found.
- Improve number field validation.

## 0.4.1 - 2021-06-24
### Added
- Generate POT language file for translations.

### Changed
- Use `include` in place of `require` so that missing or corrupt files do not take WordPress down.

### Removed
- Removed the Multiple Choice field for now while we add support for custom choice API IDs.

## 0.4.0 - 2021-06-22
- First public release. There may be breaking changes until 1.0.0.

### Added
- New Multiple Choice field (beta) to create radio and checklist groups.
- New “Send Feedback” button to share your experience with us.
- New model option for “Private” or “Public” API visibility.
- The Text field now includes an optional character minimum and maximum count in Advanced Settings.
- The Number field now includes an optional minimum, maximum and step value in Advanced Settings.
- Prompt to complete edits to an open field when attempting to open another field.
- Added LICENSE, CONTRIBUTING and CHANGELOG files.

### Changed
- REST responses now show Atlas Content Modeler fields under an `acm_fields` property.
- REST responses now display detailed information about media fields.
- Changed “Text Length” to “Input Type” in the Text field. Text length is now determined in Advanced Settings. Input type lets developers choose an input or textarea field.
- Increased the clickable area on dropdown menu items in the developer app.
- Adjusted styling in the publisher app.
- Refactored default value handling to improve field load times.
- Internal REST routes now include an `atlas` prefix.
- The README now includes a getting started guide.

### Fixed
- Pressing return in the publisher app will now submit the form, instead of clearing fields.
- Corrected an issue preventing fields from appearing in REST responses.
- Prevented custom fields from showing in REST when `show_in_rest` is false.
- Strings in the publisher and developer interfaces are now translatable.
- Fixed Jest tests and add to Continuous Integration workflow.
- Improved admin URL handling for WordPress sites hosted in a subfolder.
- Improved plugin update error messages to include the name of the plugin reporting them.
- Prevented a styling issue with the Content Modeler admin menu item.

## 0.3.0 - 2021-06-01
### Added
- Developers can now mark fields as required.
- Publishers will see inline errors prompting them to fill required fields.

### Changed
- Rebranded to Atlas Content Modeler.
- Changed data storage format.
- Changed model data option name from wpe_content_model_post_types to atlas_content_modeler_post_types.
- Updated admin sidebar icons for settings and entries.
- Improved Rich Text fields, including adding media support.
- Open fields now close when another field is created or opened.
- Media fields now have a WPGraphQL type of MediaItem instead of String to enable complete queries for media information.

### Fixed
- Improved model and field list appearance at mobile screen widths.
- Improved client-side field validation for publishers.
- Hid duplicate page title on new entry screens.
- Corrected headers when editing entries.
- Protected meta fields to prevent them appearing in the Custom Fields meta box.

### Removed
- Repeater fields have been removed.
- Screen options have been removed from entry pages for content model post types.
- Post thumbnail support has been removed for content model post types.

## 0.2.0 - 2021-05-07
### Added
- Publishers can now enter model entries via a form.
- Developers have the option to set a field as the title field.
- The plugin now checks for updates.
- Model and field options now close on blur or when the escape key is pressed.
- Model options include “Open in GraphiQL” if the WPGraphQL plugin is active.
- Improved developer tooling for linting, including pre-commit hooks.

### Changed
- The media field is restricted to single file uploads for now.

### Removed
- Unused “Created on” column from the model table.

## 0.1.0
- Initial version.
