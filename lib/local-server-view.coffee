{View} = require 'atom'

module.exports =
class LocalServerView extends View
  @content: ->
    @div class: 'local-server overlay from-top', =>
      @div "The LocalServer package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "local-server:start", => @start()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  start: ->
    @getPort()

  getPort: ->
    portfinder = require 'portfinder'

    portfinder.getPort (err, port) =>
      @startServer port

  startServer: (port) ->
    open = require 'open'

    express = require 'express'
    app = express()

    serveIndex = require 'serve-index'

    projectPath = atom.project.getPath()

    app.use express.static(projectPath)
    app.use serveIndex(projectPath,
      icons: true
    )

    app.listen port

    open "http://127.0.0.1:#{port}"
