## [3.0.5](https://github.com/conekta/conekta-woocommerce/releases/tag/v3.0.5) - 2018-07-17
## Feature
- Force TLS V1.2 protocol

## [3.0.4](https://github.com/conekta/conekta-woocommerce/releases/tag/v3.0.4) - 2018-04-11
## Fix
- Fix token already used

## [3.0.3](https://github.com/conekta/conekta-woocommerce/releases/tag/v3.0.3) - 2017-11-30
## Feature
- Adding support to PHP 7.0

## [3.0.2](https://github.com/conekta/conekta-woocommerce/releases/tag/v3.0.2) - 2017-11-30
## Feature
- Custom instructions and description for Oxxo and Spei payment

## Fix
- Order info in email templates

## [3.0.1](https://github.com/conekta/conekta-woocommerce/releases/tag/v3.0.1) - 2017-09-09
## Changed
- Bundle CA Root Certificates

## [3.0.0](https://github.com/conekta/conekta-woocommerce/releases/tag/v3.0.0) - 2017-08-21
## Feature
- Compatibility with WooCommerce 3
- Correction in access to order properties

## Notes
If you have WooCommerce 2.x, you can view this branch with latest stable version [2.0.14](https://github.com/conekta/conekta-woocommerce/tree/feature/woocommerce-2)

## [2.0.14](https://github.com/conekta/conekta-woocommerce/releases/tag/v2.0.14) - 2017-08-03
### Fix
- HotFix include email in order
- Error typo OXOO 

### Changed
- Bundle CA Root Certificates
- Update PHP Library


## [2.0.13](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.13) - 2017-07-13
### Feature
- Name the SPEI account owner in admin input section
- New marketplace review validations

## [2.0.12](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.12) - 2017-04-30
### Fix
- Send only integer values for round adjustment
### Feature
-Send current plugin version for line items tag

## [2.0.11](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.11) - 2017-03-16
###  Fix
-Fix for conflict with other plugins in checkout "`token_id` is required"

## [2.0.10](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.10) - 2017-03-16
### Fix
- Fix monthly installments

## [2.0.9](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.9) - 2017-03-10
### Fix
- Merge pull request #41 from conekta/fix/adjustment-description

## [2.0.8](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.8) - 2017-02-28
### Change
- Change name of translation inside comment

## [2.0.7](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.7) - 2017-02-28
### Fix
- Fix sku less than 0 characters

## [2.0.6](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.6) - 2017-02-28
### Fix
- Fix shipping for card and spei

## [2.0.5](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.5) - 2017-02-28
### Fix
- Merge pull request #36 from conekta/fix/shipping-contact
(fix shipping for virtual products)

## [2.0.4](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.4) - 2017-02-28
### Fix
- Fix shipping contact for non-physical products
- Don't send shipping contact incomplete

## [2.0.3](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.3) - 2017-02-26
### Fix
- Add soft validations in line items to make antifraud_info optional

## [2.0.2](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.2) - 2017-02-24
### Fix
- Adjust round for non-integer cents

## [2.0.1](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.1) - 2017-02-24
### Fix
- Discount coupons are working now
- Webhooks for cash and spei payment are working now

## [2.0.0](https://github.com/conekta/conekta-woocommerce/releases/tag/v.2.0.0) - 2017-02-23
### Fix 
- Fix shipping tax calculation
### Feature
- Add Oxxo Pay
### Remove
- Remove Banorte

## [1.0.1](https://github.com/conekta/conekta-woocommerce/releases/tag/v.1.0.1) - 2017-02-16
### Fix
- Merge pull request #27 from conekta/fix/last-api-update

## [1.0.0](https://github.com/conekta/conekta-woocommerce/releases/tag/v.1.0.0) - 2017-02-11
### Feature
- Add OxxoPay
### Fix
- Merge pull request #24 from conekta/enhancement/hide-methods-without-key
### Change
- Disable methods if no private key is set

## [0.4.4](https://github.com/conekta/conekta-woocommerce/releases/tag/v.1.0.0) - 2017-02-11
### Update
- Update README

## [0.4.3](https://github.com/conekta/conekta-woocommerce/releases/tag/v.0.4.3) - 2016-08-29
### Fix
- Fix email instructions

## [0.4.2](https://github.com/conekta/conekta-woocommerce/releases/tag/v.0.4.2) - 2016-08-15
### Fix
- Merge pull request #11 from conekta/dev
- Fix on webhook handlers

## [0.4.1](https://github.com/conekta/conekta-woocommerce/releases/tag/v.0.4.1) - 2016-08-02
### Feature
- Add translations to v0.4
- Update Readme

## [0.4.0](https://github.com/conekta/conekta-woocommerce/releases/tag/v.0.4.0) - 2016-07-29
### Fix
- Email notifications for offline payment methods
- Support locale option

## [0.3.0]() - 2016-03-31
### Feature
- Added Banorte CEP and SPEI

## [0.2.1]() - 2015-06-15
### Feature
- Added additional parameters required for more robust anti-fraude service for card payments

## [0.2.0]() - 2015-05-11
### Feature
- Added option for difered payments for 3, 6, and 12 months
- Enable or disable difered payments from the admin

## [0.1.1]() - 2014-09-01
### Feature
- Offline payments
- Barcode sent in mail and displayed in order the confirmation page
- Order Status changed dynamically once webhook is added in Conekta.io Account 

## [0.1.0]() - 2014-08-16
### Update
- Online payments
- Sandbox testing capability
- Option to save customer profile
- Card validation at Conekta's servers so you don't have to be PCI
- Client side validation for credit cards
