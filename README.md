![GTM Logo](https://raw.githubusercontent.com/git-time-metric/gtm-atom-plugin/master/lib/GTMLogo-128.png)
# GTM Atom Plugin
### Simple, seamless, lightweight time tracking for all your git projects  

GTM, or GIT Time Metrics, is a utility that tracks activity on files that
are part of a GIT repository and aggregates that activity into useful time
information. It tracks this time through the use of editor plugins and by
using GIT post-commit hooks. These timings and data are stored in the local
GIT repo in GIT notes. This plugin will track this data for projects that are
edited with the Atom editor.

# Installation

Installing GTM is a two step process.  First, it's recommended you install the GTM executable that the plug-in integrates with and then install the Sublime 3 GTM plug-in.  Please submit an issue if you have any problems and/or questions.

1. Follow the [Getting Started](https://github.com/git-time-metric/gtm/blob/master/README.md) section to install the GTM executable for your operating system.
2. Install the plug-in via [Atom Community Packages](https://atom.io/packages/git-time-metric).

# Configuration

* Use GTM - Set this to TRUE if you have GTM installed and want to track metrics
locally.
* Location of GTM executable - Set this to the path where the gtm
executable is installed. We attempt to detect this, but if it cannot
be found, or if you just want to change it, do so here.

# Features

In the status bar see your total time spent for in-process work (uncommitted).

![](https://cloud.githubusercontent.com/assets/1885760/16781702/a8fe6052-4839-11e6-9bad-fa5b5497bd83.png)

*Note* - the time shown is based on the file's path and the Git repository it belongs to. You can have several files open that belong to different Git repositories. The status bar will display the time for the current file's Git repository.  Also keep in mind, a Git repository must be initialized for time tracking in order to track time.

Consult the [README](https://github.com/git-time-metric/gtm/blob/master/README.md) and [Wiki](https://github.com/git-time-metric/gtm/wiki) for more information.

### Command Line Inteface

Use the command line to report on time logged for your commits.

Here are some examples of insights GTM can provide you.

**Git commits with time spent**
```
> gtm report -total-only -n 3

9361c18 Rename packages
Sun Jun 19 09:56:40 2016 -0500 Michael Schenk  34m 30s

341bd77 Vagrant file for testing on Linux
Sun Jun 19 09:43:47 2016 -0500 Michael Schenk  1h 16m  0s

792ba19 Require a 40 char SHA commit hash
Thu Jun 16 22:28:45 2016 -0500 Michael Schenk  1h  1m  0s
```

**Git commits with detailed time spent by file**

```
> gtm report

b2d16c8 Refactor discovering of paths when recording events
Thu Jun 16 11:08:47 2016 -0500 Michael Schenk

       30m 18s  [m] event/event.go
       12m 31s  [m] event/manager.go
        3m 14s  [m] project/project.go
        1m 12s  [r] .git/COMMIT_EDITMSG
        1m  0s  [r] .git/index
           25s  [r] event/manager_test.go
           20s  [r] metric/manager.go
       49m  0s
```

**Timeline of time spent by day**

```
> gtm report -format timeline -n 3

           0123456789012345678901234
Fri Jun 24 *                              22m  0s
Sat Jun 25 **                          1h 28m  0s
Sun Jun 26 ****                        3h 28m  0s
Mon Jun 27 *                               4m  0s
Tue Jun 28 **                          1h 36m  0s
                                       6h 58m  0s
```

Consult the [README](https://github.com/git-time-metric/gtm/blob/master/README.md) and [Wiki](https://github.com/git-time-metric/gtm/wiki) for more information.

# Support

To report a bug, please submit an issue on the
[GitHub Page](https://github.com/git-time-metric/gtm-atom-plugin/issues)
