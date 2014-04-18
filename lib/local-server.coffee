LocalServerView = require './local-server-view'

module.exports =
  localServerView: null

  activate: (state) ->
    @localServerView = new LocalServerView(state.localServerViewState)

  deactivate: ->
    @localServerView.destroy()

  serialize: ->
    localServerViewState: @localServerView.serialize()
