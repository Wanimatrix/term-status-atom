TermStatus = require '../lib/term-status-atom'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TermStatus", ->
  activationPromise = null
  workspaceElement = null

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    # atom.workspaceView = atom.views.getView(atom.workspace).__spacePenView
    activationPromise = atom.packages.enablePackage('term-status-atom')

  describe "when the cli-status:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(workspaceElement.classList.contains('cli-status')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch(workspaceElement,'terminal:toggle')

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.classList.contains('cli-status')).toExist()
        atom.commands.dispatch(workspaceElement,'terminal:toggle')
        expect(workspaceElement.classList.contains('cli-status')).not.toExist()

  # describe "when cli-status is activated", ->
  #   it "should have configuration set up with defaults"
  #
  #   waitsForPromise ->
  #     activationPromise
  #
  #   runs ->
  #       expect(atom.config.get('term-status-atom.WindowHeight')).toBe(300)
