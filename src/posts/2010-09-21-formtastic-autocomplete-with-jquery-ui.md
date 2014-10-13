---
title: "formtastic autocomplete with jQuery UI"
date: 2010-09-21
comments: true
tags: coding
gist: sukima/590498:application_formtastic_builder.rb sukima/590498:model_view.html.erb sukima/590498:routes.rb sukima/590498:main_controller.rb sukima/590498:application.js
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

<!-- more -->

First lets set up the formtastic input (place this in the `lib` directory):

gist:sukima/590498:application_formtastic_builder.rb

Now in the view I can setup the form:

gist:sukima/590498:model_view.html.erb

This will allow jQuery to find the text field. However jQuery needs to ask the
application where to look for the autocomplete data. We will create a route to
a custom action and it will tell jQuery where to look. First the routes file:

gist:sukima/590498:routes.rb

Now the contgroller that includes the mapping and the data (this could be done
through more than one controller):

gist:sukima/590498:main_controller.rb

And finally the javascript to make it all happen:

gist:sukima/590498:application.js

I also include the jQuery js request problem. Take a look at this
[blog post][1] for some good information concerning jQuery AJAX and Rails.

[formtastic]: http://github.com/justinfrench/formtastic
[1]: http://www.justinball.com/2010/08/09/jquery-ajax-requests-are-html-not-js/
