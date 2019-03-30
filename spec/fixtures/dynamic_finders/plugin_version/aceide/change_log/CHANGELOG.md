## AceIDE Changelog

#### 2.6.2
* See github issue #32. Adds precision to backup naming.
* Reverts breaking changes made by commit 80e8adf to fix #15.

#### 2.6.1
* See github issue #27. Fixes issue introduced in 2.6.0, attempting to fix noise in AJAX.
* See github issue #26. Fixes CSS highlighting not working.
* Bumped Ace version to 1.2.9.
* Fixed PHPParser_Error not being caught.
* Added 'aceide_parse_php' filter to allow disabling the inbuilt PHP syntax parser.
* See github issue #24. Fixes some resource URLs.

#### 2.6.0
* See github issue #15. Removes AJAX noise from ALL other plugins/themes etc. Much more solid than previous solution for github issue #5.
* Resolves github issue #21. Better error output in the event the HTTP server will not process a file upload request.
* Added plugin license.
* Resolved github issue #22. AceIDE now supports PHP 7.

#### 2.5.5
* Fixed github issue #11, where text would be replaced when clicking in replace field of the search box - Thanks to X-Raym
* Fixed shift line up/down hotkeys
* Added editor to Multisite's network admin menu - Thanks to X-Raym
* Added AceIDE logo - Thanks to Kevin Young (rdytogokev)
* Added Fullscreen editor
* Slightly modified some keyboard command handlers for usability
* Changed capability from 'create_users' to 'edit_plugins' (See GitHub issue #14)

#### 2.5.4
* Fixed broken SumoPaint image manipulation functionality (see github issue #3)
* Strips noise from other plugins upon opening files (see github issue #5)/wp-content/plugins/aceide/CHANGELOG.md
* Fixed broken zipping functionality with ZipArchive (see github issue #6)

#### 2.5.3
* Added autocomplete for taxonomy functions add_term_meta, get_term_meta, update_term_meta and delete_term_meta
* Fixed broken zipping functionality (see github issue #2)

#### 2.5.2
* Fixed AceIDE editor main class error on older versions of PHP for unknown shorthand array syntax - Thanks to X-Raym

#### 2.5.1
* Fixed dialog issues with Z order of find, settings and git dialogs
* Fixed dialog close button mislocation

#### 2.5.0
* WPide was forked into AceIDE!
* Introduced composer as a dependency management solution
* Massive code refactor to better follow Single Role Principle, and the WordPress PHP coding standards - introduces PHP namespacing into internal plugin code
* Fixed WPide admin_body_class filter issue
* Added multi-site support. (UNTESTED)
* Added Drag n' Drop file moving
* Added syntax highlighting for the Twig templating language  (http://twig.sensiolabs.org)
* Added the Emmet plugin to create HTML nodes with CSS syntax (http://emmet.io)
* Upgraded Ace to v1.2.4
* Fixed SumoPaint link issues when the aceide_filesystem_root filter is not at default value

#### 2.4.0
* Context menu option added to file browser to rename, delete, download, zip, unzip!! thanks to shanept https://github.com/shanept for the code behind this.
  Right click on a folder/file in the file browser to see options (Thanks to https://github.com/shanept)
* find+replace
* Stopped using the full functionality of sanitize_file_name() and using a cut down version instead that allows period, dash and underscore at the beginning and end of filename.
* corrected invalid regex for determining image type
* Changed order of PHP4 compatible constructor in an attempt to stop a PHP Strict Standard error
* Update to Ace Editor 1.2.0
* Editor settings, so that it’s possible to change the theme and other editor features/behaviours
* New application icon in menu bar

#### 2.3.2
* Update the Ace component to 1.1.1 which includes some bug fixes, a PHP worker (showing PHP errors as you work) and a greatly improved search box.
* Fixed issue with file save showing javascript alert as if there was a failure when there wasn't
* Order folders and files alphabetically

#### 2.3.1
* As a quick fix I have commentted out the git functionality as the namespacing used is causing issues with old versions of PHP

#### 2.3
* Added initial git functions using the following library: PHP-Stream-Wrapper-for-Git from https://github.com/teqneers/PHP-Stream-Wrapper-for-Git
* Initial Git functionality added - it's very experimental!

#### 2.2
* Add restore recent backup facility - It's a primative implementation at this point but it does the job. See FAQ note.
* Turned on the LESS mode when a .LESS file is edited
* Made the autocomplete functionality only be enabled for PHP files otherwise it can be a pain to write txt files like this one!

#### 2.1
* Ramped up the version number because the last one was just getting silly
* Interface changes to make the editor take up more screen space. Including hiding the WP admin menu and footer.

#### 2.0.16
* Fixed problem saving PHP documents - PHP-Parser library wasn't included in the codebase correctly

#### 2.0.15
* PHP syntax checking before saving to disk (Using: https://github.com/nikic/PHP-Parser)

#### 2.0.14
* Fixed error Warning: Creating default object from empty value in AceIDE.php
* Updated the ace editor to current build

#### 2.0.13
* Added colour assist - a colour picker that displays when you double click a hex colour code in the editor (see other notes for info).
* Added a confirm box to stop you exiting the editor by mistake and losing unsaved chnages.
* Added 'aceide_filesystem_root' filter (see other notes for info).
* A number of bug fixes.

#### 2.0.12
* Added links to the WordPress codex and the PHP manual from within the function refrence for further info

#### 2.0.11
* Newly created files use to contain a space, instead it now defaults to a blank file.

#### 2.0.10
* Fixed a problem with file loading (ajax) indicator not showing.

#### 2.0.9
* Upload snapshot of current ajaxorg editor (master/build/src) at 00:30 on the 22 May 2012. Which fixes some issues with selecting big blocks of text, code folding seems better with gutter interface hidden when not in use

#### 2.0.8
* Fix browser compatibility issues

#### 2.0.7
* Fixing issue with closing tabs not focusing onto next tab once closed.
* Fixed issue with detecting ajax url correctly which was causing all AceIDE ajax requests to fail if WordPress was installed in a subdirectory.
* Stopped autocomplete from trying to work when a js/css file is being edited.

#### 2.0.6
* Cleaned up the AceIDE class and modified the way the class is passed to WordPress actions/filters.

#### 2.0.5
* On startup the editor page now shows extra debuggin information for the filesystem API initialisation.

#### 2.0.4
* On startup the initial editor page now shows some startup info regarding file permissions to help with debugging.

#### 2.0.3
* If AceIDE cannot access your files due to permissions then when it starts up it will give you an alert to say this.

#### 2.0.2
* Image editing is now available using the SumoPaint image editor and drawing application http://www.sumopaint.com/

#### 2.0.1
* You can now create new files/folders

#### 2.0
* Recreated this plugin as a dedicated AceIDE section/app rather than extending the built in plugin/theme editor (just incase WP remove it)
* Now using the WP filesystem API (although currently restricted to local access)
* More security checks on file opening and editing
* Added new file tree for exploring the file system and opening files (any file in wp-content)
* Massive overhaul to code autocomplete functionality with the addition of function information right in the app
* Update the ajaxorg Ace Editor to the current branch
* Tabbed editing

#### 1.0.6
* Added link to meta section of plugin list for easy install of V2 Dev version if you have dismissed the alert.

#### 1.0.5
* Added the facility to download and run the cutting edge development version of AceIDE from the Github repository

#### 1.0.4
* Implemented JavaScript and CSS mode for better syntax highlighing and checking  (Thanks to Thomas Wieczorek)
* Organise and format source code

#### 1.0.2
* Tidy and comment code
* Added message when backup file is generated
* Adjust code complete dropdown position
* Improved editor responsiveness when using delete or enter keys

#### 1.0.1
* Fixed "Folder name case" issue.

#### 1.0
* Initial release.
