Handlebars = require "handlebars"

exports.jsbin = (path, panels) ->
  panels = if panels?
    "?#{panels}"
  else
    ""
  html =
    """
    <a class="jsbin-embed" href="http://jsbin.com/#{path}/embed#{panels}">JS Bin</a>
    """
  new Handlebars.SafeString(html)
