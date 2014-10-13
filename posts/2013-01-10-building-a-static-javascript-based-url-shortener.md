---
title: "Building a (static) JavaScript based URL Shortener"
date: 2013-01-10
comments: true
tags: coding, javascript
gist: sukima/4504087:ShortUrl.coffee
---
They say tools are built out of necessity. The trouble is _who's_ necessity?
In my case I wanted to have a URL Shortener service on my domain. The
problem with that is my website is a static site based off of [Octopress][]
(based on [Jekyll][]). The problem was how do I create a URL Shortener but have
it work with just HTML and JavaScript?

This article steps through the trials and solution I developed for just such a
problem. To see the finished code visit [this gist][1]. It was written in
[CoffeeScript][] so if you want the JavaScript version you'll have to deal with
the (sometimes misunderstood) [generated code][2].

[1]: https://gist.github.com/4504087#file-shorturl-coffee
[2]: https://gist.github.com/4504087#file-shorturl-js
[CoffeeScript]: http://coffeescript.org/
[Octopress]: http://octopress.org/
[Jekyll]: http://jekyllrb.com/

<!-- more -->

At first I thought hey a simple JavaScript object with the short id linked to
the actual url was easy. I'd lookup the id then change the location:

```javascript
var data = {
  "1": "http://example.com",
  "2": "http://example.com/2"
};

window.location.href = data[window.location.hash];
```

Then we check if `window.location.hash` is defined or if the id does not exist
in the data. If so, print a list of all the urls to help users find the right
one.

Two issues:
1. We can not provide any feedback to the user while the new page loads because
   window.location.href is blocking.
2. The data file is JavaScript and harder to maintain. It would be better to
   use JSON. The issue is that you have to parse it.

So my solution is to off shore the data to a JSON file, Then use jQuery's
`getJSON()` method to load the data.

Then I use `setTimeout` to queue tasks for later allowing things like DOM
manipulations to work.

I originally thought it was a good idea to avoid jQuery's `$(document).ready()`
because it would save more async loading that the rest of the templated page
would do by executing the JavaScript immediately. But with the responsive
design I had to bail out of my methods so text could update and the `getJSON()`
could finish loading. I ended up using a flag system with a bit of setTimeout
queuing if needed to get the job done.

I admit this might be a bit excessive but I like the logic behind it and it
works. By not relying on jQuery's ready event handling I learned a lot about
running managing async logic with setTimeout.

The extent of this module is that you can have an HTML page that lists the
contents of your JSON file and if the hash tag is given it will redirect using
JavaScript. Now I can custom add sites to the JSON file and use the shortened
URL in things like resumes or QR-Codes where I don't want to give someone a
bit.ly link.

gist:sukima/4504087:ShortUrl.coffee
