---
layout: post
title: "How I understand JavaScript Object Oriented Programming"
date: 2012-11-13 20:59
comments: true
categories: [ "coding", "JavaScript" ]
published: false
---
One of the great things about [CoffeeScript][] is that it compiles into
JavaScript. I found that when addressing several problems in JavaScript I would
often attempt to address it using CoffeeScript in an Object Oriented way so
that I could examine the JavaScript output.

The affect of this is that I learned a lot about how JavaScript approaches
Object Oriented Programming. So I though I would share those insights here.

## The Why

I know your first question is "why another blog post about JavaScript Objects?"
Well because I haven't seen many posts that walk through this in an incremented
by example form. I have to address that there is a much more detailed
explanation in [this article][1] and [this article][2]. Oh, and lets not forget
Douglas Crawford's [JavaScript: The Good Parts][3]. I read both of these and
gained a ton of understanding but remembering how to implement the concepts and
the best practise on form and style is still left to be desired.

Giving myself a walk through my understanding with the style that I found
delightful from CoffeeScripts' translations.

[1]: https://developer.mozilla.org/en-US/docs/JavaScript/Introduction_to_Object-Oriented_JavaScript
[2]: http://killdream.github.com/blog/2011/10/understanding-javascript-oop/
[3]: http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742

<!-- more -->

## Objects

Objects are easy and you'll see them everywhere. In JavaScript Objects and
Functions are somewhat interchangeable. We will get a sense of this later. For
now I'll show two ways to define objects:

{% codeblock object literal (object_literal.js) %}
// Object Literal
var object = {
  foo: "Foo",
  'bar': "Bar"
};

// Dynamic Objects
var object2 = {};
object2.foo = "Foo";
object2['bar'] = "Bar";

object.foo;     // "Foo"
object['bar'];  // "Bar"
object2.foo;    // "Foo"
object2['bar']; // "Bar"
{% endcodeblock %}

## Classes

Classes provide a logical representation of objects that you define once then
create instances of that object as you need them. It starts by making a self
calling function which returns the object definition. It includes a constructor
function and any logic needed to create the object.

{% codeblock Basic Class (basic_class.js) %}
var MyObject = (function() {
  function MyObject() {}
  return MyObject;
})();

var instance = new MyObject();
{% endcodeblock %}

## Static methods and attributes

Static methods and attributes are accessible to the object itself not bu
instances of that object.

## Instance attributes

## Instance methods

## Private methods and attributes (closures)

First things in JavaScript there are no private attributes. If you attempt to
make one it will be a static attribute.

On the other hand you can make private methods. And here is how.

[CoffeeScript]: http://www.coffeescript.org/
