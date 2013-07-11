---
layout: post
title: "My own template engine in Titanium"
date: 2013-07-10 14:22
comments: true
external-url:
categories: [ "coding", "javascript", "underscore", "titanium" ]
---
I ran into an interesting problem while trying to internationalize a
[Titanium][] application. The recommended way to do so is to use `String.format`
to interpolate the localized string you grabbed from the `L()` method. Here is
an example:

{% highlight js %}
String.format( L("message_id", "Default %s text"), "foobar" );
// => "Default foobar text"
{% endhighlight %}

{% pullquote %}
This was all well and good till some problems presented themselves. {" If I
passed in a null reference the application would crash! "} And if I passed
in a non string I would get "null" instead regardless of value. The
`String.format` used the _printf_ specifications which means the string had to
be aware of both order and type of the values. Either translators needed to
understand variable typing (`"%s strings and %d numbers"`) or I had to convert
all values to strings (`String.format("%s", "" + number_value)`). Out of order
translations were very cryptic (`"out %2$s of order %1$s strings"`) and the
translator looses context of what they want to translate.
{% endpullquote %}

With all these problems I ventured on a quest to find a better alternative. And
I found one. A very simple solution that you can implement today! Follow me on
the journey while I recount my quest and how I found the best solution I know
of.

[Titanium]: http://www.appcelerator.com/platform/titanium-platform/

<!-- more -->

Since [Underscore][] was already in my project my first thought was to drop the
use of `String.format` in favor of Underscore's `_.template()` function. The
problem with this idea was:

1. By default underscore uses the `with` statement. Which is _bad_
2. It is annoying to force a variable prefix to translators
   (`"<%= prefix.variable %>"`) to fix the first problem.
3. It allows code injection and can expose internal logic to translators who
   have no need for that.
4. In line templates are slow and since they are being interpreted on a per
   translation basis building a cache of compiled template functions would have
   been a nightmare to maintain.

[Underscore]: http://underscorejs.com

The obvious next step was to look into some thing like [mustache][]. This had
the advantage of naming variables, preventing code injection / exposure, and it
was mostly familiar to translators (Twitter did it).

[mustache]: http://mustache.github.io/

The disadvantage was _yet another library_ to add to the project and we really
didn't need the power of mustache only the string interpolation part.

So then I started wondering how a simple regexp would hold up to this.

With all these options I had to build a comparison table:

|          | built in | named variables | prevents code injection | ordering | familiar | not confusing | complexity | Performance |
|:---------|:--------:|:---------------:|:-----------------------:|:--------:|:--------:|:-------------:|:----------:|:-----------:|
| String.format | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:green">Low</span> | <span style="color:green">Fast</span> |
| Underscore template | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:red">✘</span> | <span style="color:green">Low</span> | <span style="color:red">Slow</span> |
| Underscore template Compiled | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:red">✘</span> | <span style="color:red">High</span> | <span style="color:green">Super Fast</span> |
| Mustache | <span style="color:red">✘</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:red">High</span> | <span style="color:red">Slow</span> |
| Underscore with mustache style | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">Low</span> | <span style="color:red">Slow</span> |
| Underscore with mustache style compiled | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:red">✘</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:red">High</span> | <span style="color:green">Super Fast</span> |
| Custom regexp | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">✔</span> | <span style="color:green">Low</span> | <span style="color:green">Fast</span> |

(more to the right ➔ )

I found that a custom regexp function is the best (for me!). All I did was add
this short and to the point function to my `app.js`. And here it is:

{% gist 5971122 simple_template.js %}

Now I can replace where I would use `String.format` with `String.template` It
will look for variables on the passed objects' properties.

Oh and speaking of performance I wrote a [jsPerf][] for this very concept.
Notice the huge difference between a compiled Underscore template and in-line
ones? It goes to show you that if you have the opportunity and you plan to
repeat the same template use Underscore's compiled pattern. To clarify, the
problem describe above did _not_ fit the compiled template pattern.

[jsPerf]: http://jsperf.com/underscore-vs-custom-mustache-templates

Here are some examples on how I used this beauty:

{% codeblock examples.js %}
{% raw %}
// => "Amy has 5 apples."
String.template(
  "{{ name }} has {{ number }} apples.",
  {name: "Amy", number: 5}
);

// => "The Doctor has apples."
var data = {name: "The Doctor", number: 5}
String.template("{{ name }} has {{ apples }} apples.", data);

// en => "River has 6 apples."
String.template(
  L("name_has_x_apples", "{{ name }} has {{ number }} apples."),
  {name: "River", number: 6}
);

// i18n/yoda/strings.xml:
// <string name="name_has_x_apples">{{ number }} apples {{ name }} has.</string>
// yoda => "7 apples Obiwan has."
String.template(
  L("name_has_x_apples", "{{ name }} has {{ number }} apples."),
  {name: "Obiwan", number: 7}
);
// yoda language is not really available.
{% endraw %}
{% endcodeblock %}
