# Used to pre-process the contents of files before processing through
# metalsmith-templates normally. Uses metalsmith-templates inPlace option but
# filters out un-processable files first.
_         = require "lodash"
templates = require "metalsmith-templates"

module.exports = (options) ->
  template = templates(_.extend {}, options, inPlace: true)

  (files, metalsmith, done) ->
    refCount = 0
    templateDone = (err) ->
      throw err if err?
      refCount--
      done() if (refCount <= 0)

    try
      for filename, file of files then do (file) ->
        contents = file.contents?.toString() ? ""

        # Only process files designed for use in templates
        return unless file.template? && contents != ""

        refCount++
        template([file], metalsmith, templateDone)

    catch err
      done(err)
