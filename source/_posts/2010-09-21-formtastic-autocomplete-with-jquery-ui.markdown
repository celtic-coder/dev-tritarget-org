--- 
layout: post
title: "formtastic autocomplete with jQuery UI"
date: 2010-09-21 00:00
comments: true
categories:
---
I did a little hacking in Ruby on Rails using [formtastic][] to make an
autocomplete text box. The trouble as of this writing formtastic does not have
an autocomplete input. RoR uses some RJS magic to accomplish autocomplete but I
never like RJS styled AJAX. I prefer unobtrusive JS especially with jQuery.

What I did was create a custom input for formtastic that did nothing but adds a
HTML class name to the input field. Then I had the jQuery turn these to
autocomplete. However to get the values of the autocomplete I also created a
seperate action that returns a **map** to the correct path to the AJAX action.
I don't like how complicated that sounds. Maybe some code snippits?

First lets set up the formtastic input (place this in the `lib` directory):

<script src="http://gist.github.com/590498.js?file=application_formtastic_builder.rb"> </script>

Now in the view I can setup the form:

<script src="http://gist.github.com/590498.js?file=model_view.html.erb"> </script>

This will allow jQuery to find the text field. However jQuery needs to ask the
application where to look for the autocomplete data. We will create a route to
a custom action and it will tell jQuery where to look. First the routes file:

<script src="http://gist.github.com/590498.js?file=routes.rb"> </script>

Now the contgroller that includes the mapping and the data (this could be done
through more than one controller):

<script src="http://gist.github.com/590498.js?file=main_controller.rb"> </script>

And finally the javascript to make it all happen:

<script src="http://gist.github.com/590498.js?file=application.js"> </script>

I also include the jQuery js request problem. Take a look at this
[blog post][1] for some good information concerning jQuery AJAX and Rails.

[formtastic]: http://github.com/justinfrench/formtastic
[1]: http://www.justinball.com/2010/08/09/jquery-ajax-requests-are-html-not-js/
