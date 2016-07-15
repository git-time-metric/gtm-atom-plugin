statusBarTileView = null

ConfigSchema = require('./configuration')
StatusBarTileView = require('./status-bar')
Locator = require('./locator')

{CompositeDisposable} = require 'atom'
{BufferedProcess} = require 'atom'
path = require 'path'
os = require 'os'

module.exports = Influxtime =
  config: ConfigSchema.config
  GTMVersionString: ">= v1.0-beta.6"

  updateDuration: 30000
  subscriptions: null
  lastFile: ""
  lastUpdate: new Date()
  warned: false
  useLegacy: false
  statusBar: null

  useGTM: false
  gtmLocation: ''
  exe: 'gtm'

  activate: (state) ->
    if os.platform() == 'win32'
      @exe += '.exe'

    @subscriptions = new CompositeDisposable

    # Observe text editors. Any time a new one is opened, log it
    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      if editor
        @subscriptions.add(editor.onDidSave () =>
          @logTime(true))
        @subscriptions.add(editor.onDidStopChanging () =>
          @logTime(false))

    @subscriptions.add atom.workspace.onDidChangeActivePaneItem () =>
      @logTime(false)

    atom.config.observe 'git-time-metric.useGTM', (value) =>
      console.log("Config value changed: useGTM: " + value)
      @useGTM = value
      if @statusBar
        @statusBar.setStatus()

    atom.config.observe 'git-time-metric.GTMLocation', (value) =>
      console.log("Config value changed: GTMLocation: " + value)
      @warned = false
      @gtmLocation = value
      @useLegacy = false
      @checkGTMVersion(@GTMVersionString)

    if @gtmLocation == ""
      console.log("No executable location set - attempting to detect")
      locator = new Locator
      location = locator.findGTM()
      if !location || location == ""
        atom.notifications.addWarning("No GTM executable found. GTM will not function. Please configure.")
      else
        atom.notifications.addInfo("Auto-detected GTM (" + location + ") and set in your configuration.")
        atom.config.set('git-time-metric.GTMLocation', location)


    console.log("GTM Plugin Active")

  consumeStatusBar: (statusBar) ->
    statusBarTileView = new StatusBarTileView()
    statusBarTileView.init()
    @statusBarTile = statusBar.addRightTile(item: statusBarTileView, priority: 300)
    statusBarTileView.setTitle('Git Time Metric Plugin Active')
    statusBarTileView.setStatus()
    @statusBar = statusBarTileView

  deactivate: ->
    @subscriptions.dispose()
    @statusBarTile?.destroy()
    statusBarTileView?.destroy()
    statusBarTileView = null

  logTime: (force) ->
    ed = atom.workspace.getActiveTextEditor()
    if ed
      filename = ed.getPath()
      now = new Date()
      duration = now - @lastUpdate

      if filename != @lastFile || duration >= @updateDuration || force
        if filename != @lastFile
          @logEvent(@lastFile)

        @logEvent(filename)

        @lastFile = filename
        @lastUpdate = now

  logEvent: (filename) ->
    if filename && filename != ""
      if @useGTM
        @logGTMEvent(filename)

  logGTMEvent: (filename) ->
    args = []
    if @useLegacy
      args = ["record", filename]
    else
      args = ["record", "--status", filename]

    process = new BufferedProcess
      command: @gtmLocation + path.sep + @exe
      args: args
      stdout: (output) =>
        @statusBar.setStatus(output)
      stderr: (output) ->
        console.log("Error logging gtm event: " + output)

    process.onWillThrowError (errorObject) =>
      console.log("Error running GTM: " + errorObject.error)
      errorObject.handle()
      if !@warned
        atom.notifications.addError("GTM Failed to run. Please check configuration.")
        @warned = true

  checkGTMVersion: (gtmVersionString) ->
    if @gtmLocation != ""
      console.log("Checking GTM Version")
      process = new BufferedProcess
        command: @gtmLocation + path.sep + @exe
        args: ["verify", gtmVersionString]
        stderr: (output) =>
          @setLegacyMode()
        stdout: (output) =>
          if output != "true"
            @setLegacyMode()

      process.onWillThrowError (errorObject) =>
        console.log("Error Checking GTM Location: " + errorObject.error)
        errorObject.handle()

  setLegacyMode: ->
    console.log("Using legacy mode.")
    @useLegacy = true
    atom.notifications.addWarning("GTM Executable is out of date.\n\n" +
      "The plug-in has rolled back to legacy behavior.  " +
      "Please install the latest GTM version and restart Atom.\n\n" +
      "See https://github.com/git-time-metric/gtm/blob/master/README.md")
