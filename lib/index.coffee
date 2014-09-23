require "bootstrap"
require "./ie10-viewport-workaround"
AppManager = require "./appmanager.coffee"

new AppManager()
  .init()
