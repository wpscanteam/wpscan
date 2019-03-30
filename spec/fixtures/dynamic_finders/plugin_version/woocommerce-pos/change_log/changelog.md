= 0.4.21 - 2018/11/27 = 
* WP 5 compatibility: fix custom order fields

= 0.4.20 - 2018/10/24 = 
* WC 3.5 compatibility: POS will use WC REST API v3 

= 0.4.19 - 2018/09/24 =
* Fix: Gutenberg conflict causing error on POS settings page
* Fix: remove customer meta for POS
* Fix: tweak payment options on Order edit page

= 0.4.18 - 2018/02/12 =
* Fix: Product variation stock adjustment
* Fix: Category search for products
* Fix: Prevent display of hidden order item meta
* Fix: POS flag on Orders list page
* Fix: Add payment method to Orders list page
* Fix: Printing in Chrome 46+

= 0.4.17 - 2017/11/24 =
* WP 4.9 compatibility fix for decimal quantities

= 0.4.16 - 2017/11/22 =
* WP 4.9 compatibility fix for 'rest_invalid_param'

= 0.4.15 - 2017/10/12 =
* WC 3.2 compatibility: fix tax calculation

= 0.4.14 - 2017/08/03 =
* Urgent Fix: bug fix for browsers crashes affecting some users

= 0.4.13 - 2017/06/15 = 
* Fix: (WC3 compatibility): save product meta
* Fix: (WC3 compatibility): correctly sync stock numbers
* Improvement: disable WorldPay gateway for POS
* Improvement: disable zoom on touch devices

= 0.4.12 - 2017/06/05 =
* Fix: (WC3 compatibility): Any retrieve Products with post_status = publish

= 0.4.11 - 2017/05/31 =
* Fix: (WC3 compatibility): correct sale completed date
* Fix: (WC3 compatibility): featured and on_sale filter
* Fix: date localisation
* Improve translations

= 0.4.10 - 2017/05/26 =
* Fix: Receipt date time zone
* Fix: Emailing receipts
* Fix: Product search by title only

= 0.4.9 - 2017/05/04 =
* Fix: Custom variation attributes
* Fix: (WC3 compatibility): non-taxable products
* Fix: (WC3 compatibility): taxable fees
* Fix: (WC3 compatibility): order created_at property

= 0.4.8 - 2017/04/27 =
* Fix: 'Any ...' variations

= 0.4.7 - 2017/04/15 =
* WC 3 Compatibility fixes

= 0.4.6 - 2016/06/15 =
* WC 2.6 Compatibility Fix: Prevent POS gateways from appearing on online checkout
* Fix: checkout settings not showing for some users due to Javascript conflicts
* Fix: POS orders not showing in reports
* Fix: bug causing issue with some variations, e.g.: 000, 00 and 0
* Fix: character encoding in checkout
* Fix: incorrect translation strings

= 0.4.5 - 2015/10/28 =
* Important: WooCommerce POS now requires PHP 5.4 or higher
* Important: WooCommerce POS now requires WooCommerce 2.3.7 or higher
* Important: Pro users should update [WooCommerce POS Pro](http://wcpos.com/pro) to version 0.4.5
* Fix: Layout issues in Chrome 46+
* Fix: POS permalink bug introduced in 0.4.2 - [22388f7](https://github.com/kilbot/WooCommerce-POS/commit/22388f7a6d91959b3b55fd07b6f973ba8eda01af)
* Fix: POS Cash not recording amount tendered or change - [2ef2260](https://github.com/kilbot/WooCommerce-POS/commit/2ef226070eb4a2f966cd1d96c3fbd850b6baec34)
* Fix: POS Cash and Card gateways not showing for some users
* Fix: Permalink slugs should not begin with slash
* Fix: Product variation popover where variant contains a comma or special character
* Fix: Firebox bug where POS would be unresponsive after printing receipt
* Improve: POS template caching and performance
* Improve: Plugin update notices - [08058a9](https://github.com/kilbot/WooCommerce-POS/commit/08058a99e89cf9c3612c7086534a576e99ae9435)
* Improve: Customer search
* New: (Pro) Edit customer details during checkout

= 0.4.4 - 2015/08/26 =
* Fix: cart totals going to zero with new fee or shipping line item - commit [35f547c](https://github.com/kilbot/WooCommerce-POS/commit/35f547cf40919736ff769702043489ff1698ec30)
* Improve: scanning barcodes multiple times - commit [670173b](https://github.com/kilbot/WooCommerce-POS/commit/670173b4e890d74800420511803e48ef9f6a4ec7)

= 0.4.3 - 2015/08/24 =
* Fix: barcode scanning bug introduced in version 0.4.2 - commit [8a608c8](https://github.com/kilbot/WooCommerce-POS/commit/8a608c8124d77cd3499af55e08651752287261bc)

= 0.4.2 - 2015/08/24 =
* New: local storage will now clear on version change - commit [85ec411](https://github.com/kilbot/WooCommerce-POS/commit/85ec411a58600988b811272be6d151cb11161f4f)
* New: option to automatically print receipt after checkout - commit [16fba05](https://github.com/kilbot/WooCommerce-POS/commit/16fba054593e118be6c567ce4d87f8d0b91acaa5)
* New: add cashier to receipt data - commit [c4caa8d](https://github.com/kilbot/WooCommerce-POS/commit/c4caa8df78d9f255445f370854fbb3e466b46b4e)
* New: add pos_cash info to receipt data - commit [e7e443b](https://github.com/kilbot/WooCommerce-POS/commit/e7e443ba07aff02f3927f2c08128e062b81fe5c1)
* New: WooPOS icon to denote POS orders in WP Admin
* Fix: variation display and select issues - commit [91c7ec1](https://github.com/kilbot/WooCommerce-POS/commit/91c7ec13e737f820d84feb7890d7b6d027a79792), [b3d6543](https://github.com/kilbot/WooCommerce-POS/commit/b3d6543b86140df62ff90f3a7b7e734d73ae59ab)
* Fix: variation barcode search for products in queue - commit [3fda531](https://github.com/kilbot/WooCommerce-POS/commit/3fda5317ef580f6b6d70e24ba235d2b7e69c5ee4)
* Fix: variation stock adjustment after sale - commit [26978fd](https://github.com/kilbot/WooCommerce-POS/commit/26978fd0e74cfb9cf28ef2bb4bc5222820a77d38)
* Fix: populate order addresses from customer id - commit [b86bc56](https://github.com/kilbot/WooCommerce-POS/commit/b86bc5650a2bf41d7744bf07cda34407e8fa3dd5)
* Fix: compatibility fix for WC 2.4 SSL authentication - commit [525671b](https://github.com/kilbot/WooCommerce-POS/commit/525671b7613b20864366aebf426f14d07b37bfa4)
* Fix: modal CSS conflict in WP Admin - commit [837b918](https://github.com/kilbot/WooCommerce-POS/commit/837b918e5bae4de6c1cee1492d390ade1b2e7f45)
* Fix: numpad discount bug introduced in 0.4.1
* Fix: quick edit links not showing on WP Admin Products page - commit [07d3e98](https://github.com/kilbot/WooCommerce-POS/commit/07d3e984802b64c645f53899396bb393ea7cb7ef)
* Fix: POS visibility options not showing on new product page - commit [ef20a5b](https://github.com/kilbot/WooCommerce-POS/commit/ef20a5bd4e9727855e9eac747f912502ae0c9cc9)
* Tweak: WP Admin CSS - commit [c5a38c7](https://github.com/kilbot/WooCommerce-POS/commit/c5a38c7f889a7788e3eaa633c28620d2e80ac2ee)

= 0.4.1 =
* Note: WooCommerce POS now requires WooCommerce 2.3 or greater
* New: added woocommerce_pos_email_receipt hook
* Improve: blur() barcode search field after successful match
* Improve: editing a product/fee/shipping title in cart - commit [216e8a5](https://github.com/kilbot/WooCommerce-POS/commit/216e8a5)
* Improve: css tweaks for Firefox - commit [216e8a5](https://github.com/kilbot/WooCommerce-POS/commit/216e8a5)
* Improve: keyboard entry for qty and prices - commit [ee61744](https://github.com/kilbot/WooCommerce-POS/commit/ee61744)
* Improve: variation attributes now stored as line item meta for display on receipts
* Fix: support for legacy server HTTP methods - commit [5765491](https://github.com/kilbot/WooCommerce-POS/commit/5765491)
* Fix: Internal Server Error for PHP 5.2.x - commit [d800d40](https://github.com/kilbot/WooCommerce-POS/commit/d800d40)
* Fix: parse $HTTP_RAW_POST_DATA global to array - commit [ac88f50](https://github.com/kilbot/WooCommerce-POS/commit/ac88f50)
* Fix: decimal quantity display - commit [358d95f](https://github.com/kilbot/WooCommerce-POS/commit/358d95f)
* Fix: check WooCommerce has loaded - commit [80285c4](https://github.com/kilbot/WooCommerce-POS/commit/80285c4)
* Fix: variation selection issues in popover - commit [5c9673b](https://github.com/kilbot/WooCommerce-POS/commit/5c9673b)
* Fix: incorrect total tax calculation for negative fees - issue [#85](https://github.com/kilbot/WooCommerce-POS/issues/85)
* Fix: decimal bug on numpad entry, eg: 0.01 - commit [b46884d](https://github.com/kilbot/WooCommerce-POS/commit/b46884d)
* Update npm dependencies

= 0.4.0 =
* Note: this is a major code refactor, almost every line of code has been rewritten
-
* Products: Variation popover/drawer
* Products: Infinite scroll
* Products: Hotkey for barcode search
* Products: Attributes now show in tooltip
* Cart: Tax settings can now be changed per cart item
* Cart: Meta data can be added to cart items
* Cart: Ability to add shipping line item
* Cart: Ability to fee line item
* Hotkeys: Use hotkey '?' to display a list of available hotkeys
* Translations: WooCommerce POS now uses automatic downloads
* New: Set custom permalink for POS front-end
* Improved: Responsive design for tablets & mobile
-
* Pro: Add customer during checkout
* Pro: Open multiple carts
* Pro: Hotkey for credit card readers
* Pro: New product page for quick product management
* Pro: New customer page for quick add/edit customers
* Pro: New order page
* Pro: New coupon page
* Pro: Multiple stores
* Pro: Compatibility fix for Stripe gateway
-
* Fix: all the things

= 0.3.5 =
* Note: this is a minor compatibility update for WooCommerce 2.3
* Fix WC_Gateway_Mijireh error with WC 2.3
* Fix for W3 Total Cache minify js conflict
* Fix capitalization bug with product searches

= 0.3.4 =
* Urgent Fix: performance issue downloading products
* Fix: potential clash for admin menu position
* Fix: bug affecting woocommerce_api_order_response
* Fix: cashback entry on receipt
* Improved: POS Only products

= 0.3.3 =
* Urgent Fix: Compatibility with new order-status introduced in WooCommerce > 2.2
* Fix: POS Only products improved, fixes 404 errors on imported products
* Fix: IndexedDB now available on Safari 7.1, compatibility update to db
* Fix: bug effecting default customer setting
* Fix: added support for Simplify Commerce by Mastercard
* Improved: product thumbnails, support for non-cropped thumbs
* Improved: clearing local database improved for large stores

= 0.3.2 =
* Urgent Fix: POS bug causing problems with product display on some websites, eg: featured products
* Fix: refresh button on offsite payment receipts
* Fix: managing_stock for variations

= 0.3 =
* New: Set default POS customer on new settings page
* New: Add customer to order
* New: Documentation for third party developers [http://kilbot.github.io/WooCommerce-POS/](http://kilbot.github.io/WooCommerce-POS/)
* New: pt_BR translation thanks to Hermes Alves Dias Souza! [http://pt.woopos.com.au/pos](http://pt.woopos.com.au/pos)
* New: Icons for mobile devices. Thanks [@sixthcore](https://github.com/kilbot/WooCommerce-POS/issues/11)!
* Fix: stock is now synced after each order
* Fix: Add-to-cart bug for particular tax settings (tax enabled + prices exclusive from tax + no tax rates set)
* Fix: product display for sites where home_url != site_url
* Fix: authentication test for subfolder wordpress installs

= 0.2.15 =
* New: [website](http://woopos.com.au)!
* New: Multisite support: visit [http://demo.woopos.com.au/pos](http://demo.woopos.com.au/pos) to see WooCommerce POS in different languages using multisite
* New: nl_NL translation thanks to Egbert Jan! [http://nl.woopos.com.au/pos](http://nl.woopos.com.au/pos)
* New: nb_NO translation thanks to Olav Solvang! [http://no.woopos.com.au/pos](http://no.woopos.com.au/pos)
* Visit: [http://translate.woopos.com.au](http://translate.woopos.com.au) if you would like to translate WooCommerce POS into your language
* Improved: Search field now reset after successful barcode search
* Fix: Bug with multiple tax rates and compound tax rates
* Fix: WooCommerce POS will deactivate if WooCommerce not active, fixes https://github.com/kilbot/WooCommerce-POS/issues/9
* Fix: Added admin message if permalinks not active
* Fix: proper fix for rounding error for comma decimals
* Fix: fixed bug for subfolder wordpress install
* Removed: Beta tag!

= 0.2.14 =
* New: Search by 'barcode'. Defaults to SKU for the moment. Instant add to cart for barcode matches, ie: barcode scanning!
* New: Support page: contact support directly from the POS
* New: Add order discount
* New: Add order note
* New: Void order
* New: Basic translations for nl_NL, fr_FR, es_ES and pt_BR. Corrections can be submitted to [GitHub](https://github.com/kilbot/WooCommerce-POS/issues) or via email [support@woopos.com.au](mailto:support@woopos.com.au). Thanks Javier Gómez for the Spanish translation!
* Fix: fixed bug for product_variations which effects WooCommerce < 2.1.7
* Fix: fixed rounding bug for comma decimals
* Fix: https://github.com/kilbot/WooCommerce-POS/issues/7

= 0.2.13 =
* Improved: Product Sync now handled by web worker, improves sync performance for large stores (1000+ products)
* Fix: Access to WC REST API now validates against the wordpress cookie, only logged in users with manage_woocommerce_pos capability can access the api
* Fix: Added flag for WC REST API request and response filters
* Fix: Cart now handles comma decimals correctly

= 0.2.12 =
* Improved: Product list now uses local IndexedDB for fast searching and filtering. Fallback to server-side filtering for browsers which do not support [IndexedDB](http://caniuse.com/indexeddb)
* Improved: Cart logic now handled client-side, no more waiting for the server to respond
* New: Pagination info and last update time added to the product list
* New: Cart item price can now be changed
* New: Print receipt
* New: Added text domain, readying the plugin for translation

= 0.2.11 =
* Fix: Bug caused WC REST API authentication problems
* Fix: Bug caused no shipping fees for all users
* Tweak: Back to server side filtering until localstorage is complete

= 0.2.10 =
* New: Update cart quantity
* Tweak: Improvement to cart load time
* Tweak: Prevent New Order emails to admin
* Fix: No shipping fees on cart items

= 0.2.9 =
* Tweak: Improvement to cart add/remove products.
* New: Added some sanity check on the settings page.

= 0.2.6 =
* Tweak: Products now uses WC REST API for better performance. Tested on 300+ products. 

= 0.2.4 =
* Fix: Cart totals
* Fix: Notice about updating via github
* Fix: pagination weirdness

= 0.2 =
* Proof of concept
