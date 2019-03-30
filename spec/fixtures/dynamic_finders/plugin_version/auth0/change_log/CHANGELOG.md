# Change Log

## [3.9.0](https://github.com/auth0/wp-auth0/tree/3.9.0) (2019-01-11)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.8.1...3.9.0)

### Notes on this release

- Added a complete Spanish translation!
- Email changes for WordPress users now work properly and are rejected clearly if Auth0 rejects the change. This does not affect the email verification process in WordPress; the email is changed only after the verification happens. A current API token is not required but your Application does need to allow for a Client Credentials grant with the Management API (this configured for you by default, [more information here](https://auth0.com/docs/cms/wordpress/configuration#authorize-the-application-for-the-management-api)). 
- Sibling sub-domains are now allowed for the Login Redirect URL. Anything within the same domain name as the site URL can now be saved. 
- Default Auth0 IP addresses are now allowed by default on the user migration endpoints. Adding or changing the IP addresses for the "Migration IPs Whitelist" field will not affect default IPs. 
- User migration endpoints were improved to provide better errors when requests are rejected and more clear custom database scripts that can be used as an example when setting up the migration manually. Switching this setting on or off does not make any changes in the Auth0 dashboard or to the existing token, it only makes the endpoints available or not.  
- The Social Amplificator functionality has been removed. 

**Added**
- Update Translations [\#615](https://github.com/auth0/wp-auth0/pull/615) ([joshcanhelp](https://github.com/joshcanhelp))
- Allow subdomains in redirect and refactor validation tests [\#601](https://github.com/auth0/wp-auth0/pull/601) ([joshcanhelp](https://github.com/joshcanhelp))
- Whitelist Auth0 IPs by default and show in wp-admin [\#596](https://github.com/auth0/wp-auth0/pull/596) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix migration login route output and add tests [\#595](https://github.com/auth0/wp-auth0/pull/595) ([joshcanhelp](https://github.com/joshcanhelp))
- Added filter to allow for changing the output of die_on_login [\#593](https://github.com/auth0/wp-auth0/pull/593) ([coperator](https://github.com/coperator))
- Spanish translation by Carlos Longarela [\#526](https://github.com/auth0/wp-auth0/pull/526) ([CarlosLongarela](https://github.com/CarlosLongarela))

**Changed**
- Refactor migration route handling and add tests [\#606](https://github.com/auth0/wp-auth0/pull/606) ([joshcanhelp](https://github.com/joshcanhelp))
- Remove unnecessary callback; add notice if plugin is already setup [\#604](https://github.com/auth0/wp-auth0/pull/604) ([joshcanhelp](https://github.com/joshcanhelp))
- Refactor migration token validation and match entire token on endpoints [\#602](https://github.com/auth0/wp-auth0/pull/602) ([joshcanhelp](https://github.com/joshcanhelp))
- Update translations [\#599](https://github.com/auth0/wp-auth0/pull/599) ([joshcanhelp](https://github.com/joshcanhelp))
- Refactor and tests for user migration get user route [\#598](https://github.com/auth0/wp-auth0/pull/598) ([joshcanhelp](https://github.com/joshcanhelp))
- Move custom DB scripts to separate files [\#592](https://github.com/auth0/wp-auth0/pull/592) ([joshcanhelp](https://github.com/joshcanhelp))

**Deprecated**
- Deprecations for ip_range setting [\#618](https://github.com/auth0/wp-auth0/pull/618) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate Social Amplificator classes + methods [\#612](https://github.com/auth0/wp-auth0/pull/612) ([joshcanhelp](https://github.com/joshcanhelp))

**Removed**
- Remove unused IP range setting [\#616](https://github.com/auth0/wp-auth0/pull/616) ([joshcanhelp](https://github.com/joshcanhelp))
- Remove Social Amplificator functionality [\#607](https://github.com/auth0/wp-auth0/pull/607) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Fix Migration Token Generation; Add JSON Content-Type header [\#617](https://github.com/auth0/wp-auth0/pull/617) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix escaped passwords sent to Auth0 [\#611](https://github.com/auth0/wp-auth0/pull/611) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix notice when settings constant is defined too late [\#600](https://github.com/auth0/wp-auth0/pull/600) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix email update on Auth0 [\#594](https://github.com/auth0/wp-auth0/pull/594) ([joshcanhelp](https://github.com/joshcanhelp))

**Closed issues**
- Invalid State error 100% of the time [\#597](https://github.com/auth0/wp-auth0/issues/597)
- Update docs [\#591](https://github.com/auth0/wp-auth0/issues/591)
- Correct dimensions for custom login icon [\#586](https://github.com/auth0/wp-auth0/issues/586)
- Basic settings edit box doesn't show values from AUTH0_ENV_* constants [\#569](https://github.com/auth0/wp-auth0/issues/569)
- Better documentation of User Migration endpoints with manual setup [\#542](https://github.com/auth0/wp-auth0/issues/542)
- Keep getting logged out once SSO is turned on [\#541](https://github.com/auth0/wp-auth0/issues/541)

## [3.8.1](https://github.com/auth0/wp-auth0/tree/3.8.1) (2018-11-14)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.8.0...3.8.1)

**Closed issues**
- Javascript: Use readonly instead of disabled on email field [\#587](https://github.com/auth0/wp-auth0/issues/587)

**Changed**
- Change logged-in user redirect to login_init hook [\#584](https://github.com/auth0/wp-auth0/pull/584) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Switch email field property to readonly [\#588](https://github.com/auth0/wp-auth0/pull/588) ([joshcanhelp](https://github.com/joshcanhelp))
- Add WooCommerce password change action. [\#585](https://github.com/auth0/wp-auth0/pull/585) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix Connection update over-writing Connection settings. [\#582](https://github.com/auth0/wp-auth0/pull/582) ([joshcanhelp](https://github.com/joshcanhelp))


## [3.8.0](https://github.com/auth0/wp-auth0/tree/3.8.0) (2018-11-06)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.7.1...3.8.0)

### Notes on this release

- Administrators can now mark certain strategies as able to skip email verification. This is typically used for Enterprise strategies that do not provide an email verification flag. This should be used sparingly and only for connections that do not provide this flag. 
- Password changes for WordPress users now work properly and are rejected clearly if Auth0 rejects the change (typically because the password does not conform to the password policy). A current API token is not required but your Application does need to allow for a Client Credentials grant with the Management API (this configured for you by default, [more information here](https://auth0.com/docs/cms/wordpress/configuration#authorize-the-application-for-the-management-api)). 
- The `wp-login.php` page is no longer used for any callback processing. If you are using this page to process callbacks in a custom plugin or theme, please update to use the main callback URL for the implicit flow `/index.php?auth0=implicit`. In addition, users that are already logged in will be redirected to the default login page when accessing `wp-login.php`.
- Error logging has been improved in general, along with improvements to the error log display. Consecutive, duplicate errors are now combined, the error log now shows more entries, and entries can be cleared from the admin. 
- The "Auto-Login" setting has been renamed to "Universal Login Page" and moved from the Advanced tab to the Features tab. The functionality is the same as before and will retain the existing setting.

### Issues and PRs 

**Closed issues**
- Plugin tries to create a user if they log in a different way [\#539](https://github.com/auth0/wp-auth0/issues/539)
- Problems with implicit login in > 3.6 [\#536](https://github.com/auth0/wp-auth0/issues/536)
- Add authorization token to header for external request [\#534](https://github.com/auth0/wp-auth0/issues/534)
- Configuring auth0 OIDC URL parameters [\#521](https://github.com/auth0/wp-auth0/issues/521)
- Single sign on shows the login username/password fields briefly before automatically signing in [\#508](https://github.com/auth0/wp-auth0/issues/508)
- Better behavior when logged-in users visits wp-login.php [\#414](https://github.com/auth0/wp-auth0/issues/414)
- Profile password update changes [\#375](https://github.com/auth0/wp-auth0/issues/375)
- auth0 forgot password doesn't change WP password [\#310](https://github.com/auth0/wp-auth0/issues/310)
- Woocommerce can't change user password [\#300](https://github.com/auth0/wp-auth0/issues/300)

**Added**
- Update translation file [\#561](https://github.com/auth0/wp-auth0/pull/561) ([joshcanhelp](https://github.com/joshcanhelp))
- Add Management API framework [WIP] [\#537](https://github.com/auth0/wp-auth0/pull/537) ([joshcanhelp](https://github.com/joshcanhelp))
- Update README, CONTRIBUTION, LICENSE, and Issue+PR templates [\#533](https://github.com/auth0/wp-auth0/pull/533) ([joshcanhelp](https://github.com/joshcanhelp))
- Add filters for authorize URL and params, logout URL + tests [\#531](https://github.com/auth0/wp-auth0/pull/531) ([joshcanhelp](https://github.com/joshcanhelp))
- Improve error log [\#530](https://github.com/auth0/wp-auth0/pull/530) ([joshcanhelp](https://github.com/joshcanhelp))
- Add skip strategies setting and tests [\#528](https://github.com/auth0/wp-auth0/pull/528) ([joshcanhelp](https://github.com/joshcanhelp))

**Changed**
- Update telemetry header [\#577](https://github.com/auth0/wp-auth0/pull/577) ([joshcanhelp](https://github.com/joshcanhelp))
- Update JWT library [\#576](https://github.com/auth0/wp-auth0/pull/576) ([joshcanhelp](https://github.com/joshcanhelp))
- Change deprecation error handling [\#574](https://github.com/auth0/wp-auth0/pull/574) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix tests to run in same process [\#565](https://github.com/auth0/wp-auth0/pull/565) ([joshcanhelp](https://github.com/joshcanhelp))
- Rename the Auto Login setting to ULP; move to features tab [\#551](https://github.com/auth0/wp-auth0/pull/551) ([joshcanhelp](https://github.com/joshcanhelp))
- Switch implicit flow to hybrid flow and correct Management API scopes [\#546](https://github.com/auth0/wp-auth0/pull/546) ([joshcanhelp](https://github.com/joshcanhelp))
- Update README and version number for dev->master merge [\#543](https://github.com/auth0/wp-auth0/pull/543) ([joshcanhelp](https://github.com/joshcanhelp))

**Deprecated**
- Deprecate unused rules JS [\#560](https://github.com/auth0/wp-auth0/pull/560) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate WP_Auth0_Email_Verification::ajax_resend_email [\#559](https://github.com/auth0/wp-auth0/pull/559) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate a0_render_message method [\#558](https://github.com/auth0/wp-auth0/pull/558) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate unused login methods and props [\#557](https://github.com/auth0/wp-auth0/pull/557) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate WP_Auth0_Options connection methods [\#556](https://github.com/auth0/wp-auth0/pull/556) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate WP_Auth0_Referer_Check [\#555](https://github.com/auth0/wp-auth0/pull/555) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate WP_Auth0_Metrics [\#554](https://github.com/auth0/wp-auth0/pull/554) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate WP_Auth0_InitialSetup_Signup, remove usage [\#553](https://github.com/auth0/wp-auth0/pull/553) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate methods in WP_Auth0_Api_Operations and related ones in WP_Auth0 [\#552](https://github.com/auth0/wp-auth0/pull/552) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate unused methods and classes for initial setup [\#550](https://github.com/auth0/wp-auth0/pull/550) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate unused methods in WP_Auth0_Api_Client [\#549](https://github.com/auth0/wp-auth0/pull/549) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecations for WP_Auth0_EditProfile [\#548](https://github.com/auth0/wp-auth0/pull/548) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecations for WP_Auth0_EditProfile [\#547](https://github.com/auth0/wp-auth0/pull/547) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Fix label font-weight and migration token display [\#579](https://github.com/auth0/wp-auth0/pull/579) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix user profile saving [\#573](https://github.com/auth0/wp-auth0/pull/573) ([joshcanhelp](https://github.com/joshcanhelp))
- Update phpcs script and dependent libs [\#572](https://github.com/auth0/wp-auth0/pull/572) ([joshcanhelp](https://github.com/joshcanhelp))
- Move SSO checking into Lock init [\#570](https://github.com/auth0/wp-auth0/pull/570) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix migration token display to allow copying [\#540](https://github.com/auth0/wp-auth0/pull/540) ([joshcanhelp](https://github.com/joshcanhelp))
- Change and improve user profile [\#532](https://github.com/auth0/wp-auth0/pull/532) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Fix label font-weight and migration token display [\#579](https://github.com/auth0/wp-auth0/pull/579) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix user profile saving [\#573](https://github.com/auth0/wp-auth0/pull/573) ([joshcanhelp](https://github.com/joshcanhelp))
- Update phpcs script and dependent libs [\#572](https://github.com/auth0/wp-auth0/pull/572) ([joshcanhelp](https://github.com/joshcanhelp))
- Move SSO checking into Lock init [\#570](https://github.com/auth0/wp-auth0/pull/570) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix migration token display to allow copying [\#540](https://github.com/auth0/wp-auth0/pull/540) ([joshcanhelp](https://github.com/joshcanhelp))
- Change and improve user profile [\#532](https://github.com/auth0/wp-auth0/pull/532) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.7.1](https://github.com/auth0/wp-auth0/tree/3.7.1) (2018-10-08)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.7.0...3.7.1)

**Closed issues**
- "search_engine=v2 is not available for your tenant because it is deprecated" error [\#562](https://github.com/auth0/wp-auth0/issues/562)

**Fixed**
- 3.7.1 patch release to fix user search engine in rules [\#563](https://github.com/auth0/wp-auth0/pull/563) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.7.0](https://github.com/auth0/wp-auth0/tree/3.7.0) (2018-08-13)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.6.2...3.7.0)

**Closed issues**
- Optionally load client ID, secret and domain from environment [\#480](https://github.com/auth0/wp-auth0/issues/480)
- Allow login redirect URL to point to an in-network domain for multi-site [\#459](https://github.com/auth0/wp-auth0/issues/459)

**Added**
- Add new IP addresses and tests for WP_Auth0_Ip_Check [\#513](https://github.com/auth0/wp-auth0/pull/513) ([joshcanhelp](https://github.com/joshcanhelp))
- Add constant settings support [\#509](https://github.com/auth0/wp-auth0/pull/509) ([joshcanhelp](https://github.com/joshcanhelp))
- Add translation ability [\#507](https://github.com/auth0/wp-auth0/pull/507) ([joshcanhelp](https://github.com/joshcanhelp))
- Add more info to Contributing section, including tests [\#506](https://github.com/auth0/wp-auth0/pull/506) ([joshcanhelp](https://github.com/joshcanhelp))
- Add custom domain support with tests; add compat test to Circle CI [\#505](https://github.com/auth0/wp-auth0/pull/505) ([joshcanhelp](https://github.com/joshcanhelp))
- Add testing suite, initial tests, and CircleCI [\#503](https://github.com/auth0/wp-auth0/pull/503) ([joshcanhelp](https://github.com/joshcanhelp))
- Add code quality tools and contrib instructions [\#498](https://github.com/auth0/wp-auth0/pull/498) ([joshcanhelp](https://github.com/joshcanhelp))

**Changed**
- Update new Application creation URLs [\#514](https://github.com/auth0/wp-auth0/pull/514) ([joshcanhelp](https://github.com/joshcanhelp))
- Add support for subdomains and different scheme URLs for redirect [\#512](https://github.com/auth0/wp-auth0/pull/512) ([joshcanhelp](https://github.com/joshcanhelp))
- Update wordpress.org readme [\#500](https://github.com/auth0/wp-auth0/pull/500) ([joshcanhelp](https://github.com/joshcanhelp))

**Removed**
- Remove account cleanup tool [\#510](https://github.com/auth0/wp-auth0/pull/510) ([joshcanhelp](https://github.com/joshcanhelp))
- Remove connection settings [\#502](https://github.com/auth0/wp-auth0/pull/502) ([joshcanhelp](https://github.com/joshcanhelp))
- Remove signup disabling [\#501](https://github.com/auth0/wp-auth0/pull/501) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Fix login processing if already logged in [\#518](https://github.com/auth0/wp-auth0/pull/518) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix PHP notice for Amplificator widget [\#511](https://github.com/auth0/wp-auth0/pull/511) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix whitespace [\#499](https://github.com/auth0/wp-auth0/pull/499) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.6.2](https://github.com/auth0/wp-auth0/tree/3.6.2) (2018-06-29)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.6.1...3.6.2)

**Closed issues**
- `auth0_state` cookie and Pantheon [\#494](https://github.com/auth0/wp-auth0/issues/494)
- Question: Way to visit directly to Sign Up tab? [\#489](https://github.com/auth0/wp-auth0/issues/489)
- Custom Fields  [\#487](https://github.com/auth0/wp-auth0/issues/487)
- TypeError: jQuery(...).tab is not a function [\#484](https://github.com/auth0/wp-auth0/issues/484)
- Error - auth0 cannot find node with id "auth0-login-form" [\#483](https://github.com/auth0/wp-auth0/issues/483)

**Added**
- Add a filter for nonce and state cookie names [\#495](https://github.com/auth0/wp-auth0/pull/495) ([joshcanhelp](https://github.com/joshcanhelp))
- Add error handling for JWT decode [\#492](https://github.com/auth0/wp-auth0/pull/492) ([joshcanhelp](https://github.com/joshcanhelp))
- Show signup tab if action=register on wp-login.php page [\#490](https://github.com/auth0/wp-auth0/pull/490) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Fix missing signup fields [\#491](https://github.com/auth0/wp-auth0/pull/491) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix import-export tabs not working [\#486](https://github.com/auth0/wp-auth0/pull/486) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.6.1](https://github.com/auth0/wp-auth0/tree/3.6.1) (2018-06-07)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.6.0...3.6.1)

**Closed issues**
- No versions in Wordpress plugin repo [\#478](https://github.com/auth0/wp-auth0/issues/478)
- Javascript error loading Customize [\#476](https://github.com/auth0/wp-auth0/issues/476)

**Fixed**
- Fix SLO callback URL  [\#479](https://github.com/auth0/wp-auth0/pull/479) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix Customizer failing after upgrade; fix widget settings [\#477](https://github.com/auth0/wp-auth0/pull/477) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.6.0](https://github.com/auth0/wp-auth0/tree/3.6.0) (2018-06-05)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.5.2...3.6.0)

**NOTES**

- Passwordless was reconfigured completely to use the combined Lock library (currently hard-coded to 11.5). All current settings will be migrated to the new configuration so your login process should not change. Lock initiation has also been refactored to improve maintainability and adhere to WordPress standards. 
- The Setup Wizard has been adjusted to more clearly explain the process and options available. This only affects new installations using the Setup Wizard for configuration.
- The settings page has been rearranged and improved overall. New settings descriptions have also been added along with links to documentation, where appropriate.
- State validation was added to both login flows; nonce validation was added to sites using Implicit flow. 
- OIDC compliant Applications should now function as expected (though this setting is not yet activated by default on installation). OpenID Connect login is now possible by turning off the Client Credentials grant for your WordPress Application. 
- Dashboard widgets have been removed. This can easily be added back as a plugin, if needed. Please [contact support](https://support.auth0.com/) if you need assistance with this. 
- A number of new hooks have been added, please see our [docs page on extension](https://auth0.com/docs/cms/wordpress/extending) for a complete inventory with examples. This includes the ability to support refresh tokens. 
- Federated logout has been removed. 


**Closed issues**

- Expose a configurable toggle that allows Users to state if federated logout should be used [\#471](https://github.com/auth0/wp-auth0/issues/471)
- Updating to 3.5.2 - Fatal error: Uncaught Error: Cannot use object of type stdClass as array in /app/wp-content/plugins/auth0/lib/WP_Auth0_DBManager.php on line 225 [\#464](https://github.com/auth0/wp-auth0/issues/464)
- Autoloader performance issue [\#461](https://github.com/auth0/wp-auth0/issues/461)
- Bad request does not raise error [\#432](https://github.com/auth0/wp-auth0/issues/432)
- Widget URL changes don't save when you are using passwordless [\#430](https://github.com/auth0/wp-auth0/issues/430)
- Deprecate `oauth/ro` endpoint [\#410](https://github.com/auth0/wp-auth0/issues/410)
- Handling errors [\#403](https://github.com/auth0/wp-auth0/issues/403)
- Fallback /api/v2/users/{id} to /userinfo [\#401](https://github.com/auth0/wp-auth0/issues/401)
- CORS errors [\#400](https://github.com/auth0/wp-auth0/issues/400)
- Provide Resend verification email only for DB connections [\#345](https://github.com/auth0/wp-auth0/issues/345)
- SSO disabled, Single Logout enabled causes users to get logged out automatically a few seconds after logging in [\#336](https://github.com/auth0/wp-auth0/issues/336)
- French translation  : html characters [\#309](https://github.com/auth0/wp-auth0/issues/309)
- "Invalid authorization code": Access token is requested twice in a row, breaking the login flow [\#305](https://github.com/auth0/wp-auth0/issues/305)
- Make state work after SSO login [\#302](https://github.com/auth0/wp-auth0/issues/302)
- Is there a way to use Refresh Tokens and Wordpress? [\#296](https://github.com/auth0/wp-auth0/issues/296)
- Only decode the payload before user profile fetch in login manager [\#283](https://github.com/auth0/wp-auth0/issues/283)
- redirect callback errors [\#280](https://github.com/auth0/wp-auth0/issues/280)
- Linked Users won't be able to login using implicit flow and pipeline 2 [\#272](https://github.com/auth0/wp-auth0/issues/272)
- Normalize use of shortcode and widget [\#260](https://github.com/auth0/wp-auth0/issues/260)
- Wrong z-index on modal error message in manual setup [\#252](https://github.com/auth0/wp-auth0/issues/252)
- Logout does not work when Wordpress is locked down (private site) [\#39](https://github.com/auth0/wp-auth0/issues/39)

**Added**

- Adding refresh token support; adjusting default scope [\#456](https://github.com/auth0/wp-auth0/pull/456) ([joshcanhelp](https://github.com/joshcanhelp))
- Add code quality tools, improved composer.json [\#454](https://github.com/auth0/wp-auth0/pull/454) ([joshcanhelp](https://github.com/joshcanhelp))
- Add /userinfo fallback during login [\#423](https://github.com/auth0/wp-auth0/pull/423) ([joshcanhelp](https://github.com/joshcanhelp))
- State handling during login process for both types [\#406](https://github.com/auth0/wp-auth0/pull/406) ([joshcanhelp](https://github.com/joshcanhelp))

**Changed**

- Change token exchange redirect URL to match what was sent for auth code [\#463](https://github.com/auth0/wp-auth0/pull/463) ([joshcanhelp](https://github.com/joshcanhelp))
- Hide the signup tab if registrations are turned off [\#460](https://github.com/auth0/wp-auth0/pull/460) ([joshcanhelp](https://github.com/joshcanhelp))
- New class for state handling; set cookie for implicit nonce [\#458](https://github.com/auth0/wp-auth0/pull/458) ([joshcanhelp](https://github.com/joshcanhelp))
- Change auto-login action [\#449](https://github.com/auth0/wp-auth0/pull/449) ([joshcanhelp](https://github.com/joshcanhelp))
- Require telemetry for API calls [\#441](https://github.com/auth0/wp-auth0/pull/441) ([joshcanhelp](https://github.com/joshcanhelp))
- Change Appearance tab settings output [\#439](https://github.com/auth0/wp-auth0/pull/439) ([joshcanhelp](https://github.com/joshcanhelp))
- Change Feature settings output [\#436](https://github.com/auth0/wp-auth0/pull/436) ([joshcanhelp](https://github.com/joshcanhelp))
- Change Basic settings field display; better admin UX [\#433](https://github.com/auth0/wp-auth0/pull/433) ([joshcanhelp](https://github.com/joshcanhelp))
- Change how Advanced admin settings fields are output [\#429](https://github.com/auth0/wp-auth0/pull/429) ([joshcanhelp](https://github.com/joshcanhelp))
- Setting titles and option names [\#427](https://github.com/auth0/wp-auth0/pull/427) ([joshcanhelp](https://github.com/joshcanhelp))
- Clean up admin notices [\#421](https://github.com/auth0/wp-auth0/pull/421) ([joshcanhelp](https://github.com/joshcanhelp))
- Change asset enqueuing [\#419](https://github.com/auth0/wp-auth0/pull/419) ([joshcanhelp](https://github.com/joshcanhelp))
- Improve WP_Auth0_Options [\#418](https://github.com/auth0/wp-auth0/pull/418) ([joshcanhelp](https://github.com/joshcanhelp))

**Deprecated**

- Deprecate 2 lookup methods [\#446](https://github.com/auth0/wp-auth0/pull/446) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecating wp-admin settings-related methods + classes [\#445](https://github.com/auth0/wp-auth0/pull/445) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecating unused Lock Options classes and methods [\#444](https://github.com/auth0/wp-auth0/pull/444) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecating admin_enqueue functions [\#443](https://github.com/auth0/wp-auth0/pull/443) ([joshcanhelp](https://github.com/joshcanhelp))
- Deprecate oauth/ro endpoint [\#413](https://github.com/auth0/wp-auth0/pull/413) ([joshcanhelp](https://github.com/joshcanhelp))

**Removed**

- Remove wp-admin click tracking [\#451](https://github.com/auth0/wp-auth0/pull/451) ([joshcanhelp](https://github.com/joshcanhelp))
- Remove dashboard widgets [\#428](https://github.com/auth0/wp-auth0/pull/428) ([joshcanhelp](https://github.com/joshcanhelp))
- Remove and migrate Passwordless setting [\#425](https://github.com/auth0/wp-auth0/pull/425) ([joshcanhelp](https://github.com/joshcanhelp))
- Remove api_audience settings field [\#422](https://github.com/auth0/wp-auth0/pull/422) ([joshcanhelp](https://github.com/joshcanhelp))
- Removing dashboard widgets [\#397](https://github.com/auth0/wp-auth0/pull/397) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**

- Correcting input field height on settings pages for IE [\#472](https://github.com/auth0/wp-auth0/pull/472) ([joshcanhelp](https://github.com/joshcanhelp))
- Save sub or user_id if not provided; remove extemporaneous ID token attributes [\#469](https://github.com/auth0/wp-auth0/pull/469) ([joshcanhelp](https://github.com/joshcanhelp))
- Improve Setup Wizard [\#468](https://github.com/auth0/wp-auth0/pull/468) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix install and DB update errors [\#467](https://github.com/auth0/wp-auth0/pull/467) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix SLO redirect, SLO on when SSO off, SSO setting not pushed to dashboard [\#466](https://github.com/auth0/wp-auth0/pull/466) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed auto-loader to skip non-WP-Auth0 classes [\#465](https://github.com/auth0/wp-auth0/pull/465) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix empty path notice on initial setup [\#457](https://github.com/auth0/wp-auth0/pull/457) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix logout process [\#453](https://github.com/auth0/wp-auth0/pull/453) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix help tab text and settings tab UX [\#452](https://github.com/auth0/wp-auth0/pull/452) ([joshcanhelp](https://github.com/joshcanhelp))
- Only show email verification resend for DB connections [\#447](https://github.com/auth0/wp-auth0/pull/447) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix Passwordless handling; update Lock instantiation [\#434](https://github.com/auth0/wp-auth0/pull/434) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix Implicit login handling [\#426](https://github.com/auth0/wp-auth0/pull/426) ([joshcanhelp](https://github.com/joshcanhelp))
- Admin settings refactor - WP_Auth0_Admin_Generic [\#416](https://github.com/auth0/wp-auth0/pull/416) ([joshcanhelp](https://github.com/joshcanhelp))
- Fix Login Process Error Handling [\#409](https://github.com/auth0/wp-auth0/pull/409) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.5.2](https://github.com/auth0/wp-auth0/tree/3.5.2) (2018-02-22)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.5.1...3.5.2)

**Closed issues**
- [Security] [URGENT] XSS injection error page [\#381](https://github.com/auth0/wp-auth0/issues/381)
- Non-static method WP_Auth0_Api_Client::convertCertToPem() should not be called statically [\#380](https://github.com/auth0/wp-auth0/issues/380)
- Notices in /lib/admin/WP_Auth0_Admin_Advanced.php [\#374](https://github.com/auth0/wp-auth0/issues/374)
- SSO login failing when not using implicit flow [\#363](https://github.com/auth0/wp-auth0/issues/363)
- "Override WordPress avatars" option doesn't appear to work with comments [\#355](https://github.com/auth0/wp-auth0/issues/355)
- Change log is missing from readme.txt, the separate changelog file is not updated [\#346](https://github.com/auth0/wp-auth0/issues/346)
- Uninstall doesn't remove all Auth0 database plugin entries [\#322](https://github.com/auth0/wp-auth0/issues/322)
- Unable to save migration IPs whitelist [\#320](https://github.com/auth0/wp-auth0/issues/320)
- 3.2.16 throws errors if Error Log is empty [\#285](https://github.com/auth0/wp-auth0/issues/285)
- Login plugin form name incorrect [\#269](https://github.com/auth0/wp-auth0/issues/269)

**Changed**
- Readme updates [\#392](https://github.com/auth0/wp-auth0/pull/392) ([joshcanhelp](https://github.com/joshcanhelp))
- Changed error handling [\#384](https://github.com/auth0/wp-auth0/pull/384) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Changing boolval() and array shorthand to PHP 5.3-compatable [\#402](https://github.com/auth0/wp-auth0/pull/402) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed SSO auto-login in Lock [\#394](https://github.com/auth0/wp-auth0/pull/394) ([joshcanhelp](https://github.com/joshcanhelp))
- Renaming un-deprecated function [\#393](https://github.com/auth0/wp-auth0/pull/393) ([joshcanhelp](https://github.com/joshcanhelp))
- Cleanup PR for 3.5.2 [\#391](https://github.com/auth0/wp-auth0/pull/391) ([joshcanhelp](https://github.com/joshcanhelp))
- Improved setup wizard client create process [\#389](https://github.com/auth0/wp-auth0/pull/389) ([joshcanhelp](https://github.com/joshcanhelp))
- Deleting all added options and transients on uninstall [\#387](https://github.com/auth0/wp-auth0/pull/387) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed wrong title and icon for login widget [\#385](https://github.com/auth0/wp-auth0/pull/385) ([joshcanhelp](https://github.com/joshcanhelp))
- XSS in error query vars [\#383](https://github.com/auth0/wp-auth0/pull/383) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed migration IPs being saved [\#382](https://github.com/auth0/wp-auth0/pull/382) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed get_avatar hooked function to account for other user identifiers [\#376](https://github.com/auth0/wp-auth0/pull/376) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.5.1](https://github.com/auth0/wp-auth0/tree/3.5.1) (2018-01-26)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.5.0...3.5.1)

**Please see note from 3.5.0 below if upgrading from 3.4.0 or earlier**

**Fixed**
- Fixed Client Grant Types during update [\#377](https://github.com/auth0/wp-auth0/pull/377) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.5.0](https://github.com/auth0/wp-auth0/tree/3.5.0) (2018-01-25)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.4.0...3.5.0)

**Please note:** This is a major update that requires changes to your Auth0 Dashboard to be completed. You can save a new [API token](https://auth0.com/docs/api/management/v2/tokens#get-a-token-manually) in your Basic settings in wp-admin before upgrading and the changes will be made automatically during the update. Otherwise, after upgrading, please review your [Application Advanced Settings](https://auth0.com/docs/cms/wordpress/configuration#application-setup), specifically your Grant Types, and [authorize your Client for the Management API](https://auth0.com/docs/cms/wordpress/configuration#authorize-the-client-for-the-management-api). 

**Changed**
- updating CDN URLs for Lock and Auth.js [\#365](https://github.com/auth0/wp-auth0/pull/365) ([joshcanhelp](https://github.com/joshcanhelp))
- Changing home_url() to site_url(), wp_login_url(), and wp_logout_url()  [\#360](https://github.com/auth0/wp-auth0/pull/360) ([joshcanhelp](https://github.com/joshcanhelp))

**Fixed**
- Changing algorithm for migration tokens [\#372](https://github.com/auth0/wp-auth0/pull/372) ([joshcanhelp](https://github.com/joshcanhelp))
- Migration tokens only use HS256 [\#371](https://github.com/auth0/wp-auth0/pull/371) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed automatic setup process for public sites [\#370](https://github.com/auth0/wp-auth0/pull/370) ([joshcanhelp](https://github.com/joshcanhelp))
- Added use Management API for user data [\#368](https://github.com/auth0/wp-auth0/pull/368) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixing DB version upgrade [\#367](https://github.com/auth0/wp-auth0/pull/367) ([joshcanhelp](https://github.com/joshcanhelp))
- Creating client_grant for management API [\#366](https://github.com/auth0/wp-auth0/pull/366) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed login flow for new tenants, refactored verification email resend [\#364](https://github.com/auth0/wp-auth0/pull/364) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixed shortcode warning [\#362](https://github.com/auth0/wp-auth0/pull/362) ([joshcanhelp](https://github.com/joshcanhelp))
- Fixing "Algorithm not allowed" error during user migration [\#361](https://github.com/auth0/wp-auth0/pull/361) ([joshcanhelp](https://github.com/joshcanhelp))
- When activating using wp-cli the plugin should not redirect [\#344](https://github.com/auth0/wp-auth0/pull/344) ([AubreyHewes](https://github.com/AubreyHewes))

## [3.4.0](https://github.com/auth0/wp-auth0/tree/3.4.0) (2018-01-08)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.3.2...3.4.0)

**Added**
- Added Lock 11 / Auth0 9.0, Updated SSO, JWT Algorithm Upgrade Fixes [\#350](https://github.com/auth0/wp-auth0/pull/350) ([cocojoe](https://github.com/cocojoe))
- Add RS256 support [\#331](https://github.com/auth0/wp-auth0/pull/331) ([renrizzolo](https://github.com/renrizzolo))

**Fixed**
- Switching wizard admin user creation to use /dbconnections/signup  [\#356](https://github.com/auth0/wp-auth0/pull/356) ([joshcanhelp](https://github.com/joshcanhelp))

## [3.3.2](https://github.com/auth0/wp-auth0/tree/3.3.2) (2017-10-05)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.3.2...3.2.24)

**Added**
- Added translation support for a few user-facing exception messages [\#312](https://github.com/auth0/wp-auth0/pull/312) ([idpaterson](https://github.com/idpaterson))

**Changed**
- Use literal 'wp-auth0' rather than WPA0_LANG constant [\#311](https://github.com/auth0/wp-auth0/pull/311) ([idpaterson](https://github.com/idpaterson))

**Fixed**
- Properly handle auto login configuration + custom parse url hash in login page ([glena](https://github.com/glena))
- Implicit mode in auto login ([glena](https://github.com/glena))

**Notes**
There is a jump in version due to a release issue which required bumping the version a few times. 

## [3.2.24](https://github.com/auth0/wp-auth0/tree/3.2.23) (2017-08-14)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.2.23...3.2.24)

**Changed**
- More generous JWT leeway [\#332](https://github.com/auth0/wp-auth0/pull/332) ([cocojoe](https://github.com/cocojoe))

**Removed**
- Remove client_id/secret validation since it is not allowed anymore [\#334](https://github.com/auth0/wp-auth0/pull/334) ([glena](https://github.com/glena))

## [3.2.23](https://github.com/auth0/wp-auth0/tree/3.2.23) (2017-07-18)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.2.22...3.2.23)

**Changed**
- Update /authorize URL [\#326](https://github.com/auth0/wp-auth0/pull/326) ([cocojoe](https://github.com/cocojoe))

## [3.2.22](https://github.com/auth0/wp-auth0/tree/3.2.22) (2017-06-26)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.2.21...3.2.22)

**Fixed**
- Fixed migration for older plugins that use base64 secret [\#324](https://github.com/auth0/wp-auth0/pull/324) ([cocojoe](https://github.com/cocojoe))

## [3.2.21](https://github.com/auth0/wp-auth0/tree/3.2.21) (2017-06-14)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.2.5...3.2.21)

**Added**
- Improve redirect_login error logging, JWT leeway [\#317](https://github.com/auth0/wp-auth0/pull/317) ([cocojoe](https://github.com/cocojoe))

**Changed**
- Expand internal login error with hint to disable base 64 encoding [\#318](https://github.com/auth0/wp-auth0/pull/318) ([cocojoe](https://github.com/cocojoe))
- Disable base64_encoded by default [\#313](https://github.com/auth0/wp-auth0/pull/313) ([thameera](https://github.com/thameera))

## [3.2.5](https://github.com/auth0/wp-auth0/tree/3.2.5) (2016-09-07)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.2.0...3.2.5)

**Closed issues:**

- Profile data not returned in get\_auth0userinfo\(\) [\#236](https://github.com/auth0/wp-auth0/issues/236)
- Login Only Not Allowed [\#234](https://github.com/auth0/wp-auth0/issues/234)
- Dashboard widget, Uninitialized string offset [\#232](https://github.com/auth0/wp-auth0/issues/232)
- allow toggle to override users avatars [\#231](https://github.com/auth0/wp-auth0/issues/231)
- Lock in register page does not show custom fields [\#229](https://github.com/auth0/wp-auth0/issues/229)
- Wordpress user creation with duplicate emails [\#219](https://github.com/auth0/wp-auth0/issues/219)
- Setup Wizard errors out halfway [\#218](https://github.com/auth0/wp-auth0/issues/218)
- Add compatibility class that can be used to improve integration with 3rd-party plugins  [\#208](https://github.com/auth0/wp-auth0/issues/208)
- Bug - Twitter authentication fails when user's Twitter name has non-ASCII characters [\#207](https://github.com/auth0/wp-auth0/issues/207)
- Callback URL's not working [\#203](https://github.com/auth0/wp-auth0/issues/203)
- Support Lock10 with custom fields [\#195](https://github.com/auth0/wp-auth0/issues/195)
- Broken \(or confusing?\) flow in creating passwordless auth [\#194](https://github.com/auth0/wp-auth0/issues/194)
- Add support button pointing to support.auth0.com [\#178](https://github.com/auth0/wp-auth0/issues/178)
- Disable social logins [\#153](https://github.com/auth0/wp-auth0/issues/153)

**Merged pull requests:**

- 3.2.5 - Lock 10 custom fields + added avatars + bugfixes [\#237](https://github.com/auth0/wp-auth0/pull/237) ([glena](https://github.com/glena))
- fix migration [\#228](https://github.com/auth0/wp-auth0/pull/228) ([glena](https://github.com/glena))
- fix [\#227](https://github.com/auth0/wp-auth0/pull/227) ([glena](https://github.com/glena))
- Fix federated clientid [\#226](https://github.com/auth0/wp-auth0/pull/226) ([glena](https://github.com/glena))
- changed the federated client metadata url to be relative to th ehome … [\#225](https://github.com/auth0/wp-auth0/pull/225) ([glena](https://github.com/glena))

## [3.2.0](https://github.com/auth0/wp-auth0/tree/3.2.0) (2016-08-16)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.1.4...3.2.0)

**Merged pull requests:**

- Lock10 + guardian support [\#224](https://github.com/auth0/wp-auth0/pull/224) ([glena](https://github.com/glena))
- Force logo to https [\#222](https://github.com/auth0/wp-auth0/pull/222) ([lesaff](https://github.com/lesaff))
- added federated SLO [\#221](https://github.com/auth0/wp-auth0/pull/221) ([glena](https://github.com/glena))

## [3.1.4](https://github.com/auth0/wp-auth0/tree/3.1.4) (2016-07-01)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.1.3...3.1.4)

**Closed issues:**

- Lock blank after signup [\#216](https://github.com/auth0/wp-auth0/issues/216)

**Merged pull requests:**

- 3.1.4 [\#220](https://github.com/auth0/wp-auth0/pull/220) ([glena](https://github.com/glena))

## [3.1.3](https://github.com/auth0/wp-auth0/tree/3.1.3) (2016-06-15)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.1.2...3.1.3)

**Merged pull requests:**

- Add auth0\_before\_login hook and exception type [\#215](https://github.com/auth0/wp-auth0/pull/215) ([schamp](https://github.com/schamp))
- Fix some minor spelling issues in README.md [\#205](https://github.com/auth0/wp-auth0/pull/205) ([thameera](https://github.com/thameera))

## [3.1.2](https://github.com/auth0/wp-auth0/tree/3.1.2) (2016-06-13)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/3.1.1...3.1.2)

**Merged pull requests:**

- refactor error handling, fix rules creation with site name, fix SLO [\#214](https://github.com/auth0/wp-auth0/pull/214) ([glena](https://github.com/glena))

## [3.1.1](https://github.com/auth0/wp-auth0/tree/3.1.1) (2016-06-06)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.2.0...3.1.1)

**Merged pull requests:**

- V3 [\#211](https://github.com/auth0/wp-auth0/pull/211) ([glena](https://github.com/glena))

## [2.2.0](https://github.com/auth0/wp-auth0/tree/2.2.0) (2016-05-11)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.11...2.2.0)

**Closed issues:**

- Connection doesn't require username [\#202](https://github.com/auth0/wp-auth0/issues/202)

**Merged pull requests:**

- 2.2.0 [\#206](https://github.com/auth0/wp-auth0/pull/206) ([glena](https://github.com/glena))

## [2.1.11](https://github.com/auth0/wp-auth0/tree/2.1.11) (2016-04-27)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.9...2.1.11)

**Closed issues:**

- auth0 account creation [\#192](https://github.com/auth0/wp-auth0/issues/192)

**Merged pull requests:**

- v2.1.11 [\#198](https://github.com/auth0/wp-auth0/pull/198) ([glena](https://github.com/glena))
- v2.1.10 [\#197](https://github.com/auth0/wp-auth0/pull/197) ([glena](https://github.com/glena))
- Fix WordPress typo in README [\#193](https://github.com/auth0/wp-auth0/pull/193) ([pieterbeulque](https://github.com/pieterbeulque))

## [2.1.9](https://github.com/auth0/wp-auth0/tree/2.1.9) (2016-04-07)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.8...2.1.9)

**Closed issues:**

- Windows Live logo [\#190](https://github.com/auth0/wp-auth0/issues/190)
- Change name of plugin [\#187](https://github.com/auth0/wp-auth0/issues/187)
- Set up process online / offline [\#156](https://github.com/auth0/wp-auth0/issues/156)

**Merged pull requests:**

- 2.1.9 [\#191](https://github.com/auth0/wp-auth0/pull/191) ([glena](https://github.com/glena))

## [2.1.8](https://github.com/auth0/wp-auth0/tree/2.1.8) (2016-04-05)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.7...2.1.8)

**Closed issues:**

- CTA for account creation [\#183](https://github.com/auth0/wp-auth0/issues/183)

**Merged pull requests:**

- fix css issues [\#189](https://github.com/auth0/wp-auth0/pull/189) ([glena](https://github.com/glena))

## [2.1.7](https://github.com/auth0/wp-auth0/tree/2.1.7) (2016-04-05)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.6...2.1.7)

**Closed issues:**

- change error message [\#186](https://github.com/auth0/wp-auth0/issues/186)
- Make WP plugin installation entirely & fully automatic [\#184](https://github.com/auth0/wp-auth0/issues/184)
- Maybe trim CSS on feedback  [\#182](https://github.com/auth0/wp-auth0/issues/182)
- tracking for "powered by..." image [\#180](https://github.com/auth0/wp-auth0/issues/180)
- import-export settings [\#175](https://github.com/auth0/wp-auth0/issues/175)
- help [\#170](https://github.com/auth0/wp-auth0/issues/170)
- Add a help tab [\#168](https://github.com/auth0/wp-auth0/issues/168)

**Merged pull requests:**

- 2.1.7 [\#188](https://github.com/auth0/wp-auth0/pull/188) ([glena](https://github.com/glena))
- Added Scope Resolution to unserialize function call [\#181](https://github.com/auth0/wp-auth0/pull/181) ([caseyjbenko](https://github.com/caseyjbenko))

## [2.1.6](https://github.com/auth0/wp-auth0/tree/2.1.6) (2016-03-23)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.5...2.1.6)

## [2.1.5](https://github.com/auth0/wp-auth0/tree/2.1.5) (2016-03-23)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.4...2.1.5)

**Closed issues:**

- login box [\#177](https://github.com/auth0/wp-auth0/issues/177)
- css login issue [\#176](https://github.com/auth0/wp-auth0/issues/176)
- user export [\#174](https://github.com/auth0/wp-auth0/issues/174)
- auth0 logo on the quick start guide [\#173](https://github.com/auth0/wp-auth0/issues/173)
- online setup popup [\#172](https://github.com/auth0/wp-auth0/issues/172)
- quick start guide screen 1 [\#171](https://github.com/auth0/wp-auth0/issues/171)
- Quick Start Guide [\#169](https://github.com/auth0/wp-auth0/issues/169)
- settings / features / fullcontact [\#167](https://github.com/auth0/wp-auth0/issues/167)
- settings / features / MFA [\#166](https://github.com/auth0/wp-auth0/issues/166)
- settings / features / sso [\#165](https://github.com/auth0/wp-auth0/issues/165)
- Settings / Features / Password policy [\#164](https://github.com/auth0/wp-auth0/issues/164)
- setting text [\#163](https://github.com/auth0/wp-auth0/issues/163)
- title link [\#162](https://github.com/auth0/wp-auth0/issues/162)
- Auth0 settings / basic [\#161](https://github.com/auth0/wp-auth0/issues/161)
- Auth0 settings / Basic [\#160](https://github.com/auth0/wp-auth0/issues/160)
- Auth0 settings page / Basic [\#159](https://github.com/auth0/wp-auth0/issues/159)
- deleting plugin doesn't delete all data [\#158](https://github.com/auth0/wp-auth0/issues/158)
- setup text [\#157](https://github.com/auth0/wp-auth0/issues/157)
- Plugin description text [\#155](https://github.com/auth0/wp-auth0/issues/155)
- New plugin breaks due to callback URL mismatch? [\#146](https://github.com/auth0/wp-auth0/issues/146)

## [2.1.4](https://github.com/auth0/wp-auth0/tree/2.1.4) (2016-03-18)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.3...2.1.4)

**Merged pull requests:**

- 2.1.4 [\#154](https://github.com/auth0/wp-auth0/pull/154) ([glena](https://github.com/glena))

## [2.1.3](https://github.com/auth0/wp-auth0/tree/2.1.3) (2016-03-16)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.2...2.1.3)

**Closed issues:**

- MFA reset [\#149](https://github.com/auth0/wp-auth0/issues/149)
- Site login broken after updating the plugin to version 2 [\#143](https://github.com/auth0/wp-auth0/issues/143)
- Add a way to customize error pages like templates/verify-email.php [\#103](https://github.com/auth0/wp-auth0/issues/103)
- Docs changes [\#94](https://github.com/auth0/wp-auth0/issues/94)

**Merged pull requests:**

- 2.1.2 [\#152](https://github.com/auth0/wp-auth0/pull/152) ([glena](https://github.com/glena))

## [2.1.2](https://github.com/auth0/wp-auth0/tree/2.1.2) (2016-03-15)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.1...2.1.2)

## [2.1.1](https://github.com/auth0/wp-auth0/tree/2.1.1) (2016-03-11)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.1.0...2.1.1)

## [2.1.0](https://github.com/auth0/wp-auth0/tree/2.1.0) (2016-03-08)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/2.0.0...2.1.0)

**Closed issues:**

- sso is loosing `redirect\_to` [\#150](https://github.com/auth0/wp-auth0/issues/150)
- Google Authenticator integration problems [\#148](https://github.com/auth0/wp-auth0/issues/148)
- Zipcode-Income throws an error [\#147](https://github.com/auth0/wp-auth0/issues/147)
- Errors in configuring plugin, with no clear path to fixing them... [\#145](https://github.com/auth0/wp-auth0/issues/145)
- Typo [\#144](https://github.com/auth0/wp-auth0/issues/144)
- Register [\#142](https://github.com/auth0/wp-auth0/issues/142)
- Change password [\#141](https://github.com/auth0/wp-auth0/issues/141)
- word order for App token required scopes very confusing [\#140](https://github.com/auth0/wp-auth0/issues/140)
- Bad Link - Enterprise - Google Apps [\#136](https://github.com/auth0/wp-auth0/issues/136)
- SSO state and lock exception. [\#109](https://github.com/auth0/wp-auth0/issues/109)

**Merged pull requests:**

- V2.1 [\#151](https://github.com/auth0/wp-auth0/pull/151) ([glena](https://github.com/glena))

## [2.0.0](https://github.com/auth0/wp-auth0/tree/2.0.0) (2016-03-01)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.3.6...2.0.0)

**Closed issues:**

- check redirections in shortcode and widget [\#139](https://github.com/auth0/wp-auth0/issues/139)
- Social connections  [\#135](https://github.com/auth0/wp-auth0/issues/135)
- Bad Link - Appearance Tab - Remember Last Login [\#134](https://github.com/auth0/wp-auth0/issues/134)
- Bad link - Appearance Tab - Username [\#133](https://github.com/auth0/wp-auth0/issues/133)
- Bad Link - Appearance Tab - Custom JS [\#132](https://github.com/auth0/wp-auth0/issues/132)
- Bad Link - Appearance Tab [\#131](https://github.com/auth0/wp-auth0/issues/131)
- Bad link - Features Tab [\#130](https://github.com/auth0/wp-auth0/issues/130)
- Dashboard Typo [\#129](https://github.com/auth0/wp-auth0/issues/129)
- Implicit Flow Bug [\#128](https://github.com/auth0/wp-auth0/issues/128)
- Users Export [\#127](https://github.com/auth0/wp-auth0/issues/127)
- Advanced Tab - Extra Settings [\#126](https://github.com/auth0/wp-auth0/issues/126)
- Advanced Tab - IP Ranges [\#125](https://github.com/auth0/wp-auth0/issues/125)
- Advanced Tab - Valid Proxy IP [\#124](https://github.com/auth0/wp-auth0/issues/124)
- Advanced Tab - Login Redirection URL [\#123](https://github.com/auth0/wp-auth0/issues/123)
- Advanced Tab - Auth0 implicit flow [\#122](https://github.com/auth0/wp-auth0/issues/122)
- Advanced Tab - User Migration [\#121](https://github.com/auth0/wp-auth0/issues/121)
- Advanced Tab - Social [\#120](https://github.com/auth0/wp-auth0/issues/120)
- Advanced Tab - Link users with same email [\#119](https://github.com/auth0/wp-auth0/issues/119)
- Advanced Tab -  Remember Users Session: [\#118](https://github.com/auth0/wp-auth0/issues/118)
- No Token in Settings [\#117](https://github.com/auth0/wp-auth0/issues/117)
- No Buttons to Activate Social Login when Installing [\#116](https://github.com/auth0/wp-auth0/issues/116)
- Troubleshoting [\#115](https://github.com/auth0/wp-auth0/issues/115)
- Wordpress Auth0 plugin + 3rd party app \(Thinkific\) [\#114](https://github.com/auth0/wp-auth0/issues/114)
- License file needs an update to current version [\#111](https://github.com/auth0/wp-auth0/issues/111)
- Redirect to default domain also from aditional domain for different language [\#110](https://github.com/auth0/wp-auth0/issues/110)
- How do I pass the JWT to firebase from wp-auth0 [\#108](https://github.com/auth0/wp-auth0/issues/108)
- Plugin should check the WP Database when user isnt found in Auth0 Database [\#107](https://github.com/auth0/wp-auth0/issues/107)
- Not redirecting to admin path after SSO login [\#106](https://github.com/auth0/wp-auth0/issues/106)
- Install\_db being called all the time... [\#104](https://github.com/auth0/wp-auth0/issues/104)
- Review design for setup pages [\#102](https://github.com/auth0/wp-auth0/issues/102)
- Refresh of settings page changes view - always opens "Features" [\#101](https://github.com/auth0/wp-auth0/issues/101)
- Add redirect param to auth0 shortcode config [\#92](https://github.com/auth0/wp-auth0/issues/92)
- Show widget in signup mode [\#91](https://github.com/auth0/wp-auth0/issues/91)
- Consent flow TODOs [\#88](https://github.com/auth0/wp-auth0/issues/88)
- enhance the could not create user error [\#12](https://github.com/auth0/wp-auth0/issues/12)

**Merged pull requests:**

- Update LICENSE [\#112](https://github.com/auth0/wp-auth0/pull/112) ([aguerere](https://github.com/aguerere))
- v2.0 [\#86](https://github.com/auth0/wp-auth0/pull/86) ([glena](https://github.com/glena))

## [1.3.6](https://github.com/auth0/wp-auth0/tree/1.3.6) (2015-10-01)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.3.1...1.3.6)

**Implemented enhancements:**

- Upgrade to API V2 [\#60](https://github.com/auth0/wp-auth0/issues/60)

**Closed issues:**

- Custom Registration Fields [\#100](https://github.com/auth0/wp-auth0/issues/100)
- Quick setup informational banner confusing [\#99](https://github.com/auth0/wp-auth0/issues/99)
- "This user does not have enough scopes..." error is confusing. [\#98](https://github.com/auth0/wp-auth0/issues/98)
- Remove the "create an application" informational error after setup complete. [\#97](https://github.com/auth0/wp-auth0/issues/97)
- Update wording for quickstart [\#96](https://github.com/auth0/wp-auth0/issues/96)
- Change name of plugin in WP dashboard to "Auth0 for WordPress" [\#95](https://github.com/auth0/wp-auth0/issues/95)
- Doesn't Seem that Lock Config Accepts "dict" parameter [\#93](https://github.com/auth0/wp-auth0/issues/93)
- Update user data on edit profile [\#90](https://github.com/auth0/wp-auth0/issues/90)
- Signup enabled issue with multisite [\#89](https://github.com/auth0/wp-auth0/issues/89)
- Add option to migrate users with custom data [\#85](https://github.com/auth0/wp-auth0/issues/85)
- upcoming [\#84](https://github.com/auth0/wp-auth0/issues/84)
- Auto redirect on preview post pages [\#83](https://github.com/auth0/wp-auth0/issues/83)
- Wordpress tries to auto login even when "Auto Login \(no widget\)" is unchecked [\#80](https://github.com/auth0/wp-auth0/issues/80)
- Support Storing Stripe id in Auth0 [\#77](https://github.com/auth0/wp-auth0/issues/77)
- Allow loading / saving Shipping Addresses used by WooCommerce in Auth0 Profile [\#76](https://github.com/auth0/wp-auth0/issues/76)
- add\_menu\_page/admin\_menu conflicts with other plugins.  [\#37](https://github.com/auth0/wp-auth0/issues/37)
- Session\_start warnings [\#31](https://github.com/auth0/wp-auth0/issues/31)

**Merged pull requests:**

- fix [\#82](https://github.com/auth0/wp-auth0/pull/82) ([glena](https://github.com/glena))
- Added access token to the login action + Merged PR \#79 [\#81](https://github.com/auth0/wp-auth0/pull/81) ([glena](https://github.com/glena))

## [1.3.1](https://github.com/auth0/wp-auth0/tree/1.3.1) (2015-06-10)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.3.0...1.3.1)

**Closed issues:**

- Mixed content warning [\#75](https://github.com/auth0/wp-auth0/issues/75)

**Merged pull requests:**

- Fixed Mixed content warning \#75 & added login action for issue \#76 \#77 [\#78](https://github.com/auth0/wp-auth0/pull/78) ([glena](https://github.com/glena))

## [1.3.0](https://github.com/auth0/wp-auth0/tree/1.3.0) (2015-06-01)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.2.7...1.3.0)

**Implemented enhancements:**

- Support for SSO [\#64](https://github.com/auth0/wp-auth0/issues/64)

**Merged pull requests:**

- Added SSO features [\#74](https://github.com/auth0/wp-auth0/pull/74) ([glena](https://github.com/glena))

## [1.2.7](https://github.com/auth0/wp-auth0/tree/1.2.7) (2015-05-28)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.2.4...1.2.7)

**Closed issues:**

- Add custom js to add custom buttons [\#73](https://github.com/auth0/wp-auth0/issues/73)
- Hardwired redirect url after login [\#71](https://github.com/auth0/wp-auth0/issues/71)
- State shouldn't be required [\#66](https://github.com/auth0/wp-auth0/issues/66)
- Enable new users creation on JWT authentication [\#57](https://github.com/auth0/wp-auth0/issues/57)

**Merged pull requests:**

- fix implicit wf in subdirectories, added custom JS [\#72](https://github.com/auth0/wp-auth0/pull/72) ([glena](https://github.com/glena))
- New jwt auth integration + auto user creation with JWT [\#70](https://github.com/auth0/wp-auth0/pull/70) ([glena](https://github.com/glena))
- Fix array notation [\#69](https://github.com/auth0/wp-auth0/pull/69) ([glena](https://github.com/glena))

## [1.2.4](https://github.com/auth0/wp-auth0/tree/1.2.4) (2015-05-21)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.2.3...1.2.4)

**Merged pull requests:**

- Fix error when the state param is not present [\#67](https://github.com/auth0/wp-auth0/pull/67) ([glena](https://github.com/glena))

## [1.2.3](https://github.com/auth0/wp-auth0/tree/1.2.3) (2015-05-19)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.2.2...1.2.3)

**Merged pull requests:**

- Fix issue with email verified requirement [\#65](https://github.com/auth0/wp-auth0/pull/65) ([glena](https://github.com/glena))

## [1.2.2](https://github.com/auth0/wp-auth0/tree/1.2.2) (2015-05-19)
[Full Changelog](https://github.com/auth0/wp-auth0/compare/1.2.1...1.2.2)

**Implemented enhancements:**

- Auto Login \(no widget\) Does not work with WooCommerce My Account Login [\#45](https://github.com/auth0/wp-auth0/issues/45)

**Merged pull requests:**

- Added support for WooCommerce + updated info headers [\#63](https://github.com/auth0/wp-auth0/pull/63) ([glena](https://github.com/glena))

## [1.2.1](https://github.com/auth0/wp-auth0/tree/1.2.1) (2015-05-14)
**Implemented enhancements:**

- Auth0 users with different accounts but same username will not be able to log into the site [\#52](https://github.com/auth0/wp-auth0/issues/52)
- Error: Could not create user. The registration process is not available. [\#48](https://github.com/auth0/wp-auth0/issues/48)
- Enhancement: Allow WordPress plugin to work in enterprise environment without internet access [\#42](https://github.com/auth0/wp-auth0/issues/42)
- Support redirecting to arbitrary URLs after login is succesful [\#29](https://github.com/auth0/wp-auth0/issues/29)
- Add link to create Auth0 Account [\#28](https://github.com/auth0/wp-auth0/issues/28)
- Validate settings before saving [\#24](https://github.com/auth0/wp-auth0/issues/24)
- Show WP Auth0 Logs somewhere so that we can easily diagnose problems [\#22](https://github.com/auth0/wp-auth0/issues/22)
- Add option to enter custom CSS [\#21](https://github.com/auth0/wp-auth0/issues/21)
- Make Widget options accessable by the Plugin [\#15](https://github.com/auth0/wp-auth0/issues/15)
- Make the widget showable as Shortcode and Widget [\#14](https://github.com/auth0/wp-auth0/issues/14)

**Fixed bugs:**

- No widget shown in latest release [\#20](https://github.com/auth0/wp-auth0/issues/20)

**Closed issues:**

- SDK Client headers spec compliant [\#61](https://github.com/auth0/wp-auth0/issues/61)
- Make usernames unique if it is already in use [\#58](https://github.com/auth0/wp-auth0/issues/58)
- Check text on "allow signup" option in plugin settings [\#54](https://github.com/auth0/wp-auth0/issues/54)
- Why is Client Secret Needed [\#53](https://github.com/auth0/wp-auth0/issues/53)
- Client Secret Field in Settings should not be remembered by browser [\#44](https://github.com/auth0/wp-auth0/issues/44)
- Demo is down [\#43](https://github.com/auth0/wp-auth0/issues/43)
- wp-login?wle does not work when "Auto Login \(no widget\)" is enabled [\#38](https://github.com/auth0/wp-auth0/issues/38)
- Add fallback URL to log in with WP credentials even after disabling WP login [\#35](https://github.com/auth0/wp-auth0/issues/35)
- Wordpress login no longer works when the "Auto Login \(no widget\)" option is set. [\#34](https://github.com/auth0/wp-auth0/issues/34)
- Shortcode attributes are being ignored [\#33](https://github.com/auth0/wp-auth0/issues/33)
- Update to Lock [\#19](https://github.com/auth0/wp-auth0/issues/19)
- errors not being shown when something fails [\#18](https://github.com/auth0/wp-auth0/issues/18)
- add nice error message when exchange of token returns 401 [\#11](https://github.com/auth0/wp-auth0/issues/11)
- Don't show widget when registrations are not allowed. [\#5](https://github.com/auth0/wp-auth0/issues/5)
- Auto-create users option [\#4](https://github.com/auth0/wp-auth0/issues/4)
- plugin packaging and publish [\#3](https://github.com/auth0/wp-auth0/issues/3)
- after session times out the login widget is shown inside the iframe and after login the site is embedded in the iframe [\#2](https://github.com/auth0/wp-auth0/issues/2)
- lost your password [\#1](https://github.com/auth0/wp-auth0/issues/1)

**Merged pull requests:**

- Updated info headers [\#62](https://github.com/auth0/wp-auth0/pull/62) ([glena](https://github.com/glena))
- Auth WP V1.2 [\#55](https://github.com/auth0/wp-auth0/pull/55) ([glena](https://github.com/glena))
- Security vulnerability fix on login [\#51](https://github.com/auth0/wp-auth0/pull/51) ([glena](https://github.com/glena))
- Add fallback URL to log in with WP credentials even after disabling WP login \#35 [\#36](https://github.com/auth0/wp-auth0/pull/36) ([glena](https://github.com/glena))
- Issues \#24, \#28 & \#29 [\#30](https://github.com/auth0/wp-auth0/pull/30) ([glena](https://github.com/glena))
-  Add option to enter custom CSS \#21 [\#27](https://github.com/auth0/wp-auth0/pull/27) ([glena](https://github.com/glena))
- Issues ready to merge [\#26](https://github.com/auth0/wp-auth0/pull/26) ([glena](https://github.com/glena))
- New popup widget & some small changes [\#23](https://github.com/auth0/wp-auth0/pull/23) ([glena](https://github.com/glena))
- A0 widget [\#16](https://github.com/auth0/wp-auth0/pull/16) ([glena](https://github.com/glena))
- New feature: Add a new config to allow people to access with the standar... [\#13](https://github.com/auth0/wp-auth0/pull/13) ([glena](https://github.com/glena))
- Fix wp submision problems [\#10](https://github.com/auth0/wp-auth0/pull/10) ([hrajchert](https://github.com/hrajchert))
- Added screenshots [\#9](https://github.com/auth0/wp-auth0/pull/9) ([hrajchert](https://github.com/hrajchert))
- Many improvements [\#8](https://github.com/auth0/wp-auth0/pull/8) ([hrajchert](https://github.com/hrajchert))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
