---
layout: post
title: "Some JavaScript Insights"
date: 2012-11-12 15:08
comments: true
categories: [ "coding", "JavaScript" ]
---
I did a few [jsFiddle's][jsFiddle] and realized there were some things about JavaScript that I did not know.

Following is three examples I found useful to me when working with JavaScript.

## Objects passed by reference

For example the `prototype` object will hold sub-objects by by reference. Take a look at [this example][1]:

{% jsfiddle tvEjJ js,result %}

The `StaticTest` will assign `test_obj` to the object's `prototype`. However,
when you have two instances of the `StaticTest` changing the `test_obj` data in
one instance will also change it in the other instance. However if you use
`this` to make a local `test_obj` then you will have indepenant versions
between the two instances as you can see with the `LocalTest` object.

It is a little bit difficult to explain except by example. So study the example above.

<!-- more -->

## Padding

This [jsFiddle][2] shows three examples to add padding to a string.

{% jsfiddle 4LtLZ js,result %}

## Walking the DOM tree

In the case of manipulating the text inside a single DOM element things are
simple. But when that same content includes other DOM nodes thigs get tricky.
Infact jQuery won't help you much here.

In [this jsfiddle][3] you can see an example how to walk the tree converting
the text of all the nodes.

{% jsfiddle 9wF7N js,html,result %}

[jsFiddle]: http://jsfiddle.net/
[1]: http://jsfiddle.net/sukima/tvEjJ/
[2]: http://jsfiddle.net/sukima/4LtLZ/
[3]: http://jsfiddle.net/sukima/9wF7N/
