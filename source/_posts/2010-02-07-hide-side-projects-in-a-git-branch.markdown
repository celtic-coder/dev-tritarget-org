---
layout: post
title: "Hiding side projects in a Git branch"
date: 2010-02-07 00:00
comments: true
catagory: tips
---
So I found this really cool trick. A way to use Git branches to store complete
new repositories inside another. What I mean is basically hiding a side
project in a Git branch. This is great for things like unmodified images, HTML
source for a project page attached to the project itself, documentation,
storing large files that are not needed with every clone of the master branch,
storing approved copies of libraries and other dependencies.

I use this feature to store meta data on a project for example many of my
website projects have the actual web files but the design was first created
using comps (usually blank markups and/or Photoshop files). Once I use these
comps to make the site they are usually no longer needed. However later down
the road when I need to reference them because the client wished for a change
I find them deleted. I though about storing them out on the server but then
there is two locations I have to remember instead of the source repository.

In the SVN days I used to add a forth directory:

    Root
    |+Tags
    |+Branches
    |+Trunk
    `+Comps

There were the usual directories and another for the comps. Working on the
source you would checkout the Trunk directory and never see Comps unless you
checked it out manually.

Git also allows this only much easier and cleaner. And Github has a great how to
with there [Github Pages][1] section and also from this [blog post][2].
However I'll repost the instructions here.

__Make sure you have no local or un-committed changes or they will be lost!__

First create a new symbolic reference to a new branch. We don't make a new
branch in the normal way because it will link itself to the current HEAD and
what we want it to link it to nothing. That way any files on the new branch
are unassociated to any branches you make with your code.

    $ git symbolic-ref HEAD refs/head/newbranch

This will create the new branch _and_ put you in that branch. Next is a bit
strange. Since the _index_ that Git knows about still has all the files in
the master branch and so doing a `git status` will show all those files ready
to be committed. This isn't what we want we need to clear out the index.
Easiest way is to delete the index file since Git will recreate it if missing.
It will recreate it properly based on the branch we are in.

    $ rm .git/index

Last but not least all those files are still in the working directory. It's a
pain to go through and `rm -rf` everything (And dangerous) make Git do it with
a clean.

    $ git clean -fdx

**UPDATE: This branch now needs to manually be attached**

Turns out (maybe a version thing) that I was unable to use the new branch
created before because git claimed it was detached. After I had commited
something (important or git thinks the branch hasn't been born yet) I had to
explicitly check out the new branch for it to work:
`git checkout -b newbranch`

Now Your ready. Add some files, Commit them and eventually push them.

    $ git push origin newbranch

What's great is a clone by anyone will get the master branch and ignore this
new branch unless they need it and they pull it manually.

**UPDATE: full walk through**

    (no branch)$ git init test_repo
    Initialized empty Git repository in /Users/suki/tmp/test_repo/.git/
    (no branch)$ cd test_repo/
    (master)$ echo "test data in master" > testdata-in-master
    (master)$ git add testdata-in-master
    (master)$ git ci -m "First commit on master branch"
    [master (root-commit) b879d9f] First commit on master branch
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 testdata-in-master
    (master)$ git symbolic-ref HEAD refs/head/newbranch
    (refs/head/newbranch)$ rm .git/index
    (refs/head/newbranch)$ git clean -fdx
    Removing testdata-in-master
    (refs/head/newbranch)$ echo "test data in newbranch" > testdata-in-newbranch
    (refs/head/newbranch)$ git add testdata-in-newbranch
    (refs/head/newbranch)$ git ci -m "First commit on newbranch branch"
    [refs/head/newbranch (root-commit) ac63f64] First commit on newbranch branch
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 testdata-in-newbranch
    (refs/head/newbranch)$ git checkout -b newbranch
    Switched to a new branch 'newbranch'
    (newbranch)$ git push origin newbranch
    fatal: 'origin' does not appear to be a git repository
    fatal: The remote end hung up unexpectedly
    (newbranch)$ ls
    testdata-in-newbranch
    (newbranch)$ git checkout master
    Switched to branch 'master'
    (master)$ ls
    testdata-in-master

[1]: http://pages.github.com/
[2]: http://madduck.net/blog/2007.07.11:creating-a-git-branch-without-ancestry/
