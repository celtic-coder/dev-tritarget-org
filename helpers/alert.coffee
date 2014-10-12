Handlebars = require "handlebars"

exports.alert = (type, options) ->
  if not options?
    options = type
    type    = "info"

  new Handlebars.SafeString("""
    <div class="alert alert-#{type}" role="alert">
      #{options.fn()}
    </div>
  """)
