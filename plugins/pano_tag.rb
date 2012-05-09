# Title: Pano tag for Jekyll
# Authors: Devin Weaver
# Description: Allows the inclusion of panoramas using salado and vr5
#
# ** This only covers the markup. Not the integration of salado or vr5 **
#
# To see an unabridged explination on integrating this with [Salado][1]
# and [vr5][2] please read my [blog post about it][3].
#
# This also assumes you have integrated [FancyBox][4]. Please read
# [how to do this][5] from my blog.
#
# This uses convention over customization. It is dependent on the
# [pano-skel][6] project.
#
# Site option `panos_prefix` will determine where panos are stored.
#
# [1]: https://github.com/mstandio/SaladoConverter/downloads
# [2]: http://www.vrhabitat.com/#vr5
# [3]: 
# [4]: http://fancyapps.com/fancybox/
# [5]: http://tritarget.org/blog/2012/05/07/integrating-photos-into-octopress-using-fancybox-and-plugin/
# [6]: 
#
# Syntax {% pano filename %}

module Jekyll
  
  class PanoUtil
    def initialize(context)
      @context = context
    end

    def path_for(filename)
      filename = filename.strip
      prefix = (@context.environments.first['site']['panos_prefix'] unless filename =~ /^(?:\/|http)/i) || ""
      prefix = "#{prefix}/" unless prefix =~ /^$|\/$/
      "#{prefix}#{filename}"
    end

    def player_path
      @context.environments.first['site']['salado_player']
    end

    def pano_path_for(pano)
      path_for("#{pano}/salado.html")
    end

    def xml_path_for(pano)
      path_for("#{pano}/salado.xml")
    end

    def vr5_path_for(pano)
      path_for("#{pano}/vr5.html")
    end

    def thumb_for(pano, thumb=nil)
      thumb = (thumb unless thumb == 'default') || "preview.jpg"
      path_for("#{pano}/#{thumb}")
    end
  end

  class PanoTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      if /(?<pano>\S+)(?:\s+(?<thumb>\S+))?(?:\s+(?<title>.+))?/i =~ markup
        @pano = pano
        @title = title
        @thumb = thumb
      end
      super
    end

    def render(context)
      unless context.environments.first['site']['salado_player'].nil?
        p = PanoUtil.new(context)
        if @pano
          "<a href=\"#{p.pano_path_for(@pano)}\" data-vr5-path=\"#{p.vr5_path_for(@pano)}\" data-player-path=\"#{p.player_path}\" data-xml-path=\"#{p.xml_path_for(@pano)}\" class=\"fancybox-pano\" title=\"#{@title}\"><img src=\"#{p.thumb_for(@pano,@thumb)}\" alt=\"#{@title}\" /></a>"
        else
          "Error processing input, expected syntax: {% pano filename [title] %}"
        end
      else
        "Error: 'salado_player' not defined in _config.yml"
      end
    end
  end

end

Liquid::Template.register_tag('pano', Jekyll::PanoTag)
