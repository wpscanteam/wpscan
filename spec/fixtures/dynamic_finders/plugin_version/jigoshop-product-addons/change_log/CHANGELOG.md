### Changelog

* 2.1 - 2019-01-31
    - New: Allow to add checkbox addons multiple times.
* 2.0.2 - 2017-08-11
    - Updated Links
* 2.0.1 - 2016-08-05
    - Released as JS2 compatible
* 2.0 - 2016-04-28
    - Plugin Redeveloped to Jigoshop 2.0 compatible
* 1.19.2 - 2014-12-16 
    - Added: actions links
    - Fixed: Plugin header
    - Fixed: Changelog file name
* 1.19.1 - 2014-05-15
    - Fixed: PayPal price adjust is no longer needed.
* 1.19 - 2013-10-15
    - Improved: Backported some updates from Premium version.
* 1.18 - 2013-04-04
    - Added: few filters to allow integration with user templates
* 1.17.2 - 2013-01-29
    - Fixed: displaying values in format with comma as decimal separator.
* 1.17.1 - 2013-01-22
    - Fixed: removed ucfirst which was applied to user entered values
* 1.17 - 2013-01-22
    - Fixed: displaying price for PayPal gateway if product in cart has no addons
    - Added links to uploaded files in cart/checkout/emails
    - Added the check during plugin activation if other instance of Addons plugin is activated. If so, the plugin is not activated
    - Added css classes for each addon form-row (.form-row) for more accurate styleing
    - Added ability to call JS function countTotalPrice from the outside, use jQuery.fn.jigoshopProductAddons('countTotalPrice')
    - Added filter 'jigoshop_product_addons_get_item_data' which allows modyfication of displaying addons on cart and checkout
* 1.16 - 2012-11-23
    - Make compatible with Jigoshop Multi Currencies plugin which allows to define other cart currencies and change cart currency on the fly. Product addons is full compatible with it, all prices are exchanged to other currencies on the fly also.
* 1.15 - 2012-10-27
    - Added label on datepicker field
    - Changed credentials
    - Filting added for extending empty option of select (addon type)
    - Added more hooks
* 1.14 - 2012-10-25
    - Added radio list as the addon type
    - Fixed bug when addon name was not entered in admin panel (addon was saved and appeared in frontend, but it stopped showing in admin panel). Right now addon would not be saved if it has no name.
* 1.13 - 2012-10-04
    - Modified initialization of plugin
    - Introducing more hooks for extending addons
* 1.12 - 2012-09-30
    - Better displaying of addons in emails
    - Fixed bug, which occured in admin panel, when saveing order with the same product many times with different addons
    - Extended core for additional extensions
* 1.11 - 2012-09-27
    - Fixed dynamic price Javascript (problem with rounding numbers)
* 1.10 - 2012-09-10
    - Added hooks for plugin custom extensions
* 1.9 - 2012-09-07
    - Extened to work with PayPal Gateway cart
* 1.8 - 2012-09-05
    - Fixed displaying custom input values in order summary and email template
* 1.7 - 2012-09-03
    - Fixed the bug deletion addons information when order in panel admin was updated
    - Improved display of addons in cart for Custom Input Boxes (displaying name of addon and label)
* 1.6 - 2012-08-10
    - Fix for dynamic pricing
    - Added Polish translation
    - Made compatibile with Jigohop version 1.3 (with backward compatibility with 1.2)
    - Made easier to translate with CodeStyling Localization
* 1.5 - 2012-07-27
    - Fix for upload_size_limit_filter error in multisite configuration
    - Added clickable links to uploaded files in order admin panel
* 1.4 - 2012-07-25
    - Fixed "lonely colon" when no label and no price are put for option of custom type and file upload
    - Added "textarea" as one of addon types
    - Added datepicker as one of addon types which stores data in Wordpress date format
    - Added ability to send addons in email with order summary (will be seen in Jigoshop version 1.3)
    - Fixed error displaying while file uploading
* 1.3 - 2012-07-20
    - Added dynamic pricing during choosing addons in frontend
* 1.2 - 2012-07-19
    - Fixed addons displaying in admin panel
* 1.1 - 2012-07-07 -
    - Added file upload support
