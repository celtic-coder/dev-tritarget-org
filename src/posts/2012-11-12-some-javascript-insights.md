---
title: "Some JavaScript Insights"
date: 2012-11-12
comments: true
tags: coding, javascript
---
I did a few [JSBin's][jsbin] and realized there were some things about
JavaScript that I did not know.

Following is three examples I found useful to me when working with JavaScript.

## Objects passed by reference

For example the `prototype` object will hold sub-objects by by reference. Take
a look at [this example][1]:

{{jsbin "gineba/1" "js,output"}}

The `StaticTest` will assign `test_obj` to the object's `prototype`. However,
when you have two instances of the `StaticTest` changing the `test_obj` data in
one instance will also change it in the other instance. However if you use
`this` to make a local `test_obj` then you will have indepenant versions
between the two instances as you can see with the `LocalTest` object.

It is a little bit difficult to explain except by example. So study the example
above.

<!-- more -->

## Padding

This [JSBin][2] shows three examples to add padding to a string.

{{jsbin "taside/1" "js,output"}}

## Walking the DOM tree

In the case of manipulating the text inside a single DOM element things are
simple. But when that same content includes other DOM nodes thigs get tricky.
Infact jQuery won't help you much here.

In [this JSBin][3] you can see an example how to walk the tree converting
the text of all the nodes.

{{jsbin "tomati/1" "js,output"}}

[jsbin]: http://jsbin.com/
[1]: http://jsbin.com/gineba/1/edit
[2]: http://jsbin.com/taside/1/edit
[3]: http://jsbin.com/tomati/1/edit
