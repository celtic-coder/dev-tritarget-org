---
title: "Fun trick with underscore templates (check this out)"
date: 2013-07-05
comments: true
tags: coding, javascript
---
Doing some work in [Titanium][] and I found some code I needed to translate
*and* DRY up. In the process I descoved a really cool trick with
[Underscore][]'s template engine.

When translating strings in Titanium you use the format:

```javascript
Titanium.Local.getString("message_id", "Default text")
```

or `L("message_id", "Default text")` for short. There was an example when this
format served a hindrance:

```javascript
var textField1 = Ti.UI.createTextField({
  hintText: "e.g. 123 Washington Rd. (required)"
});
var textField1 = Ti.UI.createTextField({
  hintText: "e.g. example@example.com (required)"
});
var textField1 = Ti.UI.createTextField({
  hintText: "e.g. (123) 555-5555 (optional)"
});
```

The above asked to localize three strings that were not easily
internationalize-able (e.g. ?) and all of them looked fairly close in concept.
Using string interpolation would be a mess and would still require many message
ids.

```javascript
var textField1 = Ti.UI.createTextField({
  hintText: String.format(
    "%s %s (%s)",
    L("example_text", "e.g."),
    L("example_address", "123 Washington Rd."),
    L("required", "required")
  )
});
```

I'll be honest, `"%s %s (%s)"` looks confusing as hell.

I'm going to show you how I handled this using Underscore's template engine.
I'll explain the process progressively so you can see how I ened up with the
cool trick I did. And why I mentioned you should _check **this** out_.

[Titanium]: http://www.appcelerator.com/platform/titanium-platform/
[Underscore]: http://underscorejs.org/

<!-- more -->

At first I thought lets break this up and use string concatenation. Although
this was the simpilest solution it looks ugly.

```javascript
function Sample() {
  this.output = L("foo", "Foo") +
    " " + L("bar", "Bar") +
    " (" + L("foobar", "Foobar") + ")";
}
Sample.prototype.render = function() { return this.output; };

var sample = new Sample();
console.log( sample.render() );
```

_Live demo on [JS Bin](http://jsbin.com/ovizip/2/edit?javascript,console)_

So I opted instead for Underscore's template. This looks much cleaner with one
small problem. The `L("foo", "Foo")` and `L("foobar", "Foobar")` repeat That
seems silly to attempt to pull the same values out every time.

```javascript
_.extend( _.templateSettings, { variable: "data" } );

function Sample() {}
Sample.prototype.render = _.template(
  "<%= data.foo %> <%= data.bar %> (<%= data.foobar %>)"
);

var sample = new Sample();

console.log( sample.render({
  foo:    L("foo", "Foo"),
  bar:    L("bar", "Bar"),
  foobar: L("foobar", "Foobar")
}) );
console.log( sample.render({
  foo:    L("foo", "Foo"),
  bar:    L("bar1", "Bar one"),
  foobar: L("foobar", "Foobar")
}) );
console.log( sample.render({
  foo:    L("foo", "Foo"),
  bar:    L("bar2", "Bar two"),
  foobar: L("foobar", "Foobar")
}) );
```

_Live demo on [JS Bin](http://jsbin.com/ovizip/3/edit?javascript,console)_

If you haven't guessed I setup the templating as an object. So I'm going to add
the pseudo-static content on instantiation and only worry about the dynamic
part. I use the `this` keyword to differentiate content that is passed into
the `render()` function and content that was created prior (pseudo-static).

```javascript
_.extend( _.templateSettings, { variable: "data" } );

function Sample() {
  this.foo    = L("foo", "Foo");
  this.foobar = L("foobar", "Foobar");
}
Sample.prototype.render = _.template(
  "<%= this.foo %> <%= data.bar %> (<%= this.foobar %>)"
);

var sample = new Sample();

console.log( sample.render({
  bar: L("bar", "Bar")
}) );
console.log( sample.render({
  bar: L("bar1", "Bar one")
}) );
console.log( sample.render({
  bar: L("bar2", "Bar two")
}) );
```

_Live demo on [JS Bin](http://jsbin.com/ovizip/4/edit?javascript,console)_

Ultimately this allowed me to easily expand on the template and develop a
concise method of extracting the rendered string with internationalization
support

```javascript
_.extend( _.templateSettings, { variable: "data" } );

var hintTextTemplate = {
  example_text:  L("for_example", "e.g."),
  required_text: L("required", "required"),
  optional_text: L("optional", "optional"),
  render: _.template(
    "<%= this.example_text %> <%= data.content %> " +
    "(<%= data.required ? this.required_text : this.optional_text %>)"
  )
};

var textField1 = Ti.UI.createTextField({
  hintText: hintTextTemplate.render({
    content: L("example_address", "123 Washington Rd."),
    required: true
  })
});
var textField1 = Ti.UI.createTextField({
  hintText: hintTextTemplate.render({
    content: L("example_email", "example@example.com"),
    required: true
  })
});
var textField1 = Ti.UI.createTextField({
  hintText: hintTextTemplate.render({
    content: L("example_phone", "(123) 555-5555"),
    required: false
  })
});
```

What do you think? Did I over think this? Or is it more scalable? Let me know,
leave a comment.
