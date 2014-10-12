$ = require "jquery"
require "lightbox"

showLightbox = (e) ->
  e.preventDefault()
  $(this).ekkoLightbox()

class Photos
  init: ->
    $(document).delegate '*[data-toggle="lightbox"]', "click", showLightbox

module.exports = Photos
