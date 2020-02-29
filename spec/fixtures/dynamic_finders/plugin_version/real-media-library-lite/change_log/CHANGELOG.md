# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 4.7.2 (2020-02-27)


### build

* optimize wordpress.org plugin description (#3wgvmg)


### docs

* CHANGELOG and README





## 4.7.1 (2020-02-26)


### fix

* compatibility running Real Media Library and Real Thumbnail Generator together (hotfix)





# 4.7.0 (2020-02-26)


### build

* abstract freemium package (#3rmkfh)
* migrate real-thumbnail-generator to monorepo


### ci

* automatic wp.org SVN deploy (#1aemay)


### feat

* added swedish language (#3uhd4j)
* prepare for free / lite version (#1aemay)


### fix

* folder selector in compat view / insert media dialog (#3rfbaw)
* import from FileBird works now as expected
* import from other plugins is now more intuitive (#3pf4jb)
* make importing categories only available in PRO version (#1aemay)
* make importing categories only available in PRO version (#1aemay)
* use correct library for cover image media picker (#3mjrrc)
* use own wp_set_script_translations to make it compatible with deferred scripts (#3mjh0e)





## 4.6.1 (2020-02-13)


### fix

* compatibility with Justified Image Grid
* no longer use lodash in frontend coding (#3mjrrc)
* old PHP versions (7.1) reported a bug related to namespaces
* use correct pathes without whitespaces together with Real Physical Media





# 4.6.0 (2020-02-11)

* the plugin is now available in following langauges: English, German, Dutch, Spanish, French, Indian, Chinese, Russian
* add feature to set default startup folder
* fix bug with Divi Page Builder
* fix bug with subfolder ordering by name
* fix bug with multiple MobX usage (developers only)
* fix bug with ReactJS v17 warnings in your console
* refactor partly JavaScript object rmlOpts to rmlOpts.others (developers only)

## 4.5.4 (2019-09-07)

* fix bug with PHP 7.2.7

## 4.5.3 (2019-09-07)

* fix bug with WP 5.2.2 when uploading a file directly to a folder
* fix bug with custom order when used a "orderby" clause before
* extend core WP REST API /wp-json/wp/v2/media to fetch RML specific data (developers only)
* add RML/Item/DragDrop and RML/Folder/OrderBy action (developers only)

## 4.5.2 (2019-08-09)

* improve compatibility with Beaver Builder
* fix bug with Flatsome UX Page builder when the folder dropdown shows no content
* fix bug with SuperPWA wordpress plugin (cache)
* fix bug with Avada 6.0 and Fusion Builder Live
* fix bug with search box height in some cases that it needed too much space
* add filter RML/Tree/Parsed so you can for example hide folders (developers only)
* add filter RML/Scripts/Skip to skip assets loading for given pages (developers only)
* fix bug when uploading a file to a specific folder which is generated through filter (developers only)
* fix bug with logged Notice in folder shortcode (developers only)

## 4.5.1 (2019-06-10)

* fix bug with Gutenberg "Gallery" block and the folder sidebar
* fix bug with folder selector, use modal dialog instead
* fix bug with snax plugin frontend submission uploader
* improve "Add new" button with preselection in uploader

# 4.5.0 (2019-05-07)

* add multi toolbar action "Delete" when multiple folders are checked
* add compatibility with "Export Media Library" plugin: Download a folder as .zip
* fix bug with limited image amount in Gutenberg block
* now you can add multi toolbar actions (when multiple nodes are selected) (developers only)

## 4.4.1 (2019-04-27)

* add feature to show SVG images in media library as image and not a generic icon
* fix count cache in list mode
* fix bug with Real Physical Media when queue is not filled in automatic mode when tree node is relocated
* improve API function wp_rml_create_all_children_sql() with MySQL UDF and legacy fallback (developers only)

# 4.4.0 (2019-04-13)

* add sort menu for subfolders so you can order subfolders alphabetically
* add "title" attribute to tree node for accessibility
* add ability to cancel uploads
* fix bug with uploader showing more then one upload message (with spinner)
* fix bug with item click on touch devices does not open links / dialogs
* fix bug in "Replace image" dialog
* fix bug in custom content order when navigating back to All files

# 4.3.0 (2019-03-19)

* add button to expand/collapse all node items
* add option while holding CTRL while creating a new folder you can bulk insert folders
* add option to rearrange a folder manually by selecting the parent folder and next sibling
* improve user settings / folder details dialog
* improve dropdown when selecting a folder (e. g. Media > Add new) with searchbar
* improve dark mode
* fix bug with edit dialog in portfolio image gallery in Glazov theme
* fix bug with domains with umlauts
* fix bug with Divi Builder (wrong dependency registered for script)
* add API function wp_rml_selector() for a dropdown (developers only)

# 4.2.0 (2018-02-02)

* add Gutenberg block to create a dynamic gallery (shortcode still works)
* fix bug with Gutenberg edit dialog
* fix bug with Ninja Table Pro and edit "Add media" dialog
* fix bug with admin notice when using PHP version < 5.4
* fix bug with frontend loading and "Upload to folder" dropdown (e.g. Marketplace vendor plugins)

## 4.1.1 (2019-01-23)

* add Material WP compatibility
* add new order: Order by date (ascending, descending)
* add Polish translation
* fix bug with custom order when editing a detail in the media dialog
* fix bug with ACF when editing an image field
* fix bug with PHP 5.4 and autoupdater
* fix bug with PHP 7.3 (deprecation notice in error log)
* improve compatibility with Trive Quiz Builder

# 4.1.0 (2018-12-10)

* add auto update functionality
* fix bug with german translations
* fix bug with with Thrive Architect page builder
* reduced installable .zip file size
* improve performance for JS and CSS resources / assets (developers only)

## 4.0.10 (2018-12-07)

* fix bug with hierarchical SQL queries and MariaDB database system
* fix bug with wp_attachment_get_shortcuts() API function (developers only)

## 4.0.9 (2018-11-27)

* fix bug with option to hide shortcuts in All files view
* fix bug with slow environments / pcs and big admin pages
* fix bug with bulk select in grid mode and unnecessary server requests

## 4.0.8 (2018-11-04)

* add option to hide shortcuts in All files view
* add compatibility with Slick slider plugin and other gallery shortcodes which use the standard gallery shortcode
* improve load time when opening a custom ordered folder
* PHP 5.4 is now minimum required PHP version (legacy version 4.0.7 for PHP 5.3 support add to download package)
* fix bug with "Edit gallery" dialog when entering in an ordered folder
* fix bug with ordered images when switching back to "All files"
* fix bug with bulk select and delete when using the grid view (performance)
* fix bug with wrong breadcrumb in media details dialog
* fix bug with The Grid and RML modal dialog (folders not visible)
* fix bug with WPML and custom order content
* fix bug with last queried folder (HTTP header error)
* fix bug with picu Plugin

## 4.0.7 (2018-09-08)

* add russian translation (thanks to Антон)
* add compatibility for Tailor page builder
* fix bug with WPML: WPML Media translation add-on is no longer needed
* fix bug with Divi Builder in frontend-editing
* fix bug with debugging the plugin with debug option in media settings
* fix bug with ACF edit screen
* fix bug with new created folders and droppable attachment
* add a few new PHP actions / hooks (see API documentation) (developers only)

## 4.0.6 (2018-08-11)

* improve cover image metabox (removable with preview)
* improve german translation
* fix bug with Divi Page builder and the gallery module
* fix bug with folder sorting (error handling)
* fix bug with missing resources when developer tools are opened (source maps)

## 4.0.5 (2018-08-03)

* fix save bug with last queried folder on NGINX envs
* fix bug with "Plain" permalink structure
* fix bug with non-multiple browser uploader and media assignment to folder
* fix bug with floating sidebar when scrolling and the first three folders are invisible
* fix bug with collapsable/expandable folders

## 4.0.4 (2018-07-20)

* improve dark mode compatibility (meta box)
* improve error handling with plugins like Clearfy
* fix bug in media modal when changing the tab to "Upload"
* fix bug with X Pro Theme / Cornerstone
* fix bug with PHP 5.3
* fix bug with WPML v4 "All files" counter
* fix bug with non-SSL API root urls
* fix bug with pagination in list mode after switching folder
* fix bug with cover image in list mode
* fix bug with Gutenberg 3.1.x (https://git.io/f4SXU) (developers only)
* removed unnecessary server request at startup (developers only)

## 4.0.3 (2018-06-15)

* add compatibility with WP Dark Mode plugin
* fix bug with XML/RPC requests when using WP/LR extension
* removed one unusued script (immer) (developers only)
* use global WP REST API parameters instead of DELETE / PUT (developers only)

## 4.0.2 (2018-06-11)

* add help message if WP REST API is not reachable through HTTP verbs
* fix bug with scroll container in media modal in IE/Edge/Firefox
* fix bug with custom content ordering
* fix bug with older MySQL systems or non-InnoDB engines
* fix bug with count cache when using REST API
* improve scroll behavior in main media library page
* improve mass delete process of attachments to avoid too many requests
* prepared the plugin for the new WP/LR extension (Adobe Lightroom sync)
* add action RML/Creatable/Register (developers only)
* fix bug with RML/Active filter (developers only)
* fix bug with creatables which are no longer registered (developers only)
* improve debug mode in media settings (developers only)

## 4.0.1 (2018-06-04)

* fix bug with spinning loader when permalink structure is "Plain"
* fix bug with WPML when using another language within WP admin as default
* fix bug with german translation
* fix bug with modal in Avada Theme options
* fix bug with IE11/Edge browser

# 4.0.0 (2018-05-31)

* complete code rewrite, same functionality with improve performance, with an eye on smooth user interface and experience
* improve performance when opening the media library in grid mode
* removed option in media settings to reset a single folder attachment order
* removed API function wp_rml_select_tree (developers only)
* removed filters RML/Folder/TreeNodeLi/Class, RML/Folder/TreeNode/Class, RML/Folder/TreeNode/Content, RML/Folder/TreeNode/Href (developers only)
* rewrite the plugin to WP REST API, ReactJS, Mobx-State-Tree (developers only)
* changed IUserSettings/IMetadata interface method save() (developers only)

## 3.4.8 (2018-05-03)

* add Right-to-left support (RTL)

## 3.4.7 (2018-04-12)

* improve performance when opening the media library with lots of folders
* add lazy loading of folders in attachment details folder dropdown
* fix bug with WPML languages like Portuguese (Brazil) and Portuguese (Portugal)

## 3.4.6 (2018-04-07)

* improve shortcut generation: Caption and description are also copied (Alt text if image)
* fix bug with lost selection when opening the media modal dialog

## 3.4.5 (2018-03-05)

* fix bug with WPML multisite usage regarding folder count

## 3.4.4 (2018-03-02)

* improve delete dialog with selected folder name
* fix bug with folder counter when WPML is active
* fix bug when moving a file to "/ Unorganized" the list is updated now correctly
* fix bug with bulk select deletion and switching folder in grid mode
* fix bug with PHP 7.2.2

## 3.4.3 (2018-01-16)

* improve uploading process / performance
* fix bug with uploader when uploading to "All files"
* fix bug when moving files from "All files" to another target

## 3.4.2 (2017-12-17)

* fix bug with F&O theme
* fix bug with new PHP version 7.2 (developers only)

## 3.4.1 (2017-12-06)

* fix bug while installation process when creating database tables (developers only)

# 3.4.0 (2017-12-05)

* add functionality to Import / Export folder hierarchy
* add functionality to Import an registered taxonomy with attachment relations
* improve touch experience, add scrollbar in media picker to avoid drag&drop attachments
* fix bug with search bar when folders were not found
* fix bug with query links
* fix bug with Database updates caused by dbDelta (developers only)

## 3.3.2 (2017-10-31)

* fix bug after creating a new post the nodes are not clickable

## 3.3.1 (2017-10-27)

* fix bug with Unorganized folder in attachments dialog
* fix bug with toolbar buttons
* fix bug with touch devices (no dropdown was touchable)
* add filters for structure operations, and created Interface for structure classes (developers only)
* fix bug for all parents getter API function (developers only)
* improve code quality (developers only)
* removed filters RML/Tree/QueryCount (developers only)

# 3.3.0 (2017-10-22)

* add ability to expand/collapse the complete sidebar by doubleclick the resize button
* add option to allow automatically order a folder by a given criterium
* add "General" tabs in folder details settings (developers are now able to add own tabs)
* improve: Update the columns width in grid mode while resizing the sidebar
* fix bug with wrong characters in gallery shortcode generator dialog
* fix bug with Inbound Now PRO plugin dialogs
* fix style bug with uploader in modal window
* fix bug with ESC key in rename mode
* fix bug with creating a new folder and switch back to previous
* add owner/creator field for a folder (developers only)
* add option to reset the folder names, slugs and absolute pathes (developers only)
* add API functions to get all parents of a folder (additionally add metadata condition) (developers only)
* add API functions to get all children of a folder (additionally add metadata condition) (developers only)
* add hooks to allow "Apply to subfolder" mechanism after moving files to a folder (developers only)
* improve the save of localStorage items within one row per tree instance (developers only)
* improve the way of generating unique slugs (developers only)
* fix bug with font awesome handler in wordpress style enqueue logic (developers only)

## 3.2.2 (2017-08-23)

* fix bug with IE 11 when folder structure does not show up
* updated icon font (Font Awesome 4.3 to 4.7)

## 3.2.1 (2017-08-11)

* fix bug with refresh button in folder tree

# 3.2.0 (2017-08-11)

* new free Add-On "Default Startup Folder for Real Media Library"
* add external link to "Browse Add-Ons"
* add ability to add user options (for Add-ons)
* add compatibility for Cornerstone page builder plugin
* fix bug with modal window when opening the same again
* add new filters to support the default wordpress media library extension plugin (developers only)
* add PHPDoc for API (developers only)
* add Hooks (Filter & Actions) Documentation (developers only)
* improve and renamed/refactored the events of JS hooks (developers only)
* improve the debug log (developers only)
* improve the generation and registration of minified scripts (developers only)
* fix bug with localized Javascript object (developers only)
* fix bug with slug regeneration when folder is moved (developers only)
* fix bug with meta data for Unorganized folder (developers only)

## 3.1.3 (2017-July-04)

* fix bug with gallery shortcode when the message occurs "Headers already sent[...]"
* fix bug with sticky header in insert media dialog

## 3.1.2 (2017-06-24)

* improve the "Add new" in media library to preselect the last queried folder
* fix bug with some browsers when local storage is disabled
* improve the wp_rml_dropdown() function to support multiple selected folders (developers only)

## 3.1.1 (2017-06-10)

* add full compatibility with WordPress 4.8
* improve english / german localization
* fix bug with search field in IE

# 3.1.0 (2017-06-08)

* add ESC to close the rename folder action
* add F2 handler to rename a folder
* add double click event to open folder
* add search input field for folders
* add full compatibility with Elementor page builder
* improve rearrange mode
* improve performance on media library initial startup / load screen
* improve uploader for large amount of uploads
* fix bug with icons in BeaverBuilder
* fix bug with multiple media modal dialogs (improve user experience) and expander
* fix bug with ACF media picker and duplicate shortcut info
* fix bug with rearrange mode in media modal view
* fix bug with Enhanced Media Library representation

## 3.0.2 (2017-05-09)

* add title attribute on folder hover (for long names)
* fix bug in customizer while folder structure is not displayed
* fix bug with multiple media modal's after switching the folder
* fix bug with Advanced Custom Fields when using the image picker modal
* add compatibility for Tatsu Page Builder (Oshine Theme)

## 3.0.1 (2017-04-22)

* fix bug with attachment details, on some browsers the dropdowns were not clickable
* add a message strip to the plugins page to show MatthiasWeb plugins

# 3.0.0 (2017-04-20)

* add feature to create shortcuts and put images in multiple folders, like you already know from your operating system
* removed popups
* fix bug with changing the folder location in grid view attachment details dialog
* fix bug with Polylang while moving a translation file
* fix bug with WPML while moving a translation file
* fix bug with count cache after uploading a new file
* fix performance bug with the count cache
* add API function wp_rml_create_shortcuts() (developers only)
* add API function wp_rml_created_shortcuts_last_ids() (developers only)
* add API function wp_attachment_ensure_source_file() (developers only)
* add API function wp_attachment_has_shortcuts() (developers only)
* add API function wp_attachment_get_shortcuts() (developers only)
* add API function wp_attachment_is_shortcut() (developers only)

## 2.8.6 (2017-03-25)

* fix bug with PHP < 5.6

## 2.8.5 (2017-03-24)

* fix bug with styles and scripts
* fix bug with rearrange
* minify scripts / css for prepared shortcut functionality (developers only)

## 2.8.4 (2017-03-22)

* add https://matthias-web.com as author url
* improve the way of rearrange mode, the folders gets expand after 700ms of hover
* fix bugs with absolute pathes and slugs of folders, if you have problems, please rename the first level folders to regenerate
* add getPlain() method to IFolder interface to get a normal array for the folder properties (developers only)
* prepared readable REST API for folders (developers only)

## 2.8.3 (2017-02-14)

* add new permission "par" to restrict the change of parent folder
* fix bug with korean characters in folder names
* removed icon when a folder has a restriction (WP/LR)
* add api/IFolder.interface.php and more API functions (developers only)
* improve the OOP: getters/setters (developers only)
* improve code quality by using own API functions (developers only)

## 2.8.2 (2017-02-03)

* fix bug with migration in multisite installations
* fix bug with Facebook hint in plugins site
* fix XSS vulnerability (this bug can only be used by folder creators, no visitors) (developers only)
* fix bug with MLA class dependency (developers only)

## 2.8.1 (2017-01-20)

* add v2.7.2 stable for older PHP versions to the codecanyon download files
* fix bug with permission system for WP/LR extension
* fix bug with the migration system for WP multisite

# 2.8.0 (2017-01-15)

* add more useful error messages when changing the hierarchical order of the folders
* add confirm dialog when you sort the files inside the folder
* improve the performance
* improve the way of relocating the folder tree (immediatly saved after relocating)
* improve the way of sortable folder content (galleries), now it is possible to reorder files in every folder
* improve naming of folders, every character is now allowed, the folder name is sanitized
* improve the folder metadata dialog and refresh the view if needed (button click in dialog)
* fix bug while uploading a new plugin .zip file
* add autoloading for php classes (developers only)
* add namespaces for php classes (developers only)
* add new abstract class for Creatable's (folders, collections, galleries, ...) (developers only)
* add new abstract class for Sortable's (folders, collections, galleries, ...) extends Creatable's (developers only)
* add folder\Root as own class (developers only)
* add debug mode, define('WP_DEBUG', true); and define('SCRIPT_DEBUG', true); in wp-config.php (developers only)
* add visible debug mode in options panel (developers only)
* add API function wp_rml_create_or_return_existing_id() (developers only)
* add API function wp_rml_structure_reset() (developers only)
* add admin notice for when you have PHP Version < 5.3.0 (developers only)
* improve the whole API and Advanced wp_rml_get_object_by_id() to get folder object (developers only)
* improve the split between Structure and CountCache (php classes) (developers only)
* improve the php code quality (developers only)
* removed the database table wp_realmedialibrary_order, merged with wp_realmedialibrary_posts (developers only)
* removed unnecessary sql query in pre_get_posts (developers only)
* removed bid columns in database tables and add new index (developers only)

## 2.7.2 (2016-12-10)

* add option to reset the count cache
* fix bug with upload in modal window
* fix count cache when moving from Unorganized to folder

## 2.7.1 (2016-12-05)

* add the MatthiasWeb promotion dialog
* fix bug with IE8
* fix bug with TinyMCE editor shortcode dialog

# 2.7.0 (2016-11-24)

* add natural filename sort of folders (thanks to KorbinianT)
* add lazy loading to folder tree, now it is only loaded from server when needed
* add: You can now directly upload files to a folder with a dropdown selection in media modal and "Add Media" page
* fix bug with migration on multisite installation
* fix bug with modal views, now it also supports lazy loading
* fix bug with attachment movement helper (Move x file)
* fxied bug with plugin "Visual Composer Extensions All In One" and the tooltips
* improve the changelog file
* improve the actions RML/Folder/Deleted|Renamed|Moved (developers only)
* fix bug with jQuery AIO tree version when RCM is enabled (developers only)
* fix bug with api method wp_attachment_folder and the default value (developers only)
* fix bug with creating a new folder with new order number (developers only)
* prepare RML for Physical Press plugin and avoid folder names "." and ".." (developers only)

## 2.6.5 (2016-10-26)

* fix bug with Justified Image Grid
* fix bug with migration system, no image relationships were imported

## 2.6.4 (2016-10-21)

* fix bug while wipe of folders in multisite installation
* fix bug after save in attachment details
* fix problem with negative -1 count
* fix bug when switching folder when on page 2 in table mode
* improve tabs in options panel of RML media options
* improve the delete behaviour of folder (files will be moved to unorganized)
* add a migration system for further updates (developers only)
* add filter for parent root folder id (Default -1) (developers only)
* fix the usage of switch_to_blog together with api functions (developers only)
* improve some CSS experiences (loader) (developers only)
* improve the save point of relationship between folder and post (own database table for relationships) (developers only)

## 2.6.3 (2016-09-25)

* improve some CSS
* fix bug while bulk select and moving files
* fix bug with reopening a media select dialog
* fix bug with Avia / Enfold page builder
* fix bug with reordering the gallery data folder
* removed deprecated ressource files

## 2.6.2 (2016-09-16)

* fix database tables are not generated, now they are

## 2.6.1 (2016-09-16)

* fix options bug while accessing other pages (developers only)

# 2.6.0 (2016-09-15)

* add full compatibility with WP/LR Lightroom plugin
* add minified scripts / styles
* add option to apply an order by title, filename, ID to gallery data folders
* add option to disable scripts/styles on frontend viewing
* add finnish translation (Thanks to Antti!)
* fix Enfold / Avia media picker bug (Thanks to Josh!)
* fix Thickbox bug while logged out
* improve load performance
* improve the order for gallery data folders
* add option for folders "restrict" (developers only)
* add a minified permission system so 3rd party plugins can restrict folders interactions (developers only)

## 2.5.5 (2016-08-19)

* fix capability bug while logged out
* add Javascript polyfill's to avoid browser incompatibility (developers only)
* fix bug for crashed safari browser (developers only)

## 2.5.4 (2016-08-08)

* add option to remove advertisement links
* fix "Edit selection" bug while inserting media to post

## 2.5.3 (2016-07-21)

* fix media.comparator bug (developers only)
* fix bugs with Easy Digital Downloads plugin (developers only)
* fix String.prototype problems (developers only)

## 2.5.2 (2016-07-11)

* fix toolbar while scrolling in media library
* fix problems with plugin "Formidable Forms"
* fix resize bug
* fix WP query database notices in error log (developers only)
* fix count bug when many folders exist (performed SQL statement) (developers only)
* improve API, wp_rml_create() now returns false or a string error array, on success it return an int (ID) (developers only)

## 2.5.1 (2016-07-10)

* fix shortcode builder [folder-gallery] did not work

# 2.5.0 (2016-07-03)

* add folder tree to insert media dialog
* complete recoding of javascript code (developers only)

## 2.4.2 (2016-06-20)

* fix TinyMCE bug when not admin
* fix style issues
* fix PHP < 5.3 Bug with func_get_args (developers only)

## 2.4.1 (2016-03-20)

* fix website is empty because javascript occurs an error

# 2.4.0 (2016-03-10)

* add "Reamining time" and bytes/s in uploader
* add order mode in galleries
* add warning when moving files from "All Files"
* improve move in table list mode (no page refresh)
* improve ux styling (uploader, tree, tree in upload media dialog)
* improve options panel in Settings > Media
* fix theme preview when plugin is active
* fix hidden folder nodes on safari browser
* fix usage of front-end editor in BeaverBuilder and Visual Composer
* add custom fields (meta data) for folders (see inc/api/meta.php) (developers only)
* add custom field: cover image + description (not activated as standard, used in JIG) (developers only)
* fix admin_footer problem when a plugin removes styles and javascript of RML (developers only)
* fix database queries to avoid long load time on dashboard (developers only)
* fix bug pre_get_posts (developers only)

# 2.3.0 (2016-03-10)

* add compatibility with JUSTIFIED IMAGE GRID
* add resizable container width
* add option to wipe all settings and releations
* add spanish translation - by Ana Ayelén Martínez. http://caribdisweb.com/
* fix edit mode when creating a new folder
* fix default order in folder gallery
* fix UX bugs (draggable, droppable, sortable)
* fix sticky sidebar
* add "slug" and "absolute" to database table (developers only)
* add / updated api (developers only)

## 2.2.3 (2016-Feburary-26)

* add Finnish translation (thanks to palvelu)
* add more attractive alerts and prompt windows
* fix visual bugs
* fix delete bug => when folder is deleted, switch view to root
* fix upload percentage issue
* fix live update of folder count
* fix upload in "Insert media" dialog => file is now in correct folder
* fix drag and drop experience
* moved folder gallery button above visual editor into visual editor
* add more actions and filters (developers only)
* add javascript actions (window.rml.hooks) (developers only)
* changed javascript function names (developers only)
* changed localize javascript variables (developers only)

## 2.2.2 (2016-01-20)

* bugfix error in creating a folder gallery

## 2.2.1 (2016-01-17)

* add facebook advert on plugin activation
* improve restyled upload window
* fix font awesome bug
* add filters and actions (developers only)
* add three more api functions (developers only)

# 2.2.0 (2015-12-29)

* add sticky container when scrolling
* add collection and galleries folder types
* add collapsable folders
* add left infos about folder structure
* add option to hide upload preview (for slow loading pc's)
* fix conditional tag to create / sort items
* fix count bug (WPML)
* fix duplicate name
* add API functions (look inc/api/) (developers only)
* outsourced javascript functions (developers only)
* fix AJAX bug (developers only)
* PHP Code rewritten (better split in view and structure) (developers only)
* PHP Code documentation improve (developers only)

## 2.1.2 (2015-11-22)

* add french translation (thanks to Youpain)
* fix rename bug
* fix count bug when WPML in usage

## 2.1.1 (2015-11-13)

* removed unnecessary code (developers only)
* fix jquery conflict (developers only)

# 2.1.0 (2015-11-07)

* add multisite compatibility
* fix correct sorting (not alphabetic)

# 2.0.0 (15-11-03)

* support PHP version < 5.4 (developers only)

# 1.3.0 (15-11-02)

* add nice uploading to folder

# 1.2.0 (15-10-29)

* add notice about the alphabetic sorting
* fix problems with RevSlider >= 5.0 (developers only)
* fix body class for grid mode (add Javascript methode) (developers only)

# 1.1.0 (15-10-21)

* fix moving in list table
* fix style (drag and drop helper)
* removed limit of folder gallery images
* fix pre_get_posts appending meta_query (developers only)
* add pre_get_posts capability check (developers only)

## 1.0.1 (15-10-16)

* improve rename without window reload
* improve delete without window reload
* fix https:// resources for css and js files

# 1.0.0 (2015-10-9)

* initial Release
