Handlebars = require "handlebars"

panosPrefix  = "http://photos.tritarget.org/panoramas/"

panoMarkup = ({href, title, thumbnail}) ->
  """
  <a href="#{href}" class="pano normal" target="_blank" title="#{title}"><img src="#{thumbnail}" alt="#{title} (thumbnail)" class="img-thumbnail"><i class="fa fa-cube"></i></a>
  """

exports.pano = (filename, {fn, hash}) ->
  html = panoMarkup
    title:     hash.title || filename
    href:      "#{panosPrefix}#{filename}"
    thumbnail: "#{panosPrefix}#{filename}/#{hash.thumbnail || "preview.jpg"}"
  new Handlebars.SafeString(html)
