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
# This uses convention over customization. It is dependent on 
#
# [1]: 
# [2]: 
# [3]: 
# [4]: http://fancyapps.com/fancybox/
# [5]: http://tritarget.org/blog/2012/05/07/integrating-photos-into-octopress-using-fancybox-and-plugin/
#
# Syntax {% pano filename %}

module Jekyll
  
  class PanoUtil
    def initialize(context)
      @context = context
    end

    def path_for(filename)
      filename = filename.strip
      prefix = (@context.environments.first['site']['photos_prefix'] unless filename =~ /^(?:\/|http)/i) || ""
      "#{prefix}#{filename}"
    end

    def pano_path_for(panoname)
      # default to salado file to handle backwards compatability
      # vr5 supported by javascript after the fact.
      path_for("#{panoname}/salado/index.html")
    end

    def thumb_for(panoname, thumb=nil)
      thumb = (thumb unless thumb == 'default') || "preview.jpg"
      path_for("#{panoname}/#{thumb}")
    end
  end

  class PanoTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      if /(?<filename>\S+)(?:\s+(?<thumb>\S+))?(?:\s+(?<title>.+))?/i =~ markup
        @panoname = panoname
        @title = title
        @thumb = thumb
      end
      super
    end

    def render(context)
      p = PhotosUtil.new(context)
      if @panoname
        "<a href=\"#{p.pano_path_for(@panoname)}\" class=\"fancybox-pano\" title=\"#{@title}\"><img src=\"#{p.thumb_for(@panoname,@thumb)}\" alt=\"#{@title}\" /></a>"
      else
        "Error processing input, expected syntax: {% pano filename [title] %}"
      end
    end
  end

end

Liquid::Template.register_tag('pano', Jekyll::PanoTag)
