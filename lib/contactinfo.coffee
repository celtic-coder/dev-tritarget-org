_         = require "lodash"
$         = require "jquery"
BadCipher = require "bad-cipher"

decryptData = (data) ->
  if data.edata?
    JSON.parse BadCipher.decrypt(data.edata)
  else
    data

itemToContacts = (contacts) ->
  (item) ->
    if item == "all"
      contacts
    else
      _.find(contacts, id: item)

buildContactHTML = ({template}, isList) ->
  template = if template
    _.template template
  else
    _.template """<%= iconHtml %> <a href="<%= href %>"><%= title %></a>"""

  (contact) ->
    {href, title, value, fa_icon} = contact

    titleHtml = if titleTemplate?
      template(contact)
    else
      title

    iconHtml = if fa_icon?
      "<i class=\"fa fa-#{fa_icon}\"></i>"
    else
      ""

    html = template _.extend(contact, {iconHtml})

    if isList
      "<li>#{html}</li>"
    else
      html

loadInfo = (url) -> $.getJSON(url).then(decryptData)

addToDOM = (selector) ->
  (contacts) ->
    $(selector).each (i, el) ->
      $el          = $(el)
      items        = ($el.data("items") ? "all").split(/[,\s]/)
      isList       = items.length > 1 || items[0] == "all"
      contactsHTML = _(items).chain()
        .map(itemToContacts contacts)
        .flatten()
        .map(buildContactHTML $el.data(), isList)
        .value().join("")
      $el.append(contactsHTML)

class ContactInfo
  constructor: (@url="/info.json", @selector=".contact-data") ->
    @waitForDomReady = $.Deferred()
    $.when(loadInfo(@url), @waitForDomReady)
      .then(addToDOM(@selector))

  init: -> @waitForDomReady.resolve()

module.exports = ContactInfo
