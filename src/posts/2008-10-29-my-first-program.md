---
title: "My First Program"
date: 2008-10-29
comments: true
categories: coding
---
So lets take a look at programming. This will be our first installment on
programming. In this module we will look at making the computer do something
for us. There are two steps. Setting up the system to listen to us and telling
the system what to do.

We have chosen to use Java as the programming language. Mainly the choice was
because of OOP and tight Type Casting. We'll get more into these later on. But
what we will get into now is the basics for getting the computer to talk to
us.

Now the computer uses what we call _Machine Code_ to tell the CPU
(Computer) what to do. It is a series of one's and zero's that are specific to
that type of computer. When we write a program we have to translate that
program into this machine code and that is done through another program call a
compiler. Now for the monkey wrench. Java is a  bit different. Instead of
compiling it into machine code for your type of computer (PC, Mac, Etc.) it
will compile it into machine code for a _virtual_ computer that doesn't
exists. We call this special machine code _bytecode_. When you run a
compiled Java program (bytecode) your computer emulates this virtual computer
that the bytecode was meant for. We call this process the _Java Virtual
Machine_.

<!-- more -->

![Diagram of the application process](/images/posts/javavm.jpg)

So how do we do this? First off you need the [Java Development][1] Kit. Head
over to [http://java.sun.com/javase/][2] and choose the **JDK** not the JRE to
download. ([Installation instructions][3] for windows users) Mac users can
download it [here][4].

Once installed let's do something simple: Our first program. Copy the following
into a file ending with the suffix `.java` for example
`C:\My_First_Project\hello.java`

```java
/**
 * My First Program.
 * See the whole article at
 * {{ site.url }}{{ path }}
 */
class Hello
{
    /**
     * Entry point.
     * @param args the command line parameters.
     */
    public static void main(String[] args)
    {
        // Output to the screen the following phrase.
        System.out.println("Hello World!");
    }
}
```

Now after you save it open up a command line (Most Windows computers will open
a command line by selecting Start | Run... and typing in `cmd` or `command`
depending on the Windows version. See [commandwindows.com][5] for more info)
and get yourself to that directory. Then compile the code and run it through
the Virtual Machine. (The Java programs need to be in your PATH. If the
following does not work as expected perhaps you can take a look at [setting
your PATH][6])

    C:> CD My_First_Project
    C:\My_First_Project> javac hello.java
    C:\My_First_Project> java Hello
    Hello World!

So lets take a look at what we did.

- __Line 1:__ We changed the directory to where we save the file. This allows
  us to perform actions contained within the directory. Helps with organizing
  things and simplifies how we interact with the command line.
  __Line 2:__ We compile the source code into bytecode. the `javac` command
- will make a new file in this directory called `Hello.class` which is the
  bytecode.
- __Line 3:__ We run the bytecode through the virtual machine. The command
  `java` only needs to know what _class_ you want to execute (Will
  explain later) suffice it to say it does not need the `.class` and it is
  capitalized.
- __Line 4:__ This what you should see if everything worked out.

Congratulations you just made your first program. I know kind of anti climatic
but we'll get better. So lets look at parts of the program.

#### Comments

I don't care what anyone says. Comments make the code! Learn them and use them!
A comment is a piece of text in your source code that doesn't do anything. It
is there so when you read it or when others read it they know what the heck is
going on and how to use things. You will see through out my code there are
comments describing what it's doing or information that is useful to someone
who is developing the program.

A comment is created by surrounding the text in the characters '`/*`' and
'`*/`' or if the line starts with '`//`'.

#### Wrappers

Ok so without getting into too much detail all Java programs must have the
following: Class definition and an Entry Point. We will discuss this later as
to why but for now every program you make will have a line that defines the
_class_:

```java
class Hello
```

Everything is surrounded by brackets. This give the code a look of hierarchy
again for organization. So we use these curly brackets around all the "blocks"
of code. Some people like to put the curly bracket on the same line some like
it underneath it doesn't matter which either works just as well.

#### Entry Point

The entry point is where executing of your program starts. As we learn about
OOP you'll understand that all programs have to start some where and they all
start with the following line (We will explain the meaning of these commands in
later modules):

```java
public static void main(String[] args)
```

And again we surround the next block in curly brackets.

#### Execution

Last but not least that actual  part of the code that does anything. As we
venture into OOP you understand why this command is so drawn out but for now
just deal with it looking cumbersome.

```jave
System.out.println("Hello World!");
```

First off all _commands_ end with a semi-colon. Forget one of these and it all
falls apart. Since this is our only statement we only have one. This is
different from say the above wrappers which do not need an ending semi-colon.
Now what we are asking the computer to do is ask the "System" object for the
output object and telling the output object to print a line of text. This
esentially just shows the "Hello World!" text on the screen since the output
object is associated with the command line your typing in.

That's it for now we will get much more detail later but for now you made your
first program.

[1]: http://en.wikipedia.org/wiki/Java_Development_Kit "Wikipedia entry for Java Development Kit"
[2]: http://java.sun.com/javase/ "Official download of JDK"
[3]: http://java.sun.com/javase/6/webnotes/install/jdk/install-windows.html "How to install the JDK on windows"
[4]: http://developer.apple.com/java/download/ "Java JDK Download"
[5]: http://commandwindows.com/command1.htm "Using the command line"
[6]: http://java.sun.com/javase/6/webnotes/install/jdk/install-windows.html#Environment "Setting up your evironment in windows"
