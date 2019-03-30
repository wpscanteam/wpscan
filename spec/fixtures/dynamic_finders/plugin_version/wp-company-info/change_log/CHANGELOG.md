# Changelog

## 1.9.0

* Replacing the old CMB address class with an updated one that includes support for international addresses.
* Making the address field international by supporting countries.
* Adding support for the new country field in the address shortcode.

## 1.8.9

* Updating CMB2 to the latest version.

## 1.8.7

* Fixing an issue with the social links outputting all links even if the URL wasn't filled in.

## 1.8.6

* Fixing the placement of commas in the address shortcode to remove extra commas.

## 1.8.5

* Only including the address field if another plugin didn't already register a CMB2 address field.

## 1.8.4

* Adding support for adding classes to the phone number link.

## 1.8.3

* Adding the $output variable to fix an 'undefined variable' PHP notice.

## 1.8.2

* Adding a new pencil icon as an option.

## 1.8.1

* Adding nofollow to the social links output.

## 1.8.0

* Adding support for links in custom contact shortcodes.

## 1.7.7

* Fixing issue with the email link not being outputted properly when the schema tags are active.

## 1.7.6

* Adding schema tags around the email address if schema tags are enabled.

## 1.7.5 

* Adding a schema tag around the site name if the schema tags are being used.
* Fixing an issue with the address field getting broken because of renamed functions.

## 1.7.4

* Updating address function prefixes again.

## 1.7.3

* Updating the function prefixes for the address field functions.

## 1.7.2

* Renaming the shortcode date function.

## 1.7.1

* Updating changelogs.

## 1.7.0

* Adding a new class for creating generic shortcodes.

## 1.6.1

* Making sure a comma appears after the address line 1 in the unformatted shortcode output.

## 1.6.0

* Adding two new shortcodes: one for outputting the site name and another for outputting the site description.

## 1.5.0

* Adding a widget that outputs the custom logo uploaded by the user.

## 1.4.0

* Changing the customizer control from an image control to a media control so it saves the attachment ID instead of a URL.

## 1.3.1

* Fixing an issue with the address shortcode when not using any formatting.

## 1.3.0

* Adding Instagram to the list of social network options.

## 1.2.0

* Removing the wpautop reordering function because it interferes with the Gravity Forms shortcode output.

## 1.1.1

* Modifying the schema tags for the address so it uses a span tag instead of a div tag.

## 1.1.0

* Adding support for showing addresses not formatted (on one line).
* Adding a function that moves wpautop priority higher so shortcodes used within page/post content are formatted with paragraphs and line breaks.

## 1.0.1

* Adding a missing constant that was causing some PHP warnings and an issue with the social network links widget.

## 1.0.0

* Working version of the plugin upon approval by Wordpress.org

## 0.0.13

* Renaming the plugins directory to plugin-addons and updating the calls to those files accordingly.

## 0.0.12

* Fixing the inclusion of files to ensure the plugin works for all setups of Wordpress.
* Fixing the uninstall file as per the Wordpress codex.

## 0.0.11

* Removing the default shortcode attribute for 'link' for the email and phone shortcodes.

## 0.0.10

* Removing the shortcode <p> tag fix.
* Adding support for schema markup when outputting the contact information.
* Making the phone and email shortcodes only show as links if the link parameter was set to true, instead of checking if it's set to false.

## 0.0.9

* Fixing an issue where the logo alt tag wasn't being overridden properly.

## 0.0.8

* Enabling shortcodes in text widget content.
* Adding support for additional social networks as well as a social network widget that outputs colorful icons for each network.
* Adding support for the user specifying additional contact information fields via the options page.
* Reordering the filters on the_content to ensure paragraphs and line breaks around our shortcodes render properly.
* Updating readme files.

## 0.0.7

* Outputting the phone number and email address as a hyperlink, with the ability to output a plain value via the shortcode 'link' parameter.

## 0.0.6

* Updating the readme and adding a WP.org readme in preparation for submitting this plugin.
* Adding a shortcode for outputting the logo.
* Adding a help tab that tells the user what shortcodes are available.

## 0.0.5

* Adding the branding logo field into the Customizer so users can edit it there too.

## 0.0.4

* Removing support for favicons in sites running WP 4.3 and up.

## 0.0.3

* Enabling the plugin to be updated through the WP admin area from the GitHub repo.
* Adding an uninstall file to remove the options created by our plugin.

## 0.0.2

* Adding success messages when saving the settings pages.
* Adding support for the WP Admin Instructions plugin.
* Allowing the user to specify a wrapper class name around the social networks.
* Adding a social networks field.
* Adding shortcodes for each of the fields.
* Adding an options page for the contact information.
* Adding a custom CMB2 field for creating an address field.
* Adding a variable for the options page slug and changing it to branding.
* Adding a changelog and readme.
* Adding the CMB2 script to the repo.
* Moving the get_option call and saving it as a variable before checking whether it's empty.
* Renaming the branding class file to match the plugin slug.

## 0.0.1

* Initial version of the plugin with the branding logo and favicon integrated.