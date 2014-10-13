---
title: "My First jQuery Plugin"
date: 2012-11-03
comments: true
tags: coding, javascript
gist: sukima/4008388:collapsible.coffee sukima/4008419:collapsible.js
---
I often feel like creating a portfolio for coding seemed a daunting task
because I am not good with design. I can design systems and programs but I
don't have the artistic flare to envision the look of an application. Most
programs I steal design from others and plug them into the final look. Like
iPhone apps already have a look and feel that you can use. [jQuery-mobile][]
already offers a design to work with. Even this blog is a design from
[OctoPress][]. But that isn't to say I can not be creative. I flourish in the
work under the hood. And it is my hope that the examples I put on this blog
with show that in the code examples and design ideas I layout.

[This post][1] mentioned publishing your jQuery plugins and so here is my first
jQuery plugin. It is a simple collapsible div plugin. It mimics what the
jQuery-ui [Accordion][2] plugin does but for single divs. Now most simply use
the [slideToggle][3] feature as it is simple. But for my case I wanted to
modify the DOM and add more markup.

[jQuery-mobile]: http://jquerymobile.com/
[OctoPress]: http://octopress.org/
[1]: http://workplace.stackexchange.com/questions/1962/im-a-web-developer-with-no-design-skills-should-i-still-have-a-portfolio
[2]: http://docs.jquery.com/UI/API/1.8/Accordion
[3]: http://api.jquery.com/slideToggle/

<!-- more -->

I like [CoffeeScript](coffeescript.org) so I wrote this is CoffeeScript but
I'll also include the compiled JavaScript for those who like JavaScript.

This was spawned from my [99 Bottles on The Wall][4] project. So to see it in action check out the [demo][4].

gist:sukima/4008388:collapsible.coffee

And for the compiled JavaScript:

gist:sukima/4008419:collapsible.js

[collapsible.coffee]: https://gist.github.com/4008388
[collapsible.docs]: http://sukima.github.com/99-bottles-cs/docs/collapsible.html
[collapsible.js]: https://gist.github.com/4008419
[4]: http://sukima.github.com/99-bottles-cs/
