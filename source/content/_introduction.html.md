

> Hey, what are macros anyway? - 
> <a href="http://ola-bini.blogspot.com/2006/09/three-ways-to-add-ruby-macros.html?showComment=1159199100000#c8031594432717641283">Chris Richards</a>


Good question, Mr. Richards, and one without an easy answer.

Perhaps it's easier to answer a related 
question as posed by Ola Bini:

> [What is the purpose of ruby macros?](http://ola-bini.blogspot.com/2006/09/three-ways-to-add-ruby-macros.html)
>
> 1. generate code
> 2. Give ruby syntax (eg expressed in AST) a different meaning in a specific context, ie transform a ruby block into another.

We'll have more to learn from Mr. Bini shortly. In the meantime, let's
briefly examine the macro "problem."

## Introduction to the macro problem

> Defn: macrophobia - an unreasonable fear of 
> defining new syntactical constructions. - 
> (Plagiaphrased from Seibel's 
> [Practical Common Lisp](http://www.gigamonkeys.com/book/macros-standard-control-constructs.html))


In general, macros are used for language extension via 

1. extending syntax to reduce awkward, inconvenient or otherwise unimplementable code, or 
2. extending the capability of a program.

These goals are accomplished by:

1. Textual replacement
2. Expression expansion


Macros may appear identical to functions 
by accepting parameters and returning a result.
The difference is how macros go about their business.
A macro may not *return* a result directly, instead
the *result is obtained from the expression returned
by the macro*. When this expression-returning 
process is invisible, macros look like functions.


Rule of Thumb from Lisp: When you can use
a function, do so. Functions are easier to 
understand.

#### Function

A function tells the program to go somewhere
else, do something, and come back with results.


#### Macro 

A macro tells the program to go get some code, 
put that code in this here place, then find 
the result of that code.


### What, exactly, is the problem macros solve?

Macros, essentially, allow you to replace small,
ugly pieces of code with even smaller but prettier
pieces of code.

* When you find yourself writing the same little
bits of code over and over, and that code doesn't
"fit" into a class, that's a good candidate for a 
macro.

* When you have long strings in arbitrary places, 
consider replacing those with macros.

* When your logic becomes convoluted and clunky, 
consider replacing that logic with a macro expressing
exactly what's needed. 


Scale is important. Convoluted and clunky logic, in this context,
implies relatively short pieces of code. If your whole program is
convoluted and clunky (no shame, it happens), implementing macros is
probably not the best use of your time.



### Who this web page is for

The authors (Dave and Caleb) of _Ruby Macros for You_
know macros from a C/TeX
background, with a small amount of Lisp/Scheme and Ruby.
Macros in those environments have specific connotations
which overlap Ruby's notion of macros, but are not
quite the same.  Accordingly, this web page will
be of most use for people coming from those languages.
If you, the reader, have learned to program primarily
from Ruby, some of the following discussion revolves
around certain aspects of metaprogramming which you
may already know.

However, if you are moving from Ruby to languages
in either the Lisp camp or the C/C++ camp, you will 
find some valuable information here.


## We're gonna talk about Ruby now...


