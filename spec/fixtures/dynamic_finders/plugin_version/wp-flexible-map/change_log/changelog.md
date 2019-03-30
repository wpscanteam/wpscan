# Flexible Map

## Changelog

### 1.17.0

Released 2018-11-19

* fixed: map tiles don't redraw for KML maps with zoom when hidden in a tab / accordion
* changed: use the [current quarterly (stable) version of the Google Maps API](https://developers.google.com/maps/documentation/javascript/versions)
* changed: remove support for ancient browsers (Opera 12, IE < 11)
* tested: WordPress 5.0 (no Gutenberg block yet; maybe next release!)

### 1.16.0

Released 2018-09-07

* added: setting that prevents the plugin from loading the Google Maps API; useful for preventing conflicts
* added: attribute [gesturehandling](https://flexible-map.webaware.net.au/manual/attribute-reference/#attr-gesturehandling) for smarter handling of the scroll wheel, drag to pan, double-click to zoom; default = cooperative
* deprecated: attributes `scrollwheel`, `draggable`, `dblclickzoom` are supported but not recommended; please use `gesturehandling` instead

### 1.15.0

Released 2018-07-21

* fixed: KML maps can now use the `center` attribute to set the map center
* changed: remember server-side address lookups for up to one month
* added: attribute `hidefullscreen` for hiding the full-screen control
* added: attribute `markeranimation` for setting how a single marker is added to the map - drop, bounce, none; defaults to drop

### 1.14.0

Released 2018-06-07

* added: server API key to reduce `REQUEST_DENIED` errors from server side address resolution requests
* changed: bump version of Google Maps API to 3.32

### 1.13.0

Released 2018-01-15

* changed: bump version of Google Maps API to 3.30

### 1.12.1

Released 2016-11-18

* changed: bump version of Google Maps API to 3.26

### 1.12.0

Released 2016-06-27

* added: support for [Google Maps API key](https://cloud.google.com/maps-platform/#get-started), required [since 2016-06-22 for new websites](https://googlegeodevelopers.blogspot.com.au/2016/06/building-for-scale-updates-to-google.html).

### 1.11.0

Released 2016-06-05

* fixed: monitor changes to invisible containers, not just non-displayed containers (thanks, [zetoun17](https://profiles.wordpress.org/zetoun17/)!)
* fixed: "FlexibleMap is not defined" error when `isajax="1"` used without calling `flexmap_load_scripts()` (per the [FAQ](https://wordpress.org/plugins/wp-flexible-map/faq/))
* added: ask [Autoptimize](https://wordpress.org/plugins/autoptimize/) to leave our inline script alone, to reduce the number of cached script files
* changed: use localisation from [translate.wordpress.org](https://translate.wordpress.org/projects/wp-plugins/wp-flexible-map) in preference to local plugin copy
* changed: translations updated from translate.wordpress.org
* changed: bump version of Google Maps API to 3.24

### 1.10.1

Released 2015-11-29

* fixed: NextGEN Gallery breaks localisation of maps by messing with order of `wp_print_footer_scripts` calls
* changed: Dutch translation updated / completed (thanks, [Chantal Coolsma](https://webpressed.nl/) and [TacoVerdo](https://profiles.wordpress.org/tacoverdo)!)
* changed: German translation updated / completed (thanks, [Dominik Schilling](https://dominikschilling.de/)!)
* changed: Norwegian Bokmål translation updated / completed (thanks, [neonnero](https://www.neonnero.com/)!)
* changed: translations now accepted on [translate.wordpress.org](https://translate.wordpress.org/projects/wp-plugins/wp-flexible-map)
* changed: Localisation (l10n) slug changed from `flexible-map` to `wp-flexible-map`, with move to translate.wordpress.org
* changed: bump version of Google Maps API to 3.22; NB: [control sizes have no effect with API v3.22](https://developers.google.com/maps/articles/v322-controls-diff)
* changed: removed "sensor" query parameter to Google Maps API; no longer required

### 1.10.0

Released 2015-08-23

* fixed: Brazilian Portuguese translation (thanks, Alexsandro Santos and Paulo Henrique!)
* fixed: JavaScript error on KML map marker click when marker has no description
* fixed: can show directions without having a marker title (or infowindow)
* added: `linktarget` attribute for changing where marker links open, e.g. `linktarget="_blank"`
* added: `linktext` attribute for changing marker link text
* added: `dirunitsystem` attribute for forcing directions units to metric or imperial
* added: `dirtravelmode` attribute for selecting directions by driving, bicycling, walking, or transit
* changed: bump version of Google Maps API to 3.20
* changed: always load Google Maps API on HTTPS

### 1.9.2

Released 2015-03-21

* fixed: sometimes vertical copyright message on IE8 with some themes
* changed: bump version of Google Maps API to 3.19 (resolves some Safari styling issues)

### 1.9.1

Released 2014-12-29

* fixed: zoom control styling / hiding was broken in v1.9.0

### 1.9.0

Released 2014-12-24

* fixed: maps broken when hidden in tabs / accordions (not for IE 10 and earlier; uses MutationObserver)
* fixed: strip spaces from map coordinates
* fixed: suppress border radius on images within map containers
* added: server-side lookup of address, to reduce the number of Google Maps queries when only an address is given
* added: support for custom map types (inc. styled maps)
* added: `maptypes` attribute for selecting which map types can be picked by visitors
* changed: refactored JavaScript for localised strings

### 1.8.3

Released 2014-12-17

* fixed: CSS for directions in twentyfifteen theme and others that toss table-layout:fixed around willy nilly

### 1.8.2

Released 2014-12-06

* added: Welsh translation (thanks, [Dylan](https://profiles.wordpress.org/dtom-ct-wp/)!)

### 1.8.1

Released 2014-10-05

* fixed: Hungarian translation (thanks, Krisztián Vörös!)
* changed: bump version of Google Maps API to 3.17

### 1.8.0

Released 2014-08-31

* fixed: Czech translation (thanks, [caslavak](https://profiles.wordpress.org/caslavak/)!)
* fixed: Norwegian translations (thanks, [neonnero](https://www.neonnero.com/)!)
* changed: localisation uses standard .mo files now; if you'd like to help translate, please [sign up for an account and dig in](https://translate.wordpress.org/projects/wp-plugins/wp-flexible-map).

### 1.7.3.1

Released 2014-03-22

* fixed: infowindow width on some Webkit browsers, and IE10/11

### 1.7.3

Released 2014-03-16

* fixed: German translation (thanks, [Carib Design](https://www.caribdesign.com/)!)
* fixed: some themes (e.g. Evolve) mess up Google Maps directions markers
* fixed: CSS for infowindows with Google Maps Visual Refresh / API v3.15
* changed: removed instructions page, better handled by new homepage for plugin
* changed: bump version of Google Maps API to 3.15
* added: KML cache buster attribute `kmlcache`, for dynamically created KML maps
* added: WordPress filter `flexmap_shortcode_script`
* removed: `visualrefresh` attribute doesn't do anything any more (Google Maps API has adopted Visual Refresh as standard)

### 1.7.2

Released 2014-01-01

* fixed: Spanish translation (thanks, [edurramos](https://profiles.wordpress.org/edurramos/)!)
* fixed: clean up JSHint warnings
* changed: Slovenian translation refresh from Google Translate (human translators wanted!)
* changed: plugin homepage, better documentation and examples, will develop as time permits!

### 1.7.1

Released 2013-10-13

* fixed: Google link was showing marker at centre, not at marker location when marker != centre

### 1.7.0

Released 2013-10-12

* fixed: Greek translation (thanks, [Pantelis Orfanos](https://profiles.wordpress.org/ironwiller/)!)
* fixed: Dutch translation (thanks, [Ivan Beemster](https://lijndiensten.com/)!)
* fixed: KML map zoom sometimes doesn't happen on first page visit
* fixed: some themes (e.g. twentythirteen) mess up Google Maps directions markers
* fixed: Google link opens maps without marker (NB: <= IE8 not supported)
* added: `dirshowsteps` attribute, to allow directions steps (i.e. turn-by-turn steps) to be turned off
* added: `dirshowssearch` attribute, to allow directions search form to be turned off
* added: `zoomstyle` attribute, to allow large or small zoom controls
* added: `visualrefresh` attribute, to enable [visual refresh](https://developers.google.com/maps/documentation/javascript/basics#VisualRefresh) for all maps on the page
* added: default CSS sets info window text color to #333
* changed: bump version of Google Maps API to 3.13

### 1.6.5

Released 2013-07-19

* fixed: stop twentythirteen theme stuffing up Google Maps infowindows with its too-promiscuous box-sizing rules
* added: `dirdraggable` and `dirnomarkers` attributes

### 1.6.4

Released 2013-06-14

* fixed: can set directions=false and showdirections=true
* fixed: space before colon in fr translation (thanks, [mister klucha](https://wordpress.org/support/profile/mister-klucha)!)
* added: load unminified script if SCRIPT_DEBUG is defined / true
* changed: clicking directions link sets focus on From: address again
* changed: bump version of Google Maps API to 3.12

### 1.6.3

Released 2013-03-14

* fixed: HTML description now works for address-based maps (thanks, [John Sundberg](https://profiles.wordpress.org/bhwebworks/)!)

### 1.6.2

Released 2013-03-04

* fixed: CSS fix for themes that muck up Google Maps images by specifying background colour on images without being selective
* added: icon attribute to set marker icon on centre / address maps

### 1.6.1

Released 2013-01-29

* fixed: infowindow auto-pans on load, to prevent the top of the bubble being cropped
* added: WordPress filter `flexmap_google_maps_api_args` for filtering array of arguments before building Google Maps API URL
* added: function flexmap_show_map() accepts an attribute "echo", and returns a string without output to screen when "echo"=>"false"
* changed: all scripts now loaded through wp_enqueue_scripts, including language scripts (thanks to a [tip from toscho](https://wordpress.stackexchange.com/a/38335/24260))
* changed: bump version of Google Maps API to 3.11

### 1.6.0

Released 2012-12-30

* added: themes can call function flexmap_load_scripts() to force load of scripts, e.g. on single-page AJAX websites
* added: can add HTML block to infowindow, e.g. images
* fixed: no auto-focus on directions search field, thus no auto-scroll page to last directions search field!

### 1.5.3

Released 2012-11-30

* fixed: when attributes showdirections or directionsfrom were specified, but not directions, the directions panel was not added to page and a JavaScript error was generated
* changed: bump version of Google Maps API to 3.10

### 1.5.2

Released 2012-10-12

* fixed: KML maps broken; KMLLayer status_changed event unreliable, use defaultviewport_changed event instead (possible Google Maps API change)

### 1.5.1

Released 2012-09-30

* changed: tighten up FlexibleMap API to keep private members private (in case they change later)

### 1.5.0

Released 2012-09-29

* added: new shortcode attribute "id" which will be used for the container div, instead of the random unique div id
* added: FlexibleMap object is accessible via global variable with name derived from container div id (e.g. if you need to access the Google Maps map object in your own scripts)
* added: redraw() and redrawOnce() methods, for when the map needs to be redrawn correctly (e.g. when initially hidden then revealed)
* added: KML maps support directions (sponsored by [Roger Los](http://www.rogerlos.com/) -- thanks!)

### 1.4.1

Released 2012-09-11

* fixed: targetfix was not stopping KML marker links opening in new window/tab since Google Maps API 3.9

### 1.4.0

Released 2012-08-22

* changed: bump version of Google Maps API to 3.9
* added: allow CSS units in ch, rem, vh, vw, vmin, vmax

### 1.3.1

Released 2012-07-13

* fixed: width/height in digits (no units) defaults to pixels (sorry folks, I thought I tested that, but missed it somehow!)

### 1.3.0

Released 2012-07-12

* fixed: Norwegian translation had incorrect file name
* fixed: Malaysian translation had incorrect index (was overwriting Macedonian translation)
* added: filters so that theme and plugin developers can modify the behaviour of this plugin
* added: width and height can be any valid CSS units, not just pixels

### 1.2.0

Released 2012-06-29

* added: option showdirections, to show the directions search when the map loads
* added: option directionsfrom, to set the default from: location, and immediately search for directions when showdirections is set

### 1.1.2

Released 2012-05-20

* fixed: some themes set box-shadow on all images, now forceably fixed for Google Maps images
* added: option to control whether links on KML maps open in new window

### 1.1.1

Released 2012-04-15

* fixed: instructions updated to reflect recent changes

### 1.1.0

Released 2012-04-15

* added: locale-specific messages (using translations from Google Translate) e.g. Directions link
* wanted: translators to help me add new translations, and clean up the messages I got from Google Translate!
* fixed: use region to help refine street address searches

### 1.0.6

Released 2012-04-06

* fixed: use plugin_dir_url() to get url base, and protocol-relative url to load Google Maps API (SSL compatible)

### 1.0.5

Released 2012-03-17

* fixed: CSS fixes for themes that muck up Google Maps images (e.g. twentyeleven)
* added: infowindow styles now in enqueued stylesheet

### 1.0.4

Released 2012-03-06

* fixed: use LatLng methods to access latitude/longitude, instead of (ever changing) Google Maps API private members
* added: tooltip on markers in non-KML maps
* added: options to disable pan control, zoom control, drag to pan, double-click to zoom

### 1.0.3

Released 2012-02-27

* fixed: address query updated to work with Google Maps v3.8 (so using address for centre marker works again)
* fixed: tied Google Maps API to v3.8 so newer versions don't break plugin, and will keep updated as API changes

### 1.0.2

Released 2012-02-04

* added: address attribute as alternative to center coordinates
* added: use address attribute for directions, if given (so that directions match address)
* changed: readme improved a little
* changed: refactored code for DRY (don't repeat yourself)

### 1.0.1

Released 2012-01-26

* fixed: directions bugs in JavaScript for Opera, IE

### 1.0.0

Released 2012-01-08

* final cleanup for public release
