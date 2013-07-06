---
layout: post
title: "Rolling your own event dispatcher for Titanium"
date: 2013-06-20 11:57
comments: true
external-url:
categories: [ "codeing", "javascript", "titanium", "underscore" ]
---
I have been working on a lot of [Titanium][] work and on the way I've learned a
lot of little tricks. One of which is that you can not use Titanium objects like
they were everyday JavaScript objects. Titanium uses a global event model which
will leak memory if your not careful to remove your event listeners. And it will
also double up on events if your not careful. Personally I like the event model
but when my object goes for garbage collection I don't want to worry _did I
remove any left over events?_.

I want to discuss my solution to this by showing a neat trick to roll your own
event dispatcher that is object oriented and scoped to your own object. Oh and
it is pretty simple.

[Titanium]: http://www.appcelerator.com/platform/titanium-platform/

<!-- more -->

I had noticed others had the same trouble and would develop their own even
handling code for each object. The code varied in complexity but needless to say
it was a hack on an object. And had to use some odd prototyping to make it DRY:

{% codeblock Poor man's event model (event.js) %}
function Foo() {
  this.events = {};
}
Foo.prototype.addEventListener = function(event, fn) {
  if (this.events[event] == null) { this.events[event] = []; }
  this.events[event].push(fn);
}
Foo.prototype.removeEventListener = function(event, fn) {
  // Search through the array? Ugg...
}
Foo.prototype.fireEvent = function(event, data) {
  var i, len, events = this.events[event];
  if (events == null) { return; }
  for (i = 0, len = events.length; i < len; i++) {
    events[i](data);
  }
}
{% endcodeblock %}

I could have gone the route of the [Super Simple Event Dispatcher][1] but that
would not match the established practice of Titanium's event model
(`addEventListener`, `fireEvent`, `removeEventListener`). So I made the
[Damn Simple Event Dispatcher][2] instead. (This uses [Underscore][]).

[1]: https://gist.github.com/sukima/4683467
[2]: https://gist.github.com/sukima/5623141
[Underscore]: http://underscorejs.org/

{% codeblock damn simple event dispatcher snippit (Utils.js) %}
exports.EventEmitter = (function() {
  function EventEmitter() {
    this.event_handlers = {};
  }
  var fn = EventEmitter.prototype;
  fn.addEventListener = function(name, func) {
    this.event_handlers[name] = _.chain(this.event_handlers[name])
      .union(func).filter(_.isFunction).value();
    return this;
  };
  fn.removeEventListener = function(name, func) {
    if (!_.isEmpty(this.event_handlers[name])) {
      this.event_handlers[name] = _.without(this.event_handlers[name], func);
    }
    return this;
  };
  fn.fireEvent = function(name, data, context) {
    if (context == null) { context = this; }
    _.each(this.event_handlers[name], function(func) { func.call(context, data); });
  };
  return EventEmitter;
})();
{% endcodeblock %}

_See the [gist][2] to view the documentation and test specs._

Now with that in place all you need is to _make your object_ inherit from the
`EventEmitter`. To do this easily in JS and in Titanium without the overhead of
rolling your own extend feature is to manipulate the prototype:

{% codeblock simple object inheritance (MyObject.js) %}
var Utils = require("lib/Utils");

function MyObject() {
  Utils.EventEmitter.call(this);
}

MyObject.prototype = new Utils.EventEmitter();

MyObject.prototype.test = function() {
  this.fireEvent("test", "It Works!");
};

module.exports = MyObject;
{% endcodeblock %}

The reason this is so much easier is that you do not have to worry about
removing the event. As you objects are garbage collected so are the references
to the event callbacks.

{% codeblock example usage of MyObject (example.js) %}
var MyObject = require("includes/MyObject");

var example = new MyObject();

example.addEventListener("test", function(message) {
  Ti.API.info(message);
});

example.test();
{% endcodeblock %}

_See a live demo at [JS Bin](http://jsbin.com/opehif/1/edit)._

Did you know that in JavaScript you can inherit from a parent object by calling
it as a function with the scope of `this` in the child constructor then assign
the prototype to a new instance of the parent?

CoffeeScript may make this easy with `class Foo extends Bar` or in jQuery
`$.extend(obj1, obj2)` or Underscore's `_.extend(obj1, obj2)`. But in one-off
vanilla JavaScript you can use this model:

{% codeblock example usage of MyObject (example.js) %}
function Foo() { }
Foo.prototype.foo = function() { };

function Bar() {
  Foo.call(this);
}
Bar.prototype = new Foo();
Bar.prototype.bar = function() { };

var foo = new Foo();
var bar = new Bar();
foo.foo(); // OK
foo.bar(); // NOT OK
bar.foo(); // OK
bar.bar(); // OK
{% endcodeblock %}

What are your thoughts?
