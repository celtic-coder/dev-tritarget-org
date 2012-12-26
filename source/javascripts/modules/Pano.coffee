$ = jQuery

Pano =
  isIOS: ->
    # detect browser
    navigator
      .userAgent
      .toLowerCase()
      .match /(iphone|ipod|ipad)/

  openPano: (e) ->
    e.preventDefault()
    el = $(@)
    if Pano.isIOS()
      window.location.href = el.data 'vr5-path'
    else
      $.fancybox.open
        href: el.attr 'href'
        title: el.attr 'title'
        type: 'iframe'
    false

module.exports = Pano
