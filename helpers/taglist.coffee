_          = require "lodash"
Handlebars = require "handlebars"

exports.tagList = (tags, joiner, options) ->
  return "" unless tags?
  joiner = ", " unless options?
  results = tags.map (tag) -> "##{tag}"
  new Handlebars.SafeString(results.join(joiner))

exports.tagListLinks = (tags, prefix="/tags/", joiner, options) ->
  return "" unless tags?
  joiner = ", " unless options?
  results = tags.map (tag) ->
    """<a href="#{prefix}#{tag}">##{tag}</a>"""
  new Handlebars.SafeString(results.join(joiner))
