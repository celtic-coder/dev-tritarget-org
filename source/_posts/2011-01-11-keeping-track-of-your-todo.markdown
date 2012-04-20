--- 
layout: post
title: "Keeping track of your todo"
date: 2011-01-11 00:00
comments: true
categories: [ "tools", "command-line", "productivity", "life-hacking", "developemnt", "programming" ]
---
I am a big fan of productivity tools. I love utilities that make my life
better. "Life-hacking" is the term. I use a great tool called [Things][1].
However, it has some big draw backs. First off it is centralized to one file.
You can organize it by projects and areas of responsibility. Thing is this
didn't fit well with organizing tasks to specific programming projects.

It seems silly to have _pick up the milk_ mixed with a project for my latest
development project (_add newMigration() method to MainController_). Because of
this development todos in [Things][1] wasn't contextually appropriate. I code on
the command line and should have my project's todo on the command line (think:
ssh). Not only that but it was centralized and not scoped to each project.

(Finally [Things][1] doesn't have cloud syncing but bonjour syncing which is
impossible while at work! You listening [Cultured Code][2]? The syncing problem
makes [Omnifocus][3] look good!)

So to the terminal... I found this great app called [TaskWarrior][4] which is a
very full featured task manager. It is [GTD][] on the command line. Trouble is
it was centralized to one database as well. Tons of features but I still wanted
my databases based per project (directory) and optionally commit the database
to version control.

<!-- more -->

#### Developer Todo List

To the rescue is this gem called the [Dev Todo][5]. It is a task manager that
uses an XML file in the current directory. It's so simple it's stupid. However,
it is not without some great features. I use this to keep track of what I need
or want to do with a project. Basically a simple note taking. The command line
is simple and it's quick. You have a great level of flexibility since the data
is nothing but a simple XML file which is well formatted and intuitive to
understand. But who edits data manually. The program will output, organize,
manage, and track tasks with **color**! It has hierarchy and it can link to
multiple other databases.

Here is how I've used it. In my Rails app I had a master `.todo` file in the
root directory of the app. I stored all the main tasks there. I also made a
todo in the `test` directory then linked them.

    $ tda -p medium add new action for :print in main_controller.rb
    Index of new item is 1
    $ cd test
    $ tda -p medium refactor unit tests
    Index of new item is 1
    $ tda -p medium refactor functional tests
    Index of new item is 2
    $ todo --title Testing
    $ cd ..
    $ tdl -p high test/.todo
    $ todo +
      1.Testing
          1.refactor unit tests
          2.refactor functional tests
      2.add new action :print for main_controller.rb

I can't say enough cool things about this app. Perhaps I'll write more at a
later time but it has saved me. It is now one of my must haves in development.

[1]: http://culturedcode.com/things/
[2]: http://culturedcode.com/
[3]: http://www.omnigroup.com/products/omnifocus/
[4]: http://taskwarrior.org/projects/show/taskwarrior/
[5]: http://swapoff.org/DevTodo
[GTD]: http://www.davidco.com/what_is_gtd.php
