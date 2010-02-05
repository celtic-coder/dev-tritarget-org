---
layout: post
title: 'Jekyll on Dreamhost'
catagories: [ site news ]
tags: [ blogging, dreamhost, ruby, git, jekyll ]
---
Well I took the learning exercise on getting [Jekyll][] working on
[Dreamhost][] mainly because I have a [gitosis][] environment set up for my
personal projects. I had plans to write down the process I used to accomplish
this. However, after it was all completed I found a [blog post][1] that
detailed exactly the process I haphazardly stumbled onto.

It should be noted that the author mentions that this method of deployment is
not ideal. And that a [better solution][2] is available to most users.

I do like the Rakefile and rsync solution as it is quite elegant however for
my site which is under gitosis it isn't usable. Gitosis blocks shell access
via SSH for the Git repo user in order to facilitate authentication. And
because the website is owned by the Git repo user rsync will never reach the
file system to sync. So in my case I have to use Git hooks and compile the
site on the server with Jekyll.

I have decided to allow the use of [LESS][] by using a [fork of Jekyll by
tatey][3] even if I don't intend to use LESS soon at least I have it and this
fork has [Growl][] notifications ([gem][4]).

[Jekyll]: http://jekyllrb.com/
[Dreamhost]: http://dreamhost.com/
[gitosis]: http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way
[LESS]: http://lesscss.org/
[Growl]: http://growl.info/
[1]: http://tatey.com/2009/04/29/jekyll-meets-dreamhost-automated-deployment-for-jekyll-with-git/
[2]: http://tatey.com/2009/10/29/simpler-deployment-for-jekyll-using-a-rakefile-and-rsync/
[3]: http://tatey.com/2009/12/05/forking-jekyll-now-with-less-and-growl-notifications/
[4]: http://gemcutter.org/gems/growl
