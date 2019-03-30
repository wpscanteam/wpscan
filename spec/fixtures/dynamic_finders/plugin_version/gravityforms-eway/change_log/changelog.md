# Gravity Forms eWAY

## Changelog

### 2.2.8, 2018-11-17

* added: validates credit card number before running Client Side Encryption
* added: show placeholders when field values are hidden during Client Side Encryption
* tested: WordPress 5.0, Gravity Forms 2.4

### 2.2.7, 2018-02-03

* changed: load front end CSE script from file, don't inline in the page footer
* added: custom merge tag `{date_created}` so that notification resends can show the entry date instead of the current date

### 2.2.6, 2017-09-12

* fixed: Gravity Forms 2.3 compatibility; don't directly access database tables
* fixed: amounts in Japanese Yen (JPY) are already in the lowest denomination; no need to shift to / from cents
* fixed: Client Side Encryption fails when Gravity Forms HTML5 Validation plugin is active

### 2.2.5, 2017-05-01

* fixed: Recurring Payments could not send formatted phone numbers with () characters
* changed: filters pass `false` for third parameter, for compatibility with filters in Pro version

### 2.2.4, 2017-01-19

* fixed: logging should not record encrypted card details (even though they're encrypted)
* fixed: stored payments legacy API fails
* changed: replace old $field array access with GF_Field object access
* changed: log which API was used, and capture or authorise

### 2.2.3, 2016-12-08

* fixed: don't attempt card processing if form validation fails (validation in other plugins; honeypot failure; save and continue heartbeat)
* fixed: conflict between eWAY's Client Side Encryption script and File Upload fields
* fixed: undefined index errors on `gform_replace_merge_tags` hook, e.g. with GF User Registration login widget

### 2.2.2, 2016-07-24

* fixed: no confirmation message after saving settings
* changed: use the minified version of the eWAY Client Side Encryption script, unless `SCRIPT_DEBUG` is enabled
* changed: use `wp_remote_retrieve_*()` functions instead of response array access (WP4.6 compatibility)
* changed: use Gravity Forms `get_order_total()` to calculate form total (fixes T2T Toolkit conflict with Coupons add-on)
* added: check for PCRE (regular expression library) minimum version
* added: new error message strings for eWAY Rapid API response codes
* added: prevent multiple instances of Recurring field on form

### 2.2.1, 2016-05-06

* fixed: T2T Toolkit breaks posted Gravity Forms total field when products have options
* fixed: set default values for optional Recurring Payment fields, avoids fatal PHP error

### 2.2.0, 2016-04-27

* changed: minimum required version of Gravity Forms is 1.9.15
* added: separate sandbox configuration, making it easier to switch between Live and Sandbox modes

### 2.1.5, 2016-03-14

* fixed: PHP warning on static member access
* fixed: use correct textdomain slug for loading translation strings
* fixed: Client Side Encryption works on form previews now too

### 2.1.4, 2016-02-24

* fixed: don't use Client-Side Encryption on Recurring Payments (even when not used conditionally!)
* changed: use normal text field for API password in settings (stop browsers hassling to remember the password)

### 2.1.3, 2016-02-15

* fixed: Client-Side Encryption is now used for one-off transactions on forms that conditionally use Recurring Payments
* changed: always send the customer IP in Rapid API transactions, for Beagle Lite support
* changed: only allow turning off Beagle Lite when using the legacy XML API (can't be disabled externally for Rapid API)

### 2.1.2, 2016-02-05

* fixed: "Are you sure you want to do this?" security message when trying to save a form confirmation

### 2.1.1, 2016-02-02

* added: partner ID sent to eWAY with payment requests (improved traceability)
* changed: some words on upgrade notices

### 2.1.0, 2016-02-01

* added: [support for eWAY Client Side Encryption](https://shop.webaware.com.au/gravity-forms-eway-client-side-encryption), allowing sites without PCI compliance to use Rapid 3.1 API

### 2.0.0, 2016-01-27

* changed: uses eWAY Rapid API if API key and password are set (not applicable for Recurring Payments)
* changed: minimum Gravity Forms version is now 1.9
* changed: currency is no longer limited to AUD
* changed: don't restrict credit cards, let user select; please review your forms after upgrading, and ensure that the correct credit cards are enabled in your forms
* changed: use WordPress post date format for recurring payments reported dates
* fixed: don't attempt to use real Customer ID for Recurring Payments sandbox (only 87654321 works)
* fixed: only need `gravityforms_edit_settings` to save eWAY settings
* added: strings are localized and ready for [translation](https://translate.wordpress.org/projects/wp-plugins/gravityforms-eway)!

### 1.8.0, 2015-06-20

* fixed: prevent conditional recurring payment fields from losing their default values
* fixed: register recurring field's "type" to avoid PHP notice "Deprecated button for the Recurring field"
* added: some precautionary XSS prevention
* changed: recurring start/end date can be hidden independently
* changed: trim credit card posted values before submitting to gateway
* changed: use Settings API for plugin settings
* changed: some code refactoring for easier maintenance

### 1.7.0, 2014-11-08

* fixed: Gravity Forms 1.9 compatibility
* added: custom entry meta `authcode` and `payment_gateway` which can be added to listings
* changed: cache result of `isEwayForm()` (may affect some hookers intercepting filter `gfeway_form_is_eway`)
* changed: some code cleanup
* changed: minimum requirements now WordPress 3.7, Gravity Forms 1.7

### 1.6.3, 2014-08-25

* added: filter `gfeway_form_is_eway` for telling Gravity Forms eWAY to ignore a form

### 1.6.2, 2014-08-15

* added: basic support for Gravity Forms Logging Add-On, to assist support requests; credit card numbers are obfuscated

### 1.6.1, 2014-06-25

* fixed: Gravity Forms 1.8.9 Payment Details box on entry details

### 1.6.0, 2014-06-07

* fixed: hidden products are now correctly handled
* fixed: shipping is now correctly handled
* fixed: RGFormsModel::update_lead() is deprecated in Gravity Forms v1.8.8
* changed: move authcode, beagle score into Gravity Forms 1.8.8 Payment Details box on entry details
* changed: merge template for payment amount is now formatted as currency
* changed: some code refactoring

### 1.5.12, 2014-05-14

* fixed: products with separate quantity fields fail

### 1.5.11, 2014-04-01

* fixed: load datepicker styling for Gravity Forms 1.8.6 when no other datepicker fields are present

### 1.5.10, 2014-01-18

* fixed: recurring payments failed on Windows hosting, no function strptime()
* fixed: should not be able to duplicate recurring payments field in form editor
* added: custom merge field for payment status

### 1.5.9, 2014-01-03

* fixed: a datepicker was being added to the bottom of the page since WordPress 3.8 (jQuery-UI bug on set datepicker options late)
* fixed: clean up JSHint warnings

### 1.5.8, 2013-11-10

* fixed: settings wouldn't save in WordPress multisite installations
* fixed: doco / settings page didn't explain that Beagle requires an Address field
* fixed: Beagle IP address 127.0.0.1 for form submitted on server (substitutes with an Australian IP address)
* changed: eWAY settings page is now a Gravity Forms settings subpage, like other addons

### 1.5.7, 2013-08-23

* fixed: a datepicker was being added to the bottom of the page when initial and start/end dates were hidden on recurring payments

### 1.5.6, 2013-08-19

* fixed: Gravity Forms 1.7.7 **changed their datepicker script handle** and broke recurring fields (not all change is good!)
* fixed: can now set Show Start/End Dates without Show Initial Amount

### 1.5.5, 2013-07-21

* fixed: can select currency for Gravity Forms for forms not using credit card field, but still enforces AUD for forms with credit card field
* fixed: nonce (number once) handling in settings admin
* added: load unminified script if SCRIPT_DEBUG is defined / true

### 1.5.4, 2013-04-21

* fixed: recurring payments fields marked "required" were generating error "This field is required"
* added: quarterly recurring time period

### 1.5.3, 2013-04-07

* fixed: don't squabble with other plugins (e.g. DPS PxPay) for custom merge tags of same name
* added: recurring payments can set customer reference and invoice reference independently, through the filters `gfeway_invoice_ref` and `gfeway_invoice_trans_number` respectively

### 1.5.2, 2013-03-19

* added: filter `gfeway_invoice_trans_number` for setting the invoice transaction reference (NB: 16 character limit)

### 1.5.1, 2013-02-14

* fixed: merge tags work on new notification emails, not just on resends!
* added: filter `gfeway_recurring_periods` for removing recurring payment periods, from `array('weekly', 'fortnightly', 'monthly', 'yearly')`

### 1.5.0, 2013-01-26

* added: support for [Beagle lite](https://eway.io/features/antifraud-beagle-lite) anti-fraud using geo-IP (Direct Payments only)
* added: record authcode for transactions, and show on entry details screen
* added: merge tags for authcode and beagle_score, for notification emails
* changed: use WordPress function wp_remote_post() instead of directly calling curl functions

### 1.4.1, 2013-01-17

* added: when entry is stored as 'Pending' for Stored Payment, can edit and change to 'Approved'
* added: record payment gateway in lead properties
* changed: Stored Payments use the Direct Payments sandbox when sandbox is selected

### 1.4.0, 2013-01-17

* added: can now use eWAY Stored Payments, e.g. for merchants who do drop-shipping
* added: merge tags for transaction_id and payment_amount, for notification emails

### 1.3.0, 2012-10-22

* fixed: can't submit form multiple times and get multiple payments
* added: can now customise the eWAY credit card error messages

### 1.2.2, 2012-10-03

* fixed: error when recurring field is present on form, but hidden (thanks, [Simon Watson](http://moonbuggymedia.com/)!)
* fixed: some undefined index PHP errors

### 1.2.1, 2012-10-02

* fixed: address on one-off eWAY invoice was getting "0, " prepended when PHP < 5.3
* fixed: address line 2 combined with line 1 when provided

### 1.2.0, 2012-09-21

* added: option to disable whether remote SSL certificate must be verified (only disable if your website can't be correctly configured!)
* added: prevent XML injection attacks when loading eWAY response (security hardening)
* added: recurring payments (sponsored by [Castle Design](http://castledesign.com.au/) -- thanks!)
* added: if a name field is added to the form, it will be used for the eWAY customer name (NB: not cardholder name)
* added: filter hooks for invoice description and reference

### 1.1.0, 2012-06-17

* added: options for extending use of eWAY sandbox (testing) environment capabilities
* added: more documentation (thanks, [gymbaroo.net.au](http://gymbaroo.net.au/) and samwoods!)

### 1.0.3, 2012-05-24

* fixed: don't show settings link if Gravity Forms is not installed and activated
* added: readme file makes it clear that this plugin requires Gravity Forms to be installed and activated

### 1.0.2, 2012-05-13

* fixed: correctly handle quantity for singleproduct fields
* fixed: don't validate or process credit card if credit card field is hidden (e.g. other payment option selected)
* fixed: form ID recorded in eWAY invoice reference field
* added: cardholder's name recorded in eWAY last name field (for reference on eWAY email notification)
* added: remove spaces/dashes from credit card numbers so that "valid" numbers can be passed to eWAY with spaces removed

### 1.0.1, 2012-05-05

* fixed: optional fields for address, email are no longer required for eWAY payment

### 1.0.0, 2012-04-16

* final cleanup and refactor for public release
