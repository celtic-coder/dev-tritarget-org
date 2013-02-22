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
# It is dependent on jQuery.
#
# ## Usage ##
#     var s = new ShortUrl("path/to/json");
#     s.setPath("http://mysite.com/s/");
#     s.setOutputWith(function(data) {
#       console.log(data);
#     });
#     s.ready();
#
# #### Date Object ####
# The callback for setOutputWith will send a data object of the form:
#     {
#       id: 1,                      // The short id
#       url: "http://example.com/", // The URL the short id points to
#       short_path: "/s/#1"         // The path used for the sortened URL
#     }
#
# #### Events ####
# The following events are triggered:
# * `redirect` - Called when the browser is about to redirect. Used to offer
#   feed back to the user just before the redirect.
# * `error` - Used to display any errors encountered. Passes a jQuery event
#   object.
#
# Example:
#     var s = new ShortUrl("path/to/json");
#     $(s).on("redirect", function(data) {
#       console.log(data);
#     });
#     $(s).on("error", function(event) {
#       console.log(event);
#     });
$ = jQuery

class ShortUrl
  # Load the json file passed in as a string
  constructor: (json_url, options) ->
    # Allows for alternative syntax
    if arguments.length is 1 and typeof json_url isnt "string"
      options = json_url
      json_url = options.json
    @data = null
    # Promises
    @_waiting_for_ready = $.Deferred()
    @_loading_JSON = $.getJSON(json_url)
      .done( (@data) => )
    @_waiting_for_all_done = $.when(@_waiting_for_ready, @_loading_JSON)
      .done( => @checkUrl() )
    # Allows an object to preset parameters and immediatly declare ready state.
    if options?
      @setPath(options.path)
      @onError = options.onError
      @onRedirect = options.onRedirect
      @output_function = options.output
      @_waiting_for_ready.resolve()
    else
      @setPath()
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
      @path = "#{domain}#{path}"
    else if domain?
      @path = domain
    else
      @path = "/s/"
  setOutputWith: (@output_function) ->
  # Abstact function for testing
  @redirectTo: (url) -> window.location.href = url
  # Util function to make output data
  outputData: (item) ->
    $.extend item, { short_path: "#{@path}##{item.id}" }
  # Atempt to redirect the browser
  loadLocation: (id) ->
    item = @data[id]
    if item?
      $(@).trigger "redirect", @outputData(item)
      setTimeout ( => ShortUrl.redirectTo item ), 10
      return true
    else
      $(@).trigger "error", $.Event("error", { id: id })
      return false
  # Output the list of known short urls when not redirecting
  output: ->
    if @output_function?
      @output_function @outputData(item) for item of @data
    return
  # Abstact function for testing
  @getHash: -> window.location.hash
  # Check if requested a redirect or a list
  # If you have a hash value in the URL then it will attempt to redirect to
  # that short url. Otherwise it will output the list on the page.
  checkUrl: ->
    return false unless @_waiting_for_all_done.isResolved()
    id = ShortUrl.getHash()?.substring(1) or null
    if id?.length > 1
      @loadLocation id
    else
      setTimeout ( => @output() ), 10
    return true
  # Register that checking, redirecting or outputing is ready after all
  # asynchronous tasks are finished.
  ready: -> @_waiting_for_ready.resolve()

if module?
  # CommonJS
  module.exports = ShortUrl
else
  # Attach to global object (not CommonJS)
  @ShortUrl = ShortUrl
