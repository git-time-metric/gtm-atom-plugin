## 1.1.8 - Require gtm version 1.2.7
* Update warning message to add the desired GTM version

## 1.1.7 - Require gtm version 1.2.1

## 1.1.6 - Require gtm version 1.2.0
* Update README with new "reporting" features
* Update README to be more consistent with other editor plugins

## 1.1.5 - Require gtm version 1.1.0

## 1.1.4 - Require gtm version 1.0.0

## 1.1.3 - Strip off seconds on status bar
* Removed the seconds portion of the time string to be more in line
  with the other GTM plugins.

## 1.1.2 - Windows bug Fix
* Weird bug when opening a new file in an uninitialized project was
  passing invalid arguments (or lack of arguments) to the underlying
  gtm command, which was then shown in the status bar.

## 1.1.1 - Made Windows work properly
* Fixed bugs in detecting the Windows executable

## 1.1.0 - Put uncommitted time in the status bar.
* Added to the right of the status icon
* Check the version of the GTM executable

## 1.0.1 - Minor documentation updates
* Added AUTHORS, Updated LICENSE, and changed README to remove non-existent
  support e-mail address.

## 1.0.0 - Released to Atom.io

## 0.4.0 - Auto-configure
* Once auto-detected, write value to configuration so it doesn't have to be
  detected again.

## 0.3.0 - GTM Update
* Updated Logo
* Auto-find the GTM executable

## 0.2.0 - GTM Alone
* Updated to use GTM Alone. Deprecated influxtime.

## 0.1.1 - Bug Fix
* Fixed bug where _influxmetric_ command cannot be found when launched from the
finder. A future release will present the user with a setting to set this.

## 0.1.0 - First Release
* Initial revision

This is the initial revision. It requires that an Influxtime agent is
installed on your machine and the "influxtime" application is in the system
path somewhere.
