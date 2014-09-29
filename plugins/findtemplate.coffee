module.exports = ({pattern, templateName}) ->
  pattern = new RegExp(pattern) unless pattern instanceof RegExp

  (files, metalsmith, done) ->
    for filename, file of files
      if pattern.test(filename) && not file.template?
        file.template = templateName
    done()
