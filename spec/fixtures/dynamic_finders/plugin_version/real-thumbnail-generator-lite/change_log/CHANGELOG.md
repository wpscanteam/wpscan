# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2.0.8 (2020-02-27)


### docs

* CHANGELOG and README





## 2.0.7 (2020-02-26)


### fix

* compatibility running Real Media Library and Real Thumbnail Generator together (hotfix)





## 2.0.6 (2020-02-26)


### build

* add exclude-from-classmap for freemium package (#3rgyt1)
* asset is not correctly enqueued (#3rgyt1)
* migrate real-thumbnail-generator to monorepo
* prepare lite version for further usage (#3rgyt1)


### docs

* exclude-from-classmap (#3rgyt1)


### fix

* make more compatible with WP 5.3 (#3upazm)
* only this sizes works now as expected (#3upazm)
* thumbnails are now correctly deleted in wp-content/uploads (#3upazm)
* update urls to devowl.io (#3rgyt1)





## 2.0.5 (2019-10-07)

* fix bug with thumbnails path when using %size-identifier%
* fix bug with 503er server errors and retry regenerate again

## 2.0.4 (2019-08-21)

* add search by filename in Analyse / Regenerate tab
* fix bug with WooCommerce thumbnails and custom cropping
* improve error handling so the process does not stop when an error occurs
* improve performance by only loading images when hovering in analyse item
* improve performance by list virtualization
* improve height of opened analyse dialog

## 2.0.3 (2019-08-09)

* fix bug with page reload in "Edit attachment" page
* fix bug while error is logged when opening an attachment in the dialog
* fix bug when attachment is deleted and shows still as "Unused"
* improve regeneration list that now all items are clickable
* released lite version

## 2.0.2 (2019-03-19)

* fix bug with style/script dependencies

## 2.0.1 (2019-02-21)

* the plugin is now fully compatible with Crop-Thumbnails plugin
* fix bug with Internet Explorer
* fix bug with icons
* fix bug with PDFs

# 2.0.0 (2019-02-15)

* complete code rewrite, same functionality with improve performance, with an eye on smooth user interface and experience
* add option to skip existing thumbnail files
* add autoupdater functionality in Plugins > "License settings"
* add checbox to select / deselect all registered thumbnail sizes
* fix bug with generation of single thumbnail sizes
* fix compatibility with Simple Matted Thumbnails
* fix compatibility with EWWW Image Optimizer
* improve performance and usability

## 1.1.7 (2018-03-23)

* add "Regenerate" button to PDF files in list view
* fix bug with PDF thumbnails while getting "-1" prefix

## 1.1.6 (2018-03-22)

* fix bug with PDF generation in thumbnail folders
* fix bug with deletion of old thumbnails when changing the thumbnails schema
* fix bug with deletion of empty thumbnail folders

## 1.1.5 (2017-10-10)

* fix bug with duplicate info containers about thumbnails

## 1.1.4 (2017-05-25)

* add option to set a chunk size for regeneration

## 1.1.3 (2017-04-14)

* fix bug with SVG images

## 1.1.2 (2017-03-17) #

* fix bug with AJAX Search Pro
* fix bug with Facebook hint in plugins site

## 1.1.1 (2017-01-04)

* fix bug with failed thumbnail sizes
* fix bug with .txt upload
* fix bug with regenerating only a set of sizes

# 1.1.0 (2016-12-09)

* add ability to regenerate only specific image sizes
* fix bug with copped image sizes

## 1.0.1 (2016-11-29)

* add the MatthiasWeb promotion dialog

# 1.0 (2016-11-10)

* initial review
