---
layout: post
title: "The Pyramid of Doom: A javaScript Style Trap"
date: 2012-11-28 11:03
comments: true
categories: [ "coding", "JavaScript" ]
---
*The term "Pyramid of Doom" was coined (as far as I know) from the
[JavaScript Jabber podcast][1] episode 1: Asynchronous Programming.*

[1]: http://javascriptjabber.com/001-jsj-asynchronous-programming/

In JavaScript that uses AJAX and other asynchronous methods they all take a
function as a callback argument. A common yet ugly style to code this is using
anonymous functions:

```javascript
setTimeout( function() {
  alert("Hello World!");
}, 1000); 
```

Although these are quick and easy they can really get over complicated producing
a ever increasing indent to the code. This has the effect of making a pyramid
like shape out of the whitespace when you turn it on it side:

<!-- more -->

{% codeblock The Pyramid of Doom (pyramid.js) %}
// Code uses jQuery to illustrate the Pyramid of Doom
(function($) {
  $(function(){
    $("button").click(function(e) {
      $.get("/test.json", function(data, textStatus, jqXHR) {
        $(".list").each(function() {
          $(this).click(function(e) {
            setTimeout(function() {
              alert("Hello World!");
            }, 1000);
          });
        });
      });
    });
  });
})(jQuery);
{% endcodeblock %}

This leads to a difficulty in readability. It also confuses what is in scope and
out of scope. A refactoring might included named functions that makes it easier
to see what is happening and understand scoping.

{% codeblock Refactored Version to avoid the Pyramid (refactor.js) %}
// Code uses jQuery
(function($) {

  function init() {
    // Add onClick to buttons
    $("button").click(getData);
  }

  function getData() {
    $.get("/test.json", onSuccess);
  }

  function onSuccess(data, textStatus, jqXHR) {
    $(".list").each(addListOnClick);
  }

  function addListOnClick(e) {
    $(this).click(helloWorldTimeout);
  }

  function helloWorldTimeout() {
    setTimeout(helloWorldAlert, 1000);
  }

  function helloWorldAlert() {
    alert("Hello World!");
  }

  $(init);

})(jQuery);
{% endcodeblock %}
