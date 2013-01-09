$ = jQuery

class ShortUrl
  constructor: (@json) ->
  location: (id) ->
    if @json[id]?
      window.location.href = @json[id]
    else
      @error()
    return
  error: =>
    $("#error").show()
  output: =>
    el = $("#urls")
    for id, url of @json
      short = "http://tritarget.org/s/##{id}"
      $("<li/>").html("""
        <b title="#{short}">#{id}</b> - <a href="#{short}">#{url}</a>
      """).appendTo(el)
    $("#urls-loading").hide()
  checkUrl: ->
    id = window.location.hash?.substring(1) or null
    if id?
      @location id
    else
      setTimeout @output, 10

module.exports = ShortUrl
