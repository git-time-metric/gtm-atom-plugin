{CompositeDisposable} = require 'atom'
{BufferedProcess} = require 'atom'

module.exports = Influxtime =
  updateDuration: 30000
  subscriptions: null
  lastFile: ""
  lastUpdate: new Date()

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    console.log("Influxtime Active")

    # Observe text editors. Any time a new one is opened, log it
    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      if editor
        @subscriptions.add(editor.onDidSave () =>
          @logTime(true))
        @subscriptions.add(editor.onDidStopChanging () =>
          @logTime(false))

    @subscriptions.add atom.workspace.onDidChangeActivePaneItem () =>
      @logTime(false)

  deactivate: ->
    @subscriptions.dispose()

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
      command = "influxmetric"
      args = ["record", "file", filename, ">> ~/.influxmetric/influxtime-atom.log"]
      stdout = (output) -> console.log(output)
      process = new BufferedProcess({command, args, stdout})
