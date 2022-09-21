## **iG:Syntax Hiliter v5.1**
---------------------------------

### **Changelog**

##### **v5.1**

* Minimum required PHP version bumped to 7.4.0. The plugin simply won't load its code on lower versions.
* Refactored plugin code for PHP 7.4.x for better performing code.
* **This is the last release using the GeSHi library.** GeSHi library has not been updated in several years and it looks unlikely that it will continue. Next release of the plugin will use a different syntax highlighting library. All existing shortcodes will continue to work and so the update and transition would be seamless for the most part, except a feature or two that will phase out and a few changes in plugin configuration options.

##### **v5.0**

* Minimum required PHP version bumped to 5.3.0. The plugin simply won't load its code on lower versions.
* Major re-write of plugin for cleaner, modular & better performing code.
* Assets are enqueued only if needed.
* NEW: You can now disable plugin stylesheet which styles code boxes. People who have their own styling don't need it anyway.
* NEW: 2 new options allow more control on GeSHi behaviour.
* BUGFIX: Language name cache was not re-building automatically. It is now fixed.

##### **v4.3**

* BUGFIX: Some language file names got snipped when building language name cache. It has been fixed.

##### **v4.2**

* BUGFIX: Shorthand tags for all languages supported now - props to Karol Kuczmarski for reporting the bug.
* NEW: Added `C++` language file.

##### **v4.1**

* BUGFIX: Github Gist URL XSS security hole fixed.
* BUGFIX: `__DIR__` doesn't work below PHP 5.3 - props to Karol Kuczmarski for reporting it.
* NEW: Added `lang` as shorthand for `language` attribute.
* NEW: Additional GeSHi language files can be put in `geshi` directory in theme, which will prevent their deletion on plugin update.
* IMPROVED: If a code block is repeated with same attributes then it is parsed only once and output is reused. This improves performance of the plugin.

##### **v4.0**

* NEW: Added ability to embed Github Gist in post and comments (configurable).
* NEW: Added ability to highlight one or multiple lines in a code block to show them as different.
* NEW: Added new code box layout.
* NEW: Added ability to escape plugin tags to prevent their processing.
* NEW: New GeSHi core (v 1.0.8.11)
* IMPROVED: Removed quirks from plain text view & its now much more smoother.
* IMPROVED: Handling of how code is prevented from beautification. The rest of the post/comment text is not affected as `wptexturize` is not removed anymore.
* IMPROVED: Simpler and faster options page in `wp-admin`.

##### **v3.5**

* BUGFIX: BB Tags except the ones of iG:Syntax Hiliter are allowed. The language file's existence is checked before parsing the code. If the language file does not exist then the code is not parsed.
* BUGFIX: `C` code highlighting is now fixed.
* BUGFIX: 'Plain Text' has been improved to strip the extra blank lines and spaces in Opera and FireFox.
* NEW: The latest stable GeSHi core (v1.0.7.6).
* NEW: Code highlighting for comments has been implemented. This feature can be Enabled/Disabled from the admin interface for iG:Syntax Hiliter. The tags are same for highlighting the code.
* NEW: A cross-browser Colour Picker (tested in IE6, FireFox1.5 and Opera8.5) is now available to easily set the line colours displayed in the code box.
* NEW: A new type of view implemented for seeing "Plain Text" code. Besides opening the plain text code in a new window, you can have it displayed in the code box itself with an option to display the highlighted HTML code back again. The "Plain Text" view type can be set in the admin interface.
* The language file for Ruby that I created a while back is now bundled with the plugin and its also a part of the default GeSHi package.

##### **v3.1**

* BUGFIX: Critical bug, which broke the plugin when the square brackets(`[` & `]`) were used in the posts in places other than tags, has been fixed.
* BUGFIX: Another bug, which allowed any attribute in the tags besides the `num` and also allowed any attribute value for it, affecting the processing. Now only the `num` attribute is accepted and if you specify the `num` attribute then its value must be a positive number otherwise your code won't be highlighted. The `num` attribute is optional and you can leave it out without any problems.
* BUGFIX: Fixed the unclosed `<select>` tags in the Plugin GUI code.
* GeSHi BUGFIX: Fixed a bug in GeSHi where the first line colour was not used when using FANCY LINE NUMBERS thus resulting in just one colour being used for the alternate lines.
* There's a problem in WordPress due to which the starting delimiters of ASP, PHP were not displayed correctly, as whitespace was inserted between the `<` and the rest of the delimiter. This has been patched so that its displayed correctly, but its not saved in the database, so the database still contains the delimiters as formatted by WordPress.

##### **v3.0**

* Complete re-write of the plugin resulting in reduction of code from 750+ lines to about 400 Lines.
* UPDATE: New GeSHi Core(v1.0.7) which has some bug-fixes, please see GeSHi Website for its changelog.
* NEW: New languages added are C#, Delphi, Smarty & VB.NET.
* NEW: Drag-n-Drop usage of new languages. The plugin now supports all languages that GeSHi(v1.0.7) supports. You just need to drop the language file in the `geshi` directory & use the filename as the tag for the language. So for example, if file is `pascal.php`, then the filename is `pascal` & the tags will be `[pascal]` & `[/pascal]`.
* NEW: Plain-Text View of the code highlighted in the code-box is now possible. This feature can be enabled/disabled easily in the Configuration Interface in WordPress Administration.
* ASP language file structure updated & more keywords added.
* IMPROVED: Language name which is displayed in the Code-Box can now be turned ON or OFF easily.
* IMPROVED: No more need to set the physical-path to the `geshi` directory if you are doing a default installation.
* IMPROVED: NO NEED TO EDIT THE PLUGIN FILE ANYMORE. You can now configure the plugin settings from a GUI located under the OPTIONS menu in your WordPress Administration (WordPress 1.5 & above only).

##### **v2.01**

* BUGFIX: Fixed a bug by removing a `<br />` tag from the function `pFix()` which lead to closing of an unnecessary `<p>` tag making the code not xHTML valid (as per my desires).

##### **v2.0 Final**

* Implemented the new version of GeSHi core, v1.0.2 which has some bug fixes and which uses Ordered Lists for Line Numbering and supports starting of a Line Number from any given number.
* The ASP language file has been updated to the new Language File structure of GeSHi as well as more keywords added & highlighting is more effective now.
* iG:Syntax Hiliter now also supports ActionScript, C, C++, JavaScript, Perl, Python, Visual Basic and XML.
* The whole plugin has been re-written and all the highlighting code is now in a class. You can just use the class anywhere else too for highlighting the code. But to also use the Code Tags to wrap your code and then highlight them, you will need to use all other functions. You can remove the WordPress Filter calls at the end of the plugin & use the rest of the code as you want somewhere else.
* BUGFIX: The issue of multi-line comments not being highlighted properly in v2.0 Preview has been sorted out.

##### **v2.0 Preview**

* Implemented the new version of GeSHi core, v1.0.1 which has some bug fixes including the extra quote(`"`) bug that broke the xHTML validation of the code.
* I've created a new language file for ASP (Active Server Pages) which has been added to this release and will also be a part of the next GeSHi release.
* Line numbering is now done through Ordered Lists(`<ol>`) and the code is xHTML compliant.
* Auto-Formatting disabled for posts that contain the iG:Syntax Hiliter code tags so that your code is good for copy-paste operations.

##### **v1.1**

* Implemented the line numbering of code.
* The code box is now of fixed dimensions without word-wrap and with scrollbars (if required).

##### **v1.0**

* Highlights code between the special tags, all of them differently.
* Uses GeSHi for syntax highlighting.
* Supports HTML, CSS, PHP, JAVA & SQL codes.
