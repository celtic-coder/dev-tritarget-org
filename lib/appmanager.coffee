$ = require "jquery"

class AppManager
  constructor: ->
    @plugins = []

  use: (Middleware) ->
    @plugins.push new Middleware()
    this

  init: ->
    $ => plugin.init?() for plugin in @plugins
    this

module.exports = AppManager
