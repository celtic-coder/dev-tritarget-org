# A module to handle fetching, parsing, and displaying the short urls data and
# to handle loading the long url baed on the passed in hash tag.
#
# When this is executed on a page it will load the data from a JSON file. It
# the checks if there is a hash tag in the URL. If so it redirects the page to
# the long url. If not it lists out all the short urls.
#
# For example, `http://mysite.com/s/` will display the list and
# `http://mysite.com/s/#1` will redirect to the associated url for the id 1.
#
# This assumes that you have an index.html in the /s directory of your website.
# It also has HTML elements it interacts with and is dependent on jQuery.
#
# ## Usage ##
#     var s = new ShortUrl("path/to/json");
#     s.setSiteUrl("http://mysite.com");
#     s.ready();
$ = jQuery

class ShortUrl
  # Load the json file passed in as a string
  constructor: (@json) ->
    @data = null
    @isReady = false
    @setPath()
    $.getJSON @json, (@data) =>
      @checkUrl()
  # Explicity set the short url path (default: '/s/')
  #
  # Examples:
  #     setPath();                            // => "/s/"
  #     setPath("/foo/");                     // => "/foo/"
  #     setPath("http://foobar/", "/foo/");   // => "http://foobar/foo/"
  #     setPath("http://foobar", "bar.html"); // => "http://foobar/bar.html"
  setPath: (domain,path) ->
    if path?
      domain = "#{domain}/" unless domain[domain.length-1] is '/'
      path = path.substring(1) if path[0] is '/'
      @short_path = "#{domain}#{path}"
    else if domain?
      @short_path = domain
    else
      @short_path = "/s/"
  # Atempt to redirect the browser
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
  # Output the list of known short urls when not redirecting
  output: =>
    el = $("#urls")
    for id, url of @data
      short = "#{@site_path}##{id}"
      $("<li/>").html("""
        <b title="#{short}">#{id}</b> - <a href="#{short}">#{url}</a>
      """).appendTo(el)
    $("#urls-loading").hide()
  # Check if requested a redirect or a list
  # If you have a hash value in the URL then it will attempt to redirect to
  # that short url. Otherwise it will output the list on the page.
  checkUrl: =>
    return false unless @isReady and @data?
    id = window.location.hash?.substring(1) or null
    if id?
      @loadLocation id
    else
      setTimeout @output, 10
    return true
  # Register that checking, redirecting or outputing is ready after all
  # asynchronous tasks are finished.
  ready: ->
    @isReady = true
    @checkUrl()

if module?
  # CommonJS
  module.exports = ShortUrl
else
  # Attach to global object (not CommonJS)
  @ShortUrl = ShortUrl
