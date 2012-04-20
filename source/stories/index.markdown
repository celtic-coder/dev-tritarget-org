---
layout: page
title: "Creative Writing"
date: 2012-03-30 09:38
comments: false
sharing: false
footer: false
---
Here is my collection of creative writing.

## Interactive Fiction

Interactive Fiction (or IF for short) is both a computer game and a book, or
rather something in between. You usually take on the role of the main character
in a story. The game tells you what happens to the character, and you tell the
game how the character should act. This is not always simple, but can make for
a very rewarding experience.

For more information you can read [A Beginner's Guide to Playing Interactive
Fiction][1].

- [Underworld][2] - During a guided meditation I did on the eve of Samhain I
  envisioned the following story. Travel to the underworld and meet a few
  mythical people and animals like Hecate, Persephone, and Cerberus. Can you
  give up enough negativity to make it back out?

[1]: http://www.microheaven.com/ifguide/index.html
[2]: {{ root_url }}/stories/if/Underworld

## Stories

The following is any creative writing I have posted to this site:

{% for story in site.categories['creative writing'] %}
* [{{ story['title'] }}]({{ story['url'] }}) on {{ story['date_formatted'] }}
{% endfor %}
