# Changelog

## 0.2.7
_Release Date: 2016-04-10_

* [FIX] Wrong enclosure type were used in podcast feed if URL had GET parameters.

## 0.2.6
_Release Date: 2016-03-03_

* [HOTFIX] Add iTunes explicit tag to feed. Feeds were rejected without it
* [UPDATE] Use cover art of show for episodes if not cover art is set for it
* [UPDATE] Activate comments for episodes. I really have no idea why this this was not activated `¯\_(ツ)_/¯`

Thx to all how reported the missing explicit tag.

## 0.2.5
_Release Date: 2015-12-10_

* [HOTFIX] Fix issue with term_meta in WP 4.4

## 0.2.4
_Release Date: 2015-10-22_

* [HOTFIX] Allow loading custom styles and scripts via HTTPS. props @noelboss

## 0.2.3
_Release Date: 2015-08-08_

* [ADD] There exists now a Dicentis Slack Channel: http://slack.dicentis.io
* [FIX] All shows (i.e. also empty shows) are shown in dashboard. (#16)
* [FIX] Now feed link is shown if no show exists
* [UPDATE] Init composer project
* [UPDATE] Start using Travis CI and Unit Tests
* [UPDATE] Add Dicentis Icon Font and use new Logo for CPT
* [REMOVE] Remove TGM Plugin dependency
* [TEST] Add Test to check if Icon Font is enqueued properly

## 0.2.2
_Release Date: 2014-11-16_

* [FIX] Warning during `join` operation. Fix #13 thx @pierreberchtold
* [UPDATE] This version introduces show specific settings
* [UPDATE] Audio and / or Video player are added to content
* [UPDATE] If JS: Show dropdown to download mediafiles
* [UPDATE] If no JS: Download links for files are displayed
* [FICTION] Superman is now using Dicentis Podcast to broadcast his superhero stories

## 0.2.1
_Release Date: 2014-10-05_

* [FIX] Cover Art Image URL
* [UPDATE] If no cover art is given a placeholder cover art is used
* [UPDATE] Some <itunes> tags in feeds are using CDATA now
* [UPDATE] If no duration is given <itunes:duration> tag is left out

## 0.2.0 (Brass Monkey)
_Release Date: 2014-07-26_

* [UPDATE] new Dashboard with more useful information and a feed generator which gives you the correct feed you need
* [UPDATE] complete restructured plugin with a better OOP approach

## 0.1.3
_Release Date: 2014-06-29_

* [FIX] Revert changes. Fix from 0.1.2 cause more trouble than it solve -.-

## 0.1.2
_Release Date: 2014-06-29_

* [FIX] Redirect `/podcasts/` to a page and not to archive if a page with that slug exists

## 0.1.1
_Release Date: 2014-06-28_

* [FEATURE] Feeds for file extentions are available
	* Example: http://www.your-domain.com/podcasts/feed/mp3
* [FEATURE] Copyright is added to feed and buttons for icons on settings page
* [UPDATE] Dicentis DB-Version added to DB
* [FIX] Fix CSS for metabox

## 0.1.0 (Bloody Mary)
_Release Date: 2014-06-01_

* [FEATURE] Create multiple podcast shows
* [FEATURE] Create multiple speaker
* [FEATURE] Create multiple series
* [FEATURE] Add global iTunes information to your feed
* [FEATURE] Add multiple media files to one episode
* [FEATURE] Import existing Podcast Feeds
