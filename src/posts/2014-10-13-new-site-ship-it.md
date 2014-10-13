---
title: "New Site; Ship-It!"
date: 2014-10-13
tags: coding, news
---
This new site uses a [lot of technologies](/about) behind the scenes. A side
effect of this is that the build from zero to upload to web server takes a
little bit of time. About 10 seconds on my Mac Pro and about 4 minutes on my
Pentium Ubuntu (tablet) server.

I wanted to be able to advance the code without the need to
clean/update/build/rsync all the time. Especially if I need to space out when I
deploy and when I update. I really liked the idea of de-coupling the act of
development and the act of deploying.

What I came up with was a deployment system that uses a chat bot ([Hubot][]) to
trigger my off site deployment scripts. This allowed me to deploy from any
where, be notified when complete, choose which branch to deploy from (feature
tests and easy reverts), and not tie up my laptop waiting for files to upload.

<!-- more -->

On possible option was to use github web hooks to trigger deployments. My
current employment does deploys this way. I however prefer to separate this. One
of the reasons is that by coupling your deploy with your git repo it blesses the
repo. In other words extra care must be made to prevent contaminating the
branch and you can't switch branches easily;. Every merge is a anxiety
triggering event. Will github break? Was the merge correct? etc. etc. I know
this is silly but for me I like the [github way][1].

Our household chat client has a [Hubot][] running (named [River Song][2]) who
politely monitors our [slack][] chat. When I tell her to deploy she opens an SSH
session to my Ubuntu server sitting in my basement. It kicks of a deploy script
which pull the latest from Github, installs any dependencies, builds the static
site and rsync's it to my web server. Then it kicks off an HTTP request to River
who promptly tells the chat the task is complete.

![Diagram of deployment](/images/posts/river-deploy.png)

The cool part of this is that each step of the system is in it's own
environment. River is on heroku, the deploy is on my server at home, the web
files are hosted on Dreamhost, and the source is stored on Github.

I manage the SSH using public keys and setup the hubot to recieve a file as a
key to be stored in it's redis *brain*. That way I don't have to store the key
in a repo and I don't have to spam the chat channel (which archives all). Also
using an ssh key means I can revoke access at anytime.

You probubly want some links at this point...

* [Daemon script][3] to build and deploy the site (runs on my Ubuntu server).
* [Hubot script][4] to manage the interaction.

[1]: https://github.com/blog/1241-deploying-at-github
[2]: http://en.wikipedia.org/wiki/River_Song_(Doctor_Who)
[3]: https://github.com/sukima/dev-tritarget-org/blob/master/deploy.sh
[4]: https://github.com/sukima/river-song/blob/master/scripts/tritarget.coffee
[Hubot]: https://hubot.github.com/
[slack]: https://slack.com/
