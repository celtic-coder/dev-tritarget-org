---
layout: page
title: "JSAuth"
date: 2012-12-24 11:00
comments: true
sharing: false
footer: false
---
JSAuth is an idea that we could help the basic authentication paradigm. In
typical authentication the browser sends the username and password. The server
then compares them with the ones in the database. Now usually the password is
hashed (often with a salt) to prevent stealing. However the passwords are
usually still sent in plain text.

Some solutions attempt to hash the password on the client using JavaScript.
However the hash is still transmitted. What needs to happen is an exchange that
uses a one time salt. It would also be useful to allow encrypted data to be
sent and received. It would also need to be TNO compatible (Trust No One)

The following concept can be seen in practise form the company
[lastpass.com](http://lastpass.com/) who uses a TNO based system as described:

#### Paradigm ####

The client collects a user name and password. They are concatenated and then
hashed. This is now the master key. The server should send over a random salt.

_unfinished_
