# Used to pre-process the contents of files before processing through
# metalsmith-templates normally. Uses metalsmith-templates inPlace option but
# filters out un-processable files first.
_         = require "lodash"
templates = require "metalsmith-templates"

module.exports = (options) ->
  template = templates(_.extend {}, options, inPlace: true)
  filterFn = (file) -> file.template?

  (files, metalsmith, done) ->
    template _.filter(files, filterFn), metalsmith, done
