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
#     s.setPath("http://mysite.com/s/")
#       .onRedirect(function(e) {
#         console.log(e.url);
#       }).ready();
#
# The following functions can be chained: `onDisplay`, `onRedirect`,
# `onError`, and `setPath` (`ready` only works at the end of the chain).
#
# ### Events ###
# The following events are triggered and data is sent with the event objects passed in.
#
# #### display ####
# Used to build the list (view) of all items. The event object will have these
# properties:
#     items: [
#       { id: "", url: "", short_path: "" },
#       ...
#     ]
#
# #### redirect ####
# Called when the browser is about to redirect. Used to offer feed back to the
# user just before the redirect. The event object will have these properties:
#     id: "",
#     url: "",
#     short_path: ""
#
# #### error ####
# Used to display any errors encountered. The event object will have these
# properties:
#     id: ""
#
# Examples:
#     var s = new ShortUrl("path/to/json");
#     $(s).on("display", function(e) {
#       console.log(e.items);
#     });
#     s.onDisplay(function(e) {
#       console.log(e.items);
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
    @setPath()
    if options?
      if options.domain? and options.path?
        @setPath options.domain, options.path
      else
        @setPath options.path
      @onError options.onError
      @onRedirect options.onRedirect
      @onDisplay options.onDisplay
      @_waiting_for_ready.resolve()
  onRedirect: (fn) ->
    $(@).on("redirect", fn) if fn?
    @
  onError: (fn) ->
    $(@).on("error", fn) if fn?
    @
  onDisplay: (fn) ->
    $(@).on("display", fn) if fn?
    @
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
    @
  # Abstact function for testing
  @redirectTo: (url) -> window.location.replace url
  # Atempt to redirect the browser
  loadLocation: (id) ->
    url = @data[id]
    if url?
      e = $.Event("redirect")
      $(@).triggerHandler $.extend(e, @buildOutputItem(id, url))
      setTimeout ( => ShortUrl.redirectTo url ), 10
      return true
    else
      $(@).triggerHandler
        type: "error"
        id: id
      return false
  # Util function to make output data
  buildOutputItem: (id, url) ->
    return {
      id: id
      url: url
      short_path: "#{@path}##{id}"
    }
  # Build data then call output event callback
  output: ->
    output_data = []
    output_data.push @buildOutputItem(id,url) for id,url of @data
    e = $.Event("display")
    e.items = output_data
    $(@).triggerHandler e
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
  ready: ->
    @_waiting_for_ready.resolve()
    return

if module?
  # CommonJS
  module.exports = ShortUrl
else
  # Attach to global object (not CommonJS)
  @ShortUrl = ShortUrl
