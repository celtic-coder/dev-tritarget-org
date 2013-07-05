# Title: jsbin tag for Jekyll
# Author: Devin Weaver (@sukima)
# Description:
#   Given a jsbin shortcode, outputs the jsbin link code.
#   Using 'default' will preserve default tabs.
#   Hacked from jsFiddle plugin by Brian Arnold (@brianarn)
#   See more ifo at https://github.com/remy/jsbin/blob/master/docs/embedding.md
#
# Syntax: {% jsbin shorttag [tabs] %}
#
# To embed the code you must place the following in your head or footer:
#
#     <script src="http://jsbin.com/js/embed.js"></script>
#
# To customize the embeded iframe (width is not adjustable):
# 
#     iframe.jsbin-embed {
#       height: 500px;
#     }
#
# Examples:
#
# Input: {% jsbin abc/1 %}
# Output: <a class="jsbin jsbin-embed" href="http://jsbin.com/abc/1/embed?javascript,live">View JS Bin Example</a>
#
# Input: {% jsbin abc/4 javascript,html,console %}
# Output: <a class="jsbin jsbin-embed" href="http://jsbin.com/abc/4/embed?javascript,html,console">View JS Bin Example</a>
#

module Jekyll
  class JSBin < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      if /(?<jsbin>[\w\/]+)(?:\s+(?<sequence>[\w,]+))?/ =~ markup
        @jsbin    = jsbin
        @sequence = (sequence unless sequence == 'default') || 'javascript,live'
      end
    end

    def render(context)
      if @jsbin
        "<a class=\"jsbin jsbin-embed\" href=\"http://jsbin.com/#{@jsbin}/embed?#{@sequence}\">View JS Bin Example</a>"
      else
        "Error processing input, expected syntax: {% jsbin shorttag [tabs] %}"
      end
    end
  end
end

Liquid::Template.register_tag('jsbin', Jekyll::JSBin)
