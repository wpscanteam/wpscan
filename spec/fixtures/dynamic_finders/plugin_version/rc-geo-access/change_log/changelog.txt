# Changelog 

## 1.42

- Changed IPStack API url call to use plain HTTP as free accounts don't support SSL requests. Added related error code notification.

## 1.41

- Prevented "Settings" link from appearing in Network Plugins page on Multisite installation.

## 1.4

- Added plugin activation check to see if the plugin has been previously activated and had its restriction function enabled to prevent users from potentially being locked out of their site again.
- Countries Whitelist now hidden until restriction function enabled and API Key set, this process improves the first-run experience when configuring the plugin.
- Added notice in Dashboard and Plugin page to prompt user to configure the plugin via a link to the plugin settings page.

## 1.3

- Added validation of notification recipient email address, notice displayed next to field in admin and the notifications emails will not be sent if the email address is considered invalid.

## 1.2

- Added UI for saving an email address to receive notifications
- Added UI for enabling type of email notifications to receive
- Added various error handling and notifications in the admin, in particular to notify if the API request limit has been reached.

## 1.1

- Added support for IPStack API as the sole geolocation provider
- Added UI for saving IPStack API Key
- Added UI for enabling / disabling restriction
- Added UI for setting restricted countries
- Added warning when no countries have been set to strongly encourage user to add their current location to try and prevent them being locked out of the Admin(!)

## 1.0

- Initial plugin build.