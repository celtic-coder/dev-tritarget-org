Handlebars = require "handlebars"

exports.pullquote = (pull, options) ->
  if not options?
    options = pull
    pull    = "right"
  quote = ""

  saveQuote = (__, quoteText) ->
    quote = quoteText.trim()

  result = options.fn(this)
    .replace(/{"\s*([\s\S]*)\s*"}/, saveQuote)

  new Handlebars.SafeString """
    <div class="pullquote pull-#{pull}">
      <blockquote class="blockquote-#{pull} pull-#{pull}">
        <p>#{quote}</p>
      </blockquote>
    </div>
    #{result}
  """
