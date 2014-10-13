---
title: "Bug tracking"
date: 2009-07-22
comments: true
tags: coding
---
I recently installed [MantisBT][1] a PHP based bug tracker. I found a
[great plugin][2] that lets Mantis monitor a source repository and associate
the logs to issue and bug tickets.

I don't have much explanation of the process I used to install it. It was your
basic PHP based system. I use gitosis to handle the Git repositories. I can
config gitosis to authorize gitweb with a cherry picked set of repositories.
However, Mantis uses gitweb to link into the git repositories. Since the
gitosis config handles gitweb publicly I didn't want just anyone to browse the
source via gitweb. But I need a gitweb for all repositories so mantis could
track changes.

What I did was copy the gitweb CGI directory to another directory. I change
it's configuration to read all repositories (Yes this includes the
gitosis-admin.git repo) and then use an apache .htaccess file to log access
except from the webserver itself (mantis PHP script).

```apache
# filename: wwwroot/private_gitweb/.htaccess
order deny,allow
deny from all
allow from 127.0.0.1
```

_You might have to replace `127.0.0.1` with the IP of your site not loaclhost.
(Use `ping yoursite` to get the external IP)_

[1]: http://www.mantisbt.org/
[2]: http://git.mantisforge.org/
