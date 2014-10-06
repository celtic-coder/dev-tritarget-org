---
template: page.hbs
title: "About TriTarget.org"
comments: false
---
This site is built with a static site generator. What this means is I write the
code in [Markdown][] and it is compiled into the website you see now. You can
[view the source code][1] for this site on GitHub.

[![Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png)][2]

The static site generator was cobbled together with the following technologies:

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/)
* [Gulp](http://gulpjs.com/)
* [Metalsmith](http://www.metalsmith.io/)
* [Markdown][]
* [Handlebars](http://handlebarsjs.com/)
* [Browserify](http://browserify.org/)
* [CoffeeScript](http://coffeescript.org/)
* [Less](http://lesscss.org/)
* [Bootstrap](http://getbootstrap.com/)
* [Font Awesome](http://fortawesome.github.io/Font-Awesome/)

[Markdown]: http://daringfireball.net/projects/markdown/
[1]: https://github.com/sukima/dev-tritarget-org
[2]: http://creativecommons.org/licenses/by-nc-nd/4.0/

## About Me

TriTarget.org is a name I came up with in high school. I was big into computer
programming and wanted a company name that was kinda catchy. When I made a few
programs in [BASIC][] I would brand them with __TriTarget__ as a way to show
my company (Even though I didn't have one).

After high school I began college as a computer scientist. Part way through I
scored a job as a computer programmer and continued that path for about 6
years. During the dot com burst I was laid off and left to fend in a world were
software development was not a valued commodity anymore (too many fish in the
sea). I began work as an electrician for about 3 years while I trained to be an
[EMT][]. I began that career in the medical field where I eventually became a
Paramedic. I finished my associates degree and after 10 years in the medical
field I found a job at a top hospital as a
[medical simulation technician](https://gist.github.com/sukima/5328751).

I developed my technical as well as my software development skills. Becoming a
active member in the development community, I studied modern web and mobile
technologies such as [JavaScript][JS], [Ruby on Rails][RoR], and iPhone
development. I now work in this field and am excited to continue my childhood
dreams of creating great software for everyone to enhance their lives with.

[BASIC]: http://en.wikipedia.org/wiki/BASIC
[EMT]: http://en.wikipedia.org/wiki/Emergency_medical_technician
[ECMO]: http://en.wikipedia.org/wiki/Extracorporeal_membrane_oxygenation
[JS]: http://en.wikipedia.org/wiki/JavaScript
[RoR]: http://rubyonrails.org/

<div class="panel panel-default">
<div class="panel-heading">PGP Public Key</div>
<div class="panel-body">

<p>
Download key: [{{ site.pgp.id }}](/key) <i class="fa fa-lock"></i>  
`{{join site.pgp.fingerprint " "}}`
</p>

<pre class="well">
{{includeFile "key"}}
</pre>

</div>
</div>
