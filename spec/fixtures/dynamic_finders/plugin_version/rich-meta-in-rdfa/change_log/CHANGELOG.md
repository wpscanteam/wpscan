# Changelog
All notable changes to the Rich Meta in RDFa plugin will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.2.4] - 2019-03-25
- Testing done for WordPress v5.x (up to v5.1.1)

## [1.2.3] - 2019-02-21
- Fix bug that adds an empty space before the dc:title

## [1.2.2] - 2019-02-21
- The title of each post is now preceded by a mention (if filled) editable in the settings page

## [1.2.1] - 2019-02-07
- The sitemap rich-meta-in-rdfa.xml was wrong on websites using permalink with full name of the post6, instead of ones 
with identifiers

## [1.2.0] - 2019-01-31
- A special sitemap can now be created to provide all posts of WP, their URL and Last modification date, this is
available in the option of the tool

## [1.1.0] - 2018-10-01
### Changed
- The metadata is not anymore in the header part of the HTML but in the beginning of the post and inside an hidden 
div instead of meta elements

## [1.0.0] - 2018-07-24
### Added
- An admin has possibility to hide 2 link elements in the header because of some rel attribute that do not pass 
validation on ISIDORE (view plugin settings) 
- 9 Dublin Core elements are used statically (dc:title is WP Post title, etc...)
- First version with no administration panel for Dublin Core elements yet
