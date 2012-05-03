# Title: Photos tag for Jekyll
# Authors: Devin Weaver
# Description: Allows photos tag to place photos as thumbnails and open in lightbox. Uses a CDN if needed.
#
# Syntax {% photos filename [filename ...] %}
# (photo is alias to photos) If the filename has no path in it (no slashes)
# then it will prefix the `_config.yml` setting `photos_prefix` to the path.
# This allows using a CDN is desired.
#
# Examples:
# {% photos photo1.jpg %}
# {% photos /path/to/photo.jpg %}
# {% photos photo1.jpg photo2.jpg %}

module Jekyll
  
  class PhotosTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)

    end

    def render(context)
      # context.environments.first['site']['photos_prefix']
    end
  end
end

Liquid::Template.register_tag('photos', Jekyll::PhotosTag)
Liquid::Template.register_tag('photo', Jekyll::PhotosTag)
