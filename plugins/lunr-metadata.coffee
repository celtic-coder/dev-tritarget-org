debug = require("debug")("metalsmith-lunr-metadata")
path  = require "path"

module.exports = (opts={}) ->
  enabledByDefault = opts.default ? true

  (files, metalsmith, done) ->
    for filename, file of files
      if path.extname(filename) == ".html"
        debug("processing file %s", filename)
        file.lunr ?= enabledByDefault
    process.nextTick(done)
