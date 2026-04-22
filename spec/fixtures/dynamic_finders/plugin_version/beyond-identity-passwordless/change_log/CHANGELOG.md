# Beyond Identity Changelog

## [1.0.0] - 2023-04-03

- Initial release of the Beyond Identity Passwordless Authentication plugin.

- Adds the ability to generate a Beyond Identity Universal Passkey that is sent to the users email address or directly created when the user is logged in.
- Adds a customizable shortcodes to generate passkeys.
- Adds a Beyond Identity settings page to configure the Beyond Identity account.
- Adds a Beyond Identity users filter to the admin users page to display users who have a Beyond Identity ID.

- Integrates with the WordPress login flow and provides a fallback option for users who prefer to log in with a password.

- Uses OpenID Connect (OIDC) protocol for authentication, based on the OpenID Connect Generic Client v3.9.1 licensed under GPLv2 or later.

- Licensed under the GNU General Public License (GPL) version 2 or later, consistent with OpenID Connect Generic Client plugin.

- Removes the following OpenID Connect Generic Client files as they are not necessary for the Beyond Identity Passwordless Authentication plugin and helps to reduce the plugin size and complexity:

  - CHANGELOG.md
  - readme.txt
  - docker-compose.yml
  - docker-compose.wp-env.yml
  - openid-connect-generic-settings-page.php

- Removes the OpenID Connect Generic Client settings page as all values can be configured from the Beyond Identity settings page.
- Removes the OpenID Connect Generic Client button from the WordPress login page.
- Removes the OpenID Connect Generic Client upgrade.
- Removes the OpenID Connect Generic Client cron jobs.
- Removes the OpenID Connect Generic Client Activation and Deactivation hooks.
- Removes the OpenID_Connect_Generic_Option_Logger.

- Modifies the OpenID Connect Generic Client shortcode default button_text from "Login with OpenID Connect" to "Log in Passwordless" to reflect the passwordless authentication option.
- Modifies the OpenID Connect Generic Client shortcode to allow customized redirect_to.
- Modifies OpenID_Connect_Generic class to remove the OpenID_Connect_Generic_Settings_Page class.
- Modifies OpenID_Connect_Generic bootstrap() to use Beyond Identity values set in the Beyond Identity settings page for the OpenID_Connect_Generic_Option_Settings class initalization.
- Modifies OpenID_Connect_Generic login button shortcode with button color, text color and border color attributes.
- Modified OpenID_Connect_Generic_Client_Wrapper to not redirect back to origin page. This may cause an infinite loop when generating passkeys. Instead, the forms dictate the redirect_to parameter.
- Modified OpenID_Connect_Generic_Client_Wrapper to use the user's email for display_name and nickname.
- Modified OpenID_Connect_Generic_Option_Settings set values as the default_settings.

- Rename OpenID_Connect_Generic login button shortcode to beyond_identity_login_button
- Rename OpenID_Connect_Generic authentication URL shortcode to beyond_identity_auth_url.

- Prefix all OpenID_Connect with BYNDID to address Wordpress plugin review.
- Rename filters with beyond-identity-passwordless
- Rename text domain to beyond-identity-passwordless 
