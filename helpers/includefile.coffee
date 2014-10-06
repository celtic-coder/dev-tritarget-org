path           = require "path"
{readFileSync} = require "fs"
marked         = require "marked"
Handlebars     = require "handlebars"

getContents = (filePath) ->
  # TODO: Path should not be hard coded.
  readFileSync path.resolve("#{__dirname}/../src/#{filePath}"), "utf8"

exports.includeFile = (filePath, options) ->
  new Handlebars.SafeString(getContents filePath)

exports.includeMarkdownFile = (filePath, options) ->
  content = marked(getContents filePath)
  new Handlebars.SafeString(content)
