path           = require "path"
{readFileSync} = require "fs"

exports.includeFile = (filePath, options) ->
  # TODO: Path should not be hard coded.
  readFileSync path.resolve("#{__dirname}/../src/#{filePath}"), "utf8"
