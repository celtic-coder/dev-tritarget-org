debug = require("debug")("metalsmith-findTemplate")

module.exports = ({collection, pattern, templateName}) ->
  pattern = new RegExp(pattern) if pattern? && not pattern instanceof RegExp

  (files, metalsmith, done) ->
    for filename, file of files then do (filename, file) ->
      debug("checking file %s", filename)
      return if file.template?
      return if collection? && file.collection.indexOf(collection) < 0
      return if pattern? && not pattern.test(filename)
      debug("adding default template to %s", filename)
      file.template = templateName
    done()
