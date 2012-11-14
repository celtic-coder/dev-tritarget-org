---
layout: post
title: "How I understand JavaScript Object Oriented Programming"
date: 2012-11-12 10:55
comments: true
categories: [ "coding", "JavaScript" ]
published: true
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

Static methods and attributes are accessible to the object itself not
instances of that object. In other words you access it by the Class name not
using the `new` keyword:

{% codeblock Static methods (static.js) %}
var MyObject = (function() {
  function MyObject() {}

  MyObject.foo = function() { return "Foo"; };

  return MyObject;
})();

MyObject.foo(); // "Foo"
var bar = new MyObject();
bar.foo(); // Error: no such method foo
{% endcodeblock %}

As you see above that the method foo is static. Obviously this is quite verbose for what you could use as an object literal for:

    var MyObject = {
      foo: function() { return "Foo"; }
    };

However, if you want to have dual use (say in a Factory Pattern) it might look like this:

{% codeblock Factory Pattern (factory.js) %}
var MyObject = (function() {
  function MyObject() {}
  
  MyObject.factory = function() {
    if (MyObject.instance) {
      return MyObject.instance;
    } else {
      return MyObject.instance = new MyObject();
    }
  };

  return MyObject;
}).call(this); // Notice the explicit scoping here.

var obj = MyObject.factory();
{% endcodeblock %}

**Don't forget the `call(this)` above.**

## Instance attributes

Instance attributes are referenced with the `this` keyword.

{% codeblock Instance attributes (attributes.js) %}
var MyObject = (function() {
  function MyObject(value) {
    this.value = value;
  }
  return myObject;
})();

var foo = new MyObject("Foo");
var bar = new MyObject("Bar");

foo.value; // "Foo"
bar.value; // "Bar"
{% endcodeblock %}

## Instance methods

This is where `prototype` comes in handy.

{% codeblock Instance methods (methods.js) %}
var MyObject;

MyObject = (function() {
  function MyObject(value) {
    this.value = value;
  }

  MyObject.prototype.getValue = function() {
    return this.value;
  };

  return MyObject;
})();

var foo = new MyObject("Foo");
var bar = new MyObject("Bar");

foo.getValue(); // "Foo"
bar.getValue(); // "Bar"
{% endcodeblock %}

## Private methods and attributes (closures)

First things in JavaScript there are no true private attributes. But you can
make variables that are private using closures. You can also make private
methods the same way.

{% codeblock Pivate methods (closure.js) %}
var MyObject = (function() {

  var private_attribute = null;

  function private_method() {}

  function MyObject() {}
  return MyObject;
})();
{% endcodeblock %}

[CoffeeScript]: http://www.coffeescript.org/
