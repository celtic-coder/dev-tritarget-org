---
title: "A Promising Functional Utility"
date: 2015-02-01
comments: true
tags: coding
---
I was playing around with promises in JavaScript and an idea hit. How would
[Node.js][] work as a web scrapper? Turns out quite well actually. In my
experimentation I found that [promises][] and some simple [functional style][1]
made for a nice program and surprisingly require little debugging. I wanted to
walk through a possible scenario to illustrate a though process and code style
that I've come to really like.

[Node.js]: http://nodejs.org/
[promises]: https://github.com/petkaantonov/bluebird#what-are-promises-and-why-should-i-use-them
[1]: http://en.wikipedia.org/wiki/Functional_programming

## The Scenario

There is a website that has a list of documents that you want to archive.
However, the server serving the documents does some filtering. It redirects all
traffic regardless of path to a intro page. The intro page sets a session cookie
and then each page looks at the referrer to make sure the pages are fetched in
order.

## The Setup

The first thing I going to do is start setting up the needed pieces. I know I'll
need a fetching function to fetch each page. It needs to be reusable, save
cookies, handle the referrer, and return a promise (;cause I like those). I'll
use the [request][] and the [bluebird][] modules.

```javascript
var Promise   = require('bluebird');
var request   = Promise.promisifyAll(require('request'));
var urlPrefix = 'http://example.com/';
var cookieJar = request.jar();

var fetchPage = function(href, referrer) {
  var headers = {
    'User-Agent': 'MySuperCoolFetcher 1.0'
  };
  if (referrer != null) {
    headers['Referer'] = urlPrefix + referrer;
  }
  href = urlPrefix + href;
  return function() {
    return request.getAsync({url: href, jar: cookieJar, headers: headers});
  };
};
```

The cool trick here is that this one function can define a series of functions:

```javascript
var fetchLandingPage      = fetchPage('index.html');
var fetchMainPage         = fetchPage('main.html', 'index.html');
var fetchDocumentListPage = fetchPage('docs.html', 'main.html');
```

And because they are promised they can be chained:

```javascript
fetchlandingpage()
  .then(fetchmainpage)
  .then(fetchdocumentlistpage);
```

[request]: https://github.com/request/request
[bluebird]: https://github.com/petkaantonov/bluebird

<!-- more -->

## Parsing

In our scenario the document list is so large it is impractical to try and suck
it down in one shot. So instead we should grab them one at a time. And we should
keep track of the progress. We would also like to make sure our progress is
saved in case the program has to shutdown and stat again later. Finally the fake
server is being really nasty and checking to see if multiple pages are
downloaded from the same machine and so we want to fetch each page one at a time
like we did above.

What will happen is once the document list is downloaded we will parse it and
get a list of documents. We will filter that list to only show documents that
haven't been previously downloaded. We randomly pick a document to download;
download it and then do it again. Once downloaded we register that document as
complete to be filtered out next time around.

Parsing will be handled using the [htmlparser][] and [soupselect][] modules. But
unlike their documentation we need to make a few adjustments to make them
promise compatible:

```javascript
var htmlparser = require('htmlparser');
var select     = require('soupselect').select;

var parseToDocList = function(html) {
  return Promise.fromNode(function(resolver) {
    var handler = new htmlparser.DefaultHandler(resolver);
    var parser  = new htmlparser.Parser(handler);
    parser.parseComplete(html);
  })
  .then(function(dom) {
    return select(dom, 'a')
      .map(function(link) {
        return link.attribs.href;
      })
      .filter(function(path) {
        // Ignore links to anything other then an html document.
        return path && /\.html$/i.test(path);
      });
  });
};
```

One of the advantages of [bluebird][] is it's ability to
[trap custom error objects][2]. This helps with program flow in the same vain as
you would with normal `try` / `catch` blocks.

[htmlparser]: https://github.com/tautologistics/node-htmlparser
[soupselect]: https://github.com/harryf/node-soupselect
[2]: https://github.com/petkaantonov/bluebird/blob/master/API.md#catchfunction-errorclassfunction-predicate-function-handler---promise

```javascript
var NoDocsLeftError = function(message) {
  this.message = message;
  this.name = 'NoDocsLeftError';
}
NoDocsLeftError.prototype = Object.create(Error.prototype);
NoDocsLeftError.prototype.constructor = NoDocsLeftError;

var findNewRandomDoc = function(list) {
  var newDocuments = list.filter(function(doc) {
    return downloadedList.indexOf(doc) < 0;
  });
  if (newDocuments.length === 0) {
    throw new NoDocsLeftError('No more documents are left')
  }
  var randomIndex = Math.floor(Math.random() * newDocuments.length);
  return list[randomIndex];
};
```

Then put them together:

```javascript
var fetchDocument = function(page) {
  return fetchPage(page, 'docs.html')();
};

fetchLandingPage()
  .then(fetchMainPage)
  .then(fetchDocumentListPage)
  .then(parseToDocList)
  .then(findNewRandomDoc)
  .then(fetchDocument)
  .then(function(doc) {
    console.log('Downloaded document (%d characters)', doc.length);
    process.exit(0);
  })
  .catch(NoDocsLeftError, function(err) {
    console.log('Nothing to do. %s', err.message);
    process.exit(1);
  })
  .catch(function(err) {
    console.error('Something went wrong.');
    console.error(err);
    process.exit(127);
  });
```

## Loop fetching

One of the challenges of this exercise was that the server doesn't like
concurrent connections. Interestingly, promises excel at concurrency. So A
little adjustment to the usual chaining flow needed to be used to fetch
documents sequentially.

```javascript
var fetchDocumentSet = function(numberOfDocs) {
  return function(documentList) {
    // Start with a resolved promise.
    var promiseChain             = Promise.resolve();
    // Save a reference once instead of each time in for loop
    var findNewRandomDocWithList = findNewRandomDoc(documentList);
    for (var i = 0; i < numberOfDocs; i++) {
      promiseChain = promiseChain
        .then(findNewRandomDocWithList)
        .then(fetchDocument);
    }
    return promiseChain;
  };
};
```

A complication of promises and chaining is that the return value from the then
functions mutate the promise value. In the above function I'm refreshing the
document list each time. To do this I needed to refactor the `findNewRandomDoc`
function:

```javascript
var findNewRandomDoc = function(list) {
  return function() {
    var newDocuments = list.filter(function(doc) {
      return downloadedList.indexOf(doc) < 0;
    });
    if (newDocuments.length === 0) {
      throw new NoDocsLeftError('No more documents are left')
    }
    var randomIndex = Math.floor(Math.random() * newDocuments.length);
    return list[randomIndex];
  };
};
```

I would go on to demonstrate caching of the document list and saving of files
but that is rather trivial comparatively. Instead I'll just share
[this annotated gist][3].

A use pattern for this script would be to add it as a [cron job][4] and
eventually all the documents would be downloaded and you would start to get an
email when all the documents as downloaded (since it outputs a message to
stderr).

I hope this was a fun exercise as it was for me to play with. I realize it isn't
the best solution but based on the problem criteria (which was quite unusual I
admit) this was a fun way to attempt solving it.

[3]: https://gist.github.com/97c71776759978289339
[4]: http://en.wikipedia.org/wiki/Cron
