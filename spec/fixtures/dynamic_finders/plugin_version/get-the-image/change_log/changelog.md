# Change Log

## [1.1.0] - 2017-09-22

### Added

* New `srcset_sizes` argument for adding an array of `'image-size' => 'descriptor'` key/value pairs, which handles responsive images.
* New `link` argument that can be set to `post` (links to post), `file` (links to image file), `attachment` (links to attachment page if image is attachment), or `false` to link to nothing.
* New `link_class` argument to add a custom HTML class to the wrapping link element.
* Image classes based on the content width vs. the image width (`cw-equal`, `cw-lesser`, `cw-greater`).
* `min_width` argument to only show image if it meets the minimum width provided.
* `min_height` argument to only show image if it meets the minimum height provided.
* Introduces the `image_attr` argument, which allows developers to pass in an array of attributes that they want applied to `<img>` tag.

### Changed

* New `get_image_attr()` and `get_image_class()` methods were added to split off and clean up the code for getting the image attributes and classes.

### Deprecated

* Deprecated the `link_to_post` argument in favor of the new `link` argument.

## [1.0.1]

### Fixed

* Changed priority of `split_content` filter to make sure images are split from the content.

## [1.0.0]

### Added

* Re-coded how the image script works by encapsulating the functionality into a single class rather than multiple functions. This makes it much easier to reuse code and paves the way for more improvements in the future.
* New `scan_raw` argument for pulling an image (straight HTML) directly from the post content.
* New `split_content` argument for removing an image from the post content if one is found. Used only in conjunction with the `scan_raw` argument.
* New `order` argument for changing the order in which the script looks for images.
* Better support and handling for sub-attachments (e.g., featured images for audio/video attachments).
* Support for Schema.org microdata.  `itemprop="image"` attribute added to image outputs where possible.
* New image orientation class if the width and height are available. Class can be `landscape` or `portrait`.
* Default image size is `post-thumbnail` if the theme has set this size. Otherwise, `thumbnail` is the default size.
* Supports the ability to get embedded images via WordPress' image embeds (Instagram, Flickr, etc.) via the `scan*` methods.
* New filter hook: `get_the_image_post_content`. Used when checking the post content.
* Added `min_width` and `min_height` arguments (doesn't work with `scan*` methods).

### Changed

* `the_post_thumbnail` argument deprecated in favor of `featured`.
* `image_scan` argument deprecated in favor of `scan` or `scan_raw`.
* `default_image` argument deprecated in favor of `default`.
* `order_of_image` argument removed with no replacement.

## [0.9.0]

### Added

* Caption support. FTW!
* Multiple image classes now allowed via the `image_class` argument.
* Use current theme's `post-thumbnail` as default image size if set via `set_post_thumbnail_size()`.

### Fixed

* Use the WordPress-saved attachment alt text for the image.
* Only add `$out['src']` if `$out['url']` is set when returning as an array.
* Allow `https` when returning as an array.
* Use the correct variable (`$attachment_id`) when getting an image via attachment.

## [0.8.1]

### Changed

* General code formatting updated.

### Fixed

* Use correct `$attachment_id` variable instead of `$id`.
* Pass full `$image` array to the `get_the_image_meta_key_save()` function so that it saves correctly.
* Only use `before` and `after` arguments if an image is found.

## [0.8.0]

### Added

* Added the `before` argument to output HTML before the image.
* Added the `after` argument to output HTML after the image.
* Added the `thumbnail_id_save` argument to allow the attached image to be saved as the thumbnail/featured image.

### Changed

* Inline docs updates.
* Get the post ID via `get_the_ID()` rather than the global `$post` object.
* Simplified the `meta_key` logic.
* Completely rewrote the `attachment` logic.
* Sanitize classes with `sanitize_html_class()`.

### Fixed

* Fixed debug notice with `$image_html`.
* Moved the `*_fetch_post_thumbnail_html` hooks into the main function and only fire them if displaying to the screen.

## [0.7.0]

### Added

* New cache delete functions that delete when a post or post meta is updated.

### Fixed

* Fixed notice when `image_scan` was used.

### Deprecated

* Deprecated and replaced functions that lacked the `get_the_image_` prefix.

## [0.6.2]

### Changed

* Minor code adjustments.

### Fixed

* Updated the cache to save by post ID instead of a single object.

## [0.6.1]

### Changed

* Updated inline documentation of the code.
* Smarter `meta_key` logic, which allows a single meta key or an array of keys to be used.
* Set `custom_key` and `default_size` to `null` by default since they're deprecated.

## [0.6.0]

### Added

* Added the `meta_key_save` argument to allow users to save the image as a meta key/value pair.
* Added a `callback` argument to allow developers to create a custom callback function.
* Added a `cache` argument, which allows users to turn off caching.

### Deprecated

* Deprecated `custom_key` in favor of `meta_key`.

## [0.5.0]

### Added

* Added support for persistent-caching plugins.

### Changed

* Switched the `default_size` argument to `size` to be more in line with the WordPress post thumbnail arguments, but `default_size` will still work.
* Now using `wp_kses_hair()` to extract image attributes when using the `array` value for `format`.
* Image `alt` text will now use the attachment description if one has been given rather than the post title.
* Updated the `readme.html` instructions for using the plugin.

## [0.4.0]

### Added

* Added support for `the_post_thumbnail()`, which is WordPress 2.9's new image functionality.
* New function: `image_by_the_post_thumbnail()`.
* Documented more of the code, so the inline PHP doc is updated.

### Changed

* Dropped support for older versions of WordPress. Now only compatible with 2.9+.
* Cleaned up some of the old legacy code that's no longer needed.

## [0.3.3]

### Added

* Added the `get_the_image` filter hook.

### Changed

* General code cleanup

## [0.3.2]

### Added

* Beefed up the inline documentation so developers can better understand the code.
* Added a GPL license.txt file.

### Changed

* General code cleanup.
* More efficient and logical code.

## [0.3.1]

### Fixed

* Fixed the default image and image scan features.

## [0.3.0]

### Added

* Added more parameters.

### Changed

* Changed methods of calling the image script.
