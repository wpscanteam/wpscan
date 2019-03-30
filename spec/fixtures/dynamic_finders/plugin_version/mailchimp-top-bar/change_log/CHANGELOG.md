Changelog
==========

#### 1.3.2 - Aug 8, 2018

**Fixes**

- Required fields notice on selected list was not showing because of invalid list property.

**Improvements**

- Prefix internal CSS classes for improved compatibility with other themes or plugins applying global admin styles.


#### 1.3.1 - May 29, 2018

**Improvements**

- 30% reduction in script file size because of removed JS dependency.
- Stop setting unused cookie when Top Bar form is used to subscribe.
- Add mctb_after_submit_button action hook.
- Improve animation performance.


#### 1.3 - November 1, 2017

**Improvements**

- Form now submits over AJAX, no longer reloading the entire page.
- Added `for` attribute to label elements, thanks [gabriel-kaam](https://github.com/gabriel-kaam).
- Added `mctb_replace_interests` filter hook.

#### 1.2.16 - January 19, 2017

Various minor code improvements.


#### 1.2.15 - September 8, 2016

**Improvements**

- Improved responsiveness when bar has additional input fields.
- Add `required` attribute to email input.


#### 1.2.14 - August 29, 2016

**Fixes**

- Top padding for small screens with admin bar.

**Improvements**

- Better bar responsiveness when window dimensions change on the fly (eg resizing a window or changing device orientation mode). (Thanks [tech4him1](https://github.com/tech4him1)!)


#### 1.2.13 - August 2, 2016

**Fixes**

- Error in animating body padding back to its original value.


#### 1.2.12 - July 21, 2016

**Fixes**

- Bar would crash when clicking toggle icon during bar animation.

**Improvements**

- Function scope generated JavaScript file to prevent Browserify clashes with other loaded scripts.
- Make sure script works even though it's loaded in the head section.
- Preparations for upcoming MailChimp for WordPress v4.0 release.

**Additions**

- Added Spanish language files, thanks to [Ángel Guzmán Maeso](http://shakaran.net/)
- Added `mctb_data` filter, to filter form data before it is processed.

**Deprecated**

- Deprecated `mctb_merge_vars` filter.


#### 1.2.11 - July 8, 2016

**Improvements**

- Completely removed optional jQuery dependency. The plugin now uses JavaScript animations, resulting in a much smoother experience.

#### 1.2.10 - April 12, 2016

**Fixes**

- Closed bar would still overlap underlying elements (like fixed top menu's).


#### 1.2.9 - March 16, 2016

**Fixes**

Top Bar was invisible on some themes because of `z-index` being too low.


#### 1.2.8 - March 15, 2016

**Improvements**

- Make sure top bar doesn't appear on top of WP admin bar.
- Hardened CSS styles for improved theme compatability.


#### 1.2.7 - January 26, 2016

**Improvements**

- Miscellaneous code improvements

**Additions**

- Add support for new [debug log](https://mc4wp.com/kb/how-to-enable-log-debugging/) in MailChimp for WordPress 3.1


#### 1.2.6 - January 4, 2016

 **Additions**

 - Option to "update existing subscribers" in MailChimp, which is useful if you have added fields.

 **Improvements**

 - Toggle icon now has a background color, for increased visibility.
 - Toggle icon now stacks above or below bar on small screens.

#### 1.2.5 - December 10, 2015

The plugin now requires [MailChimp for WordPress](https://wordpress.org/plugins/mailchimp-for-wp/) version 3.0 or higher.

**Fixes**

- Fixed column alignment in Appearance tab, thanks [Chantal Coolsma](https://github.com/chantalcoolsma)!

**Improvements**

- Improved admin notice when dependencies are not installed.


#### 1.2.4 - November 22, 2015

- Compatibility for [the upcoming MailChimp for WordPress 3.0 release](https://mc4wp.com/blog/breaking-backwards-compatibility-in-version-3-0/) tomorrow.
- Added `mctb_subscribed` filter.

#### 1.2.3 - November 13, 2015

**Improvements**

- Minor refactoring in the way the plugin is bootstrapped.

#### 1.2.2 - September 10, 2015

**Fixes**

- Honeypot field being auto-completed in some browsers.
- Honeypot field was accessible by pressing "tab" key.
- Hardened security for cookie that tracks sign-up attempts.

#### 1.2.1 - September 8, 2015

**Fixes**

- Response message was not showing for some themes.

**Improvements**

- Better mobile responsiveness


#### 1.2 - September 3, 2015

**Improvements**

- The bar will now auto-dismiss after every successful sign-up.
- Placeholders will now work in Internet Explorer 7, 8 & 9 as well.

**Additions**

- Added options for double opt-in and sending MailChimp's "welcome email".
- Added `mctb_before_label` action allowing you to add HTML before the label-element.
- Added `mctb_before_email_field` action allowing you to add HTML before the email field.
- Added `mctb_before_submit_button` action allowing you to add HTML before the submit button.
- Added `mctb_form_action` filter allowing you to set a custom form action.

#### 1.1.3 - June 23, 2015

**Fixes**

- Fixes fatal error when visiting settings page on some servers

#### 1.1.2 - June 18, 2015

**Improvements**

- Fixes height of response message
- CSS improvements for compatibility with various popular themes

#### 1.1.1 - June 12, 2015

**Fixes**

- Fixes unclickable admin bar (or fixed navigation menu's).

**Improvements**

- Various improvements to bar CSS so it can be easily overridden.
- Fix vertical alignment of toggle icon.

#### 1.1 - June 10, 2015

**Improvements**

- Bar no longer requires jQuery script, saving an additional HTTP request and 100kb

**Additions**

- Position option: top or bottom
- New filter: `mctb_mailchimp_list` (set lists to subscribe to)
- Lithuanian translation, thanks to [Aleksandr Charkov](https://github.com/dec0n)

#### 1.0.8 - May 6, 2015

**Fixes**

- Compatibility with [MailChimp for WordPress Lite v2.3](https://wordpress.org/plugins/mailchimp-for-wp/) and [MailChimp for WordPress Pro v2.7](https://mc4wp.com/).

#### 1.0.7 - April 15, 2015

**Fixes**

- `mctb_show_bar` filter was not functioning properly with some themes.
- Form always errored when using WPML with String Translations.

**Improvements**

- Toggle icon is no longer shown for users without JavaScript.

#### 1.0.6 - March 17, 2015

**Fixes**

- Compatibility issues with latest version of Enfold theme
- Conflict with other plugins shipping _very old_ versions of Composer

**Improvements**

- Allow simple inline tags in the bar text


#### 1.0.5 - February 25, 2015

**Fixes**

- Bar not loading in some themes after latest update
- Colors not working because of missing leading `#` value. Color settings are now validated before saving them.

#### 1.0.4 - February 23, 2015

**Fixes**

- Styling issues with Enfold theme.

**Additions**

- Settings page now uses a tabbed interface.
- You can now set a "redirect url" in the bar settings
- All form response messages can now be customised for the bar form

#### 1.0.3 - February 17, 2015

**Improvements**

- Bar will now show "already subscribed" message from MailChimp for WordPress when a person is already on the selected list.
- Response message will now show and fadeout after 3 seconds.
- Various usability improvements for the settings screen.
- Improved spam detection.
- Major JS performance improvements.

**Additions**

- Multiple new anti-spam measures
- WPML compatibility


#### 1.0.2 - February 12, 2015

**Improvements**

- Better CSS reset for elements inside the bar
- Other minor CSS improvements

**Additions**

- Top Bar sign-ups are now shown in the log for [MailChimp for WordPress Pro](https://mc4wp.com/).

#### 1.0.1 - February 4, 2015

**Fixes**

- The plugin will no longer overlap header menu's or other elements

**Additions**

- You can now set the bar as "sticky", meaning it will stick to the op your window, even when scrolling.
- You can now choose the size of the bar, small/medium/big.
- Added Dutch translation files.

**Improvements**

- The menu item will now show above the item asking you to upgrade to MailChimp for WordPress Pro.

Please update the [MailChimp for WordPress plugin](https://wordpress.org/plugins/mailchimp-for-wp/) before updating to this version.

#### 1.0 - January 28, 2015

Initial release
