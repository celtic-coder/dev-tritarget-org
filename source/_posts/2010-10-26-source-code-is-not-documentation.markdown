--- 
layout: post
title: "Source code is NOT documentation"
date: 2010-10-26 00:00
comments: true
categories: [ ruby, shoulda, development, workflow, gripe ]
---
I just have to get this out there **Source Code is NOT documentation**

Far to many times I see the response to documentation to be "Look at the source
code" Or if you can't figure it out by looking at the source code you shouldn't
be coding. This kind of thinking is viral in the open source community.

<!-- more -->

I going to give an example of a project I was working on. It halted for 3
weeks because all I had was the source code to use for documentation. I was
making a Ruby on Rails app and was attempting to make a [shoulda][1] add-on
that would complement the testing well.

The only examples were to look at the source code for shoulda so I went to
there [github page][1] and started reading all the source code. It became
clear that they were moving from one paradigm to another. (For those familiar
shoulda uses matchers not macros now) Well all the blog posts google could
find all talked about macros not matchers. I posted to [stackoverflow][2]
about this and got no response. I chated in IRC several timew and still no
leads on how to crate a custom matcher other then looking at the source code
as an example.

Well I did that I wrote a matcher based on the source code opnly to find out
that the matchers couldn't use common functions that a TestCase object could.
Sigh Back to macros. But wait theres more.

I eventually decided to figure out why adding a matcher was so convoluted
([gist with code][3]) and after several attempts and even breaking down to use
rdebug I found out that the source code that my app was using was a whole
major [revision lower][4]! Yes the `gem instal shoulda` doesn't equal the latest
revision. Then after code review of the correct revision it turns out that the
code does not support custom matchers.

The point of all this is that when it comes to using source code as your
documentation you miss a lot of the details and implementation examples
because the source code is _context sensitive_ when custom macros, matchers,
etc. are based in a completely different context. This means that things will
get confusing very quickly and has a higher chance of becoming mismatched.

Please lets do more then just RTFC and offer beter contextual documentation.
Laziness kills a project faster then anything I know. I should talk!!

[1]: http://github.com/thoughtbot/shoulda
[2]: http://stackoverflow.com/questions/3915065/adding-custom-shoulda-matchers-to-testcase
[3]: http://gist.github.com/613522
[4]: http://github.com/thoughtbot/shoulda/tree/v2.10.1
