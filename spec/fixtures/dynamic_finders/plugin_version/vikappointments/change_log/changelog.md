# Changelog

### 1.1

*Release date - 18 September 2019*

#### New Features

* Added some reports for the packages orders.
* Created the reports also for the services booked.
* Closing days can be specified also for some services only.
* Custom fields for the employees now support a visual editor.

#### Improvements

* Packages are automatically redeemed (if any) also from the back-end when creating a reservation.
* Packages are automatically restored after cancelling a reservation from both the sections.
* The packages list in the back-end now displays the number of redeemed appointments per package.
* Added some placeholders for displaying location details within the reminders.
* All the reports can be generated also by number of appointments instead of total amount earned.
* Coupon publishing dates can, optionally, refer to the checkin date or to the current date.
* The number of participants (when higher than 1) is now reported within all the notification e-mails.
* The PayPal form now owns the name and id attributes.

#### Bug Fixes

* Booking restrictions are not applied when creating a reservation as employee.
* The employee name is no more visible within the notification e-mail for customers, in case the employee selection was disabled.
* Fixed the way the system detects the default country code in case of multilingual websites.
* The payments filter within the back-end is no more visible in case there are no payment gateways.
* The parameter used to enable the recurrence for a service is no more visible in case the recurrence is globally turned off.
* Some input values have been escaped to prevent XSS attacks.

### 1.0

*Release date - 10 July 2019*

* First stable release of the VikAppointments plugin for WordPress.