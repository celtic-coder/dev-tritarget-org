--- 
layout: post
title: "Dropping Outlook and Groupwise for Gmail"
date: 2010-10-07 00:00
comments: true
categories:
---
At my job we are forced to use Groupwise for our email. This isn't going to be
a post about how much Groupwise is not agreeable but instead I'm going to
describe my solution to making my work email much more agreeable. First I'll
describe what solutions didn't work and why.

<!-- more -->

First Outlook was not a solution as my IS department couldn't figure out how
to do that even after months of emails claiming that it was "gonna" happen. As
you can tell I have great faith in that department. Moving on...

I figure it was time to start using Gmail. So I setup my Groupwise rule that
forwards any new mail to a new Gmail account I created for this. (The same can
be done with outlook and exchange). I had to make sure that gmail was set to
send mails from my work email (required a verification from the settings
panel). Then I had to tell gmail to use this as the default address.

My company places a signature every time I send an email. Because I would be
sending from gmail that professional "this email is confidential" message at
the end of the email would not be added. So I sent my self a test email to the
gmail account from my groupwise account and copy pasted the signature to
gmail's signature setting.

Now I ran into a problem when attempting to use this solution with an iPhone.
I set it up as an exchange service because that supported push (instant
notifications that a new email has arrived). The problem with this is that
every time I sent an email it was from my gmail address _not_ the work
address. Attempts to fix that were futile. I attempted using it as an
[IMAP service][1] but that didn't set well and it disabled push. I was stuck
with only able to read them and not reply.

My final solution was to use gmail's awesome mobile app. But that was slow and
since I had two gmail accounts (one for work and one for home) it was a pain
to have to log in and out each time. I found this great app called
[mailroom][] which fixes all those issues. It is like [mailplane][] for the
iPhone. It basically opens the gmail mobile email app inside and then saves it
to a cache so that it opens fast and with a better interface. It also allows
multiple gmail accounts. Perfect!

My setup is now to have the iPhone mail app set to gmail as an exchange
service. When it recives a push notice that there is new email I notice and
instead of opening up the mail app I open up [mailroom][] and manage my email
there. I get the push but also get all the advantages of gmail including
threaded messages, labels, archiving, starring , and more.

[1]: http://mail.google.com/support/bin/answer.py?hl=en&answer=78799
[mailroom]: http://www.usemailroom.com/
[mailplane]: http://mailplaneapp.com/
