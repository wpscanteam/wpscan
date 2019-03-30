==Changelog==

= 2.0.2 =
* Fixes bug where server would time out during upload-only bulk tagging events
* Fixes visual bug introduced in tag picker in WordPress 4.9

= 2.0.1 =
* Minor updates to the Readme and required PHP version.

= 2.0.0 =
* FEATURE: Supports v2 of the Clarifai API! You will need to generate an API token to continue using the product.
* FEATURE: Run the bulk tagger in upload-only mode.
* Removes support for checking your usage stats in WordPress. Clarifai no longer supports this.

= 1.2.0 =
* FEATURE: Adds the `tmt_tag_taxonomy` filter to allow users to customize the taxonomy used to store tags

= 1.1.1 =
* Show more detailed error message during Bulk Tagging failure

= 1.1.0 =
* FEATURE: A bulk tagger tags existing images in library
* FEATURE: Under the hood, sends URL to image assets instead of uploading images individually
* FEATURE: Moves Taghound settings to a dedicated screen

= 1.0.4 =
* BUGFIX: Adds media browser support back to < WordPress 4.7

= 1.0.3 =
* Removes cruft added to last build.

= 1.0.2 =
* Updates admin UI to support WordPress 4.7
* Adds a minimum required PHP version of 5.5.

= 1.0.1 =
* FEATURE: See Clarifai API usage data under Media settings.

= 1.0.0 =
* Taghound Media Tagger.
