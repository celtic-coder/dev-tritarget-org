--- 
layout: post
title: "Save the astronauts tether those pointers"
date: 2009-10-10 00:00
comments: true
catagories: [ coding, objective-c, tips ]
---
I think a lot of confusion comes from the idea of pointers and release 
responsibility. I find it is best to think of pointers as tether 
lines. Like in space the astronauts need to be very careful to 
maintain their tether lines or else the astronaut will float way and 
die a horrible death. Pointers are very much like that. The object you 
alloc/init is your astronaut and the variable (pointer) you assign it 
to is your first tether line. Now when you retain the object it 
created another tether line. 

{% highlight objc %}
// obj is now tethered to a spot on the space shuttle. 
NSObject *obj = [[NSObject alloc] init];
 
// Another tether line has just been tied to the SAME
// EXACT HOOK on the shuttle craft. 
[obj retain]; 

// You just removed one of the tethers. Since there is
// another one still attached you don't attempt to
// being the astronaut back inside. 
[obj release]; 

// You just sawed off the one hook you had and the
// astronaut and the last tether line is floating far
// away to die a horrible death. 
obj = nil; 

// A new astronaut has been attached to tether line
// attached to the shuttle craft. You have also just
// told the maintenance droid that when it is done
// swabbing the deck to cut only the tether line you
// just made. If that's the last line get the astronaut
// inside if not let the astronaut float some more with
// the other tether lines. 
obj = [[[NSObject alloc] init] autorelease]; 

// You have just attached another tether line to the
// astronaut however this time the new tether line is
// not attached to the same hook but to another
// astronaut floating around. 
NSMutableArray *array = [[NSMutableArray alloc] init]; 
[array addObject:obj]; 

// The maintenance droid has finished it's tasks (run
// loop complete pool is released) so it cuts the
// designated tether line. However there was another
// line that array attached to in its addObject: method
// so the astronaut doesn't float away. In other words
// array is responsible for the astronaut now and the
// original code doesn't care. What this does is tell
// you were the hook that holds the tether line is
// allowing you to pull the astronaut in to talk and
// let go without him floating away. It doesn't add a
// tether or remove one it simple says "here I am" If
// you want to not loose where the astronaut is then
// you have to take ownership by adding another tether
// line of your own so that when array cut it's tether
// line you still have the astronaut. 
NSObject *another_object = [array objectAtIndex:1]; 
[another_object retain]; 

// Second tether line cut. array still has one.
// Astronaut safe. 
[another_object release]; 

// And finally when you cut array's tether line both
// astronauts are brought in safely. The last line
// attached to array is pulled in and removed. Just
// before array goes inside he pulls in the original
// astronaut still attached to himself. 
[array release]; 
{% endhighlight %}

When you alloc/init you own that object it is your responsibility to 
either release it appropriately or pass on the responsibility to 
another object. NSArray will take one the responsibility (addObject:) 
but it will not give that responsibility back (objectAtIndex:) when it 
returns the object from objectAtIndex: it is your responsibility to 
either not worry about it as you don't need the object later. or if 
you do to retain it yourself so that when array goes away it doesn't 
take you object that you made yourself responsible for away under your 
nose. 
