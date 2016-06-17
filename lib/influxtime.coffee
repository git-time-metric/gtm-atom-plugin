statusBarTileView = null

ConfigSchema = require('./configuration.coffee')
StatusBarTileView = require './status-bar'

{CompositeDisposable} = require 'atom'
{BufferedProcess} = require 'atom'

module.exports = Influxtime =
  config: ConfigSchema.config

  updateDuration: 30000
  subscriptions: null
  lastFile: ""
  lastUpdate: new Date()

  useGTM: false
  gtmLocation: ""

  activate: (state) ->
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
      @gtmLocation = value

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
      command = @gtmLocation + "/gtm"
      args = ["record", filename, ">> ~/.gtm-atom.log"]
      stdout = (output) -> console.log(output)
      process = new BufferedProcess({command, args, stdout})
