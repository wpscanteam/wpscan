# Changelog

### 1.8.1
* Updated post type to support the new Gutenberg editor in WordPress 5.0+ in `dispensary-coupons.php`

### 1.8
* Added `global $post` to updated messages function in `dispensary-coupons.php`
* Updated function names to be uniform with other WPD plugins in `dispensary-coupons.php`
* Updated variable names to match other WPD plugins in `dispensary-coupons.php`
* Updated Coupons CPT `$args` to remove from search results in `dispensary-coupons.php`
* Updated `Coupon Details` metabox location to main column under title in `dispensary-coupons.php`
* Updated text strings for localization in `dispensary-coupons.php`
* Updated `.pot` file with new text strings for localization in `languages/wpd-coupons.pot`
* WordPress Coding Standards updates in `dispensary-coupons.php`

### 1.7
* Updated text for admin `post_updated_messages` in `dispensary-coupons.php`
* Updated Coupons post type to no longer be publicly queryable in `dispensary-coupons.php`
* Updated Coupons post type to no longer support the editor in `dispensary-coupons.php`

### 1.6
* Added permalink settings Classs for `coupons` base in `inc/class-dispensary-coupons-permalinks.php`
* Added permalink settings option for `coupons` base in `dispensary-coupons.php`
* Updated permalink base codes for `coupons` custom post type in `dispensary-coupons.php`

### 1.5.2
* Added `Coupons Details` metabox with `wpd_coupon_code`, `wpd_coupon_amount`, `wpd_coupon_type` and `wpd_coupon_exp` options

### 1.5.1
* Coding Standards updates
* Updated admin submenu order number **requires version 2.0+ of WP Dispensary**
* Updated <td> `Coupons` text in Pricing table
* Updated the default widget title

### 1.5
* Updated `Coupons` menu placement to be a sub-menu under WP Dispensary **requires version 1.9.8+ of WP Dispensary**
* Updated widget title size from `h3` to `strong` to make the text more uniformly sized.
* Updated the widget name to "WP Dispensary's Coupons"

### 1.4
* Added action hook to display coupons on single menu items pages (action hooks added to WP Dispensary in [WP Dispensary 1.8](http://www.wpdispensary.com/wp-dispensary-version-1-8/))

### 1.3
* Added option to select an item from the Growers menu type that was added in [WP Dispensary 1.7](https://www.wpdispensary.com/wp-dispensary-version-1-7/)

### 1.2
* Added new shortcode and widget options to show or hide the featured image of your dispensary coupon

### 1.1.1
* Added missing shortcode support for new Topicals menu type in [WP Dispensary 1.4](https://www.wpdispensary.com/wp-dispensary-version-1-4/)
* Updated CSS for `wpd-coupons-plugin-meta` class in `css/style.css`

### 1.1.0
* Added support for new Topicals menu type in [WP Dispensary 1.4](https://www.wpdispensary.com/wp-dispensary-version-1-4/)

### 1.0
* Stable release

### 0.1
* Initial release
