# Change Log
All notable changes to this project will be documented in this file, formatted via [this recommendation](http://keepachangelog.com/).

### [2.9.0]
#### Added
* New parameter `exclude` for excluding specific post IDs, see #154
* New parameter `category_id` for specifying category by ID (note: only accepts a single ID), see #156
* New parameter `include_date_modified` for displaying the date the post was last updated, see #150

#### Fixed
* Shortcode title now appears above the wrapper (ul/ol/div), fixing invalid markup, see #165
* Limit visibility to readable posts

### [2.8.0]
#### Added
* Set include_link="false" to remove link from post title and image, see [#137](https://github.com/billerickson/display-posts-shortcode/pull/137)

#### Fixed
* Category display when using multiple post types, see [#143](https://github.com/billerickson/display-posts-shortcode/issues/143)
* Issue combining multiple taxonomies, see [#131](https://github.com/billerickson/display-posts-shortcode/issues/131)

### [2.7.0]
#### Added
* Support for [Co-Authors Plus Addon](https://github.com/billerickson/dps-coauthor-addon)
* `tax_include_children` parameter for tax queries. See [#120](https://github.com/billerickson/display-posts-shortcode/issues/120)
* New filter to display the full version of manual excerpt, regardless of excerpt_length. See [#123](https://github.com/billerickson/display-posts-shortcode/issues/123)

#### Fixed
* Removed shortcodes from custom excerpts, see [#113](https://github.com/billerickson/display-posts-shortcode/issues/113)
* Fixed private post visiblity, see [#115](https://github.com/billerickson/display-posts-shortcode/issues/115)

### [2.6.2] = 2016-06-05

#### Fixed
* More improvements to excerpts, see [#110](https://github.com/billerickson/display-posts-shortcode/issues/110)
* Fix date query bug, see #108
* Fixed undefined variable notice if include_title="false"

#### Added
* Added content_class parameter

### [2.6.1] = 2016-05-16

#### Fixed
* Fix issue with manually specified excerpts

### [2.6.0] = 2016-05-16

#### Added
* Add support for author="current"
* Add support for multiple wrapper classes
* Add support for excerpt_length parameter
* Add support for excerpt_more parameter

### [2.5.1]
#### Fixed
* Fix an issue with manually specified excerpts

### [2.5.0]
#### Added
* Add support for date queries
* Exclude child pages with post_parent="0"
* Query by current taxonomy terms. Ex: [display-posts taxonomy="category" tax_term="current"]
* Display the post's categories with [display-posts category_display="true"]
* Many more fixes. See GitHub for a full list of changes.

### [2.4.0]
#### Added
* Add 'include_author' parameter
* Add 'exclude_current' parameter for excluding the current post from the results
* If you display the full content of results, additional uses of the shortcode within those posts are now turned off
* Other minor improvements

### [2.3.0]
#### Added
* Include the shortcode attributes on wrapper filter
* Add 'no_posts_message' parameter to specify content displayed if no posts found
* Add filters to the title and permalink
* Limit private posts to logged in users
* Add support for excluding sticky posts
* Add support for ordering by meta_key

### [2.2.0]
#### Added
* Use original attributes for filters
* Add support for multiple taxonomy queries
* Add filter for post classes
* Add support for post content in the post loop

### [2.1.0]
#### Added
* Add support for post status
* Add support for post author
* Add support for post offset

### [2.0.0]
#### Added
* Explicitly declare arguments, props danielbachhuber
* Sanitize each shortcode attribute for security, props danielbachhuber

### [1.9.0]
#### Added
* Add 'date_format' parameter, so you can customize how dates are displayed
* Added a class of .excerpt-dash so CSS can be used to remove the dash
* Cleaned up the codebase according to WordPress coding standards

### [1.8.0]
#### Added
* Added `display_posts_shortcode_no_results` filter for displaying content if there's no posts matching current query.
* Add support for multiple post types. [display-posts post_type="page, post"]

### [1.7.0]
#### Added
* Added `id` argument to specify specific post IDs
* Added `display_posts_shortcode_args` filter in case the arguments you want aren't already included in the shortcode. See example: http://www.billerickson.net/code/display-posts-shortcode-exclude-posts/

### [1.6.0]
#### Added
* Added `post_parent` where you can specify a parent by ID, or you can say `post_parent=current` and it will use the current page's ID.
* Added `wrapper` where you can decide if the posts are an unordered list, ordered list, or div's
* Added support for multiple taxonomy terms (comma separated) and taxonomy operator (IN, NOT IN, or AND).

### [1.5.0]
#### Fixed
* For the sake of clarity I'm changing version numbers. No feature changes

### [0.1.5]
#### Added
* Added a filter (display_posts_shortcode_output) so you can modify the output of individual posts however you like.

### [0.1.4]
#### Added
* Added post_type, taxonomy, tax_term, and include_excerpt
* Added classes to each part of the listing (image, title, date, excerpt) to make it easier to change the look using CSS

### [0.1.3]
#### Added
* Updated Readme

### [0.1.2]
#### Added
* Added image_size option

### [0.1.1]
#### Fixed
* Fix spacing issue in plugin

### [0.1.0]
#### Added
* This is version 0.1.  Everything's new!
