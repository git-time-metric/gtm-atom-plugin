InfluxtimeAtomPlugin = require '../lib/influxtime'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "InfluxtimeAtomPlugin", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('influxtime-atom-plugin')

  describe "influxtime plugin", ->
    it "is loaded", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      # expect(workspaceElement.querySelector('.influxtime-atom-plugin')).toExist()
      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.influxtime-atom-plugin')).toExist()
