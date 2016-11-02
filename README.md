![GTM Logo](https://raw.githubusercontent.com/git-time-metric/gtm-atom-plugin/master/lib/GTMLogo-128.png)
# <div align="center">Git Time Metric</div>
### Atom Git Time Metrics (GTM) Plugin
#### Simple, seamless, lightweight time tracking for all your git projects  

Git Time Metrics (GTM) is a tool to automatically track time spent reading and working on code that you store in a Git repository. By installing GTM and using supported plug-ins for your favorite editors, you can immediately realize better insight into how you are spending your time and on what files.

This plugin will help to feed data for the projects that you work on in the Atom editor.

# Installation

Installing GTM is a two step process.  First, it's recommended you install the GTM executable that the plug-in integrates with and then install the Sublime 3 GTM plug-in.  Please submit an issue if you have any problems and/or questions.

1. Follow the [Getting Started](https://github.com/git-time-metric/gtm/blob/master/README.md) section to install the GTM executable for your operating system.
2. Install the plug-in via [Atom Community Packages](https://atom.io/packages/git-time-metric).

**Note** - to enable time tracking for a Git repository, you need to initialize it with `gtm init` otherwise it will be ignored by GTM. This is done via the command line.
```
> cd /path/to/your/project
> gtm init
```

# Configuration

* Use GTM - Set this to TRUE if you have GTM installed and want to track metrics
locally.
* Location of GTM executable - Set this to the path where the gtm
executable is installed. We attempt to detect this, but if it cannot
be found, or if you just want to change it, do so here.

# Features

### Status Bar

In the status bar see your total time spent for in-process work (uncommitted).

![](https://cloud.githubusercontent.com/assets/1885760/16781702/a8fe6052-4839-11e6-9bad-fa5b5497bd83.png)

**Note** - the time shown is based on the file's path and the Git repository it belongs to. You can have several files open that belong to different Git repositories. The status bar will display the time for the current file's Git repository.  Also keep in mind, a Git repository must be initialized for time tracking in order to track time.

### Command Line Interface

Use the command line to report on time logged for your commits.

Here are some examples of insights GTM can provide you.

![](https://cloud.githubusercontent.com/assets/630550/19832562/41947ae2-9dec-11e6-932b-c2bca710da40.png)

![](https://cloud.githubusercontent.com/assets/630550/19832563/430e3caa-9dec-11e6-9bdf-51d52e95d947.png)

GTM is automatic, seamless and lightweight.  There is no need to remember to start and stop timers.  It runs on occasion to capture activity triggered by your editor.  The time metrics are stored locally with the git repository as [Git notes](https://git-scm.com/docs/git-notes) and can be pushed to the remote repository.

# Support

To report a bug, please submit an issue on the
[GitHub Page](https://github.com/git-time-metric/gtm-atom-plugin/issues)

Consult the [README](https://github.com/git-time-metric/gtm/blob/master/README.md) and [Wiki](https://github.com/git-time-metric/gtm/wiki) for more information.
