$         = require "jquery"
BadCipher = require "bad-cipher"

class ContactInfo
  constructor: ->
    @waitForDomReady = $.Deferred()
    $.when(@loadInfo(), @waitForDomReady)
      .then @addToDOM

  init: ->
    @waitForDomReady.resolve()

  loadInfo: ->
    $.getJSON("/info.json")
      .then @decryptData
      .then @buildDomElements

  decryptData: (data) =>
    if data.edata?
      JSON.parse BadCipher.decrypt(data.edata)
    else
      data

  buildDomElements: (@contacts) =>
    contactElements = []
    $.each @contacts, (i, {mainpage, href, title, fa_icon}) =>
      return true unless mainpage?
      iconHtml = if fa_icon?
        """<i class=\"fa fa-#{fa_icon}\"></i> """
      else
        ""
      contactElements.push """
        <li>#{iconHtml}<a href="#{href}">#{title}</a></li>
        """
    @listHtml = contactElements.join("")

  addToDOM: =>
    $(".contact-data").append(@listHtml)

module.exports = ContactInfo
