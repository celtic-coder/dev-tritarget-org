path           = require "path"
{readFileSync} = require "fs"
marked         = require "marked"
Handlebars     = require "handlebars"

getContents = (filePath) ->
  # TODO: Path should not be hard coded.
  contents = readFileSync path.resolve("#{__dirname}/../src/#{filePath}"), "utf8"
  index = contents.indexOf("---", 3) + 4 # include ending new line
  contents.substring(index)

exports.includeFile = (filePath, options) ->
  new Handlebars.SafeString(getContents filePath)

exports.includeMarkdownFile = (filePath, options) ->
  content = marked(getContents filePath)
  new Handlebars.SafeString(content)
