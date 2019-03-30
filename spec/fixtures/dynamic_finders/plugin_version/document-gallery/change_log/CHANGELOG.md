# Changelog

## 4.4.3
* **Bug Fix:** The pagination logic was not working correctly, resulting in the gallery not returning to the
  top after changing to a new page in some situations.

## 4.4.2
* **Enhancement:** When pagination is enabled for a gallery, navigating to another page will now scroll the page
  back to the top of the gallery.
* **Enhancement:** Added support for `%author%` to `dg_icon template` filter.

## 4.4.1
* **Enhancement:** Added support for `%date%` and `%time%` to  `dg_icon_template`.

## 4.4
* **Enhancement:** Document Gallery updated to support integration with
  [WP Real Media Library](https://codecanyon.net/item/wordpress-real-media-library-media-categories-folders/13155134).
  Simply install the [RML/DG helper plugin](https://wordpress.org/plugins/dg-real-media-library/) to use your RML
  folders right from Document Gallery!

## 4.3.2
* **Bug Fix:** Bug in editing gallery from post editor has been resolved.
* **Note:** Minimum WordPress version has been bumped from 4.1 to 4.2.

## 4.3.1
* **Enhancement:** WordPress 4.7 includes native support for PDF thumbnails. Document Gallery was already using some
  of this, but this update ensures that DG takes full advantage of the new core functionality, including some new
  logic to allow older WordPress installs running Document Gallery to take advantage of some of the new goodies.
* **Tested Up To:** Document Gallery has been tested in WP 4.7. Big thanks to
  [Bjarne](https://wordpress.org/support/users/oldrup/) for help with testing.
* **Reminder:** Don't forget that [Thumber.co](https://thumber.co) can integrate with Document Gallery to greatly
  expand supported file types (eg: Word, PowerPoint, Publisher, and Photoshop). Thumber.co offers a free 1-week trial
  if you want to try it before you buy it!

## 4.2.6
* **Bug Fix:** Document Gallery was impossible to uninstall on some WordPress systems. This is addressed now.

## 4.2.5
* **Bug Fix:** Resolves issue where visual editor gallery preview got stuck loading.

## 4.2.4
* **Tested Up To:** Document Gallery has been tested in WP 4.6.
* **Bug Fix:** Resolves bug in visual editor that would result in the gallery preview never loading in some circumstances.

## 4.2.3
* **Bug Fix:** Ghostscript thumbnail generation where the attachment name includes non-ASCII characters was failing
  on some server configurations. Kevin Hock identified the bug AND provided the fix. Gold star!

## 4.2.2
* **Bug Fix:** Ghostscript-based thumbnail generation was failing in a rare corner case. Thanks
  [sigvevidnes](https://wordpress.org/support/profile/sigvevidnes) for identifying this issue!

## 4.2.1
* **Bug Fix:** There was a bug in validating user secrets for [Thumber.co](https://thumber.co) that has now been addressed.

## 4.2
* **Enhancement:** Adding support for `tax_name`_include_children attribute, as requested by
  [John](https://wordpress.org/support/topic/add-shortcode-attribute-for-include_children). Thanks for the suggestion!
* **Enhancement:** [Thumber.co](https://thumber.co) authentication secret is no longer output in the options
  dump on the admin settings tab, removing the possibility of this information being inadvertently printed in the
  support forum.

## 4.1.14
* **Bug Fix:** The handling of saving [Thumber.co](https://thumber.co) subscriptions was broken for some use cases.
  The logic has been updated to work correctly in all cases.

## 4.1.13
* **Enhancement:** HostGator users were noticing an issue where HTTP connection failures would show up while Document
  Gallery was enabled. This resulted in symptoms like not being able to update plugins. This release modifies behavior
  to try and bypass this HostGator shortcoming. Work is still being done working with HostGator to try and identify
  a more complete resolution.

## 4.1.12
* **Bug Fix:** Resolves issues where the visual editor gallery preview was missing for a small subset of shortcode types.

## 4.1.11
* **Bug Fix:** Resolves bug that resulted in various issues, including Jetpack and some core WordPress functionality
  not working correctly.

## 4.1.10
* **Bug Fix:** Resolves drag/drop issues in the meida manager.

## 4.1.9
* **Bug Fix:** Addresses issues with the IMagick thumbnail generation.
* **Enhancement:** Handling thumbnail generation for image attachments better (should be faster & more reliable).

## 4.1.8
* **Bug Fix:** There was a minor bug in how thumbnails for image attachments were being generated. It has been addressed.

## 4.1.7
* **Bug Fix:** There was a minor issue on some admin pages that has been resolved.

## 4.1.6
* **Enhancement:** Added warning to plugins page when a PHP version < 5.3 is being used.
* **Bug Fix:** Resolves a "class not found" error.

## 4.1.5
* **Bug Fix:** For a subset of the users upgrading from `4.0` to `4.1.x`, the thumbnail images will have been corrupted
  during the upgrade process. This release addresses the problem.

## 4.1.1 & 4.1.2 & 4.1.3 & 4.1.4
* **Bug Fix:** Resolves various errors reported following `4.1` release.

## 4.1
* **Enhancement:** At long last, support for Microsoft Office files (Word, PowerPoint, Publisher, Visio), as well as a
  boat-load of [other formats](https://www.thumber.co/about#filetypes), has been re-added to Document Gallery by way of
  integration with the [Thumber.co](https://www.thumber.co) service. For a small fee you can generate images for all of your
  attachments using a service designed specifically to work well with Document Gallery. **For a limited time,
  Thumber.co is offering a free 7-day trial of the basic subscription. If you don't like it, all you have to do is
  cancel and you won't pay a penny.**
* **Enhancement:** The pagination footer now includes more than just "prev" and "next", allowing for quicker navigation
  of long multi-page galleries. Additionally, the pagination footer will no longer be included if pagination is enabled,
  but there are less than a page-length's worth of attachments in the gallery.
* **Enhancement:** Massive rewrite of some core logic that had become unmaintainable. This will mean nothing to most
  users, with the noted exception that if you were using the `dg_thumbers` filter you'll need to change some things.
  If this applies to you then you'll want to hold off on upgrading until you've had a chance to rework your usage of the
  filter to map to the new expected values.

## 4.0
* **Enhancement:** The WordPress visual editor now displays a full gallery preview.
* **Enhancement:** You can now paginate your galleries. This is especially useful in large multi-hundred item galleries.
  To enable pagination in your galleries, simply use `limit=##`.
* **Enhancement:** All CSS & JavaScript is now served minified to ensure the fastest possible load time for your site.
* **Enhancement:** When using taxonomies to generate your galleries (eg: media categories) you can now use term slug
  instead of the name. *Thanks andremalenfant for suggesting this!*
* **Enhancement:** The structure of the gallery output has been cleaned up, making it easier to style if you chose to
  use custom CSS. *NOTE: This modified structure may break existing custom CSS or PHP filtering, so be sure to check
  this if you're using either of those features.*
* **Bug Fix:** The storage of the DG thumbnail cache was very broken. Due to how the cache was originally designed, it
  ran into issues at large scale and on busy sites, which resulted in difficult to track bugs. The entire storage
  mechanism for the cache has been rewritten from the ground up to address this issue, which will result in faster
  gallery generation and more reliable performance.
* **Bug Fix:** In the thumbnail management tab of the DG settings, sorting by title was broken. This has been fixed.
* **Bug Fix:** `Limit` was not working in cases where the `ids` or `include` attribute were present. This has been fixed.
* **Tested Up To:** Document Gallery has been tested in WP 4.4 beta.

## 3.5.4
* **Bug Fix:** There were issues in the structure of HTML generated for galleries. This resulted in issues
  with icon generation.
* **Notice:** For any developers using PHP filters with Document Gallery, the structure of the content being
  filtered in `dg_gallery_template` has changed. Documentation has been updated accordingly.

## 3.5.3
* **Bug Fix:** The `images` attribute was not being parsed correctly. Thanks to
  [kalico](https://wordpress.org/support/profile/kalico) for pointing this out!

## 3.5.2
* **Bug Fix:** There was an issue with the Media Manager integration preventing using the Document Gallery creation
  within the "Add Media" dialog.

## 3.5.1
* **Bug Fix:** There was a minor bug in `3.5` with the new gallery loading logic. It was a compatibility issue with
  other plugins.

## 3.5
* **Enhancement:** No more waiting a **LONG** time for your new gallery to load. If you create a new gallery and view
  it, rendering will complete immediately and the thumbnails will be generated after your gallery initially loads.
  This should provide a significantly improved user experience!
* **Enhancement:** All JS and CSS files are now served compressed, making your WordPress that much faster!

## 3.4.2
* **Bug Fix:** Resolves issues in handling manual thumbnail uploads that were introduced in `3.4`.

## 3.4
* **Enhancement:** To address recent issues resulting from corrupt plugin options, we're making option validation no longer
  optional. This was an advanced feature that most users were likely not aware of, but it allows us to provide more
  robust option management moving forward. Any options that have been previously corrupted will be reset during upgrading
  to this version of DG.
* **Enhancement:** Various under-the-hood tweaks in preparation for supporting numerous additional file types
  (eg: MS Office). [Stay tuned.](https://wordpress.org/support/topic/notice-google-drive-viewer-not-working)
* **Bug Fix:** Log purging was not working correctly. Issue is resolved.
* **Bug Fix:** There were some CSS changes in WP 3.3 which broke some styling in the DG settings dialogs. These have
  been resolved.

## 3.3.1
* **Bug Fix:** A couple of the translation files (Finnish & Ukrainian) were named incorrectly, resulting in them
  never actually being loaded.

## 3.3
* **Enhancement:** Developers using the Document Gallery API now have access to new
  values when using the `dg_icon_template` filter.
  (Thanks to [pierowbmstr](https://wordpress.org/support/profile/pierowbmstr)!)
* **Bug Fix:** Resolved some advanced CSS commands (e.g.: `calc()`) breaking in custom CSS.
* **Bug Fix:** Some DG options were not being saved correctly resulting in odd behavior
  in some edge cases.
* **Bug Fix:** Resolved Media Manager integration not being available when first creating
  a post.

## 3.2
* **Enhancement:** The long awaited option to open thumbnail links in a new window
  has been added. Simply use `[dg new_window=true]`.

## 3.1
* **Enhancement:** The Media Manager can now be used to generate a gallery without
  needing to manually write the shortcode.
* **Enhancement:** Document Gallery logs can now be rolled over at regular intervals
  to avoid generating massive log files over extended periods of time.

## 3.0.2
* **Bug Fix:** The update process was broken in 3.0 -- this resolves that issue.

## 3.0
* **Notice:** Google Drive support has been removed as recent changes to how the service functions
  have made it no longer useful in thumbnail generation. A replacement for supporting MS Office
  filetypes (and other filetypes not supported in existing options) is in the works and we hope
  to release it soon.
* **Enhancement:** Thumbnails can now be manually overridden. To do this, either navigate to
  `Dashboard -> Settings -> Document Gallery -> Thumbnail Management` and add the image
  to the target attachment, or set the thumbnail in the attachment edit window.
* **Enhancement:** Users can now specify the number of columns for a gallery.
* **Enhancement:** Users can now create galleries with specific filetype(s) by using the `mime_types`
  option. Thanks for suggesting this functionality,
  [mepmepmep](https://wordpress.org/support/topic/dynamic-gallery-for-all-documents-of-a-certain-type)!
* **Enhancement:** Options to `include` or `exclude` specific attachments in a gallery have been added.
* **Enhancement:** The document gallery CSS has been modified to make all icon images responsive.
  We've also added the `dg_use_default_gallery_style` so that developers may completely disabled
  Document Gallery CSS and replace it with his/her own.
* **Deprecation:** The deprecated `dg_doc_icon` filter has been removed. Developers should use
  `dg_icon_template`.
* **Deprecation:** The `localpost` option has been deprecated and will be removed at a future date.
  If you are currently using `localpost=false` then it should be replaced by `id=-1`.

## 2.3.7
* **Bug Fix:** There was an issue that resulted in an error being thrown in certain situations.

## 2.3.6
* **Bug Fix:** There was an issue that resulted in the the Document Gallery Settings view crashing on some systems.

## 2.3.5
* **Bug Fix:** There was an issue with how custom CSS was being processed that is resolved in this version.

## 2.3.4
* **Bug Fix:** A bug was introduced that broke the `ids` parameter. This is resolved now.

## 2.3.3
* **Bug Fix:** Update script was failing following new release. This resolves that issue.

## 2.3.2
* **Translation:** Russian and Ukrainian translations have been updated.

## 2.3.1
* **Bug Fix:** Resolved a couple of bugs introduced with new `2.3` functionality.

## 2.3
* **Enhancement:** Taxonomy support now includes handling for both relationships
  between different taxons and relationships between different terms within a single
  taxon. See installation tab for more details.
* **Enhancement:** You can now limit how many results are displayed in the gallery with
  the *limit* attribute.
* **Enhancement:** The *post_type* and *post_status* used when generating
  a gallery are now configurable. (In most cases, these should be left at their default
  values, however advanced users may find a use case for this functionality.)
* **Enhancement:** Support was added for detecting when your site is running behind a
  firewall or on a local network where Google Drive Viewer will not be able to function.
* **Enhancement:** Handling of custom CSS was improved. Page load speed should be improved
  in some cases.
* **Bug Fix:** When Ghostscript chokes on a PDF, it will no longer print the error message
  in the Document Gallery output (instead it will end up in Document Gallery Logging).

## 2.2.7
* **Bug Fix:** There was an issue with a few phrases not being translated in the
  admin dialogs. Dates in the logs were also not being properly translated.

## 2.2.6
* **Enhancement:** Improved how Ghostscript executable is detected.

## 2.2.5
* **Bug Fix:** Resolves a bug where document descriptions were not being displayed
  correctly.
* **Translation:** Thanks, Marc Liotard and [Traffic Influence](http://www.trafic-influence.com/)
  for updating the French translation to include new phrases throughout the plugin!

## 2.2.4
* **Translation:**: Thanks to [mepmepmep](http://wordpress.org/support/profile/mepmepmep)
  who has just updated the Document Gallery Swedish translation!

## 2.2.3
* **Enhancement:** This will only be relevant to developers. `%descriptions%` tag
  is now available in the `dg_icon_template` filter.

## 2.2.2
* **Bug Fix:** Resolves minor issue in `2.2.1` that resulted in a warning being
  logged while interacting with the new thumbnail management table in the
  Document Gallery settings.

## 2.2.1
* **Bug Fix:** PHP installs older than 5.3 were crashing with version 2.2. This release
  patches the issue.

## 2.2
* **Note:** This release is the first release where development has been done by
  multiple people. I would like to give a massive thank you to
  [demur](http://wordpress.org/support/profile/demur) who has been an equal
  partner throughout the development of this version. Couldn't have done it without you!
* **Note:** With multiple developing this project, it made sense to setup
  a formal method to track issues and possible future enhancements. With this in mind
  we've begun to maintain an [issue tracker](https://github.com/thenadz/document-gallery/issues).
  Feel free to read through possible future features and even suggest new features
  you would like to see!
* **Enhancement:** You can now view which thumbnails have been generated and manually
  delete individual thumbnails from the Document Gallery settings page, located at
  Dashboard -> Settings -> Document Gallery.
* **Enhancement:* The logging for Document Gallery is now **much** more advanced.
  Logging can be configured and viewed directly from the Document Gallery settings
  page.
* **Enhancement:** Max width and height of generated thumbnails is now configurable.
* **Enhancement:** We had a couple of reports of the Document Gallery options
  being corrupted in some installs, so we added functionality to force validation
  of option structure on save. This will not be of much use to most users, but
  will help us track down some of the more difficult to reproduce bugs.
* **Enhancement:** For developers. New filters have been added to support modifying all
  aspects of HTML generated by the plugin. Look at the Installation tab for documentation
  on these new filters.

## 2.1.1
* **Translation:** Thanks to [mepmepmep](http://wordpress.org/support/profile/mepmepmep)
  who has translated Document Gallery into Swedish!
* **Translation:** Thanks to Marc Liotard who has translated Document Gallery into French!
* **Note:** If you would like to help translate Document Gallery into another language,
  get started [here](http://wordpress.org/support/topic/seeking-translators)!
* **Note:** This is an extremely minor release, but big changes are on the
  way in version `2.2`! Stay tuned as it should be going live in the very
  near future. Look for a complete makeover of the admin options including
  lots of new ways to configure DG to best meet your needs!

## 2.1
* **Enhancement:** Document Gallery now supports
  [multisite networks](http://codex.wordpress.org/Create_A_Network).

## 2.0.10
* **Enhancement:** Ghostscript detection should now work correctly on GoDaddy
  and some other hosts that don't properly setup their executables.
* **Translation:** Thanks *again* to
  [demur](http://wordpress.org/support/profile/demur) who has translated
  Document Gallery into Russian and Ukrainian! If you would like to help
  translate Document Gallery into another language, get started
  [here](http://wordpress.org/support/topic/seeking-translators)!

## 2.0.9
* **Bug Fix:** The `order` attribute was documented and implemented as being `ASC`
  or `DEC`, but the latter should actually have been `DESC`. Documentation and
  implementation for this option has been corrected. Thanks again to
  [demur](http://wordpress.org/support/profile/demur) for catching this!

## 2.0.8
* **Enhancement:** Ghostscript will now handle PS and EPS files if enabled.
* **Bug Fix:** There were a couple of issues in how the `ids` attribute was being
  handled. Thanks, [demur](http://wordpress.org/support/profile/demur) for catching
  these!

## 2.0.7
* **Bug Fix:** `2.0.6` did not fully resolve the bug described below. This should.

## 2.0.6
* **Bug Fix:** If DG failed to automagically detect the location of the
  Ghostscript binary, manually setting the location did not enable using it.
  Thanks for tracking this bug down,
  [Chris](http://wordpress.org/support/profile/fredd500)!
* **Minor:** Included various enhancements in handling thumbnail generation
  for image types.
* **Tested Up To:** Document Gallery has been tested in WP 3.9 (RC 1).

## 2.0.5
* **Bug Fix:** Rolling back part of CSS enhancments in 2.0.4 that were causing
  errors on some servers. May revisit at a later date.

## 2.0.4
* **Enhancement:** Custom CSS is now loaded faster, meaning faster page loads
  for your users. Tests are showing a speedup of around 30% over where it was
  in the last release.
* **Enhancement:** All of the default icons were sent through
  [Yahoo! Smush.it](http://www.smushit.com/ysmush.it/), giving a few percentage
  points decrease in size. Thanks for the suggestion,
  [wm](http://wordpress.org/support/profile/webbmasterpianise)!

## 2.0.3
* **Enhancement:** Now handles custom user CSS more securely.
* **Enhancement:** Now handles calling Ghostscript executable more securely.
* **Enhancement:** Now provides timing information for gallery generation
  when running WordPress in [WP_DEBUG](https://codex.wordpress.org/WP_DEBUG)
  mode. When enabled, DG will log to the PHP error log file.
* **Info:** Did you know that in tests I performed, Ghostscript (GS) performed
  350% faster than using Imagick (IM)? Try testing with
  [this file](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf),
  which finished almost instantly using GS, but took multiple minutes when
  using IM on my test server (results may vary). See new FAQ tab to find out why.

## 2.0.2
* **Bug Fix:** Imagick was actually never working... My bad -- it is now! Thanks to
  [kaldimar](http://wordpress.org/support/profile/kaldimar) for reporting this.
* **Enhancement:** Document Gallery en el Espa?ol por Andrew de
  [WebHostingHub](http://www.webhostinghub.com/). (To help translate to another
  language, [see here](http://wordpress.org/support/topic/seeking-translators).)

## 2.0.1
* **Bug Fix:** Resolves issue with `2.0` where DG options were not properly
  initialized when the plugin was updated. This caused the settings page to
  behave oddly and many other things throughout to not work as expected when
  you updated through the dashboard. Thanks to jawhite & rigbypa for
  [reporting this](http://wordpress.org/support/topic/errors-after-updating-to-20)!

## 2.0
* **Enhancement:** This release is a **BIG** deal! We are introducing true
  document thumbnails (rather than the boring static images that were the same
  for every document), meaning that you will be able to generate and display
  thumbnails for most of your documents so your users can see a preview of the
  document before downloading. This has been
  [months in development](http://wordpress.org/support/topic/pdf-thumbnails-instead-of-generic-icon)
  and I really hope that you all enjoy it!
* **Enhancement:** Document Gallery now has a settings page where you can
  configure the default options for your galleries and chose how thumbnails are
  generated.
* **Enhancement:** Customizing CSS for your document gallery is now *much easier*.
  If you want to add additional styling, just navigate to `Settings -> Document Gallery`
  in your dashboard and enter valid CSS in the "Custom CSS" textbox. See the changes
  instantly in your galleries!
* **Enhancement:** Entire plugin is now
  [Internationalization-enabled](https://codex.wordpress.org/I18n_for_WordPress_Developers).
  This means that we can now support users speaking all languages. If you are
  interested in translating Document Gallery into a language that you speak,
  please [let me know](http://wordpress.org/support/topic/seeking-translators)!
* **Enhancement:** This release saw much of the backend refactored to better
  support future development. Nothing you will notice unless you're digging into
  the code, but it will keep me sane long-term ;)
* **Note:** The thumbnail generation implementation works very hard to support
  all hosting servers (including Unix and Windows systems). That said, I cannot
  test on all hosts out there, so there is the potential for bugs to appear.
  If you notice something that doesn't look right, please don't hesitate to
  [report the issue](http://wordpress.org/support/plugin/document-gallery)
  so that I can resolve it. Thanks!

## 1.4.3
* **Bug Fix:** Resolves minor bug introduced in version 1.4.2. Thanks, tkokholm!

## 1.4.2
* **Note:** This release includes an increase in the minimum WP version to 3.5.
  If you have not yet upgraded to at least this version, you should consider doing
  so as future releases include a number of *fantastic* new features as well as
  many security improvements. If you chose not to upgrade, you must stay with
  Document Gallery 1.4.1 or lower until you do. Sorry for the inconvenience!
* **Bug Fix:** Resolved icons being displayed differently depending on which
  user was currently logged in. (Thanks to
  [Sean](http://wordpress.org/support/topic/error-after-update-19?replies=12#post-5041251)
  for reporting the issue.)
* **Enhancement:** A number of new icons were added (mainly for the iWork suite
  and source code filetypes) and a number of pre-existing icons were removed if
  they were very similar to another icon.
* **Under The Hood:** Many, many cool things. Stay tuned for a big reveal in the
  coming weeks!
  PS: If you're really curious, there are some clues in the source code ;)

## 1.4.1
* **Bug Fix:** This resolves a bug introduced in `1.4`, which caused a warning
  to be thrown when no attributes were used (i.e.: `[dg]`). (Thanks to
  [wtfbingo](http://wordpress.org/support/topic/error-after-update-19) for
  pointing this out!)

## 1.4
* **New Feature:** This release features the addition of *category/taxonomy* support,
  [as suggested by Pyo](http://wordpress.org/support/topic/sorting-documents-by-categorytag-or-other-taxonomy).
* **Under The Hood:** The plugin was completely rewritten for this release. Logic
  was cleaned up to make maintenance easier and facilitate some *big* changes
  planned for version 2.0 of Document Gallery.

## 1.3.1
* **Bug Fix:** This resolves a bug introduced in version `1.3`. (Thanks to JKChad
  for pointing this out!)

## 1.3
* **New Feature:** It is now possible to filter the HTML produced to represent
  each individual icon, making it possible to add extra attributes and other
  modifications on the fly as document icons are generated. This will probably
  only be of use to developers and people who don't mind getting their hands
  dirty. *(See bottom **Installation** tab for more details.)*
* **Enhancement:** There have been a lot of optimizations to the underlying
  plugin code to make it run more efficiently and be easier to read, if you
  are so inclined.
* **Enhancement:** Changed how images, when included within the gallery, are
  generated so that the format of the icon returned now matches the rest of
  the icons.

## 1.2.1
* **Bug Fix:** Resolved issue with the `ids` attribute in `1.2` not working.
  Sorry about that!

## 1.2
* **New Feature:** Images can now be included alongside documents in a
  document gallery (using `images=true` attribute).
  (Thanks for the suggestion, Luca!)
* **New Feature:** Attachment ids can now be explicitly listed, allowing for
  documents not attached to a post or page to be included in a document
  gallery (e.g.: `ids=2,42,57,1`). Note that no spaces should be included.
* **Enhancement:** The CSS stylesheet has been enhanced for more flexibility
  in sizing icons.

## 1.1
* **New Feature:** Included option to link to the attachment page as well as
  to the actual document.
* **Enhancement:** Added documentation for customizing the appearance of the plugin.
* **Enhancement:** Many improvements to the backend, including pretty HTML output
  and best practice implementation in calls to WordPress core functions.

## 1.0.4
* **Bug Fix:** Removed extra `div` at bottom when number of documents is
  evenly divisible by 4. (Thanks, joero4ri!)

## 1.0.3
* **Bug Fix:** Resolved issue with detecting plugin directory. (Thanks,
  Brigitte!)
* **Enhancement:** Minor improvement to how linking to individual
  documents is handled.

## 1.0.2
* **Bug Fix:** Merge for changes in 1.0 did not go through correctly so users
  downloaded the old icon set which broke the plugin. Sorry about that, but
  all is resolved with this release!

## 1.0.1
* **Bug Fix:** Resolved issue with long document titles being cut off in some themes.

## 1.0
* **New Feature:** Plugin now has **36 icons** representing **72 filetypes**!
* **Enhancement:** Optimized gallery generation (faster!)
* **Enhancement:** Added fallback to WordPress default icons if you happen to
  include one of the few filetypes not yet supported.
* **Enhancement:** Changed shortcode to `[dg]` (`[document gallery]` will still
  work for backward compatibility).
* **Enhancement:** Gave documentation some **much needed** revisions.

## 0.8.5
* **Enhancement:** Added support for
  [OpenDocuments](http://en.wikipedia.org/wiki/OpenDocument).

## 0.8
* **Release:** First public release of Document Gallery.
* **Feature:** Displays PDF, Word, PowerPoint, Excel, and ZIP documents from a
  given page or post.
* **Feature:** Documents can be ordered by a number of
  different factors.