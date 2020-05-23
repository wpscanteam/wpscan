# v2.6.1 (May 19, 2020)
* New: Wordpress Plugin available on [store](https://wordpress.org/plugins/last-9-photos-webcomponent/).

[![](https://img.shields.io/badge/donate-paypal-005EA6.svg?logo=paypal)](https://www.paypal.me/ptkdev) [![](https://img.shields.io/badge/donate-patreon-F87668.svg?logo=patreon)](https://www.patreon.com/ptkdev) [![](https://img.shields.io/badge/donate-sponsors-ea4aaa.svg?logo=github)](https://github.com/sponsors/ptkdev/)  [![](https://img.shields.io/badge/donate-ko--fi-29abe0.svg?logo=ko-fi)](https://ko-fi.com/ptkdev)


# v2.6.0 (May 18, 2020)
* Feature: Overwrite CSS Style with selector `::part`
* New attribute: mouse-hover
* New attribute: show-title
* New attribute: shadows
* Fix: Wordpress Plugin

# v2.5.0 (May 04, 2020)
* Fix: now you can use multiple webcomponents in the same html page (#3)
* NOTE: better to use the full close tag `<instagram-widget></instagram-widget>` than short `/>`

# v2.4.0 (May 02, 2020)
* New attribute: `force-square`
* Feature: wordpress-plugin

# v2.3.0 (May 01, 2020)
* Fix: `border-corners` and `border-spacing` now work without `grid` attribute.
* Fix: NPM Module give errors with require/import
* Update: examples

# v2.2.0 (April 30, 2020)
* Fix: `grid` now is more responsive (now use `calc()` function: `100%` - `spacing/padding/margin`)
* Fix: default values now work (hello object reference my old dark friend)

# v2.1.1 (April 28, 2020)
* New attribute: cache
* New attribute: border-corners
* New attribute: border-spacing
* Performance: now component send api request only if you change `username`
* Fix: refresh attributes random don't work

# v2.0.0 (April 28, 2020)
* Removed "ptkdev-" prefix
* Module for Browserify/Webpack (run: `npm install @ptkdev/webcomponent-instagram-widget`)
* Fix: Grid bug
* Installation guidelines: Browserify / Webpack / ReactJS / Angular / Wordpress

# v1.1.1 (April 27, 2020)
* Update CDN (New url!)
* Update build/dist

# v1.1.0 (April 27, 2020)
* New attribute: items-limit
* New attribute: grid
* New attribute: image-width / image-height

# v1.0.1 (April 26, 2020)
* Update CDN

# v1.0.0 (April 26, 2020)
* First Release.