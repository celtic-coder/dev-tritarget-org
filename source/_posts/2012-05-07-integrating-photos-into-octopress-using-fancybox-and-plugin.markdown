---
layout: post
title: "Integrating photos into OctoPress using FancyBox and Plugin"
date: 2012-05-07 16:41
comments: true
published: false
categories: coding
---
I wanted to use my [OctoPress][1] blog with my Photography hobby. I loved
the [Flickr](http://www.flickr.com) side bar plugin. However I still wanted
to place specific photos into my blogs.

For example If I go out and do a day of shooting I really would like to have
these photos show up into my post as I talk about what I did. I also wanted
to use a different server for storing the images that I have and not Flickr
(since I have some photos I don't want on Flickr)

I developed an OctoPress plugin to handle this. It uses [FancyBox][fb] as
the display method. The integration is a bit involved which is why I am
writing this post. BTW, I use FancyBox because it allows the use for
displaying media beyond just images which will be important to me when I
start posting about my [Panoramas][3].

[1]: http://octopress.org/
[fb]: http://fancyapps.com/fancybox/
[3]: http://en.wikipedia.org/wiki/Panorama

<!-- more -->

## Overview ##

The plugin basically takes a few Liquid tags and output FancyBox friendly
markup for the photos. To do this FancyBox must be integrated into your
OctoPress blog. I got the idea from [this blog post][4] and made the plugin
have the needed fixes as described in that post.

[4]: http://www.forceappx.com/blog/2011/12/28/getting-fancybox-to-play-nice-with-octopress/

There is a photo tag and a gallery tag. The photo tag will setup *one* photo
as a fancybox photo. It will use the setting `photos_prefix` in your
`_config.yml` to prefix that path to all images you use. This allows you to
specify a CDN or asset server.

The gallery tag takes a list of images and will output a fancybox compatible
list of photos which you can then style to your liking.

## Usage ##

The photo tag requires on argument the filename. If the file name starts
with a '/', 'http', or 'https' then it will be used as is. If that is not
the case then the `photos_prefix` option is prepended to the filename. if
you have `photos_prefix: http://mycdn.com/` in your `_config.yml` then a
filename of `mypath/foobar.jpg` will resolve to
`http://mycdn.com/mypath/foobar.jpg`

{% raw %}
    {% photo mypath/foobar.jpg %}
{% endraw %}

The next argument is optional and describes the thumbnail image. If you do
not provide a thumbnail or if you use the keyword `default` then the
thumbnail will default to the filename with `_m` to the end of the filename
but before the extension. So the above example will offer a thumbnail of
`http://mycdn.com/mypath/foobar_m.jpg`

Also if your filename ends with a `_b` that will change. For example a
filename of `foobar_b.jpg` will default the thumbnail to `foobar_m.jpg`

{% raw %}
    {% photo foobar.jpg barfoo.jpg %}
{% endraw %}

The last argument is also optional. It is the title of the photo. If you
want the default thumbnail then specify `default` to that option otherwise
the title option will be seen as the thumnail image.

{% raw %}
    {% photo foobar.jpg default My cool photo %}
{% endraw %}

The gallery tag is a bit different. All the path names above work the same
but the syntax is different. (The choice to use a different syntax was purly
to make it look better.)

The gallery tag is a block and starts with `gallery` and ends with
`endgallery`. In between these tags each line is a photo. After the photo
add a thumbnail in square brackets. Follow it with a colon and the title.
Here are a few examples:

{% raw %}
    {% gallery %}
    photo1.jpg
    photo2.jpg[thumb2.jpg]
    photo3.jpg[thumb3.jpg]: my title 3
    photo4.jpg: my title 4
    {% endgallery %}
{% endraw %}

## Installing ##

Installation is a bit more involved then just a drop in place. I had a little
bit of custom styling to make things look better IMHO.

Drop the `photos_tag.rb` into the `plugins/` folder. Then download
[FancyBox][fb] and place the files from thirs `source` directory into your
`source` directory. What I did was
`cp -r /path/to/fancybox/source /path/to/blog/source/fancybox`
This allowed me to separate fancybox style and javascript from the rest of
octopress.

FancyBox **depends** on [jQuery](http://jquery.com/).

There are a few styling mistakes that fancybox has when it is runing inside
octopress. to fix this the plugin provides the `fancyboxstylefix` tag.

Now I add fancybox to my pages by adding the following to my
`source/_includes/custom/head.html`:

{% codeblock source/_includes/custom/head.html %}
<!-- Load jQuery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
    jQuery.noConflict(); // ender.js conflicts with jQuery
</script>

<!-- Load FancyBox -->
<link rel="stylesheet" href="/fancybox/jquery.fancybox.css" />
<script src="/fancybox/jquery.fancybox.pack.js" type="text/javascript"></script>

{{ "{% fancyboxstylefix " }}%}

<!-- Custom Scripts -->
<script language="Javascript" type="text/javascript">
    // ender.js gobbles jQuery's ready event: Use ender.js $ instead
    $(document).ready(function() {
        jQuery(".fancybox").fancybox();
    });
</script>
{% endcodeblock %}

That is about all there is to it. And if you don't like the basic `ul` style
gallery you can fix that and make it pretty by customizing the _scss_. I
appended the following to my `sass/custom/_styles.scss`:

{% codeblock sass/custom/_styles.scss %}
/* FancyBox Galleries */
$rad: 6px;
ul.gallery {
  border: thin solid gray;
  -webkit-border-radius: $rad;
  -moz-border-radius: $rad;
  border-radius: $rad;
  text-align: center;
  padding: 5px;
  li {
    display: inline;
    padding: 5px;
  }
}
{% endcodeblock %}
