# Aelia PayPal Standard gateway with multi account support

## Version 1.x
####1.3.3.180413
* Tweak - Improved logic to fetch the PayPal email address during IPN verification.

####1.3.2.171220
* Fix - Fixed refund logic in WooCommerce 3.2.6.

####1.3.1.170308
* Improved compatibility with WooCommerce 2.7:
  * Replaced calls to `WC_Order::get_order_currency()` with `WC_Order::get_currency()`.
* Updated requirements.
* Updated requirement checking class.
* Improved compatibility with WordPress 4.7 and later. Added new logic to process the global `$wp_filter` variable.

####1.3.0.160106
* Rewritten gateway for WooCommerce 2.4.x. WC 2.4 includes the improvements we submitted to make the PayPal gateway more extensible. The rewritten gateway takes advantage of such changes, simplifying the multi-account logic.

####1.2.6.151208
* Fixed bug in `woocommerce_subscriptions_paypal_change_status_data` handler. Removed call to `WC_Gateway_Paypal_MultiAccount::obsolete get_order_from_subscriber_id()` method.

####1.2.5.151020
* Added new filter `payment_status_completed_data`. This new filter will allow 3rd party to pre-process payment data before it's validated.

####1.2.4.150903
* Removed unneeded code that raised some minor warnings.

####1.2.3.150731
* Updated requirement checking class.

####1.2.4.150630
* Refactored logic to validate IPN. Added mechanism to remove all references to the base IPN Handler class.

####1.2.3.150610
* Fixed bug in IPN handling in WooCommerce 2.3.10. The bug was caused by incorrect references in base `WC_Gateway_Paypal_IPN_Handler` class, which caused the PayPal merchant email validation to fail. Ref. https://github.com/woothemes/woocommerce/pull/8348.

####1.2.2.150519
* Refactored `WC_Gateway_Paypal_MultiAccount::woocommerce_subscriptions_paypal_change_status_data()`. The method now uses the order object passed to it by the Subscription plugin.
* Added `WC_Gateway_Paypal_MultiAccount::woocommerce_subscriptions_paypal_change_status_data()` method to PayPal gateway for WooCommerce 2.2 and earlier.

####1.2.1.150515
* Improved support for Subscriptions. The plugin can now alter the API keys used by the Subscriptions plugin depending on the currency used to buy the subscription.
* Set requirements to WooCommerce 2.3.8. The plugin cannot work properly with WooCommerce 2.3.0 to 2.3.7 due to some issues in the core.
* Imported logic to use a single logger for all PayPal Standard classes in WooCommerce 2.3. Ref. https://github.com/woothemes/woocommerce/commit/33d94aaea46137a0d8366e9033e6bebd218333cc.

####1.2.0.150506
* Added support for PayPal API settings in multiple currencies.
* Added support for refunds.

####1.1.2.150422
* Rewritten PayPal Request, PDT and IPN classes to work with unpatched WooCommerce. This was necessary after the decision, from WooCommerce team, of not fixing the PayPal gateway in WC 2.3.x.

####1.1.1.150420
* Fixed bug in `WC_Gateway_Paypal_IPN_Handler` class. The bug caused IPN validation to fail.

####1.1.0.150319
* Added support for the complicated PayPal Standard gateway included with WC2.3:
  * Added new `WC_Gateway_Paypal_MultiAccount` class.
  * Added new `WC_Gateway_Paypal_Request` class.
  * Added new `WC_Gateway_Paypal_IPN_Handler` class.
  * Added new `WC_Gateway_Paypal_PDT_Handler` class.
* Updated requirements. Plugin now required WooCommerce 2.1, 2.2 or 2.3.8 and later.

####1.0.8.150310
* Improved requirements checking. The new logic will prevent the plugin from crashing when the requirements are not met.

####1.0.7.140903
* Packaged plugin for public release.

####1.0.6.140318
* Added WC_Gateway_Paypal_MultiAccount::get_paypal_order() method.

####1.0.5.140318
* Improved debug code.

####1.0.4.140228
* Improved debug code.

####1.0.3.140228
* Corrected PayPal notification URL.

####1.0.2.140228
* Fixed bug in retrieving the default receiver email for a currency.
* Improved logging.

####1.0.1.140227
* Improved debug mode.
* Corrected plugin name.

####1.0.0.140227
* First release.
