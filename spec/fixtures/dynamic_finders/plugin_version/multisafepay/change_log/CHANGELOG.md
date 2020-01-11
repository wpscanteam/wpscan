# Release Notes - WooCommerce 3.4.0 (Jan 6th, 2020) #

### Added
+ PLGWOOS-287: Add maximum amount restriction for credit cards
+ PLGWOOS-321: Add Ohmygood Cadeaukaart

### Changed
+ PLGWOOS-115: Make suitable for WordPress.org Plugin Directory
+ PLGWOOS-260: Change VVV Bon to VVV Cadeaukaart

### Fixed
+ PLGWOOS-319: Disable payment fields when payment description is empty

# Release Notes - WooCommerce 3.3.0 (Dec 13th, 2019) #

### Added
+ PLGWOOS-291: Add IP validation when WooCommerce returns multiple IP addresses
+ PLGWOOS-203: Add compatibility with WPML

### Changed
+ PLGWOOS-245: Change Klarna from direct to redirect
+ PLGWOOS-275: Improve Dutch translation for 'Activate'
+ PLGWOOS-263: Correct ING Home'Pay spelling

### Removed
+ PLGWOOS-208: Remove the send invoice option from the backend

### Fixed
+ PLGWOOS-285: Fix the fatal error "Cannot redeclare error_curl_not_installed"
+ PLGWOOS-102: Prevent the Notification URL from executing when not initialized by MultiSafepay
+ PLGWOOS-266: Prevent errors from appearing in logs for notifications of pre-transactions
+ PLGWOOS-290: Resolve DivisionByZeroError bug occurring with fees 
+ Fix PHP notice incorrect use of reset in function parseIpAddress
+ Fix PHP notice undefined property when order set to shipped

# Release Notes - Woo-Commerce 3.2.0 (Jul 6th, 2018) #

## Improvements ##

PLGWOOS-232: Add TrustPay payment method
PLGWOOS-213: Add support for external fee plugin(s)

## Fixes ##

PLGWOOS-176: Restrict autoload to load only MultiSafepay classes
PLGWOOS-191: Refactor the way an order and transaction are retrieved
PLGWOOS-241: Remove status request on setting to shipped
PLGWOOS-195: Update Klarna Invoice link
PLGWOOS-231: Update Klarna payment method logo
PLGWOOS-197: Correct MultiFactor Terms and Condition link
PLGWOOS-242: Remove terms and conditions for Einvoicing
PLGWOOS-244: Shipment name now used on payment page instead of type
PLGWOOS-243: Payment page shopping cart reorganized
PLGWOOS-253: FastCheckout load correct first and last name
PLGWOOS-235: Rename KBC/CBC to KBC
PLGWOOS-236: Rename ING-Homepay to ING HomePay
PLGWOOS-247: Notice message 'Undefined variable' for E-Invoice, Pay After Delivery and Klarna
PLGWOOS-249: Remove whitespace at file headers
PLGWOOS-259: Direct E-Invoice returns unnecessary message 'Missing gender'

# Release Notes - Woo-Commerce 3.1.0 (Jun 15th, 2018) #

## Improvements ##

PLGWOOS-215 Add support for Santander Betaalplan
PLGWOOS-214 Add support for Afterpay
PLGWOOS-216 Add support for Trustly

## Fixes ##

PLGWOOS-221: Do not add Klarna invoice link when setting to Completed
PLGWOOS-218: Undefined property in error logs when cancelling order
PLGWOOS-226: getTimeActive didn't respect seconds

# Release Notes - Woo-Commerce 3.0.4 (Feb 2nd, 2018) #

## Improvements ##

+ PLGWOOS-169 Support direct transactions for Alipay/ING/Belfius/KBC
+ PLGWOOS-174 Remove usage of deprecated functions
+ PLGWOOS-175 Remove unnecessary use of file_exists
+ PLGWOOS-178 Order status is only changed to 'expired' in case the current status is 'pending' or 'on-hold'.
+ PLGWOOS-179 Add text domain for ideal issuer error message
+ PLGWOOS-182 Add Alipay as payment method
+ PLGWOOS-186 Add dynamic retrieve of shipping methods during Fast Checkout
+ PLGWOOS-187 Do not allow refund when amount is zero or less
+ PLGWOOS-192 Check/add all translations

## Fixes ##
+ PLGWOOS-173 Fix deprecated notice getRealPaymentMethod
+ PLGWOOS-180 Incorrect order-id used to load the order for updating
+ PLGWOOS-181 function getGatewayCode not implemented for FastCheckout
+ PLGWOOS-183 Update version number of plug-in failed
+ PLGWOOS-184 Incorrect check if field is empty
+ PLGWOOS-193 Fix deprecated notice FastCheckout
+ PLGWOOS-194 Refund function checks wrong variable to determine if refund was succesfull
+ PLGWOOS-199 Correct wc_get_cart_url and wc_get_checkout_url
+ PLGWOOS-200 FastCheckout doesn't redirect to order-confirmation screen
+ PLGWOOS-202:Payment method updated for Second Chance on Processing

## Changes ##
+ PLGWOOS-189 Update version number to 3.0.4
+ PLGWOOS-198 Update ING gateway to INGHOME

# Release Notes - Woo-Commerce 3.0.3 (Okt 10nd, 2017) #

## Fixes ##

+ Menu's are able to edit again.
+ In some cases the customer was redirected to the cancel-url after a succesful iDEAL transaction.

# Release Notes - Woo-Commerce 3.0.2 (Okt 10nd, 2017) #

## Improvements ##

+ Add ING Home'Pay as payment method.
+ Add Belfius as payment method.
+ Add KBC/CBC as payment method.
+ Add configuration option for Google-Analytic code.
+ Add shopping-cart information to the transaction.
+ Update payment method in order, in case a customer pays the second change with an other payment method.
+ Update the dutch translations.

## Fixes ##
+ Fixed issue to prevent a warning message when the title of a gateway wasn't filled in the config.
+ Fixed issue with retrieve the correct external transaction ID.
+ Fixed issue on error 1027 (Invalid cart amount) caused by an invalid shipping-tax.
+ Fixed issue in function to set order-status to shipped for PAD, Klarna and E-Invoiced.
+ Fixed warning issue on function setToShipped.
+ Fixed issue on not accepting PAD orders caused by an divide by zero error.

## Changes ##
+ Remove (beta)functionality to determine if there is a new version available.
+ Restrict use of the plug-in to WooCommerce 2.2 and above.

# Release Notes - Woo-Commerce 3.0.0 (April 5nd, 2017) #

## Improvements ##

+ Compatible with PHP-7
+ Installation by standard Wordpress method
+ Added Dutch language file
+ Added configuration option Karna Merchant-EID (for future use.)
+ Added Terms and Conditions for Klarna, Pay After Delivery and E-Invoicing.
+ Improve the way errors are logged.
+ Added PaySafeCard as payment method.
+ Added Nationale bioscoopbon as a giftcard.
+ Added option to the global MultiSafepay settings to enable/disable the giftcards as payment method.

## Fixes ##
+ Better algoritm to split address into street, housenumber
+ After complete FastCheckout transaction no order confirmation page was showed

## Changes ##
+ General plugin settings moved to the general checkout-options
+ Remove BabyGiftcard as payment method

# Release Notes - Woo-Commerce 2.2.7 (November 2nd, 2016) #

## Improvements ##

+ Added EPS and FerBuy as payment methods
+ Added support for E-invoicing
+ Added an extra payment method gateway called "Creditcards"; grouping creditcard payment methods as a single dropdown option.

## Fixes ##
+ Resolved an issue resulting in not being able to pay using Direct iDEAL.
+ Resolved an issue where expiring payment sessions result in orders being marked as new after 30 days.

##Changes ##
+ Changed banktransfer to direct banktransfer

# Release Notes - Woo-Commerce 2.2.6 (July 14th, 2016) #

## Improvements ##

+ Added support for WooCommerce version 2.6.2.

## Fixes ##
+ Resolved an issue resulting in not being able to pay using Direct iDEAL.

# Release Notes - Woo-Commerce 2.2.5 (June 24th, 2016) #

## Improvements ##

+ Added support for partial refunds for orders paid using Klarna and Pay After Delivery.
+ Added support for Fast Checkout order refunds.
+ Improvements were made to the iDEAL banklist selector, and a notice will be shown if no bank was selected.

## Fixes ##
+ Updated the Bancontact logo

## Fixes ##
+ Resolved issues occuring with Pay After Delivery and Klarna when using discounts.
+ Made compatible with WooCommerce version 2.6.

# Release Notes - Woo-Commerce 2.2.4 (March 8th, 2016) #

## Improvements ##

+ Pay After Delivery is now only visible for orders placed in The Netherlands.
+ Textual improvements for the option "Send the order confirmation".
+ Orders started with banktransfer are now set to On Hold, rather than "Pending Payment".
+ Uncleared orders are now set to On Hold, rather than "Pending Payment".
+ Improved the iDEAL description shown when no iDEAL issuer/bank has been selected.

## Fixes ##
+ Resolved a bug causing Error 1035 when refunding.
+ Changed the way coupons are applied, which previously resulted in a paid totals mismatch.

# Release Notes - Woo-Commerce 2.2.3 (Feb 18, 2016) #

## Improvements ##

+ Added dotpay as a payment method
+ Klarna and Pay After Delivery transactions are now set to Shipped, if enabled and the order is set to Completed.
+ Pay After Delivery is now only available as a payment method if the selected country is "The Netherlands".
+ Multistores in WooCommerce are now supported.
+ Added Bunq as a supported iDEAL issuer

## Fixes ##
+ Refunds from within WooCommerce now also work when using the WooCommerce Sequential Order Numbers plugin.
+ Issues with Gateway restrictions based on minimum and maximum amount are resolved for Klarna and Pay After Delivery.
+ Fixed a bug causing the postalcode not to be added to the order when using Fast Checkout.
+ Removed WooCommerce mailer functions in the plug-in, which was added to avoid mailing issues.

# Release Notes - Woo-Commerce 2.2.2 (Dec 14, 2015) #

## Improvements ##

+ Added Klarna reservationcode and link to the invoice in the order comments.
+ For KLARNA and PAD the orderstatus is set to shipped when order status is set to completed and this option is enabled in the configuration.
+ Added Goodcard as giftcard.

## Fixes ##
+ Fixed performance issue due to our plugin loaded the iDEAL issuers on every page..
+ Fixed housenumber is now correct parsed when using both address fields.
+ Fixed issue with wrong processing of some orderstatusses.
+ Fixed The FastCheckout button was not completly visable with latest updates of woocommerce default template.

# Release Notes - Woo-Commerce 2.2.1 (Sep 30, 2015) #

## Improvements ##

+ Added Klarna as payment method.

## Fixes ##
+ Fixed issue that prevents MultiSafepay to add the orderstatus in the order comment.

# Release Notes - Woo-Commerce 2.2.0 (May 21, 2015) #

## Improvements ##

+ Added an extra check to determine if the MultiSafepay class exists.
+ Debug option added to the plug-in for troubleshooting purposes.
+ Added improved payment method icons.
+ Added the MultiFactor agreement hyperlink.
+ Added Refund API support. Refunds via MultiSafepay can now be executed from the WooCommerce order/back-end.
+ Added a check to see if WooCommerce is active. The plug-in will not be loaded if not the case.

## Changes ##
+ Changed add_error(); to wc_add_notice();

## Fixes ##
+ Fixed some undefined notices and improved checks for page_id and the loading of the plugins.
+ Resolved the 'Cannot redeclare class' error.

# Release Notes - Woo-Commerce 2.1.0 (Oct 15, 2014) #

## Improvements ##

+ Added Fast Checkout
+ Added coupon support for FCO
+ Added option to enable/disable fco button
+ Added DB Table to check if order is already created and if so go to normal updating process when using Fast Checkout
+ Added amount check that compares the calculated order total after creating the order and the transaction amount. If they are not equal then set to wc-on-hold status and add a note about the mismatch in amounts
+ Added Payafter as a separate plugin
+ Added amex as a separate plugin
+ Added paypal as a separate plugin
+ Added VISA as a separate plugin
+ Added mistercash as a separate plugin
+ Added Mastercard as a separate plugin
+ Added Maestro as a separate plugin
+ Added giropay as a separate plugin
+ Added sofort as a separate plugin
+ Added DirectDebit as a separate plugin
+ Added Banktransfer as a separate plugin
+ Added iDEAL as a separate plugin

## Changes ##
+ Changed the processing of the offline actions so that FCO transactions work
+ Process stock on process_payment
+ Use ordernumber instead of orderid so that the plugin is compatible with thirdparty sequential ordernumbers plugins
+ Removed gateway method from the main module. Gateways are now separate plugins
+ Removed images from main module. These are now loaded from each separate plugins
+ Removed version checks as this version is only for 2.2 and higher
+ Removed useless code from all plugins
+ Removed country and amount restrictions. WooCommerce changed things and broke the function

## Fixes ##
+ Fixed bug with status updates
+ Fixed new bug with coupons not beeing processed because of extra check on cart or order discount
+ Small fixes (o.a. reported by Mark Roeling)

# Release Notes - Woo-Commerce 1.0.6 (Apr 15, 2014) #

## Improvements ##

+ Added support for direct Pay After Delivery

# Release Notes - Woo-Commerce 1.0.5 (Mar 21, 2014) #

## Improvements ##

+ Added support for American Express
+ Added housenumber check

## Fixes ##
+ Fixed bug when customer canceled a payment
+ Fixed bug that causes a empty status
+ Fixed bug in refund check

# Release Notes - Woo-Commerce 1.0.4 (Mar 06, 2014) #

## Improvements ##

+ Auto spit housenumber from address if needed

## Fixes ##
+ Fixed bug when customer canceled a payment
+ Fixed bug that causes a empty status
+ Fixed bug in refund check

# Release Notes - Woo-Commerce 1.0.3 (Feb 19, 2014) #
## Improvements ##

+ Added support for WooCommerce 2.1.x
+ Added payment method Pay After Delivery
+ Changed payment name 'directebanking' to 'Sofort Banking'
+ Added support for thirdparty payment surcharge module
+ Added support for dollars and GBP
+ Added check for available issuers when paying by iDEAL
+ added orderid to the return url

## Fixes ##
+ Fixed bug that caused no order data to show on thankyou page

# Release Notes - Woo-Commerce 1.0.2 (Aug 21, 2013) #
## Improvements ##

+ Optional send an invoice e-mail

## Fixes ##
+ Fixed bug in update order status
