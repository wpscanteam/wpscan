## Changelog ##

= 1.2 - May 23 2020 =

* Template - 'Login & Register Form' element template adjusted.
* Tweak - Online documentation and Support forum link changed in admin area header.
* Tweak - Change log link changed in welcome page.
* Tweak - Meta box tab menu width adjusted.
* Tweak - Unwanted '$options' and '$elements' variables removed in all 'loadmore' ajax call functions.
* Fix - Icon picker switching icons pack 'option' tag not rendered properly, because of 'wp_kses' allowed html.
* Fix - Data validation and sanitization improved.
* Dev - Filter introduced 'octagon_portfolio_general_meta_fields' to modify portfolio general fields.
* Dev - Filter introduced 'octagon_portfolio_meta_fields_group' to modify portfolio tabs.
* Dev - Filter introduced 'octagon_testimonial_general_meta_fields' to modify testimonial general fields.
* Dev - Filter introduced 'octagon_testimonial_meta_fields_group' to modify testimonial tabs.
* Dev - Filter introduced 'octagon_team_general_meta_fields' to modify team general fields.
* Dev - Filter introduced 'octagon_team_social_meta_fields' to modify team social fields.
* Dev - Filter introduced 'octagon_team_social_default_fields' to set the team social default repeatable field values.
* Dev - Filter introduced 'octagon_team_meta_fields_group' to modify team tabs.

Files Change:
* ../core/assets/css/admin.css
* ../core/class-enqueue-scripts.php
* ../core/select2-data.php
* ../core/views/html-header.php
* ../core/views/html-welcome.php
* ../core/icon-manager/class-icon-manager.php
* ../includes/list-tables/class-admin-list-table-templates.php
* ../includes/list-tables/class-admin-list-table-testimonial.php
* ../includes/class-ajax-calls.php
* ../includes/init-meta-fields.php
* ../shortcodes/login-register-form.php


= 1.2 - May 21 2020 =
* Tweak - Online documentation and Support forum link changed in admin area header.
* Tweak - Change log link changed in welcome page.
* Tweak - Meta box tab menu width adjusted.
* Tweak - Unwanted '$options' and '$elements' variables removed in all 'loadmore' ajax call functions.
* Fix - Icon picker switching icons pack 'option' tag not rendered properly, because of 'wp_kses' allowed html.
* Dev - Filter introduced 'octagon_portfolio_general_meta_fields' to modify portfolio general fields.
* Dev - Filter introduced 'octagon_portfolio_meta_fields_group' to modify portfolio tabs.
* Dev - Filter introduced 'octagon_testimonial_general_meta_fields' to modify testimonial general fields.
* Dev - Filter introduced 'octagon_testimonial_meta_fields_group' to modify testimonial tabs.
* Dev - Filter introduced 'octagon_team_general_meta_fields' to modify team general fields.
* Dev - Filter introduced 'octagon_team_social_meta_fields' to modify team social fields.
* Dev - Filter introduced 'octagon_team_social_default_fields' to set the team social default repeatable field values.
* Dev - Filter introduced 'octagon_team_meta_fields_group' to modify team tabs.

Files Change:
* ../core/assets/css/admin.css
* ../core/views/html-header.php
* ../core/views/html-welcome.php
* ../core/icon-manager/class-icon-manager.php
* ../includes/class-ajax-calls.php
* ../includes/init-meta-fields.php


= 1.1 - May 21 2020 =

* Enhancement - Add 'Style Section' for Notices on 'Compare Products' element.
* Enhancement - Add 'Style Section' for Notices on 'Wishlist' element.
* Enhancement - Add 'Style Section' for ( Excerpt, Client Name and Client Job ) on 'Testimonial' element.
* Enhancement - Add 'Content Section' for Load More on 'Content Type' element.
* Enhancement - Add 'Style Section' for ( Load More, Page Numbers, Next/Previous ) on 'Content Type' element.
* Enhancement - Add 'Content Section' for Load More on 'Content Type List' element.
* Enhancement - Add 'Style Section' for ( Load More, Page Numbers, Next/Previous ) on 'Content Type List' element.
* Enhancement - Add 'Content Section' for Load More on 'Portfolio' element.
* Enhancement - Add 'Style Section' for ( Load More, Page Numbers, Next/Previous ) on 'Portfolio' element.
* Enhancement - Add 'Content Section' for Load More on 'Product' element.
* Enhancement - Add 'Style Section' for ( Load More, Page Numbers, Next/Previous ) on 'Product' element.
* Enhancement - Add 'Style Section' for ( Title, Input and Button ) on 'AJAX Product Search' element.
* Template - Few element templates updated( Compare products, Content type, Content type list, Portfolio, Products, Wishlist ).
* Tweak - Removed '$wrapper_attr[]' in /shortcodes/compare-products.php and change into elementor function 'get_render_attribute_string()'.
* Tweak - Dynamic CSS file updated.
* Fix - Gradient palette style not applies in Advance Button, when 'From Gradient Palette' option used.
* Fix - 'Icon Position' and 'Only Icon' not shown in 'Image Box' element.
* Fix - Number pagination CSS style corrected.
* Localization - Translations strings updated.

Files Change:
* ../core/assets/css/gradient-palette.css
* ../core/assets/css/octagon.css
* ../core/class-enqueue-scripts.php
* ../includes/class-enqueue-scripts.php
* ../includes/helper-functions.php
* ../modules/ajax-product-search.php
* ../modules/compare-products.php
* ../modules/content-type.php
* ../modules/content-type-list.php
* ../modules/image-box.php
* ../modules/portfolio.php
* ../modules/products.php
* ../modules/wishlist.php
* ../modules/testimonial-slider.php
* ../shortcodes/compare-products.php
* ../shortcodes/content-type.php
* ../shortcodes/content-type-list.php
* ../shortcodes/portfolio.php
* ../shortcodes/products.php
* ../shortcodes/wishlist.php
* ../languages/octagon-elements-lite-for-elementor.pot

= 1.0 - May 20 2020 =
* Info - Initial Release.
