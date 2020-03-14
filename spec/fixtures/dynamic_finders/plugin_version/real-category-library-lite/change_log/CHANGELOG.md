# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 3.2.9 (2020-03-13)


### build

* migrate real-category-library to monorepo (#3ugu6a)


### fix

* i18n is not correctly initialized





## 3.2.8 (2020-03-10)
* prepare for WordPress 5.4
* fix bug with quick edit after fast mode content
* fix bug with WooCommerce panel
* update links to devowl.io

## 3.2.7 (2019-11-07)
* fix drag&drop of categories now represents the correct order after movement
* fix bug with ReactJS v17 warnings in your console

## 3.2.6 (2019-10-04)
* fix bug with two instances of MobX loaded

## 3.2.5 (2019-08-20)
* improve experience when sorting post entries
* fix bug with sort mode in subcategories
* fix bug with search box height in some cases that it needed too much space

## 3.2.4 (2019-06-02)
* fix bug when copy post that it is draggable again

## 3.2.3 (2019-05-07)
* add "title" attribute to tree node for accessibility
* update to latest AIOT version

## 3.2.2 (2019-03-19)
* add button to expand/collapse all node items
* fix bug with style/script dependencies
* fix bug with missing animations
* improve performance: Loading a tree with 10,000 nodes in 1s (the old way in 30s)

## 3.2.1 (2018-12-10)
* add notice to the tree if the product is not yet registered

# 3.2.0 (2018-10-27)
* add auto update functionality
* fix bug with new created folders and droppable posts
* fix bug with WPML API requests

## 3.1.1 (2018-08-17)
* fix bug with relocating categories to a category with no childs yet

# 3.1.0 (2018-08-05)
* improve the custom order performance
* improve the way of handling custom order
* fix bug with mass categories
* fix bug with "Plain" permalink structure
* fix bug with collapsable/expandable folders

## 3.0.6 (2018-July-20)
* improve error handling with plugins like Clearfy
* fix bug with "&" in category names
* fix bug with PHP 5.3
* fix bug with non-SSL API root urls
* fix bug with pagination in list mode after switching folder
* fix bug with Gutenberg 3.1.x (https://git.io/f4SXU)

## 3.0.5 (2018-06-15)
* add compatibility with WP Dark Mode plugin
* add help message if WP REST API is not reachable through HTTP verbs
* fix bug with scroll container in media modal in IE/Edge/Firefox
* Use global WP REST API parameters instead of DELETE / PUT

## 3.0.4 (2018-06-4)
* fix bug with spinning loader when permalink structure is "Plain"
* fix bug with german translation
* fix bug with IE11/Edge browser

## 3.0.3 (2018-05-17)
* fix bug with WPML and fetching a tree from another language within admin dashboard

## 3.0.2 (2018-05-08)
* improve performance
* fix bug with switching from category to "All posts"
* add Mobx State Tree for frontend state management

## 3.0.1 (2018-03-09)
* fix bug with mobile devices

# 3.0.0 (2018-02-28)
* Complete code rewrite
* ... Same functionality with improved performance
* ... with an eye on smooth user interface and experience
* The plugin is now available in the following languages: English, German
* fix bug with WooCommerce 3.3.x product attributes
* Sidebar is now fully written in ReactJS v16
* The plugin is now bundled with webpack v3
* Minimum of PHP 5.3 required now (in each update you'll find v2.4 for PHP 5.0+ compatibility)
* Minimum of WordPress 4.4 required now (in each update you'll find v2.4 for 4.0+ compatibility)
* PHP Classes modernized with autoloading and namespaces
* WP REST API v2 for API programming, no longer use admin-ajax.php for your CRUD operations
* Implemented cachebuster to avoid cache problems
* ApiGen for PHP Documentation
* JSDoc for JavaScript Documentation
* apiDoc for API Documentation
* WP HookDoc for Filters & Actions Documentation
* Custom filters and actions which affected the tree ouput are now removed, you have to do this in JS now
* All JavaScript events / hooks are removed now - contact me so I can implement for you

# 2.4.0 (2018-01-16)
* add support for WooCommerce attributes (through an option)
* improve the tax switcher (when multiple category types are available)

## 2.3.2 (2017-11-24)
* fix bug with hidden sidebar without resized before
* add filter to hide category try for specific taxonomies (RCL/Available)

## 2.3.1 (2017-10-31)
* fix bug after creating a new post the nodes are not clickable
* fix bug when switching taxonomy when fast mode is deactivated

# 2.3.0 (2017-10-28)
* add ability to expand/collapse the complete sidebar by doubleclick the resize button
* fix bug with WooCommerce 3.x
* fix bug with touch devices (no dropdown was touchable)
* fix bug with ESC key in rename mode
* fix bug with creating a new folder and switch back to previous
* fix bug with taxonomy switcher (especially WooCommerce products)
* improve the save of localStorage items within one row per tree instance

## 2.2.1 (2017-09-22)
* improve the tax switcher when more than two taxonomies are available
* fix bug when switching to an taxonomy with no categories
* add new filter to disable RCL sorting mechanism

# 2.2.0 (2017-06-24)
* add full compatibility with WordPress 4.8
* add ESC to close the rename category action
* add F2 handler to rename a category
* add double click event to open category hierarchy
* add search input field for categories
* fix bug with some browsers when local storage is disabled

## 2.1.1 (2017-03-24)
* add https://matthias-web.com as author url
* improve the way of rearrange mode, the folders gets expand after 700ms of hover
* fix bug with > 600 categories
* fix bug with styles and scripts
* fix bug with rearrange

# 2.1.0 (2016-11-24)
* add new version of AIO tree view (1.3.1)
* add the MatthiasWeb promotion dialog
* add responsivness
* improve performance with lazy loading of categories
* improve changelog
* Use rootParentId in jQuery AIO tree
* fix bug with jQuery AIO tree version when RML is enabled

## 2.0.2 (2016-09-09)
* Conflict with jQuery.allInOneTree

## 2.0.1 (2016-09-02)
* add minified scripts and styles
* fix capability bug while logged out
* add Javascript polyfill's to avoid browser incompatibility
* fix bug for crashed safari browser
* fix bug with boolval function

# 2.0.0 (2016-08-08)
* add more userfriendly toolbar (ported from RML)
* add fixed header
* add "fast mode" for switching between taxonomies without page reload
* add "fast mode" for switching between categories without page reload
* add "fast mode" for switching between pages without page reload
* add taxonomy to pages
* add custom order for taxonomies
* add new advertisment system for MatthiasWeb
* Complete recode of PHP and Javascript

## 1.1.1 (2016-01-20)
* add facebook advert on plugin activation
* fix count of categories

# 1.1.0 (2015-11-28)
* fix conditional tag to create / sort items
* fix hierarchical read of categories
* fix append method with CTRL - now tap and hold any key to append

## 1.0.2 (2015-11-13)
* remove unnecessary code
* fix jquery conflict

## 1.0.1 (2015-11-10)
* fix javascript error for firefox, ie and opera

# 1.0.0 (2015-11-08)
* initial Release
