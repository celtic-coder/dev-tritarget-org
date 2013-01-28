---
layout: post
title: "Moving CommonJS to the Browser"
date: 2012-12-31 11:35
comments: true
categories: [ "coding", "JavaScript" ]
---
**THIS POST IS DEPRECATED**

This is an exercise of understanding. To do this properly take a look at
[hem][] or [browserify][]. It takes care of this automatically.

- - -

I started understanding modular JavaScript from the server side using [hem][].
Hem is a bundler for JavaScript. It collects each file and adds them together
into on master file that you can easily load in the browser. It uses the
[CommonJS][] conventions to modularize the code.

I preferred this method because it used one file for many modules. Unlike the
[RequireJS][] way which uses multiple connections to the server to load each
module by itself. Both solutions need wrappings. However, the Stitch way is to
add thenm in one file which allso allow you to prepend libaries that are
**not** modules unlike ReqireJS which need libraries to be wrapped to handle
dependencies.

I realize this doesn't make much sense without examples which I'll get to. The
intent of this post is to offer a compromise solution. This is because I wanted
to load CommonJS modules inside of [jsbin](jsbin.com) and
[jsfiddle](jsfiddle.net) which use that "one script to rule them all"
methodology. And I'll explain a possible solution.

[hem]: http://spinejs.com/docs/hem
[browserify]: http://browserify.org/
[CommonJS]: http://www.commonjs.org/
[RequireJS]: http://requirejs.org/

<!-- more -->

First things first. **Why not use RequireJS for you CommonJS modules?** Well,
the simple answer is that it is personal preference. I like CommonJS modules
like you see implemented in Node.js But I don't like that RequireJS uses some
weird hacks to learn load order and that it still isn't a *one script to rule
them all* methodology.

Next, lets take a look at specifically I want in a **module**. I want a self
contained object that I build and define. Then I want to export it. Once that
is don't I want to make other's dependent on it by using a common programming
idium called _require_.

{% gist 4422441 SimpleModule.js %}

(You can see a functional example in this
[Dice Roller example](https://gist.github.com/4416233).)

When you use [hem][] on the server side it takes all your module files and
wraps them in a bit of nifty code which is the CommonJS framework. To do this
in say a jsfiddle, I pulled out the stitching wrapper code and attached it as a
global object you can manipulate. Now you can include it as a libary and write
your "one script to rule them all" in the fiddle as if it was a bunch of modules.

The following is the library and an example of how it works:

<div class="accordion">
<h3>Stitch.js Library</h3>
<div>
{% gist 4421025 Stitch.js %}
</div>
<h3>Sample script with modules</h3>
<div>
{% gist 4421025 application.js %}
</div>
<h3>Sample index.html</h3>
<div>
<p>Notice that the line that initializes was placed at the bottom to allow dom
objects to exists.</p>
{% gist 4421025 index.html %}
</div>
</div>

And finally an [example in a JSBin](http://jsbin.com/ekuyic/2/edit).

#### So why? No, Seriously why? ####

Oh that's simple it's because I wanted to have modules inside a "one script to
rule them all" methodology... Ahh actually, It is because I wanted an
experiment to learn about CommonJS and how Stitch works.
