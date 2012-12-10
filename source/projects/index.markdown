---
layout: page
title: "Projects"
date: 2012-03-29 16:44
comments: false
sharing: false
footer: false
---
These are some of the projects I am working on or have worked on.

- **[Equipment Status Viewer](http://sukima.github.com/redmine_equipment_status_viewer)** -
  A [redmine][] plugin that tracks equipment and there last know location.
  Entry of the last know location will be done via an iPhone web interface and
  use qr-codes to "check-in" equipment.
- **[skiQuery](http://sukima.github.com/skiQuery/)** - A JavaScript port of the old
  classic command-line game ski.
- **[bjurl](http://sukima.github.com/bjurl)** - A [PERL][] plugin for [irssi][]
  that collects URLs from a channel and dynamically updates a JavaScript based
  website for easy opening in a remote browser. Includes WebKit Desktop
  Notifications and [jQuery][] AJAX Support.
- **[xmledit](http://github.com/sukima/xmledit)** - A filetype plugin for [VIM][]
  to help edit XML files. (I deprecated this for [ZenCodeing][zen] but still
  maintain it for bugs).
- **[vim-markdown](http://github.com/sukima/vim-markdown)** - _(Forked)_ Markdown Vim
  Mode (Incude missing pre block) (Add [jekyll][] YAML support)
- **[SimNotify](http://sukima.github.com/SimNotify/)** - A Ruby on Rails
  scheduling program for medical simulation centers. This app is very site
  specific for a simulation center that I work for. This project is my attempt
  to allow people to schedule a simulation by entering in key data needed and
  the administrators can place that scheduled session on a calendar. (This
  project has been abandoned per management).

[VIM]: http://www.vim.rg/
[irssi]: http://irssi.org/
[redmine]: http:/www.redmine.org/
[jQuery]: http://jquery.com/
[PERL]: http://www.perl.org/
[jekyll]: http://jekyllrb.com/
[zen]: http://www.vim.org/scripts/script.php?script_id=2981

## Sample Code ##

I like to spawn little projects to learn new technology. Here is a list of
sample projects I've made in the learning process.

- **[NotesApp](http://github.com/sukima/NotesApp-Sample/)** - A sample mobile
  web application that display's and stors notes in LocalStorage. Followed a
  tutorial and expanded by making a custom Model, View, and Controller. Uses
  commonJS modules, Jasmine testing, jQuery-mobile and Handlebars templates.
- **[99-bottles-cs](http://sukima.github.com/99-bottles-cs/)** - A CoffeeScript
  implementation of the [99 bottles of beer](http://www.99-bottles-of-beer.net/) song.

## Blog Posts ##

<div id="blog-archives">
{% for post in site.categories['coding'] limit: 20 %}
<article>
  {% include archive_post.html %}
</article>
{% endfor %}
</div>

#### Not-so-random fortune quote

_When users see one GUI as beautiful,_  
_other user interfaces become ugly._  
_When users see some programs as winners,_  
_other programs become lossage._  
  
_Pointers and NULLs reference each other._  
_High level and assembler depend on each other._  
_Double and float cast to each other._  
_High-endian and low-endian define each other._  
_While and until follow each other._  
  
_Therefore the Guru_  
_programs without doing anything_  
_and teaches without saying anything._  
_Warnings arise and he lets them come;_  
_processes are swapped and he lets them go._  
_He has but doesn't possess,_  
_acts but doesn't expect._  
_When his work is done, he deletes it._  
_That is why it lasts forever._
