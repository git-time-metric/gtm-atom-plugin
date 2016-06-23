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

  updateDuration: 30000
  subscriptions: null
  lastFile: ""
  lastUpdate: new Date()
  warned: false

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

    atom.config.observe 'git-time-metric.GTMLocation', (value) =>
      console.log("Config value changed: GTMLocation: " + value)
      @warned = false
      @gtmLocation = value

    if @gtmLocation == ""
      console.log("No executable location set - attempting to detect")
      locator = new Locator
      location = locator.findGTM()
      if !location || location == ""
        atom.notifications.addWarning("No GTM executable found. GTM will not function. Please configure.")


    console.log("GTM Plugin Active")

  consumeStatusBar: (statusBar) ->
    statusBarTileView = new StatusBarTileView()
    statusBarTileView.init()
    @statusBarTile = statusBar.addRightTile(item: statusBarTileView, priority: 300)
    statusBarTileView.setTitle('Git Time Metric Plugin Active')
    statusBarTileView.setStatus()

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
    if filename != ""
      if @useGTM
        @logGTMEvent(filename)

  logGTMEvent: (filename) ->

    process = new BufferedProcess
      command: @gtmLocation + path.sep + @exe
      args: ["record", filename, ">> ~/.gtm-atom.log"]
      stdout: (output) -> console.log(output)

    process.onWillThrowError (errorObject) =>
      console.log("Error running GTM: " + errorObject.error)
      errorObject.handle()
      if !@warned
        atom.notifications.addError("GTM Failed to run. Please check configuration.")
        @warned = true
