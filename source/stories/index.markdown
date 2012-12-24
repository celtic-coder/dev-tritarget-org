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

For more information you can read [A Beginner's Guide to Playing Interactive Fiction][1].

Or for a more *interactive tutorial* check out the [Playfic Tutorial][2].

For the mutimedia folks: a quick informative [history on youtube][3].

- [Underworld][4] - During a guided meditation I did on the eve of Samhain I
  envisioned the following story. Travel to the underworld and meet a few
  mythical people and animals like Hecate, Persephone, and Cerberus. Can you
  give up enough negativity to make it back out?

- [Interactive Resume][5] - This is an interactive resume. Well -- it is my
  unique and quirky way to show the world who I am. It is a text adventure like
  the old mainframe kind (but newer). You may go directly to the information
  with the links provided or play the game for a more fun and -- interactive
  way to find out why in the world I would make such a thing.

[1]: http://www.microheaven.com/ifguide/index.html
[2]: http://playfic.com/games/cooper/tutorial
[3]: http://www.youtube.com/watch?v=9d4Fu90ubmA
[4]: http://if.tritarget.org/Underworld/
[5]: http://if.tritarget.org/InteractiveResume/

## Stories

The following is any creative writing I have posted to this site:

<div id="blog-archives">
{% for post in site.categories['creative writing'] limit: 10 %}
{% include post/variables.html %}
<article>
  {% include archive_post.html %}
</article>
{% endfor %}
</div>

[View all posts]({{ root_url }}blog/categories/creative_writing/)
