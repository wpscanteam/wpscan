= v3.1.0 =

- **Fixed:** Image compression sometimes causing Server Errors

- **Improved:** Image compression levels editable in Settings

= v3.0.0 MASSIVE NEW RELEASE! MUCH AWESOMENESS! =

- **Fixed:** Inline JavaScript was not being loaded correctly - several previous conflicts resolved by this

- **Improved:** NEW! Settings page added with several options for configuration, though WP Roids should still work just fine for most users simply by activating it

- **Improved:** NEW! Optional image compression (is on by default)

- **Improved:** NEW! WP CRON scheduler to clear cache at a choice of intervals (weekly by default)

- **Improved:** NEW! Optional caching and minification of CSS and JavaScript loaded from external CDN sources

- **Improved:** NEW! Debug logging mode

= v2.2.0 =

- **Improved:** Regex for stripping CSS and Javascript comments rewritten and separated
	* The Javascript one, in particular, was treating `base64` strings containing two or more `//` as a comment and deleting them
	
- **Improved:** Fallback serving of cache files via PHP when `.htaccess` has a hiccup was sometimes pulling single post file on achive pages :/

= v2.1.1 =

- **Fixed:** Regex tweak for handling `data:image` background images in CSS

- **Fixed:** Regex tweak where some `base64` encoded strings containing two or more `/` being stripped believing they were comments

= v2.1.0 =

- **Fixed:** There is a teeny-tiny glitch in [WPBakery's Visual Composer](https://vc.wpbakery.com/) that was causing massive display errors

- **Improved:** Negated the need to deactivate and reactivate to remove v1 `.htaccess` rules

- **Improved:** HTML `<!-- WP Roids comments -->` with better explanations

- **Improved:** Some additional cookie and WooCommerce checks

= v2.0.1 =

- **Minor Fix:** Code to remove v1 rules from `.htaccess` **DEACTIVATE AND REACTIVATE WP ROIDS ASAP**

= v2.0.0 Big Improvements! =

- **Fixed:** CSS and Javascript minifying and enqueuing had issues with:
	* Some inline items were being missed out or rendered improperly
	* Absolute paths to some assets such as images and fonts loaded via `@font-face` were sometimes incorrect
	* Some items were queued twice
	* Some items were not queued at all!
	
- **Fixed:** HTML minification was sometimes removing legitimate spaces, for example between two `<a>` tags
	
- **Fixed:** Caching function was sometimes running twice, adding unecessary overhead
	
- **Improved:** Some `.htaccess` rules
- **New:** Function checking in background `.htaccess` content is OK, with automatic/silent reboot of plugin if not
- **New:** Additional explanatory HTML `<-- comments -->` added to bottom of cache pages

= v1.3.6 =

- **Fixed:** Issue with PHP `is_writable()` check on `.htaccess` was causing plugin to not activate at all or silently deactivate upon next login

= v1.3.5 =

- **Fixed:** Regex to remove inline JS comments was failing if no space after `//`
- **Imprevement:** Compatability check when activating new plugins. On failure automatically deactivates WP Roids and restores `.htaccess` file

= v1.3.4 =

 - **Fixed:** `.htaccess` rewritebase error, was killing some sites dead AF, sorry

= v1.3.3 =

 - **Fixed:** `.htaccess` PHP fallback has conditions checking user not logged in
 - **Fixed:** WordFence JS conflict fixed

= v1.3.1 =

 - Disabled the debug logging script, you don't need me filling your server up!

= v1.3.0 =

 - **Fixed:** Directories and URLs management for assets
 - **Fixed:** Localized scripts with dependencies now requeued with their data AND new cache script dependency

= v1.2.0 =

- **Fixed:** Combining and minifying CSS and Javascript **MASSIVELY IMPROVED!**
	* For CSS, now deals with conditional stylesheets e.g. `<!--[if lt IE 9]>`, this was causing a few hiccups
	* For Javascript, now deals with scripts that load data via inline `<script>` tags containing `/* <![CDATA[ */`
	* Minification process now does newlines first, then whitespace. Was the other way around, which could cause issues

= v1.1.4 =

- **Fixed:** Sorry, I meant site domain !== FALSE. I'm an idiot, going to bed

= v1.1.3 =

- **Fixed:** Removed googleapis.com = FALSE check of v1.1.1 and replaced with site domain = TRUE check
- **Fixed:** Check for WooCommerce assets made more specific to WC core only, now excludes "helper" WC plugins

= v1.1.2 =

- **Fixed:** Version numbering blip

= v1.1.1 =

- **Fixed:** Encoding of `.htaccess` rules template changed from Windows to UNIX as was adding extra line breaks
- **Fixed:** Additional check to avoid googleapis.com assets being considered "local"
- **Fixed:** Removed lookup of non-existent parameter from "Flush Cache" links

= v1.1.0 =

- "Flush Cache" links and buttons added
- Five minutes applied to browser caching (was previously an hour)
- Whole HTML cache flush on Page/Post create/update/delete, so that home pages/widgets etc. are updated
- **Fixed:** PHP Workaround for hosts who struggle with basic `.htaccess` rewrites :/ #SMH
- **Fixed:** Additional checks before editing `.htaccess` as sometimes lines were being repeated, my bad
- **Fixed:** For you poor souls who are hosted with 1&1, a bizarre home directory inconsistency
- **Fixed:** Scheduled task to flush HTML cache hourly wasn't clearing properly on deactivation

= v1.0.0 =

- Initial release