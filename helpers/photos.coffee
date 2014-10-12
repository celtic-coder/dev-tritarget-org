path       = require "path"
Handlebars = require "handlebars"

photosPrefix = "http://photos.tritarget.org/photos/"
panosPrefix  = "http://photos.tritarget.org/panoramas/"

imageMarkup = ({href, title, thumbnail, id}) ->
  """
  <a href="#{href}" class="photo normal" data-toggle="lightbox" data-parent="" data-gallery="#{id}" title="#{title}" data-title="#{title}"><img src="#{thumbnail}" alt="#{title} (thumbnail)" class="img-thumbnail"></a>
  """

panoMarkup = ({href, title, thumbnail}) ->
  """
  <p class="pano"><a href="#{href}" class="normal" target="_blank" title="#{title}"><img src="#{thumbnail}" alt="#{title} (thumbnail)" class="img-thumbnail"><i class="fa fa-cube"></i></a></p>
  """

thumbnailName = (filename) ->
  ext      = path.extname(filename)
  basename = path.basename(filename, ext)
  dirname  = path.dirname(filename)
  href     = path.join(dirname, basename)
  "#{href}_t#{ext}"

exports.gallery = ({fn, hash}) ->
  id   = hash.id || "photos"
  html = fn()
    .split("\n")
    .map (line) ->
      [filename, title] = line.split(":")
      thumbnail = filename.trim().match(/\[(.+)\]$/)
      if thumbnail?
        thumbnail  = thumbnail[1].trim() if thumbnail?
        [filename] = filename.split("[")
      {
        filename:  filename.trim()
        thumbnail: thumbnail && thumbnail.trim()
        title:     title && title.trim()
      }
    .map ({filename, title, thumbnail}) ->
      return "" if not filename? || filename == ""
      html = imageMarkup {
        id, title
        href:      "#{photosPrefix}#{filename}"
        thumbnail: "#{photosPrefix}#{thumbnail || thumbnailName(filename)}"
      }
      "<li>#{html}</li>"
    .join("")
  new Handlebars.SafeString("""
    <div class="panel panel-default photos">
      <ul class="panel-body list-inline">#{html}</ul>
    </div>
  """)

exports.photo = (filename, {hash}) ->
  html = imageMarkup
    id:        hash.id || "photos"
    title:     hash.title
    href:      "#{photosPrefix}#{filename}"
    thumbnail: "#{photosPrefix}#{hash.thumbnail || thumbnailName(filename)}"
  new Handlebars.SafeString(html)

exports.pano = (filename, {hash}) ->
  html = panoMarkup
    title:     hash.title || filename
    href:      "#{panosPrefix}#{filename}"
    thumbnail: "#{panosPrefix}#{filename}/#{hash.thumbnail || "preview.jpg"}"
  new Handlebars.SafeString(html)
