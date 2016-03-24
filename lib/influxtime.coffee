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

  useInfluxtime: false
  useGTM: false
  influxtimeLocation: ""
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

    atom.config.observe 'edgeg.io-atom-time-plugin.useInfluxtime', (value) =>
      console.log("Config value changed: useInfluxtime: " + value)
      @useInfluxtime = value

    atom.config.observe 'edgeg.io-atom-time-plugin.useGTM', (value) =>
      console.log("Config value changed: useGTM: " + value)
      @useGTM = value

    atom.config.observe 'edgeg.io-atom-time-plugin.InfluxtimeLocation', (value) =>
      console.log("Config value changed: InfluxtimeLocation: " + value)
      @influxtimeLocation = value

    atom.config.observe 'edgeg.io-atom-time-plugin.GTMLocation', (value) =>
      console.log("Config value changed: GTMLocation: " + value)
      @gtmLocation = value

    console.log("EdgeG.IO Time Plugin Active")

  consumeStatusBar: (statusBar) ->
    statusBarTileView = new StatusBarTileView()
    statusBarTileView.init()
    @statusBarTile = statusBar.addRightTile(item: statusBarTileView, priority: 300)
    statusBarTileView.setTitle('EdgeG.IO Time Plugin Active')
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
      command = "/usr/local/bin/influxmetric"
      if @useInfluxtime
        @logInfluxEvent(filename)

      if @useGTM
        @logGTMEvent(filename)

  logInfluxEvent: (filename) ->
      command = @influxtimeLocation + "/influxmetric"
      args = ["record", "file", filename, ">> ~/.influxmetric/influxtime-atom.log"]
      stdout = (output) -> console.log(output)
      process = new BufferedProcess({command, args, stdout})

  logGTMEvent: (filename) ->
      command = @gtmLocation + "/gtm"
      args = ["record", filename, ">> ~/.gtm-atom.log"]
      stdout = (output) -> console.log(output)
      process = new BufferedProcess({command, args, stdout})
