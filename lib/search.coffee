$    = require "jquery"
_    = require "lodash"
lunr = require "lunr"

class Search
  constructor: ->
    @waitForIndex = $.getJSON("/search-index.json")
      .then (searchIndex) => lunr.Index.load(searchIndex)

  init: ->
    @waitForIndex.then =>
      $("#search-form").on("submit", @submit)
      $("#search").on("keyup", _.debounce(@search, 200))

  search: =>
    @waitForIndex
      .then (index) =>
        @displayResults index.search($("#search").val())
      .fail =>
        @displayResults null

  displayResults: (results) ->
    console.log results

  indexLoaded: -> @waitForIndex.state() == "resolved"

  submit: (evt) =>
    if @indexLoaded()
      evt.preventDefault()
      @search()

module.exports = Search
