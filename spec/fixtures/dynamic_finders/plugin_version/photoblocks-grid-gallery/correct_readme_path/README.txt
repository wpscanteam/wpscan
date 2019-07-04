=== Gallery PhotoBlocks ===
Contributors: greentreelabs, freemius
Donate link: http://amzn.eu/5SP6qpj
Tags: gallery, grid gallery, best gallery plugin, free gallery, gallery plugin, gallery grid plugin, masonry, photo gallery, image gallery, social gallery, portfolio gallery, lightbox, justified gallery
Requires at least: 3.9
Tested up to: 5.1
License: GPLv2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html

Design your personal image gallery or photo gallery or even a portfolio using a handy builder. Add stunning effects 
to your grid and always justified galleries.

== Description ==

This is an image and photo gallery plugin perfect to make galleries with justified edges! 
You can zoom the images thanks to a fast lightbox. Add special effects to your grid gallery. 
Use our builder to create justified galleries.

= Drag and drop functionality =

https://www.youtube.com/watch?v=48lvo3GCkp8


= Handy builder =

**PhotoBlocks Grid Builder** is the stellar feature that makes PhotoBlocks special and different from other galleries.
With this tool you can design the layout of your gallery simply by dragging the images. You can make a gallery 
with images spanning on more columns or rows. 

= Features =

* Drag and drop builder to design custom layouts
* Pixel perfect justified gallery
* Lightbox to zoom photos
* Special effects on mouse hover
* Loading special effects
* Social sharing
* Captions with title and description
* Caption positioning
* Responsive and mobile ready
* SEO friendly
* Open videos on image click
* Open pages on image click
* Fast loading gallery
* Full width galleries
* Shuffle images
* Jetpack's Photon compatibility for high speed
* Post galleries (*premium feature*)
* CDN support for even faster image loading (*premium feature*)
* Text blocks (*premium feature*)
* Filters/Categories (*premium feature*)
* Additional hover effects (*premium feature*)
* Additional loading effects (*premium feature*)
* Additional captions layouts (*premium feature*)
* Handle shortcodes inside blocks (*premium feature*)

= Uses = 

* wedding album photo gallery
* designer portfolio photo gallery
* photography portfolio photo gallery
* products showcase photo gallery

== Installation ==

= For automatic installation: =

The simplest way to install is to click on 'Plugins' then 'Add' and type 'PhotoBlocks' in the search field.

= For manual installation 1: =

1. Login to your website and go to the Plugins section of your admin panel.
2. Click the Add New button.
3. Under Install Plugins, click the Upload link.
4. Select the plugin zip file (photoblocks.x.x.x.zip) from your computer then click the Install Now button.
5. You should see a message stating that the plugin was installed successfully.
6. Click the Activate Plugin link.

= For manual installation 2: =

1. You should have access to the server where WordPress is installed. If you don't, see your system administrator.
2. Copy the plugin zip file (photoblocks.x.x.x.zip) up to your server and unzip it somewhere on the file system.
3. Copy the "photoblocks" folder into the /wp-content/plugins directory of your WordPress installation.
4. Login to your website and go to the Plugins section of your admin panel.
5. Look for "PhotoBlocks" and click Activate.

== Frequently Asked Questions ==

= Images fail to loading

* Are you using Hostgator? Simply contact their support via phone or live chat to report mod security blockage. Send them the faulty link to a thumbnail.
* If you are not on Hostgator but getting 403 errors then try adding these lines to your .htaccess file in the WordPress installation folder. Revert the modification if it has no effect and contact the hosting's support.

<IfModule mod_security.c>
  SecFilterEngine Off
  SecFilterScanPOST Off
</IfModule>

* Are you on Bluehost's Optimized Hosting for WordPress? Make sure you turn off Varnish caching. It empties query strings.
* Open your .htaccess file and ensure you do not have this line in it:

php_value mbstring.func_overload 2

* Or something like this:

RewriteRule wp-content/plugins/(.*\.php)$ - [R=404,L]

* Make sure you have GD library. A possible error is "GD Library Error: imagecreatetruecolor does not exist - please contact your webhost and ask them to install the GD library".
* iThemes Security (formerly Better WP Security) settings > System Tweaks > Configure Settings > Disable PHP in Plugins â€“ Off. Also, System Tweaks > Filter Suspicious Query Strings â€“ Disable.
* Sucuri Security plugin > 1-Click Hardening â€“ Do not use it.
* WP All in ONE Security:  WP Security > Firewall > Additional Firewall Rules (tabs at top of page) > Bad Query Strings â€“ Untick.
AND/OR WP Security > Firewall > 6G Blacklist Firewall Rules (tabs at top of page) > Enable 6G Firewall Protection â€“ Untick.
* Hide My WP settings > General Settings > Exclude Files â€“ add this: wp-content/plugins/photoblocks-grid-gallery/public/timthumb.php


= The layout doesnt' look correct =

Check the console of the browser and look if you see errors, if case please open a support ticket in our forum.

= Can I import galleries from other plugins? =

Currently galleries made with Envira, FooGallery, Instagram, NextGen, JetPack, Modula, etc cannot be imported.

= How can I get support? =

* Get priority support with a [premium license](https://photoblocks.greentreelabs.net/pricing)

= How can I say thanks? =

* Just recommend our plugin to your friends! or
* Like and share our [Facebook page](https://www.facebook.com/greentreelabs "Facebook fan page")
* Or buy me a [present](http://amzn.eu/5SP6qpj)



== Changelog ==

= 1.1.40 =
* [Enhancement] Updated Freemius SDK
* [Enhancement] Pre-selected filters (Premium only)

= 1.1.39 =
* [Fix] Fixed disabled layout

= 1.1.36 =
* [Add] Mobile layouts (Premium only)

= 1.1.35 =
* [Enhancement] Enable image sizes for lightbox

= 1.1.34 =
* [Fix] Fixed missing file

= 1.1.33 =
* [Fix] Security fix

= 1.1.32 =
* [Enhancement] Lazy loading (Ultimate version only)

= 1.1.31 =
* [Enhancement] Execute shortcodes in titles and captions

= 1.1.30 =
* [Enhancement] New feature: choose image size (if you don't use the built-in resizer)

= 1.1.28 =
* [Fix] Fixed wrong layout issue

= 1.1.27 =
* [Fix] Fixed a bug preventing editing the galleries

= 1.1.26 =
* [Enhancement] Removed CSS conflict with some themes

= 1.1.25 =
* [Fix] Removed reference to unused script photoblocks.map.js

= 1.1.24 =
* [Fix] Fixed typo in code

= 1.1.23 =
* [Fix] Fixed wrong image sizing for portrait formats

= 1.1.22 =
* [Fix] Added support for PHP 5.3.x

= 1.1.21 =
* [Fix] Fixed blurry images on mobile

= 1.1.19 =
* [Enhancement] Enable or disable image resizing

= 1.1.18 =
* [Fix] Fixed compatibility with JetPack's photon

= 1.1.17 =
* [Enhancement] Renamed thumbnail handler for security reasons

= 1.1.16 =
* [Fix] Fixed bug of 1.1.15 (it's not a joke)

= 1.1.15 =
* [Fix] Fixed bug of 1.1.14

= 1.1.14 =
* [Fix] Fixed wrong calculation in stacked mode (mobile)

= 1.1.13 =
* [Fix] Fixed user capabilities

= 1.1.12 =
* [Enhancement] Using Packery for blocks placement
* [Enhancement] [Premium] Fixed bug in filters

= 1.1.11 =
* [Enhancement] Admin panel tweaks

= 1.1.10 =
* [Enhancement] Added cache check
* [Enhancement] Error message when trying to load an unknown gallery

= 1.1.9 =
* [Enhancement] Use image relative paths when needed

= 1.1.8 =
* [Enhancement] Added debug informations in timthumb

= 1.1.7 =
* [Enhancement] Added new setting in General > Image scale factor to render images more crispy

= 1.1.6.2 =
* [Fix] Fixed (yet) cropped images in lightbox

= 1.1.6.1 =
* [Fix] Fixed cropped images in lightbox

= 1.1.6 =
* [Fix] Fixed wrong lightbox image url
* [Enhancement] Tuned image resizer parameters

= 1.1.5 =
* [Add] Google Fonts (premium version)
* [Enhancement] Minor improvements
* [Fix] Fixed clone button

= 1.1.4 =
* [Fix] Fixed skipped columns or rows

= 1.1.3 =
* [Fix] Galleries with a lot of images are now correctly save (it requires deactivation and activation)
* [Add] Show database errors (if any)

= 1.1.2.1 =
* [Fix] Added missing file

= 1.1.2 =
* [Add] Debugging informations

= 1.1.1 =
* [Add] Select caption field to use with lightboxes

= 1.1.0 =
* [Add] Alt attribute for SEO
* [Add] Post galleries (premium)
* [Add] CDN support (premium)
* [Add] Troubleshooting page
* [Enhancement] Greatly improved drag and drop builder
* [Enhancement] Fixed image loading sequence

= 1.0.19 =
* [Enhancement] Greatly improved performances

= 1.0.18 =
* [Enhancement] Better support for themes with bundled lightboxes

= 1.0.17 = 
* [Fix] fixed error on activation

= 1.0.14 = 
* [Add] Helper grid as builder background
* [Add] Handle shortcodes inside blocks (Premium feature)

= 1.0.13 = 
* [Add] Copy captions when adding images
* [Add] New hover effect "Hidden captions"

= 1.0.12 = 
* [Fix] Fixed shuffle

= 1.0.11 = 
* [Fix] Fixed wrong image offset

= 1.0.10 = 
* [Add] New feature: shuffle images

= 1.0.9 = 
* [Fix] Fixed hidden galleries on mobile

= 1.0.8 = 
* Added survey

= 1.0.7 = 
* [Fix] Empty galleries are now correctly managed
* [Fix] Fixed some CSS conflicts

= 1.0.6 = 
* [Fix] Fixed drag issue with Firefox (admin panel)

= 1.0.5 = 
* [Fix] Fix for JetPack's Photon

= 1.0.4 = 
* [Enhancement] Added support JetPack's Photon
* [Enhancement] Added support for Altervista hosing

= 1.0.3 = 
* [Enhancement] Added support for PHP versions prior to 5.5

= 1.0.2 = 
* [Fix] Fixed bug preventing galleries loading correctly

= 1.0.1 = 
* [Fix] Fixed plugin URL

= 1.0.0 =
* First release!

== Upgrade Notice ==

= 1.1.35 =
* [Enhancement] Enable image sizes for lightbox

= 1.1.33 =
* [Fix] Security fix

= 1.1.24 =
* [Fix] Fixed typo in code

= 1.1.23 =
* [Fix] Fixed wrong image sizing for portrait formats

= 1.1.22 =
* [Fix] Added support for PHP 5.3.x

= 1.1.21 =
* [Fix] Fixed blurry images on mobile

= 1.1.19 =
* [Enhancement] Enable or disable image resizing

= 1.1.18 =
* [Fix] Fixed compatibility with JetPack's photon

= 1.1.16 =
* [Fix] Fixed bug of 1.1.15 (it's not a joke)

= 1.1.15 =
* [Fix] Fixed bug of 1.1.14

= 1.1.14 =
* [Fix] Fixed wrong calculation in stacked mode (mobile)

= 1.1.13 =
* [Fix] Fixed user capabilities

= 1.1.12 =
* [Enhancement] Using Packery for blocks placement
* [Enhancement] [Premium] Fixed bug in filters

= 1.1.11 =
* [Enhancement] Admin panel tweaks

= 1.1.10 =
* [Enhancement] Error message when trying to load an unknown gallery
* [Enhancement] Added cache check

= 1.1.9 =
* [Enhancement] Use image relative paths when needed

= 1.1.8 =
* [Enhancement] Added debug informations in timthumb

= 1.1.7 =
* [Enhancement] Added new setting in General > Image scale factor to render images more crispy

= 1.1.6.2 =
* [Fix] Fixed (yet) cropped images in lightbox

= 1.1.6.1 =
* [Fix] Fixed cropped images in lightbox

= 1.1.5 =
* [Add] Google Fonts (premium version)
* [Enhancement] Minor improvements
* [Fix] Fixed clone button

= 1.1.4 =
* [Fix] Fixed skipped columns or rows

= 1.1.3 =
* [Fix] Galleries with a lot of images are now correctly save (it requires deactivation and activation)
* [Add] Show database errors (if any)

= 1.1.2.1 =
* [Fix] Added missing file

= 1.1.2 =
* [Add] Debugging informations

= 1.1.1 =
* [Add] Select caption field to use with lightboxes

= 1.1.0 =
* [Add] Alt attribute for SEO
* [Add] Post galleries (premium)
* [Add] CDN support (premium)
* [Add] Troubleshooting page
* [Enhancement] Fixed image loading sequence
* [Enhancement] Greatly improved drag and drop builder

= 1.0.19 =
* [Enhancement] Greatly improved performances

= 1.0.18 =
* [Enhancement] Better support for themes with bundled lightboxes

= 1.0.14 =
* [Add] Helper grid as builder background

= 1.0.13 = 
* [Add] Copy captions when adding images
* [Add] New hover effect "Hidden captions"

= 1.0.12 = 
* [Fix] Fixed shuffle

= 1.0.11 = 
* [Fix] Fixed wrong image offset

= 1.0.10 = 
* [Add] New feature: shuffle images

= 1.0.9 = 
* [Fix] Fixed hidden galleries on mobile

= 1.0.8 = 
* Added survey

= 1.0.7 = 
* [Fix] Empty galleries are now correctly managed
* [Fix] Fixed some CSS conflicts

= 1.0.6 = 
* [Fix] Fixed drag issue with Firefox (admin panel)

= 1.0.5 = 
* [Fix] Fix for JetPack's Photon

= 1.0.4 = 
* [Enhancement] Added support JetPack's Photon
* [Enhancement] Added support for Altervista hosing

= 1.0.3 = 
* [Enhancement] Added support for PHP versions prior to 5.5

= 1.0.2 = 
* [Fix] Fixed bug preventing galleries loading correctly

= 1.0.0 =
PhotoBlocks first release!