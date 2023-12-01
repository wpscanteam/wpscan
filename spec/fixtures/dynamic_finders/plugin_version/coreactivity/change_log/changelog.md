# coreActivity

## Changelog

### Version: 1.4 / November 15 2023

* **new** component: `GD Forum Manager` plugin, with 4 events
* **new** component: `Forminator` plugin, with 1 event
* **new** logs panel view support for the object by ID or name
* **new** store statistics for each event on the daily base
* **new** filter events by the plugin it originated from
* **edit** optimized logs panel views processing and matching
* **edit** log item dialog view updated rendering for expandability
* **edit** improved `Event` view display for the Logs panel 
* **edit** Dev4Press Library 4.4 Beta
* **fix** several small issues with the `Live` Logs updates
* **fix** object filtering for logs panel was unfinished
* **fix** notifications property not found for new events

### Version: 1.3 / November 6 2023

* **new** geolocation with the use of `MaxMind GeoLite2` database
* **new** `MaxMind GeoLite2` support for weekly downloading of Lite database
* **new** option to hide the `Object` column from the Logs
* **new** plugin dashboard widget for the GEO Location information
* **new** component `DebugPress` expanded with two new events
* **new** logs panel option to filter by country based on geolocation
* **new** logs panel popup dialog with overview of all event data split in tabs
* **edit** changes in the order for some columns on the log panel
* **edit** expanded `SweepPress` sweeping job logged data
* **edit** various improvements to the Logs panel styling
* **edit** improved method for running the GEO Location database update
* **edit** Dev4Press Library 4.4 Beta
* **fix** initial GEO Location database update is not triggered properly

### Version: 1.2 / October 30 2023

* **new** database: logs table has new `country_code` column
* **new** logging: options for logging country code and other location information
* **new** geolocation settings: choose between online and `IP2Location` database
* **new** geolocation with the use of `IP2Location` database
* **new** `IP2Location` support for weekly downloading of Lite database
* **new** registered weekly maintenance background job
* **edit** Dev4Press Library 4.4 Beta
* **fix** logs override filtering not working properly always
* **fix** all CRON handlers registered as filters and not actions
* **fix** weekly digest scheduled to run each day

### Version: 1.1 / October 16 2023

* **new** component: WooCommerce plugin, with 3 events
* **new** notifications component: support for WooCommerce `WC_Email` logging
* **new** logs panel action to stop logging some of the object type by value
* **new** logs panel metadata column as alternative to the metadata row
* **new** logs panel with added views for context and method
* **new** tool for bulk control of events notifications status
* **new** more settings related to object types exclusions
* **edit** sitemeta component: default object type is now `sitemeta`
* **edit** many improvements to the `Logs` class for expandability
* **edit** few improvements to the base `Component` class
* **edit** few improvements to the Logs table and rendering
* **edit** Dev4Press Library 4.4 Beta
* **fix** logs filtering in some cases not working properly
* **fix** some events not always obeying exclusion conditions
* **fix** few issues with the content terms relationship change event

### Version: 1.0.5 / October 5 2023

* **edit** Dev4Press Library 4.3.5
* **fix** admin pages header IP display may be broken if IP is unknown

### Version: 1.0.4 / October 2 2023

* **edit** more changes related to PHPCS and WPCS validation
* **edit** Dev4Press Library 4.3.4

### Version: 1.0.3 / September 26 2023

* **edit** more changes related to PHPCS and WPCS validation
* **edit** Dev4Press Library 4.3.3

### Version: 1.0.2 / September 25 2023

* **edit** Dev4Press Library 4.3.2

### Version: 1.0.1 / September 20 2023

* **edit** more changes related to PHPCS and WPCS validation
* **edit** Dev4Press Library 4.3.1

### Version: 1.0 / September 6 2023

* **new** first official release
