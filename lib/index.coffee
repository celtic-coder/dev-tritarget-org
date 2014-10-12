require "bootstrap"
require "./ie10-viewport-workaround"
window._   = require "lodash"
AppManager = require "./appmanager.coffee"

new AppManager()
  .use(require "./shorturl.coffee")
  .use(require "./contactinfo.coffee")
  .use(require "./printbutton.coffee")
  .use(require "./photos.coffee")
  .init()
