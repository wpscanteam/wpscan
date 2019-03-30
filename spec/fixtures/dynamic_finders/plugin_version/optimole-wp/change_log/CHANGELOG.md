#### [Version 2.0.6](https://github.com/Codeinwp/optimole-wp/compare/v2.0.5...v2.0.6) (2019-03-29)

* **Bug Fixes**
   * adds compatibility with background images lazyload on Essential Grid plugin ([a73d1cd](https://github.com/Codeinwp/optimole-wp/commit/a73d1cd))
   * compatibility with Oxygen builder, removes image replacement in the editor ([015698d](https://github.com/Codeinwp/optimole-wp/commit/015698d))
   * compatibility with Woocommerce zoom image feature on product single pages ([4445d1e](https://github.com/Codeinwp/optimole-wp/commit/4445d1e))
   * compatibility with YITH WooCommerce Quick View plugin, replacing images returned by the ajax request, fix [#87](https://github.com/Codeinwp/optimole-wp/issues/87) ([60169b2](https://github.com/Codeinwp/optimole-wp/commit/60169b2))
   * cropping behaviour being inconsistent with due to variable reset in image parsing loop ([2b14e7c](https://github.com/Codeinwp/optimole-wp/commit/2b14e7c))
   * remove unnecessary variables in the rest request causing conflicts with redirection plugins ([68c04ee](https://github.com/Codeinwp/optimole-wp/commit/68c04ee))
   * Woocommerce image archive ratio, preserving cropping with Optimole images, fixes [#85](https://github.com/Codeinwp/optimole-wp/issues/85) ([a3a8504](https://github.com/Codeinwp/optimole-wp/commit/a3a8504))

* **Features**
   * adds refresh stats button, syncing user details with Optimole dashboard, fix [#83](https://github.com/Codeinwp/optimole-wp/issues/83) ([1461483](https://github.com/Codeinwp/optimole-wp/commit/1461483))

#### [Version 2.0.5](https://github.com/Codeinwp/optimole-wp/compare/v2.0.4...v2.0.5) (2019-03-25)

* **Bug Fixes**
   * adds compatibility with Jetelements Slider ([c9e518e](https://github.com/Codeinwp/optimole-wp/commit/c9e518e))
   * compatibility with Metaslider, adds full support for all slider types available ([a09d1fd](https://github.com/Codeinwp/optimole-wp/commit/a09d1fd))
   * compatibility with various themes logo markup based on the image url, removes the hook to theme_mods image replace ([34e0d85](https://github.com/Codeinwp/optimole-wp/commit/34e0d85))
   * disable image replacement when we are in the Beaver Builder editing mode ([239442f](https://github.com/Codeinwp/optimole-wp/commit/239442f))
   * image replacement on header tags which uses relative urls ([2caae7f](https://github.com/Codeinwp/optimole-wp/commit/2caae7f))
   * image replacement on json strings with html entities encoded, conflicting with  variation form Woocommerce fixes [#81](https://github.com/Codeinwp/optimole-wp/issues/81) ([2bae741](https://github.com/Codeinwp/optimole-wp/commit/2bae741))
   * lazyload animation conflict with initial image animation ([3a84250](https://github.com/Codeinwp/optimole-wp/commit/3a84250))
   * lazyload on image which uses relative urls ([4655994](https://github.com/Codeinwp/optimole-wp/commit/4655994))
   * lazyload placeholder replacement affecting non-src urls, improving compatibility with Woocommerce ([7e13a32](https://github.com/Codeinwp/optimole-wp/commit/7e13a32))
   * noscript image tag issue causing problems with too specific CSS selectors ([324effd](https://github.com/Codeinwp/optimole-wp/commit/324effd))
   * relative url image replacement conflicting with plugins like WPML ([7a47827](https://github.com/Codeinwp/optimole-wp/commit/7a47827))
   * thumbnails cropping mode not affecting the resulting optimole images ([0f6dacb](https://github.com/Codeinwp/optimole-wp/commit/0f6dacb))

* **Features**
   * adds constant to disable latest images area ([a5891b6](https://github.com/Codeinwp/optimole-wp/commit/a5891b6))
   * adds constant to switch on/off network based optimization ([1accde5](https://github.com/Codeinwp/optimole-wp/commit/1accde5))
   * adds full compatibility with Beaver Builder, processing images from the generated css ([2a17f30](https://github.com/Codeinwp/optimole-wp/commit/2a17f30))

#### [Version 2.0.4](https://github.com/Codeinwp/optimole-wp/compare/v2.0.3...v2.0.4) (2019-03-11)

* **Bug Fixes**
   * adds full compatibility with Envira gallery ([7fd618f](https://github.com/Codeinwp/optimole-wp/commit/7fd618f))
   * compatibility with Foogallery plugin when the gallery uses lazyload too ([67991dc](https://github.com/Codeinwp/optimole-wp/commit/67991dc))
   * compatibility with images which contains query arguments, causing broken image urls ([56108be](https://github.com/Codeinwp/optimole-wp/commit/56108be))
   * compatibility with relative image urls ([8089610](https://github.com/Codeinwp/optimole-wp/commit/8089610))
   * compatibility with Revolution slider, adds support for background images lazyload and exact match ([0bbd254](https://github.com/Codeinwp/optimole-wp/commit/0bbd254))
   * compatibility with shortcode ultimate plugin ([164ba35](https://github.com/Codeinwp/optimole-wp/commit/164ba35))
   * compatibility with Woocommerce, solving issue with zoom image on single product pages ([1692e2b](https://github.com/Codeinwp/optimole-wp/commit/1692e2b))
   * image replacement on WordPress REST api responses ([24d191b](https://github.com/Codeinwp/optimole-wp/commit/24d191b))
   * image url replacement on custom WordPress directory structure, fixes [#79](https://github.com/Codeinwp/optimole-wp/issues/79), thanks [@hackles](https://github.com/hackles) for reporting ([980fcef](https://github.com/Codeinwp/optimole-wp/commit/980fcef))

* **Features**
   * tested up compatibility with WordPress 5.1 ([12726b6](https://github.com/Codeinwp/optimole-wp/commit/12726b6))
   * **api:** adds filter for restricting watermark based on image source urls ([337d7fa](https://github.com/Codeinwp/optimole-wp/commit/337d7fa))
   * **api:** adds filter to disable image replacement on a specific page/ur ([3250a8d](https://github.com/Codeinwp/optimole-wp/commit/3250a8d))

#### [Version 2.0.3](https://github.com/Codeinwp/optimole-wp/compare/v2.0.2...v2.0.3) (2019-02-13)

* **Bug Fixes**
   * adds whitelisted websites among the image urls to replace ([bfb016e](https://github.com/Codeinwp/optimole-wp/commit/bfb016e))
   * allow image urls that does not contain scheme, either http or https ([2aae664](https://github.com/Codeinwp/optimole-wp/commit/2aae664))
   * anchor tags image replacement, conflicting with gallery plugins ( NextGen ) ([824acdc](https://github.com/Codeinwp/optimole-wp/commit/824acdc))
   * compatibility when jetpack photon is on, fetch directly the image source ([f339dbb](https://github.com/Codeinwp/optimole-wp/commit/f339dbb))
   * cropping behaviour when lazyload is off for certain edge causing incorrect image resize ([8aca6dc](https://github.com/Codeinwp/optimole-wp/commit/8aca6dc))
   * doubled image bug, detect if image tag has already lazyload applied and bail for Optimole lazyload ([bea5ac8](https://github.com/Codeinwp/optimole-wp/commit/bea5ac8))
   * image replacement on admin ajax requests ([924cc49](https://github.com/Codeinwp/optimole-wp/commit/924cc49))
   * image url replacement on non whitelisted urls ([8567f8b](https://github.com/Codeinwp/optimole-wp/commit/8567f8b))
   * JSON strings url replacement, improves elementor's compatibility ([2ff9e9b](https://github.com/Codeinwp/optimole-wp/commit/2ff9e9b))
   * lazyload replacement when image source is in data-src attributes, solving conflict with some gallery plugins ([c26cdab](https://github.com/Codeinwp/optimole-wp/commit/c26cdab))

* **Documentation**
   * adds faq for ajax content, remove lqip and fixed typo for plugin tags ([104a17e](https://github.com/Codeinwp/optimole-wp/commit/104a17e))

#### [2.0.2](https://github.com/Codeinwp/optimole-wp/compare/v2.0.1...v2.0.2) (2019-02-01)


**Bug Fixes**

* dashboard app loading issues for some wordpress environments ([293e277](https://github.com/Codeinwp/optimole-wp/commit/293e277))

* disable srcset attribute when the javascript resizer and lazyload is active, being redundant ([76c0307](https://github.com/Codeinwp/optimole-wp/commit/76c0307))

* domain validation when www is present in the image urls, thanks [@wpriders](https://github.com/wpriders) team for reporting ([9559ce5](https://github.com/Codeinwp/optimole-wp/commit/9559ce5))

* image resize when the size class is not available, get cropping based on the width/height of the resulting image ([e5c1aab](https://github.com/Codeinwp/optimole-wp/commit/e5c1aab))



**Documentation**

* improve readme description of the OptiMole service ([e020300](https://github.com/Codeinwp/optimole-wp/commit/e020300))



**Features**

* adds upgrade box and notice to upgrade when the user is close to the limit ([62b216a](https://github.com/Codeinwp/optimole-wp/commit/62b216a))

#### [2.0.1](https://github.com/Codeinwp/optimole-wp/compare/v2.0.0...v2.0.1) (2019-01-21)


**Bug Fixes**

* fix javascript library production url ([aed9433](https://github.com/Codeinwp/optimole-wp/commit/aed9433))

### [2.0.0](https://github.com/Codeinwp/optimole-wp/compare/v1.1.2...v2.0.0) (2019-01-21)


#### Bug Fixes

* errors on low PHP environments when PHP_INT_MIN constant is not available ([44eb4af](https://github.com/Codeinwp/optimole-wp/commit/44eb4af))

* fix tag replacement on lazy load, preserve image size when found ([5c6ef70](https://github.com/Codeinwp/optimole-wp/commit/5c6ef70))

* improve image size replacement mapping for custom image sizes ([d816ccb](https://github.com/Codeinwp/optimole-wp/commit/d816ccb))

* improve lazyload fade in effect, fixes [#71](https://github.com/Codeinwp/optimole-wp/issues/71) ([eb0f76c](https://github.com/Codeinwp/optimole-wp/commit/eb0f76c))

* possible issue with image replacement not taking place when other buffer handler is registered ([3ce600a](https://github.com/Codeinwp/optimole-wp/commit/3ce600a))

* resize behaviour for WordPress defined image sizes, preserve cropping for custom sizes ([a42f830](https://github.com/Codeinwp/optimole-wp/commit/a42f830))



#### Documentation

* add basic faq to readme file ([2c09d26](https://github.com/Codeinwp/optimole-wp/commit/2c09d26))

* adds contributor related docs and github templates ([c7bbce2](https://github.com/Codeinwp/optimole-wp/commit/c7bbce2))



#### Features

* adds new service schema ([330fba0](https://github.com/Codeinwp/optimole-wp/commit/330fba0))

* adds watermark integration along with various options for watermark position ([6a4538a](https://github.com/Codeinwp/optimole-wp/commit/6a4538a))

* deactivate plugin on lower php versions, adds notice for PHP for upgrade ([58d2607](https://github.com/Codeinwp/optimole-wp/commit/58d2607))



#### Performance Improvements

* improve srcset replacement, use attachement id when present ([5587221](https://github.com/Codeinwp/optimole-wp/commit/5587221))

* improve type casting on size constrain ([589b046](https://github.com/Codeinwp/optimole-wp/commit/589b046))

### v1.1.2 - 2018-12-24 
 **Changes:** 
 * Minor fixes to Optimole dashboard page.
* Fixes DNS prefetch call when lazyload is off.
* Enable lazyload and javascript replacement by default for new users.
 
 ### v1.1.1 - 2018-12-10 
 **Changes:** 
 * Improve the lazy loading mechanism and adds compatibility with the new javascript library. 
* Improve sample images and quality selector integration. 
* Adds a notice when the Rest API is not available. 
* Adds notice for new users on how the plugin works. 
* Tested up with WordPress 5.0, all working smooth. 
* Fix possible issues with thumbnails when the original image is available on a different url scheme.
* Ignore lazyload replacement on feed/amp pages.
 
 ### v1.1.0 - 2018-11-16 
 **Changes:** 
 * Integrates lazy load feature with support for low-quality placeholders ( LQIP ). 
* Integrates Javascript library which delivers images at the right size for each device, including Retina.
* Improve image replacement algorithm.
* Improves compatibility with Elementor and Gutenberg. 
* Adds support for Custom CNAME and Client hints.
* Improves support for custom CDN. 
* Improves AMP support. 
* Improves compatibility with WordPress Multisites.
 
 ### v1.0.5 - 2018-10-05 
 **Changes:** 
 * Adds max width/height option.
* Improves registration workflow.
* Adds image comparison slider ratio.
* Adds logo on link preload.
 
 ### v1.0.4 - 2018-10-03 
 **Changes:** 
 * Adds in-plugin service registration.
* Adds image quality control.
* Adds slider for image comparison.
* Improvements to UX and workflow.
 
 ### v1.0.3 - 2018-09-26 
 **Changes:** 
 * Adds redirect on first install.
 * Improve elementor assets replacement.
  
 ### v1.0.2 - 2018-09-25 
 **Changes:** 
 * Improve compatibility with elementor external css files.
* Adds generator tag.
* Improve replacer handler hook register.
 
 ### v1.0.1 - 2018-09-23 
 **Changes:** 
 * Tag first stable version for wordpress.org.
 
 ### v1.0.0 - 2018-09-11 
 **Changes:** 
   * First version of the plugin
