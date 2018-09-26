# SSL Insecure Content Fixer

## Changelog

### 2.5.0, 2017-11-23

* changed: .htaccess rules file for non-WP test script now supports Apache v2.4; thanks, [Andreas Schneider](https://github.com/cryptomilk)!
* added: option to only fix content resource links for the current website; thanks, [Luke Driscoll](https://github.com/ldriscoll)!
* added: support for KeyCDN https detection via the X-Forwarded-Scheme header

### 2.4.0, 2017-05-14

* fixed: don't capture content on admin pages when mode is Capture or Capture All
* added: filter `ssl_insecure_content_disable_capture` for disabling Capture mode on selected pages / scripts

### 2.3.0, 2017-05-01

* added: support for Windows Azure with ARR
* added: filter `ssl_insecure_content_domain_exclusions` for domains that can be excluded from content cleaning (ignored for enqueued scripts)

### 2.2.3, 2017-02-01

* fixed: breaks Visual Composer back end editing due to a regular expression problem (now you have two!)
* changed: Capture no longer captures AJAX requests; new mode Capture All introduced to capture AJAX requests too
* added: prerequisites check, to ensure that plugin can run successfully

### 2.2.2, 2017-01-21

* fixed: make protocol header tests case-insensitive (thanks, [waja](https://github.com/waja)!)
* added: support for Amazon CloudFront `CloudFront-Forwarded-Proto` header (thanks, [gmazovec](https://github.com/gmazovec)!)
* added: clean up responsive image srcset links to external images (WordPress already handles local images)

### 2.2.1, 2016-11-19

* fixed: improve accessibility of admin pages
* removed: update message display forced on multisite; just leave that for WordPress to handle (it does it so well)

### 2.2.0, 2016-09-09

* added: stop WooCommerce cached widgets from http showing on https
* added: fix Gravity Forms confirmation content

### 2.1.6, 2016-02-02

* fixed: malware warning with GOTMLS vulnerability scanner

### 2.1.5, 2015-12-12

* changed: remove some more clutter from server environment report in tests
* removed: translations no longer in zip file; now delivered automatically as language packs when required

### 2.1.4, 2015-10-24

* added: French translation (thanks, Houzepha Taheraly!)
* added: can define `SSLFIX_PLUGIN_NO_HTTPS_DETECT` in wp-config.php to prevent the proxy fix, e.g. to overcome plugin conflicts
* added: fix inline CSS background image rules, e.g. in Capture level
* added: indicate whether WordPress HTTPS detection is successful with tick/cross

### 2.1.3, 2015-10-05

* added: Chinese (simplified) translation (thanks, [漠伦](https://molun.net/)!)

### 2.1.2, 2015-09-05

* fixed: HTTPS detection for host 123-reg

### 2.1.1, 2015-08-11

* fixed: HTTPS detection doesn't work unless SSL Tests page was just visited
* added: show update notice on plugin admin page

### 2.1.0, 2015-07-30

* **SECURITY FIX**: restrict access to AJAX test script; don't disclose server environment with system information
* changed: always show server environment on test results
* added: Bulgarian translation (thanks, [Ivan Arnaudov](https://www.bvionline.eu/)!)
* added: .htaccess file for AJAX SSL Tests, fixes conflict with some security plugins

### 2.0.0, 2015-07-26

* changed: handle media loaded by calling `wp_get_attachment_image()`, `wp_get_attachment_image_src()`, etc. via AJAX
* changed: in multisite, test tools (and settings) are only available to super admins
* added: settings page for controlling behaviour
* added: Simple, Content, Widgets, Capture, and Off modes for fixes
* added: fix for [WooCommerce + Google Chrome HTTP_HTTPS bug](https://github.com/woothemes/woocommerce/issues/8479) (fixed in WooCommerce v2.3.13)
* added: load translation (if anyone fancies [supplying some](https://translate.wordpress.org/projects/wp-plugins/ssl-insecure-content-fixer)!)

### 1.8.0, 2014-02-02

* changed: use script/style source filters instead of iterating over script/style dependency objects
* changed: only handle links for `wp_get_attachment_image()`, `wp_get_attachment_image_src()`, etc. on front end (i.e. not in admin)
* changed: refactor for code simplification
* added: fix data returned from `wp_upload_dir()` (fixes Contact Form 7 CAPTCHA images)
* added: Tools menu link to `is_ssl()` test

### 1.7.1, 2013-03-13

* fixed: is_ssl() test checks to ensure test page was actually loaded via HTTPS

### 1.7.0, 2013-03-13

* added: simple test to see whether [is_ssl()](https://codex.wordpress.org/Function_Reference/is_ssl) is working, and try to diagnose when it isn't

### 1.6.0, 2013-01-05

* added: handle images and other media loaded by calling `wp_get_attachment_image()`, `wp_get_attachment_image_src()`, etc.

### 1.5.0, 2012-11-09

* added: handle properly enqueued admin stylesheets for admin over HTTPS

### 1.4.1, 2012-09-21

* fixed: handle uppercase links properly (i.e. HTTP://)

### 1.4.0, 2012-09-13

* added: fix for images loaded by [image-widget](https://wordpress.org/plugins/image-widget/)

### 1.3.0, 2012-07-22

* removed: fix for links-shortcode (fixed in v1.3)

### 1.2.0, 2012-07-21

* removed: fix for youtube-feeder (fixed in v2.0.0); NB: v2.0.0 of that plugin still loads Youtube videos over http, so you will still get insecure content errors on pages with embedded videos until plugin author applies a fix.

### 1.1.0, 2012-05-17

* added: fix for youtube-feeder stylesheet

### 1.0.0, 2012-04-19

* initial release
