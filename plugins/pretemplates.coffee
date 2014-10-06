# Used to pre-process the contents of files before processing through
# metalsmith-templates normally. Uses metalsmith-templates inPlace option but
# filters out un-processable files first.
_         = require "lodash"
fs        = require "fs"
path      = require "path"
templates = require "metalsmith-templates"

module.exports = (options) ->
  partials = _(options.partials).chain().clone()
    .mapValues (file) -> fs.readFileSync(file, "utf8")
    .value()

  template = templates(_.extend {}, options, {partials, inPlace: true})
  filterFn = (file) -> file.template?

  (files, metalsmith, done) ->
    template _.filter(files, filterFn), metalsmith, done
