--- 
layout: post
title: Remote irssi notifications via ssh
---
I started using [irssi][1] for chatting in IRC recently. One of the
interesting ideas is that I can SSH into a shell use [GNU screen][2] and run
my irssi client without having to [logout when I move computers][3] Great
solution except on problem.

When someone PM you or mentions you in a channel I like to get a
notification. On my Mac I used to run irssi locally which meant I could use
plugin to send the notification to growl via [growlnotify][4]. However you
can't run this remotely when your using irssi inside an SSH session. Using a
remote SSH session also removed the ability for an irssi plugin to open a link
in your local browser.

Luckily I stumbled across this [great idea][5] that uses a second SSH session
to `tail -f` a file that is appended to by the irssi plugin. It essentially
sends the notification back through by the second SSH session monitoring the
file.

I made a slight adjustment to allow URL posting and integrated growlnotify.

Download the [fnotify][6] script on the SSH server and install it into irssi
like you would any other plugin. Then on your client (in this case I'm using
Max OS X with growl installed) and create this script:

<script src="http://gist.github.com/478301.js">  </script>

Then I also add the [urlplot][7] ([download][8]) script to irssi and set it's
command to post the url to the fnotify log:

    /set url_command "echo \"RequestURLBrowse __URL__\" >> ~/.irssi/fnotify"

This script will post the growl notification for any highlights I get in irssi
and if it's a url it will open it in my browser.

[1]: http://irssi.org/
[2]: http://en.wikipedia.org/wiki/GNU%20Screen
[3]: http://quadpoint.org/articles/irssi
[4]: http://growl.info/documentation/growlnotify.php
[5]: http://thorstenl.blogspot.com/2007/01/thls-irssi-notification-script.html
[6]: http://www.leemhuis.info/files/fnotify/fnotify
[7]: http://scripts.irssi.org/html/urlplot.pl.html
[8]: http://scripts.irssi.org/scripts/urlplot.pl
