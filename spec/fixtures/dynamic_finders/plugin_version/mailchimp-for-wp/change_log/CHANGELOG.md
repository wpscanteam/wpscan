Changelog
=========

#### 4.1.14 - January 8, 2018

**Fixes**

- Validate method was incorrectly checking required array fields.

**Improvements**

- Wrap some missing strings in translate calls. Thanks [morlor](https://github.com/morloi).
- Make it clear that redirecting after successful form submissions will not show the "subscribed" message.



#### 4.1.13 - December 28, 2017

**Fixes**

- Array to string conversion in default form messages.

**Additions**

- Allow marking Gravity Forms sign-up checkbox as a required field.


#### 4.1.12 - December 11, 2017

**Fixes**

- Ninja Forms double opt-in setting was incorrectly inversed.

**Improvements**

- Simplified form processing & notice logic.
- Prevent 404 errors by proactively replacing lowercased `name="name"` input attributes.
- Updated JavaScript dependencies.

**Additions**

- Integration for AffiliateWP.


#### 4.1.11 - November 2, 2017

**Fixes**

- Filter out empty array values when overriding selected MailChimp lists via `_mc4wp_lists`. 

**Improvements**

- Updated JavaScript dependencies.

**Additions**

- Link to the [HTML Forms](https://www.htmlforms.io/) from the plugin settings pages.


#### 4.1.10 - October 19, 2017

**Improvements**

- Remove unused options from Ninja Forms integration.
- Now logging all sign-ups from Ninja Forms integrations when using [MailChimp for WordPress Premium](https://mc4wp.com/premium-features/). 

**Additions**

- Added Gravity Forms integration. You can now integrate with Gravity Forms by adding the "MailChimp" field to your forms.


#### 4.1.9 - September 19, 2017

**Improvements**

- Add `<label>` element to sign-up checkbox for WCAG compatibility.
- Custom integration now works with Enfold theme's contact form element.


#### 4.1.7 & 4.1.8 - September 8, 2017

**Fixes**

- Properly escape the return value of `add_query_arg` when it is used in HTML attributes to prevent cross-site scripting. Thanks to [Karim Ouerghemmi of RIPS](https://www.ripstech.com/) for responsibly disclosing.
- Now loading integrations after WPML so that String Translations work properly.

**Additions**

- Add sign-up integration for WPForms forms.

**Improvements**

- Updated internal JS dependencies.
- Form tag `{data key="foo.bar"}` now allows you to access nested array values.


#### 4.1.6 - July 31, 2017

**Fixes**

- Method on API class for retrieving campaign data.

**Improvements**

- Show Akamai reference number when an API request is blocked by MailChimp's firewall.
- Minor output buffering improvements in form previewer.


#### 4.1.5 - June 27, 2017

**Fixes**

- Failsafe against outputting sign-up checkbox twice in registration forms.
- Properly close HTML anchor element in French translation files.
- Fix BuddyPress sign-ups when using WordPress Multisite.

**Improvements**

- Fire action hook `mc4wp_form_updated_subscriber` whenever a form was used to update a subscriber in MailChimp.
- Increase browser timeout for AJAX request when fetching MailChimp lists.

**Additions**

- Added campaign & template methods to API client class.
 


#### 4.1.4 - June 15, 2017

**Fixes**

- Some form specific JS events were not firing due to incorrect event names.
- Registration form integration now works with WooCommerce registration form.
- Notice that asks for a plugin review would re-appear after dismissing it.


#### 4.1.3 - May 24, 2017

**Improvements**

- Randomise time of cron event that renews MailChimp lists.
- Always try to show MailChimp list info when API key is given.


#### 4.1.2 - May 8, 2017

**Fixes**

- Use earlier hook priority for Ninja Forms 3 integration so action is registered on time.

**Improvements**

- Improved MailChimp list fetching & memory usage for accounts with many lists.
- Show error message when fetching lists fails.
- Updated plugin translations.

#### 4.1.1 - April 11, 2017

**Fixes**

- WPML String Translation not working with the checkbox label for sign-up integrations.

**Improvements**

- Use updated order methods when using WooCommerce 3.0, thanks to Liam McArthur.
- Updated JavaScript dependencies.


#### 4.1.0 - March 14, 2017

**Improvements**

- Updated all JavaScript dependencies in the plugin.
- Failsafed filter hooks to prevent invalid variable types.
- Explain that greyed out integrations means that specific plugin is not activated.
- Conditional form elements now uses event delegation, so it works with forms in [Boxzilla pop-ups](https://boxzillaplugin.com/).
- Updated language files.

**Additions**

- Added support for Ninja Forms 3.
- Added `mc4wp_integration_show_checkbox` filter.


#### 4.0.13 - February 8, 2017

**Improvements**

- Ensure fields are HTML decoded before sending to MailChimp.
- Better OptimizePress compatibility.
- Show all address-type fields as required when form contains 1 or more fields of the same address group.


#### 4.0.12 - January 16, 2017

**Fixes**

- Don't call `stripslashes` on POST data twice.

**Improvements**

- Plugin review notice is now dismissible over AJAX.
- Improved formatting of birthday fields.
- Updated Polish translations, thanks to Mateusz Lomber.
- Updated German translations, thanks to Sven de Vries.

**Additions**

- Add `update_ecommerce_store_product` method to API class.
- Throw form specific JavaScript events, like `15.subscribed` to hook into "subscribed" events for form with ID 15.


#### 4.0.11 - December 9, 2016

**Fixes**

- Unescaped request variable on integration settings page, allowing for authenticated XSS. Thanks to [dxwsecurity](https://security.dxw.com/) for responsibly disclosing.

**Improvements**

- Add `$args` parameter to `API::get_lists_activity` method. Relates to the [MailChimp Activity](https://wordpress.org/plugins/mc4wp-activity/) plugin.


#### 4.0.10 - December 6, 2016

**Improvements**

- You can now enable or disable debug logging from the "Other" settings page.
- No longer using deprecated function in Contact Form 7, thanks to [stodorovic](https://github.com/stodorovic).
- Improved UI for adding hidden interest groupings fields to a form.


#### 4.0.9 - November 23, 2016

**Fixes**

- Issue with escaped HTML when using form tags introduced by previous update.


#### 4.0.8 - November 23, 2016

**Improvements**

- Improved handling of large debug logs.
- Improved error messages when writing exceptions to debug log.
- Show notice when form is missing required MailChimp fields.
- Custom form integration now handles arrays with 1-level depth. Thanks to [Mardari Igor](https://github.com/GarryOne).
- You can now use nested tags in your form code, eg `{data key="utm_source" default="{current_path}"}`

**Additions**

- Add `data-hide-if` attribute logic to forms. See [conditionally hide form fields](https://kb.mc4wp.com/conditional-fields-elements/). Thanks to [Kurt Zenisek](http://kurtzenisek.com/).
- Add hooks for delayed BuddyPress sign-up. Thanks to [Christian Wach](https://profiles.wordpress.org/needle).


#### 4.0.7 - October 25, 2016

**Improvements**

- Obfuscate all email addresses in debug log. Thanks [Sauli Lepola](https://twitter.com/SJLfi).
- Ask for confirmation before disabling double opt-in, which we do not recommend.
- Allow vertical resizing of debug log.
- Failsafe against including JavaScript file twice.
- No longer wrapping CF7 checkbox in paragraph tags.

**Additions**

- Added `mc4wp_form_api_error` action hook for API errors encountered by forms.
- Added `element_class` argument to `[mc4wp_form]` shortcode for adding CSS classes.


#### 4.0.6 - October 10, 2016

**Fixes**

- Issue with lists not showing when using W3 Total Cache with APCu object cache enabled.

**Improvements**

- We're no longer stripping newlines from text fields.

**Additions**

- Added missing e-commerce related API methods to API class.


#### 4.0.5 - September 29, 2016

**Fixes**

- Allow checkbox option for the List Choice field (again).

**Improvements**

- Fetch MailChimp lists over AJAX, to speed up perceived performance (especially when your account has many lists).
- Periodically fetch MailChimp lists, so cache is always fresh.
- Improved `<label>` element accessibility for checkbox integrations.
- Stop using double underscore prefix in function names, as these are reserved in PHP 7.
- `{post}` and `{user}` shortcodes now accept a `default` parameter.

**Additions**

- Add [MemberPress](https://www.memberpress.com/) integration.
- Add missing e-commerce related API methods for next week's [WooCommerce MailChimp e-commerce integration](https://mc4wp.com/kb/what-is-ecommerce360/) release.


#### 4.0.4 - September 7, 2016

**Improvements**

- Allow re-running previous migrations by visiting a certain admin URL.
- Do not show checkboxes option for fields that only accept a single value.
- Write field specific errors to debug log when MailChimp denies a sign-up request.
- Write to debug log when custom integrations can not find an EMAIL field.
- Differentiate between connection & authorization errors when testing connection to MailChimp.
- Bump limit of number of MailChimp lists to fetch from 100 to 500.


#### 4.0.3 - August 24, 2016

**Fixes**

- Ninja Forms integration not working when using PayPal integration.

**Improvements**

- Show connection errors on MailChimp settings page.

**Additions**

- Add pre-checked option to Ninja Forms integration.
- You can now [conditionally hide fields or elements](https://mc4wp.com/kb/conditional-fields-elements/) using the `data-show-if` attribute.


#### 4.0.2 - August 10, 2016

**Fixes**

- Hidden fields which referenced interest groups by name were not sent to MailChimp.
- Adding hidden field to form would reset value on every change.

**Improvements**

- Decrease file size of JavaScript for forms by about 30%.


#### 4.0 & 4.0.1 - August 9, 2016

This release updates the plugin to version 3 of the MailChimp API. Please [read through the upgrade guide](https://mc4wp.com/kb/upgrading-to-4-0/) before updating to make sure things keep working as expected for you.

**Changes**

- "Send welcome email" is now handled from your list settings in MailChimp.
- Filter `mc4wp_form_merge_vars` is now called `mc4wp_form_data`.
- Filter `mc4wp_integration_merge_vars` is now called `mc4wp_integration_data`.
- New format for GROUPING fields in forms & filter hooks.
- Value delimiter in hidden fields is now a pipe `|` character.

**Additions**

- New filter: `mc4wp_form_subscriber_data`.
- New filter: `mc4wp_integration_subscriber_data`.
- New form tag: `{cookie name="mycookie"}`

**Improvements**

- The plugin now communicates with the latest & greatest MailChimp API.
- Previously unsubscribed subscribers can now be re-added without errors.
- Add `User-Agent` header to all API requests.
- Available fields in form editor are now split-up by category.
- Birthday fields now accept a broader range of values and delimiters.

**Fixes**

- Issue with only 10 MailChimp lists / fields / interests being returned.
- Incorrect form message showing when double opt-in is disabled.
- Error in upgrade routine when API request fails.
- List fields not fetched when list has just 1 non-default merge field.


#### 3.1.12 - July 28, 2016

**Improvements**

- Smarter scrolling after submitting form & reloading page.
- Format output of `{subscriber_count}` tag.
- You can now use `<img>` in your form messages.
- Add MailChimp API error code to debug log lines.
- Add plugin name + version to User-Agent header for all MailChimp API requests.
- Make sure value of MC_LANGUAGE field is limited to 2 characters.


#### 3.1.11 - July 5, 2016

**Improvements**

- Update JavaScript dependencies for admin screens.
- Test debug log & show notice when it's not writable.

**Additions**

- Add "placeholder" option for dropdown fields.


#### 3.1.10 - June 21, 2016

**Fixes**

- Styles Builder in Premium not building because of incorrect flag in core plugin.

**Improvements**

- Don't show position option for WooCommerce integration when sign-up is implicit.
- Improvements to form previewer logic.
- Make sure admin notifications are always shown exactly one time.

#### 3.1.9 - June 7, 2016

**Fixes**

- Placeholder polyfill wasn't loaded (only in IE8 and below).

**Improvements**

- Don't write to debug log if it is not writable.
- Reset some CSS properties for commonly used class names in Form Editor & Debug Log.
- Do not unnecessarily register styles which are then immediately enqueued.

**Additions**

- Add "is required field" option for dropdown & radio fields in Field Helper.
- Link to [Boxzilla plugin](https://boxzillaplugin.com/) from admin sidebar.


#### 3.1.8 - May 23, 2016

**Fixes**

- Form Preview mode replaced all titles on that page with "Form Preview".
- API class fix for [eCommerce360 functionality](https://mc4wp.com/kb/what-is-ecommerce360/).

**Improvements**

- Show dismissible notice when API key is not set.
- Show empty API key errors in plugin log.
- Friendlier error message for re-subscribe failures.

**Additions**

- Add `form.reset()` method to JS API.

#### 3.1.7 - May 9, 2016

**Fixes**

- Shortcode wasn't accepting `element_id` as a valid attribute.
- Take array style fields into account when checking if a form contains a given field.


**Improvements**

- Nested fields will now be properly validated when they're marked as required.
- If plugin is installed using Composer, autoloader won't be loaded (again).



#### 3.1.6 - April 12, 2016

**Fixes**

- Form event for starting a form was named `start` where it should have been `started`.

**Improvements**

- Some preparations for the upcoming migration to the new MailChimp API (version 3).
- Consistent hook parameters for `mc4wp_form_subscribed` action.
- Improved logic for rendering form response.

**Additions**

- New checkbox position for WooCommerce checkout integration.


#### 3.1.5 - March 22, 2016

**Fixes**

- Response message was shown for unsubmitted forms when using `{response}` in the form mark-up with multiple forms on the same page.

**Improvements**

- Scroll to form after form submission now uses native browser method `scrollIntoView()`.
- Various improvements for right-to-left (RTL) sites.
- The MailChimp API key is now obfuscated on the settings page.
- Contact Form 7 integration now uses an early hook priority to ensure we run before any page redirects.

**Additions**

- Add position option for WooCommerce integration.
- Add `{post}` tag whch can be used in form mark-up to fetch properties of the current page or post.

#### 3.1.4 - February 29, 2016

**Fixes**

- Forms with address fields never passing validation.

**Improvements**

- Perform type checks on global variables to prevent issues with poorly coded plugins.
- Add Interest Category ID to list overview table for easier debugging.
- Updated Russian translations.


#### 3.1.3 - February 17, 2016

**Fixes**

- Issue with API array responses (for the [MailChimp Activity add-on](https://wordpress.org/plugins/mc4wp-activity/), for example).

**Improvements**

- Updated Dutch, Portugese, Spanish and Italian translations.


#### 3.1.2 - February 15, 2016

**Fixes**

- Form JavaScript not working when another plugins loads Dojo framework.
- [ENTER] not submitting form settings or creating new-line.
- Internal fields marked as required not passing form validation.
- Deselecting all MailChimp lists wouldn't persist after saving form settings.
- No sign-up request firing for lists with only an `EMAIL` field.

**Improvements**

- Show accepted choice values for dropdown and radio fields in lists overview.
- Use all MailChimp lists for Lists Choice field, instead of just the selected ones.
- Failsafed JavaScript for when any other script loads RequireJS globally.

**Additions**

- Added support for [Shortcake](https://wordpress.org/plugins/shortcode-ui/) plugin.
- Error message for when no list is selected can now be customized from the form message settings.


#### 3.1.1 - February 1, 2016

**Fixes**

- Field Helper not adding `type` attribute when building forms.
- Field Helper not setting the correct `value` attribute for Hidden Groups.

**Improvements**

- Add sourcemaps to minified JavaScript files.
- Add link to article on how to enable debug logging.
- Field Helper now always shows both placeholder and value fields.


#### 3.1 - January 26, 2016

**Fixes**

- `<input>` fields being stripped from form when saving as a role other than "superadmin" on MultiSite installations.
- Certain actions like "renew lists" not working for users other than admin (if they have explicit access to settings pages).

**Improvements**

- Show Akamai firewall reference number when site's IP address is blocked
- Make sure integrations have a MailChimp list selected before trying to subscribe.
- Move less important settings to "Other" page.
- When a field is required in MailChimp, it has to be required in forms as well now.
- Allow including a `_mc4wp_email_type` field in forms to set an explicit email type.
- Miscellaneous overall performance improvements.

**Additions**

- Added [debug logging](https://mc4wp.com/kb/how-to-enable-log-debugging/), which shows all warnings & errors the plugin encountered in communicating with MailChimp.
- Add `get_lists_for_email( $email )` method to API class.
- Add `MC4WP_Queue` class for better background processing of expensive operations.

#### 3.0.12 - January 15, 2016

**Fixes**

- Incorrect hooks being fired for successful and unsuccessful form sign-ups (which also broke the success redirect).

#### 3.0.11 - January 14, 2016

**Improvements**

- Allow splitting up "birthday" and "date" fields into separate fields with `day`, `month` and `year` index.
- Improved algorithm for finding fields when integrating with Contact Form 7 or other custom forms.
- Ninja Forms integration can now automatically find name-fields.
- Ninja Forms integration can now use `mc4wp-` prefixed admin labels.

**Additions**

- `add_ecommerce_order()` and `delete_ecommerce_order()` methods to API class.

#### 3.0.10 - January 6, 2016

**Fixes**

- 500 server error for "already subscribed" on Windows servers.
- Incorrect HTML being generated for hidden fields.
- Duplicate sign-up request when using CF7 integration.

**Improvements**

- Stop logging "already subscribed" errors to PHP's error log.
- Simplify `pattern` attribute for `date` fields.
- Remove invalid `autofill` attribute from honeypot field.


#### 3.0.9 - December 17, 2015

**Fixes**

Not being able to select a list when creating a new form.

#### 3.0.8 - December 15, 2015

**Fixes**

- Make sure `mc4wp_show_form()` works without passing a form ID.

**Improvements**

- Remove UI for bulk-enabling integrations, as every integration needs specific settings anyway.
- Do not print inline JavaScript for forms until it's surely needed.
- Add `position` key to `mc4wp_admin_menu_items` filter to set a menu position.
- Various minor code improvements.

#### 3.0.7 - December 10, 2015

**Fixes**

Workaround for [SSL certification bug in WordPress 4.4](https://core.trac.wordpress.org/ticket/34935), affecting servers with an older versions of OpenSSL installed.

**Additions**

Added `mc4wp_use_sslverify` filter to disable or explicitly enable SSL certificate verification.


#### 3.0.4 - December 7, 2015

**Fixes**

- Fixes compatibility issues with add-on plugins performing validation, like Goodbye Captcha and BWS Captcha.

**Improvements**

- Now using group ID's for interest grouping fields, so changing the group in MailChimp does not require updating your form code.
- Never load enabled integrations which are not installed.
- Reintroduce support for automatically sending `OPTIN_IP`

**Additions**

- Add filter: `mc4wp_form_data`, filters form data before it is processed.


#### 3.0.3 - November 30, 2015

**Fixes**

- Added backwards compatibility for [Goodbye Captcha](https://wordpress.org/plugins/goodbye-captcha/) integration.

**Improvements**

- Prevented notice when saving Form widget settings for the first time.
- Add `autofill="off"` to honeypot field.
- Remove nonces from forms as they're not really useful for publicly available features.
- Errors returned by MailChimp are now logged for Forms as well.
- Pre-select MailChimp list if there's just one list in the connected account.
- Added missing translation calls for Form Editor.

#### 3.0.2 - November 25, 2015

**Fixes**

- Redirect on success not working.
- Forms overview page redirected to main WP Admin page (edge case).
- Safari was always showing the leave-page confirmation dialog.

**Improvements**

- Add form-specific classes to preview form element. This allows the [Styles Builder](https://mc4wp.com/premium-features/) to work with the Form Preview.
- Form events are now triggered _after_ the page has finished loading, so all scripts are loaded & ready to use.
- Reset background-color in Form Themes stylesheets.

#### 3.0.0 & 3.0.1 - November 23, 2015

Version 3.0 is a total revamp of the plugin. For a quick overview of the changes, please [read this post on our blog](https://mc4wp.com/blog/whats-new-in-mailchimp-for-wordpress-the-big-three-o/).

Before upgrading, please go through the [upgrade guide](https://mc4wp.com/kb/upgrading-to-3-0/) as some things have changed.

**Breaking Changes**

- Captcha fields: `{captcha}` field is now handled by the [Captcha add-on plugin](https://wordpress.org/plugins/mc4wp-captcha/).
- New dynamic content tags syntax: `{data_NAME}` is now `{data key="NAME"}`
- Event binding: `jQuery(document).on('subscribe.mc4wp','.mc4wp-form', function(){ ... })` is now `mc4wp.forms.on('subscribed', function(form) { ... })`
- Removed integrations: MultiSite & bbPress.

**Improvements**

- New form editor with syntax highlighting, more advanced field options & better visual feedback.
- Better support for MailChimp `address` fields.
- Better support for choice fields (eg groupings, list choice & country fields).
- All fields marked as `required` are now validated server-side as well (instead of just MailChimp required fields).
- All integrations have their own settings page now.
- Events Manager: checkbox is now automatically added to booking forms.
- Tons of usability & accessibility improvements.
- Tons of code improvements: improved memory usage, 100+ new unit tests & better usage of various best practices.
- The [premium plugin](https://mc4wp.com/) is now an add-on of this plugin.

**Additions**

- New "Preview Form" option, showing unsaved form changes.
- Integrations can now be "implicit", thus no longer showing a checkbox option to visitors.
- New JavaScript API, replacing jQuery event hooks.
- Ninja Forms integration
- Introduced various new filter & action hooks, please see the new [code reference for developers](http://developer.mc4wp.com/) for more information.

#### 2.3.18 - November 2, 2015

**Fixes**

- Incorrect number of parameters for `error_log` statement in integrations class.

**Improvements**

- Usage tracking is now scheduled once a week (instead of daily).
- Preparations for [the upcoming MailChimp for WordPress version 3.0 release](https://mc4wp.com/blog/breaking-backwards-compatibility-in-version-3-0/).
- Tested compatibility with WordPress 4.4

#### 2.3.17 - October 22, 2015

**Fixes**

- Honeypot field being autofilled in Chrome, causing a form error.

**Improvements**

- Updated Portugese translations.


#### 2.3.16 - October 14, 2015

**Fixes**

- Error in Russian translation, causing a broken link on the MailChimp settings page.

**Improvements**

- Textual improvements to MailChimp settings page.
- Connectivity issues with MailChimp will now _always_ show an error message.
- Renewing MailChimp lists will now also update the output of the `{subscriber_count}` tag.

#### 2.3.15 - October 9, 2015

**Fixes**

- Fixes JS error when form contains no submit button

**Improvements**

- Only prefix `url` fields with `http://` if it is filled.
- Updated Spanish & Catalan translations, thanks to [Xavier Gimeno Torrent](http://www.xaviergimeno.net/).
- Fix `mc4wp_form_before_fields` being applied twice.
- Position honeypot field to the right for Right-To-Left sites.
- `_mc4wp_lists` can now be a comma-separated string of MailChimp list ID's to subscribe to (or an array).
- Minor other defensive coding improvements to prevent clashes with other plugins.

**Additions**

- Added opt-in usage tracking to help us make the plugin better. No sensitive data is tracked.

#### 2.3.14 - September 25

**Fixes**

- Use of undefined constant in previous update.

#### 2.3.13 - September 25, 2015

**Fixes**

- Honeypot causing horizontal scrollbar on RTL sites.
- List choice fields not showing when using one of the default form themes.

**Improvements**

- Minor styling improvements for RTL sites.
- MailChimp list fields of type "website" will now become HTML5 `url` type fields.
- Auto-prefix fields of type `url` with `http://`

#### 2.3.12 - September 21, 2015

**Fixes**

- Issue with interest groupings not being fetched after updating to version 2.3.11

#### 2.3.11 - September 21, 2015

**Fixes**

- Honeypot field being filled by browser's autocomplete.
- Styling issue for submit buttons in Mobile Safari.
- Empty response from MailChimp API

**Improvements**

- Do not query MailChimp API for interest groupings if list has none.
- Integration errors are now logged to PHP's error log for easier debugging.

**Additions**

- You can now use shortcodes in the form content.

#### 2.3.10 - September 7, 2015

**Fixes**

- Showing "not connected" when the plugin was actually connected to MailChimp.
- Issue with `address` fields when `addr1` was not given.
- Comment form checkbox not outputted for some older themes.

**Improvements**

- Do not flush MailChimp cache on every settings save.
- Add default CSS styles for `number` fields.
- Placeholders will now work in older version of IE as well.

#### 2.3.9 - September 1, 2015

**Improvements**

- MailChimp lists cache is now automatically flushed after changing your API key setting.
- Better field population after submitting a form with errors.
- More helpful error message when no list is selected.
- Translate options when installing plugin from a language other than English.
- Add form mark-up to WPML configuration file.
- Sign-up checkbox in comment form is now shown before the "submit comment" button.
- URL-encode variables in "Redirect URL" setting.
- Better error message when connected to MailChimp but account has no lists.

**Additions**

- Add `mc4wp_form_action` filter to set a custom `action` attribute on the form element.

#### 2.3.8 - August 18, 2015

**Fixes**

- Prevented JS error when outputting forms with no submit button.
- Using `0` as a Redirect URL resulted in a blank page.
- Sign-up checkbox was showing twice in the Easy Digital Downloads checkout when showing registration fields, thanks [Daniel Espinoza](https://github.com/growdev).
- Default form was not automatically translated for languages other than English.

**Improvements**

- Better way to hide the honeypot field, which stops bots from subscribing to your lists.
- role="form" is no longer needed, thanks [XhmikosR](https://github.com/XhmikosR)!
- Filter `mc4wp_form_animate_scroll` now disables just the scroll animation, not the scroll itself.
- Revamped UI for MailChimp lists overview
- Updated German & Greek translations.

**Additions**

- Added `mc4wp_form_is_submitted()` and `mc4wp_form_get_response_html()` functions.

#### 2.3.7 - July 13, 2015

**Improvements**

- Use the same order as MailChimp.com, which is useful when you have over 100 MailChimp lists.
- Use `/* ... */` for inline JavaScript comments to prevent errors with minified HTML - props [Ed Gifford](https://github.com/egifford)

**Additions**

- Filter: `mc4wp_form_animate_scroll` to disable animated scroll-to after submitting a form.
- Add `{current_path}` variable to use in form templates.
- Add `default` attribute to `{data_name}` variables, usage: `{data_something default="The default value"}`

#### 2.3.6 - July 6, 2015

**Fixes**

- Undefined index notice when visitor's USER_AGENT is not set.

**Improvements**

- Relayed the browser's Accept-Language header to MailChimp for auto-detecting a subscriber's language.
- Better CSS for form reset
- Updated HTML5 placeholder polyfill

#### 2.3.5 - June 24, 2015

**Fixes**

- Faulty update for v3.0 appearing for people running GitHub updater plugin.

**Improvements**

- Updated language files.
- Now passing the form as a parameter to `mc4wp_form_css_classes` filter.

#### 2.3.4 - May 29, 2015

**Fixes**

- Issue with GROUPINGS not being sent to MailChimp

**Improvements**

- Code preview in Field Builder is now read-only

#### 2.3.3 - May 27, 2015

**Fixes**

- Get correct IP address when using proxy like Cloudflare or Sucuri WAF.
- Use strict type check for printing inline CSS that hides honeypot field

**Improvements**

- Add `contactemail` and `contactname` to field name guesses when integrating with third-party form.
- Re-enable `sslverify`

#### 2.3.2 - May 12, 2015

**Fixes**

- Groupings not being sent to MailChimp
- Issue when using more than one `{data_xx}` replacement

**Improvements**

- IE8 compatibility for honeypot fallback script.

#### 2.3.1 - May 6, 2015

**Fixes**

- PHP notice in `includes/class-tools.php`, introduced by version 2.3.

#### 2.3 - May 6, 2015

**Fixes**

- The email address is no longer automatically added to the Redirect URL as this is against Google Analytics policy. To add it again, use `?email={email}` in your Redirect URL setting.
- Registration type integrations were not correctly picking up on first- and last names.
- JavaScript error in IE8 because of `setAttribute` call on honeypot field.
- API class `subscribe` method now always returns a boolean.

**Improvements**

- Add `role` attribute to form elements
- Major code refactoring for easier unit testing and improved code readability.
- Use Composer for autoloading all plugin classes (PHP 5.2 compatible)
- You can now use [form variables in both forms, messages as checkbox label texts](https://mc4wp.com/kb/using-variables-in-your-form-or-messages/).

**Additions**

- You can now handle unsubscribe calls with our forms too.
- Added Portugese, Indonesian, German (CH) and Spanish (PR) translations.

#### 2.2.9 - April 15, 2015

**Fixes**

- Menu item for settings page not appearing on Google App Engine ([#88](https://github.com/ibericode/mailchimp-for-wordpress/issues/88))

**Improvements**

- Updated Italian, Russian & Turkish translations. [Want to help translate the plugin? Full translations get a free Pro license](https://www.transifex.com/projects/p/mailchimp-for-wordpress/).

#### 2.2.8 - March 24, 2015

**Fixes**

- API key field value was not properly escaped.
- Background images were stripped from submit buttons.

**Improvements**

- Better sanitising of all settings
- Updated all translations

**Additions**

- Added `mc4wp_before_checkbox` and `mc4wp_after_checkbox` filters to easily add more fields to sign-up checkbox integrations.
- Added some helper methods related to interest groupings to `MC4WP_MailChimp` class.
- Allow setting custom MailChimp lists to subscribe to using `lists` attribute on shortcode.

#### 2.2.7 - March 11, 2015

**Fixes**

- Honeypot field was visible for themes or templates not calling `wp_head()` and `wp_footer()`

**Improvements**

- Various minor code improvements
- Updated German, Spanish, Brazilian, French, Hungarian and Russian translations.

**Additions**

- Added [mc4wp_form_success](https://github.com/ibericode/mailchimp-for-wordpress/blob/06f0c833027f347a288d2cb9805e0614767409b6/includes/class-form-request.php#L292-L301) action hook to hook into successful sign-ups
- Added [mc4wp_form_data](https://github.com/ibericode/mailchimp-for-wordpress/blob/06f0c833027f347a288d2cb9805e0614767409b6/includes/class-form-request.php#L138-L142) filter hook to modify all form data before processing


#### 2.2.6 - February 26, 2015

**Fixes**

- CSS reset wasn't working for WooCommerce checkout sign-up checkbox.
- `mc4wp-submitted` class was not added in IE8
- Incorrect `action` attribute on form element for some server configurations

**Improvements**

- Anti-SPAM improvements: a better honeypot field and a timestamp field to prevent instant form submissions.
- Reset `background-image` on submit buttons when using CSS themes
- Smarter email detection when integrating with third-party forms
- Updated all translations

**Additions**

- Custom fallback for browsers not supporting `input[type="date"]`


#### 2.2.5 - February 13, 2015

**Fixed**

- Issue where WooCommerce checkout sign-up was not working for cheque payments.
- Translation were loaded too late to properly translate some strings, like the admin menu items.

**Improvements**

- The presence of required list fields in form mark-up is now checked as you type.
- Number fields will now repopulate if an error occurred.
- Updated all translations.
- Make sure there is only one plugin instance.
- Various other code improvements.

**Additions**

- Added support for [GitHub Updater Plugin](https://github.com/afragen/github-updater).
- You can now specify whether you want to send a welcome email (only with double opt-in disabled).

A huge thank you to [Stefan Oderbolz](http://metaodi.ch/) for various fixed and improvements related to translations in this release.


#### 2.2.4 - February 4, 2015

**Fixed**

- Textual fix as entering "0" for no redirection does not work.

**Improvements**

- Moved third-party scripts to their own directory for easier exclusion
- All code is now adhering to the WP Code Standards
- Updated [Dutch, German, Spanish, Hungarian, French, Italian and Turkish translations](https://www.transifex.com/projects/p/mailchimp-for-wordpress/).

**Additions**

- Now showing a heads up when at limit of 100 MailChimp lists. ([#71](https://github.com/ibericode/mailchimp-for-wordpress/issues/71))
- Added `wpml-config.xml` file for better WPML compatibility
- Added filter `mc4wp_menu_items` for adding & removing menu items from add-ons

#### 2.2.3 - January 24, 2015

Minor improvements and additions for compatibility with the [MailChimp Sync plugin](https://wordpress.org/plugins/mailchimp-sync/).

#### 2.2.2 - January 13, 2015

**Fixes**

- Plugin wasn't connecting to MailChimp for users on MailChimp server `us10` (API keys ending in `-us10`)

#### 2.2.1 - January 12, 2015

**Improvements**

- Use JS object to transfer lists data to Field Wizard.
- Field Wizard strings are now translatable
- Add `is_spam` method to checkbox integration to battle spam sign-ups
- Minor code & code style improvements
- Updated Danish, German, Spanish, French, Italian and Portugese (Brazil) translations

**Additions**

- You can now set `MC_LOCATION`, `MC_NOTES` and `MC_LANGUAGE` from your form HTML
- The submit button now has a default value when generating HTML for it

#### 2.2 - December 9, 2014

**Fixes**

- "Select at least one list" notice appearing when unselecting any MailChimp list in Form settings
- If an error occurs, textareas will no longer lose their value

**Improvements**

- Improved the way form submissions are handled
- Minor code & documentation improvements
- Updated Dutch, French, Portugese and Spanish translations

**Additions**

- Added sign-up checkbox integration for [WooCommerce](https://wordpress.org/plugins/woocommerce/) checkout.
- Added sign-up checkbox integration for [Easy Digital Downloads](https://wordpress.org/plugins/easy-digital-downloads/) checkout.
- The entered email will now be appended to the URL when redirecting to another page
