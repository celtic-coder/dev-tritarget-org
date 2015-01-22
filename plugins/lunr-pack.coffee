debug   = require("debug")("metalsmith-lunr-pack")
# NOTE: use lz-string instead. maybe with jsonpak?
jsonpack = require "jsonpack"

module.exports = (indexFile) ->

  (files, metalsmith, done) ->
    origData  = files[indexFile].contents
    debug("Packing #{indexFile}. Size: #{origData.length}")
    data      = jsonpack.encode(origData)
    reduction = Math.round((origData.length / data.length) * 100)
    debug("Packed #{indexFile}. Size: #{data.length} (#{reduction}%)")
    files[indexFile].contents = JSON.stringify({packed: true, data})
    process.nextTick(done)
