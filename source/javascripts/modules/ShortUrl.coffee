$ = jQuery

class ShortUrl
  constructor: (@json) ->
    @data = null
    @isReady = false
    @setSiteUrl "/"
    $.getJSON @json, (@data) =>
      @checkUrl()
  setSiteUrl: (site) ->
    site = "#{site}/" unless site[site.length-1] is '/'
    @site_url = site
  loadLocation: (id) ->
    if @data[id]?
      $("#urls-loading").html("""
        Redirecting to <a href="#{@data[id]}">#{@data[id]}</a>...
      """)
      setTimeout ( => window.location.href = @data[id] ), 10
      return true
    else
      $("#error-id").text(id)
      $("#error").show()
      return false
  output: =>
    el = $("#urls")
    for id, url of @data
      short = "#{@site_url}s/##{id}"
      $("<li/>").html("""
        <b title="#{short}">#{id}</b> - <a href="#{short}">#{url}</a>
      """).appendTo(el)
    $("#urls-loading").hide()
  checkUrl: =>
    return false unless @isReady and @data?
    id = window.location.hash?.substring(1) or null
    if id?
      @loadLocation id
    else
      setTimeout @output, 10
    return true
  ready: ->
    @isReady = true
    @checkUrl()

module.exports = ShortUrl
