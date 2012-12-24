---
layout: nil
---
$ = jQuery

class window.site
  # Function: initCollapsibleDivs() [[[1
  @initCollapsibleDivs: =>
    $(".box_top").each ->
      $(@).click ->
        $(@).siblings(".box_text").slideToggle "fast", ->
          $(@).siblings(".box_bottom").toggle()
        $(@).toggleClass("collapsed")

  # Function: initDialogBoxes() [[[1
  @initDialogBoxes: =>
    # Set div to correct location in layout
    $("#dialog-boxes").appendTo "body"

    # if close button is clicked
    $('.window .close').click (e) ->
      # Cancel the link behavior
      e.preventDefault()
      $('#mask, .window').hide()

    # if mask is clicked
    $('#mask').click ->
      $(@).hide()
      $('.window').hide()

  # Function: keyed() [[[1
  @keyed: (e) =>
    # FIXME: This does not run.
    # e.keyCode and e.which is 0 but e.charCode is correct for characters like 'a' or 'b'
    # e.charCode is 0 but e.keyCode and e.which is correct for non characters like <Up> and <Down>
    console.log e
    console.log "key: #{e.which}"
    @kkeys.push e.which
    if @kkeys.toString().indexOf(@konami) >= 0
      @openDialog "#game"

      if SKI?
        SKI.run $("#game")
      else
        $.getScript "http://github.com/sukima/skiQuery/raw/master/skiQuery.js", ->
          SKI.run $("#game")

      @kkeys = [];
      return false;

    # Prevent an ever growing array
    if @kkeys.length > 10
      @kkeys.shift()

    return true

  # Function: initKonamiCode() [[[1
  @initKonamiCode: =>
    @kkeys = []
    @konami = "38,38,40,40,37,39,37,39,66,65"
    if $.browser.mozilla
      $(document).keypress @keyed
    else
      $(document).keydown @keyed

  # Function: collapseDivs() [[[1
  @collapseDivs: =>
    $(".box_top.collapsed").each ->
      $(@).siblings(".box_text").hide()
      $(@).siblings(".box_bottom").hide()

  # Function: openDialog() [[[1
  @openDialog: (id) =>
    # Get the screen height and width
    maskHeight = $(document).height()
    maskWidth = $(window).width()

    # Set height and width to mask to fill up the whole screen
    $('#mask').css {'width':maskWidth,'height':maskHeight}
    # Set the position to the top of the page
    $('#mask').css {'top':0,'left':0}

    # transition effect
    $('#mask').fadeIn 1000
    $('#mask').fadeTo "slow",0.8

    # Get the window height and width
    winH = $(window).height()
    winW = $(window).width()

    # Set the popup window to center
    $(id).css 'top', winH/2-$(id).height()/2
    $(id).css 'left', winW/2-$(id).width()/2

    # transition effect
    $(id).fadeIn 2000

# ]]]1

# vim:set sw=2 ts=2 et fdm=marker fmr=[[[,]]]:
