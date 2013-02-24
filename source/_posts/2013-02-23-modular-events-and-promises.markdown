---
layout: post
title: "Modular Events and Promises"
date: 2013-02-23 23:10
comments: true
external-url: 
categories: [ "coding", "javascript", "jquery" ]
---
My last post about making a quick and dirty [URL shortener][1] turned out to be
an amazing learning experience in more then just the code. (See [this post][2]
to read about the project). I learned how to handle events on objects, Promises
(handling sane asynchronous code) and the value of TDD based development. I'd
like to talk about each and I'll start in reverse order. But because this is a
lot to go over Ill split it between three posts. (Also because I find the
[TL;DR][3] concept (in a blog) a little confusing).

[1]: {{ site.url }}/s/#shorturl
[2]: {{ site.url }}/blog/2013/01/10/building-a-static-javascript-based-url-shortener/
[3]: http://en.wikipedia.org/wiki/Wikipedia:Too_long;_didn't_read

## TDD ##

TDD stands for Test Driven Development. What this means is that you focus a good
portion of your development on the test the computer would run to verify your
actual code is working. Phew that was defiantly TL;DR. Ok basically you define
the proper way a piece of code _should_ work using a specifically styled API.

The reason this became so important is that it provided me a much better idea
behind what I actually wanted to accomplish. It showed ways that my code could
work, ways it should not work, and helped hunt down many issues.
