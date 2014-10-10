$          = require "jquery"
_          = require "lodash"
Backbone   = require "backbone"
Backbone.$ = $

redirect = (url) -> window.location = url

startRouter = (shouldRedirect=false) ->
  Backbone.history.start() if (shouldRedirect)

listUrls = ($el, urls) ->
  urlsMarkup = _.map urls, (url, shortKey) ->
    """
    <tr>
      <td><tt><a href="/s/##{shortKey}">#{shortKey}</a></tt></td>
      <td><tt>#{url}</tt></td>
    </tr>
    """
  $el.append(urlsMarkup.join "")

class UrlShortener extends Backbone.Router
  constructor: ->
    @waitForUrls = $.getJSON("/urls.json")
    super

  init: ->
    $el = $("#short-urls")
    @waitForUrls.then (@urls) =>
      _.each(@urls, @addRoute)
      startRouter($el.data("redirect"))
      _.defer(listUrls, $el, @urls)

  addRoute: (url, id) =>
    @route(id, _.partial(redirect, url))

module.exports = UrlShortener
