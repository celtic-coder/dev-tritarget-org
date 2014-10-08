---
title: Photography
template: page.hbs
---
I am a bit of photography buff. I am an enthhusiest of panoramas. Especially
the Virtual Tours on you find on [360cities](http://360cities.net/).

A lot of my knowlwdge came from the following tutorials:

* [How To Get Started on 360° Panoramic Photography - 360cities.net](http://help.360cities.net/taking-panoramic-pictures/how-to-get-started)
* [Panorama Tutorial Series by FloTube and elfloz](http://www.youtube.com/playlist?list=PL15B8C737F69319BE)

{{#if tags.photography}}
## Blog Posts ##

These are the latest _five_ posts which have photos and panoramics for you to
view:

<div class="panel panel-default">
  <div id="posts" class="list-group">
    {{#each-limit tags.photography 5}}
      {{> blog_list_item}}
    {{/each-limit}}
    {{#if-gt tags.photography 5}}
    <a href="/categories/photography" class="list-group-item normal">
      <h4 class="list-group-item-heading">See All</h4>
    </a>
    {{/if-gt}}
  </div>
</div>
{{/if}}

## What I use ##

My camera equipment consists of the [Canon EOS Rebel XS][1] with a [Bower 8mm
Fisheye][2] lens (known with many other names like Samyang). I also use a
Panoramic Tripod Head called [the Panosaurus][panosaurus] to minimizing the
paralax errors.

After this is done I use a lot of tools. The most promenent tools are:

* [Hugin][hugin] - A panorama sticher.
* [GIMP][gimp] - An image editor.

After I developed a finish product I will deploy it by converting it to several
formats. The following are tools I use in the background but are not needed for
making a panoramia.

* [PanoTools](http://panotools.sourceforge.net/) - Command line tools to convert panos
* [ImageMagick](http://www.imagemagick.org/) - Command line tool to convert images
* [SaladoConverter][salado] - Java GUI application to convert panos to DeepZoom format
* [SaladoPlayer][salado] - Flash panoramic viewer
* [vr5](http://www.vrhabitat.com/#vr5) - Panoramic viewer for iPhones, iPods, and iPads

[1]: http://www.usa.canon.com/cusa/support/consumer/eos_slr_camera_systems/eos_digital_slr_cameras/eos_rebel_xs_18_55is_kit
[2]: http://www.photozone.de/canon-eos/526-samyang8f35eos
[panosaurus]: http://gregwired.com/pano/Pano.htm
[hugin]: http://hugin.sourceforge.net/
[gimp]: http://www.gimp.org/
[salado]: http://panozona.com/wiki/Main_Page

I develop these on either a Linux machine runing Ubuntu or a Mac with Mac OS X.
