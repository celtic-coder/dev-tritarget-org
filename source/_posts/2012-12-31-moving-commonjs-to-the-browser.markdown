---
layout: post
title: "Moving CommonJS to the Browser"
date: 2012-12-31 11:35
comments: true
external-url: 
categories: [ "coding", "JavaScript" ]
published: false
---
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

<!-- more -->

http://jsbin.com/ekuyic/2/edit
https://gist.github.com/4421025
