---
title: "Musings of a Coder"
date: 2012-04-03
comments: true
tags: coding
---
Lately I've has some insperation to try my hand at some coding homework. I was
introduced to a site called [The Codecademy](http://www.codecademy.com/). This
site teaches people how to program. They started with [JavaScript][] and recently
added [HTML][] and [CSS][].

Here are a two I enjoyed playing with:

<!-- more -->

#### Black Jack
One of the big challenges was to make a BlackJack game. I was a little carried
away and spent the time subitting [this code][gist-1] as my final version.

**Update:** Upgraded to use promises and no more `confirm()`.

{{jsbin "xifupo/2" "output"}}

#### Number Crunching
While I was ridding home on a train I got the inspiration to wonder just how
many computer bits it took to represent a [googol][] (one followed by 100
zeros):

10, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000

Because of the size of this value there is no computer that could do the math
with basic binary arithmetic. Instead you have to rely on the kindergarten method
of long hand addition.

So I wrote a program to do this in JavaScript. Check it out :

{{jsbin "diyoxe/1" "output"}}

Suffice it to say, it take **334** bits to represent a googol.

[HTML]: http://en.wikipedia.org/wiki/Html
[CSS]: http://en.wikipedia.org/wiki/Css
[JavaScript]: http://en.wikipedia.org/wiki/JavaScript
[gist-1]: https://gist.github.com/2294904
[bj-game]: http://jsfiddle.net/sukima/RFHS2/
[googol]: http://en.wikipedia.org/wiki/Googol
[calc]: http://jsfiddle.net/sukima/jdCvt/
