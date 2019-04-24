# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Beta : 0.0.8] - 11/12/2018
### Fixed
1. Core : `wponion_get_all_fields_ids_and_defaults` Function Fully Redeveloped
2. Core : Managed To Check if debug enabled properly and provided WPOnion's Debug Const Priority
 
### Added
1. WP Module  - WP Notice (Clone of https://github.com/panvagenas/wp-admin-notices)
2. Field Type - Core WP Notice As Field
3. Field Type - Sysinfo

### Changed
Migrated From WordPress VIP Coding Standards To WordPress Core Coding Standards.

## [Beta : 0.0.7] - 25/11/2018
### Added
1. WP Module  - AdminBar
2. WP Module  - Custom Meta box Support
3. WP Module  - WP Nav Menu
4. WP Module  - Dashboard , Admin Page & Settings Modules now supports WP Network (#6)
5. Core       - Composer Support
6. Field API  - Field Compile Time Recorder
7. Field Type - Added Option To Set Dynamic Heading in Group Field (#10)

### Changed
1. WP Module - Updated Taxonomy & User Profile Fields To Work with Custom Meta boxes
2. Themes - Updated Fresh Theme To Work With WPOnion Modules API
3. Field Type - Accordion / Group / Field set Not saving properly
4. Field Type - Customize able Group / KeyValue / Cloner error Msg (#11)
5. option_value to option_label in query_args

### Removed 
1. JS Lib : Pretty Checkbox
2. JS Lib : AnimateCSS
3. Value API : ValueAPI & Its Functions

---

## [Beta : 0.0.6] - 18/11/2018
### Added
1. Field API - Auto Generate Sample PHP Code For Field If debug enabled
2. WP Module - Option To Set Custom Footer Left & Right Text in Admin Page 
3. WP Module - Added `menu_url` function to retrive admin page's menu url
4. WP Module - Custom Admin Columns
5. WP Module - Quick Edit
6. WP Module - Bulk Edit

### Fixed
1. Field API - PHP : wp_link saved value not showing (#4)
2. Field JS API - Validation  Works With Accordion
3. Field JS API - Validation  Works With Group
4. Field JS API - Validation  Works With Fieldset
5. Field JS API - Validation  Works With Cloneable
6. Field JS API - Validation issue with `wp_link` field fixed (#1)
7. Field JS API - Error when Inputmask & Dependency (#2)
8. Field JS API - Validation Issue with Dependency (#3)

---

## [Beta : 0.0.5] - 16/11/2018
### Added
1.  Field Type - notice_success
2.  Field Type - notice_danger
3.  Field Type - notice_warning
4.  Field Type - notice_primary
5.  Field Type - notice_secondary
6.  Field Type - notice_info
7.  Field Type - notice_dark
8.  Field Type - notice_light
9.  Field Type - Sorter
10. Field Type - Typography
11. Field Type - Oembed
12. Field Type - WP List Table
13. WP Module - Tab Option In Admin Page
14. WP Module - Widgets
15. WP Module - Dashboard Widgets
16. JS Module - JS Field Validation

### Fixed
1. Field Type  - ColorPicker
2. Field Type  - PrettyCheckbox CSS Issue
3. Core/Field - POPUP CSS Issue
4. Core       - Random key was added each time for each instance. so its fixed with a static key per instance.
 
### Changed
1. Field API - Updated all fields to use `$this->sub_field` function if it uses `wponion_add_element`
2. Core      - changed meterial => material

---

## [Beta : 0.0.4] - 08/11/2018
### Major Redevelopment Done

---

## [Beta : 0.0.3] - 07/11/2018
### Major Redevelopment Work Going On

---

## [Beta : 0.0.2] - 25/7/2018
### Added
1. Field Type - Datepicker
2. Field Type - Content
3. Field Type - Background
4. Field Type - Upload
5. Field Type - WPListTable
6. WP Module - User Profile
7. Core Lib  - Markdown Parser

### Changed
1. Core         - WPOnion Now Works on `after_setup_theme` instead of `init` hook
2. Core Helper  - Migrated All JSON Files into PHP Array and saved them in `data/` folder to make it bit faster
3. Field Type    - Icon Field has option to **enable** / **disable** certain icon framework

### Fixed
1. Spelling mistake - ( horizontal )
2. WP Module        - WC Metabox Style Updated

### Removed
1. CSS - FontAwesome
2. CSS - TypeIcons
3. CSS - BoxIcons
4. JS  - OverlayScrollBars
5. JS  - InputToArray
6. JS  - Bootstrap Maxlength
7. JS  - jQuery.Actual

---

## [Beta : 0.0.1] - 10/7/2018
### Added
1. Core Module -  Field Registry
2. Core Module -  Core Registry
3. Core Module -  Theme API
4. Core Module -  Field API
5. Core Module -  Clone API
6. WP Module   -  Taxonomy
7. WP Module   -  Metabox
8. WP Module   -  Settings Page

---

[Beta : 0.0.7]: https://github.com/wponion/wponion/releases/tag/0.0.8
[Beta : 0.0.7]: https://github.com/wponion/wponion/releases/tag/0.0.7
[Beta : 0.0.6]: https://github.com/wponion/wponion/releases/tag/0.0.6
[Beta : 0.0.5]: https://github.com/wponion/wponion/releases/tag/0.0.5
[Beta : 0.0.2]: https://github.com/wponion/wponion/releases/tag/Beta2
[Beta : 0.0.1]: https://github.com/wponion/wponion/releases/tag/121010072018
