# Changelog #

## 0.1.11 ## - *17-07-2018*

* Fixed a bug where the Popup could not be closed.

## 0.1.10 ## - *25-06-2018*

* Fixed a bug where shortcodes wouldn't create a conversation with user with certain id

## 0.1.9 ## - *19-03-2018*

* Fixed a bug where the notifications badge is always shown

## 0.1.8 ## - *19-03-2018*

* Fixed a bug where a "hidden" class was added to the menus when there is no logged in user

## 0.1.7 ## - *15-03-2018*

* Fixed a bug where auto show popup feature shows the current user to chat instead of the post author

## 0.1.6 ## - *13-03-2018*

* Support for older PHP versions, down to 5.3
* Fixed various bugs
* Use `display_name` instead of `user_nicename`

## 0.1.5 ## - *12-03-2018*

* Fixed a bug with setting user ID for chats

## 0.1.4 ## - *12-03-2018*

* Added property "loadOpen" for [talkjs_popup] shortcode
* Fixed PHP errors

## 0.1.3 ## - *12-03-2018*

* Updated README

## 0.1.2 ## - *09-03-2018*

* Adds `width`, `height` and `style` properties
* Fixes links

## 0.1.1 ## - *23-10-2017*

* Adds automatic Identity Validation
* Adds option to pass `topicId` and `subject` to \[talkjs_chat\], \[talkjs_inbox\], \[talkjs_popup\] shortcodes
* Removes Publishable Keys since they are deprecated

## 0.1.0 ## - *17-10-2017*

* First public release
* Adds \[talkjs_chat\], \[talkjs_inbox\], \[talkjs_popup\] shortcodes
* Adds a chatbox widget
* Adds template tags for talkjs_chat() talkjs_inbox() and talkjs_popup()
