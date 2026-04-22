# Hellō Login Changelog

## 1.1.0

* Feature: added Hellō section to profile page with link / unlink functionality
* Feature: added admin notices for Quickstart and link/unlink actions
* Feature: redirect to settings page on plugin activation
* Improvement: more restructuring of the settings page
* Improvement: moved away from all REST APIs

## 1.0.12

* Improvement: restructured the settings page
* Improvement: added information about what data is being sent through Quickstart
* Improvement: increased state time limit to 10 minutes
* Improvement: updated the short description of the plugin
* Fix: logged out message on login page moved to top

## 1.0.11

* Improvement: disable logging by default
* Improvement: login page layout fixes and improvements
* Improvement: logins from wp-login.php redirect users to admin area
* Improvement: show "User Settings" section

## 1.0.10

* Improvement: show settings form in debug mode

## 1.0.9

* Fix: disable caching on REST API response
* Improvement: enable logging by default
* Improvement: content changes on plugin settings page

## 1.0.8

* Fix: use query parameter based redirect URI

## 1.0.7

* Fix: authentication request URL generated through REST API on button click
* Improvement: removed the WordPress User Settings section
* Improvement: removed the Authorization Settings section
* Improvement: use /hello-login/callback path for redirect URI
* Improvement: added endpoint for Quickstart response
* Fix: client id field being reset on settings save
* Fix: automatic configuration of rewrite rules

## 1.0.6

* Feature: added screenshots
* Update: plugin details
* Fix: plugin settings and login page redirects after connecting with Hellō

## 1.0.5

* Feature: added `given_name` and `family_name` scopes as defaults
* Fix: admin account linking done based on curren session
* Feature: link user account on sign-in, when account is matched on email
* Fix: map `nickname` to new username, instead of `sub`

## 1.0.4

* Feature: added "Settings" link right in plugin list
* Fix: show "Continue with Hellō" button on login page only if the plugin is configured

## 1.0.3

* Feature: added `integration` parameter to Quickstart request

## 1.0.2

* First release in WordPress plugin repository
* Feature: toggle settings page content based on settings and current user state
* Feature: collapse username / password form on login page
* Feature: send Privacy Policy and Custom Logo URLs to Quickstart
* Feature: added "Link Hellō" button to settings page

## 1.0.1

* WordPress plugin submission feedback
* Improvement: updated "Tested Up To" to 6.1.0
* Fix: input/output sanitization and generation
* Improvement: removed unused global functions
* Improvement: enabled user linking and redirect after login

## 1.0.0

* Forked https://github.com/oidc-wp/openid-connect-generic
* Feature: merged PR that adds [PKCE support](https://github.com/oidc-wp/openid-connect-generic/pull/421)
* Feature: integrated Hellō Quickstart
* Feature: removed unnecessary configuration options
* Improvement: renamed all relevant identifiers to be Hellō Login specific

--------

[See pre-fork changelog up to 3.9.1 here](https://github.com/oidc-wp/openid-connect-generic/blob/main/CHANGELOG.md)
