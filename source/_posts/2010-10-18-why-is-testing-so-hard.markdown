--- 
layout: post
title: "Why is testing so hard"
date: 2010-10-18 00:00
comments: true
catagories: [ 'ruby on rails', 'testing', 'shoulda', 'authlogic' ]
---
I am having a very difficult time trying to develop functional tests for my
recent RoR application. Some back history is that my RoR project uses
[shoulda][] and [authlogic][] and I want to test that some actions require a
user to be logged in. I ran into a quandary when I realized that shoulda has
deprecated macros in favor of matchers.

So. For an example If I wanted to check that a specific action would fail if
there was no use logged in I would have done this in the past:

<script src="http://gist.github.com/632707.js?file=require_logged_in_macro.rb"> </script>

However this is limited in it's use and **does not** conform to the direction
that shoulda has moved to (matchers) A better way to accomplish this is to
write a matcher like so:

<script src="http://gist.github.com/632707.js?file=require_logged_in.rb"> </script>

This affords you the flexibility as such:

    should require_logged_in
    should require_logged_in(:post)
    should require_logged_in.for(:show)
    should require_logged_in(:post).for(:create)

A little better syntax in my opinion. There are two big problems using
matchers. First they are **not** included by default like macros were using
the `shoulda_macros` directory. They require some code in the
`test_helper.rb`:

    include Shoulda::RequireLoggedIn::Matchers
    extend Shoulda::RequireLoggedIn::Matchers

Finally you can not have access to any method that _TestCase_ would have
had normally for example `get` and `post`. So this last part renders that above
match code **useless**.

Call to all shoulda developers. Please can someone tell be what you should do?
Matchers or Macros?!

Thank you.

[shoulda]: http://github.com/thoughtbot/shoulda
[authlogic]: http://github.com/binarylogic/authlogic
