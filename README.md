# edgeg.io-atom-time-plugin package

GTM, or GIT Time Metrics, is a utility that tracks activity on files that
are part of a GIT repository and aggregates that activity into useful time
information. It tracks this time through the use of editor plugins and by
using GIT post-commit hooks. These timings and data are stored in the local
GIT repo in GIT notes. This plugin will track this data for projects that are
edited with the Atom editor.

Influxtime is a service to assist in tracking time while working on a computer.
It does this by transiently collecting data about the applications you are
using while utilizing your computer.

By utilizing Influxtime in the background, you have many opportunities to
capture interesting things about the way you work through the application
of metrics and analysis done on the data. Not only that, it has many
excellent features to help you build your time card if you happen to do
freelance work.

GTM and Influxtime are complimentary offerings that collect similar information.
GTM tracks that information locally while Influxtime will "phone home" and
aggregate that information in the cloud for more complete analysis both for
individual users as well as for teams or across multiple development machines.

# Configuration

* Use Influxtime - Set this to TRUE if you have Influxtime installed and want
to track metrics through the Influxtime website.
* Use GTM - Set this to TRUE if you have GTM installed and want to track metrics
locally.
* Location of influxtime executable - Set this to the path where the influxtime
executable is installed. Atom does not have access to your shell, so this
must be set explicitly.
* Location of GTM executable - Set this to the path where the gtm
executable is installed. Atom does not have access to your shell, so this
must be set explicitly.

**Note** Both of these programs can be used simultaneously if desired.

# Requirements

In order to utilize this plugin, you must have the Influxtime and or GTM agent
installed and running on your computer.

At the time of publish, Influxtime can be run only on a Mac OSX System.

# Copyright

&copy; 2016 EdgeG.IO - All Rights Reserved.

# Support

To get help, send e-mail to support@edgeg.io.
