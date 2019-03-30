TP2WP Wordpress plugin Changelog
===

1.0.13
---
  * Correcting error my MySQL function to check whether posts already exist
    when doing main content import.
  * Add small clarifying text to the attachment importer form, clarifying
    that domains entered in the "domains to import from" field should not
    include custom port information (ie we match only against domains, not
    ports).
  * Add additional status check, to encourage users to disable Wordpress's
    cron sysem during import / migration
  * Small formatting / code standard fixes in the status check part of the
    plugin.

1.0.12
---
  * When multiple TypePad posts have the same post name, we now generate
    a new unique postname for the duplicately named post(s).  This means that
    all posts will be imported, even those sharing the same post name /
    slug (though some incoming links will be broken).
  * Small optimization to avoid needing to download duplicate linked to files.
  * Small formatting fixes / corrections

1.0.11
---
  * Avoid trying to perform redundant symlinks / copies to existing files
    when creating the legacy (ie /.a./<hash>) style links.

1.0.10
---
  * Handle rewriting links to popup versions of images within the plugin
    (previously was only handled in the [conversion](https://convert.tp2wp.com/)
    process.
  * Remove some redundant checking on remote mimetypes, for some quicker
    imports.
  * Small, code-style cleanups

1.0.9
---
  * Handle much larger data sets by doing some array operations in the
    database instead of in PHP.  Specifically, find out which posts
    still need to be imported by using a nested query instead of
    to different queries and an array_diff, which hits memory limits
    much quicker.

1.0.8
---
  * Fix non-fatal error in attachment importer when referencing
    an undefined array (ie remove some code cruft).
  * Some further code formatting to match Wordpress coding standards.

1.0.7
---
  * Further improve duplicate post detection by only using the `post_name`
    column, which we're sure will exist since its in Typepad data (as
    BASENAME).  This allows us to avoid an expensive un-indexed query
    against `post_title`.

1.0.6
---
  * Improve duplicate post detection method to avoid false positives
    (previously the importer only checked for posts matching by title and
    date, which didn't work well with Typepad's exported data, where the
    drafts and posts have the same date).

1.0.5
---
  * Remove a non-fatal error by having the TP2WP_Import::bump_request_timeout()
    signature match the parent, WP_Importer::bump_request_timeout($val)
    signature.
  * Add support for bzip2'ed .wxr uploads.
  * Fix fatal error when zip module wasn't loaded / available.

1.0.4
---
  * Initial version with a change log
  * Symlink / copy all files into a flat directory structure too, to allow
    for redirection rules from .a/<hash> (in TypePad) to
    wp-content/uploads/tp2wp-migration/<hash>.
  * Also add in-pluguin URL redirection from Typepad attachment URLs
    to Wordpress attachment URLs (when the Wordpress equivalent exists
    in the above described directory)
  * Add several checks to the status page (pretty urls, supports symlinks, etc)
  * Fix issue with uploaded, zip'ed wxr files are not properly processed.
