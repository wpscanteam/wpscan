Complete Changelog
====

## 1.0
* First stable release.

### 1.1
* Fixed issues when showing multiple slideshows on the one page.
* Fixed issue where Flash player would set all the stages to have a transparent background.
* Cleaned up code.
* Updated readme.txt and embed dialog box. 

## 2.0
* Added AirPlay compatibility
* New settings page that allows customization of the player
* New letter- or pillar- box grid layout

### 2.0.1
* Fixed a bug where entering an RSS that started with 'feed://' gave an error.
* Fixed a bug where thumbnails in a grid layout didn't stack correctly.

### 2.0.2
* Fixed a bug which caused all "Settings" links on the Plugins page to link to players settings page.

### 2.0.3
* Updated readme.txt file.

## 2.1
* Added play button on HTML5 video.
* Added play.wdp and ended.wdp events to player.

### 2.1.1
* Bug fix.

### 2.1.2
* Fixed width/height bug.  Fixed credit list bug

## 2.2.0
* fixed bug where & characters in asset URLs were not being passed to flash correctly.
* fixed a bug when hidethumbs was enabled. tag wasn't closed properly.
* fix for html entities being displayed instead of applicable characters.
* removing poster element which caused a thumbnail bug when a video was played.
* fix for html entities being displayed instead of applicable characters.
* height/width resize fix. courtesy Visual23 - Robb Bennett (rbennett@visual23.com)
* removing poster element which caused a thumbnail bug when a video was played
* renamed files so they will work better with other plugins.  settings.php was conflicting with other plugins settings files in php5.2

### 2.2.1
* Fixed README layout issue with wordpress.org

### 2.2.2
* renamed README.txt to readme.txt for issue with wordpress.org
* Added GPLv2 license

### 2.2.3
* Bumping version to make wordpress.org behave

### 2.2.4
* Added poster image to html5 template

### 2.2.5
* Bugfix: Preventing slideshow instances from disappearing/reappearing and affecting other player instances in the same document

### 2.2.6
* Bugfix: Preventing HTML5 player from resizing incorrectly after switching to the next video

## 3.0b1
* Player now properly supports multiple instances on a single page
* Presentation data is now recieved as JSONP
* Player can now display both images and videos as part of the same presentation
* Now accepts any valid (non password protected) Wiredrive presentation url (short link, mRSS, email, etc.)
* Grid and Grid-Box themes have been replaced by the Gallery theme
* Player can now loop entire presentations
* Slideshow functionality can now be controlled via on hover play/pause buttons
* Duration between slideshows is now customizable
* Number of credits being displayed is now customizable
* Added option to choose whether or not the credit label is displayed with each credit
* Gallery thumbnails can now be either constrained to fit within the thumbnail bounding box (Scale) or the bounding box can be used as a cropping mask for the thumbnail (Crop)
* Gallery players can now specify a linebreak, that is how many thumbnails will be rendered before the next thumbnail is forced to the line below
* Bugfix: Flash volume slider now works (Open Video Player has been replaced with Adobe Strobe)

### 3.0b2
* proxy calls to retrieve a presentation url can now only be made by authenticated WordPress admins
* Removed all PHP short tags
* Fixed video poster image justification
* Pagination arrows now only appear if there is more than one asset in the presentation
* A presentation with no viewable assets now renders out an error message in place of the player. It no longer generates JavaScript errors.
* Added loading indicator to post Dialog window on submit.

## 3.0
* Video poster images now use the largest thumbnail
* Overlay pagination arrows should no longer be visible on iPad 1
* Bugfix: If a presentation contains both images and videos, set to slideshow, no autoplay, and the first asset is a video, the slideshow button no longer conflicts with the play button.
* Bugfix: HTML5 - Image viewer no longer visible at init if first asset is video (regression: lead to rendering errors)
* Bugfix: HTML5 Gallery thumbnails now play the correct video.
* Bugfix: Setting the credit count to 0 now behaves correctly

### 3.0.1
* Bugfix: Moved player strategy logic to JavaScript from PHP to address (issue 34)[https://github.com/wiredrive/wiredrive-player/issues/34]

### 3.0.2
* Bugfix: Updated to fix admin style issues with WordPress 6
* Bugfix: If Flash fails to load a video, it no longer prevents you from loading another video

### 3.0.3
* Fixed bug in IE11 that prevented some videos in the gallery modal from scaling correctly, causing the video player to scale to 0x0.

### 3.1.0
* Switched to HTML5 video player by default
