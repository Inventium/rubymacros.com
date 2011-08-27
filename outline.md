# Ruby Macros  



> Hey, what are macros anyway? - 
> <a href="http://ola-bini.blogspot.com/2006/09/three-ways-to-add-ruby-macros.html?showComment=1159199100000#c8031594432717641283">Chris Richards</a>


Good question, Mr. Richards, and one without an easy answer.

Perhaps it's easier to answer a related 
question as posed by Ola Bini:

> [What is the purpose of ruby macros?](http://ola-bini.blogspot.com/2006/09/three-ways-to-add-ruby-macros.html)
>
> 1. generate code
> 2. Give ruby syntax (eg expressed in AST) a different meaning in a specific context, ie transform a ruby block into another.


From the Pickaxe (4th ed., p. 378), we have macros defined as 
Ruby methods which generate code "behind the scenes" by 
turning small bits of code into larger bits of code.


## Introduction to the problem

> Defn: macrophobia - an unreasonable fear of 
> defining new syntactical constructions. - 
> (Plagiaphrased from Seibel's 
> [Practical Common Lisp](http://www.gigamonkeys.com/book/macros-standard-control-constructs.html))


In general, macros are used for language extension via 

1. extending syntax to reduce awkward, inconvenient or otherwise unimplementable code, or 
2. extending the capability of a program.

These goals are accomplished by:

1. Textual replacement
2. Method expansion


Macros may appear identical to functions 
by accepting parameters and returning a result.
The difference is how macro go about their business.
A macro may not return a result directly, instead
the result is obtained from the expression returned
by the macro. When this expression-returning 
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






with foo.bar {
  baz
  quux
  fleeble
}
       =>
t=foo.bar
t.baz
t.quux
t.fleeble


macro with arg
  :( t= ^arg )
  yield.deep_copy{|node|
    if RedParse::CallNode===node and node.receiver.nil?
      node.receiver=:(t) 
    end
    node
  }
end


## Benefits of parse tree substitution 

* Consider an assert macro which allows
inspect the expression which is passed to the 
assert method. When constructing error message, 
the macro can retrieve both arguments.
Test::Unit solves by creating various methods
corresponding to various types of conditional 
operators.  Assert.equals, assert.greater_than, etc etc etc.
Assert macro gives the value AND the names of the
arguments to the conditional are in the macro.
This allows code to run without evaluating 
the assertion.  Thus, error checking can go 
into code, without needing to be removing.

* This allows implementation of logging which 
can be switched off at run time as well.



* Compile regex at parse time. 


iterate:


common lisp's ITERATE library is a powerful and subtle looping facility. it allows you to write
loops declaratively instead of imperatively and includes many types of subclauses for most or all
of the common tasks that need to be done inside of loops.

examples stolen from: http://common-lisp.net/project/iterate/doc/Introduction.html

(iter (for i from 1 to 10)
        (collect i))   

this doesn't seem so exciting. Ruby has collect too, and some nice looping facilities. The ruby equiv is:

(1..10).map{|i| i}  #=>[1,2,3,4,5,6,7,8,9,10]

But ITERATE has many more capabilities than the actually fairly limited set of things that ruby's each, map, inject, find, etc can do for you

This one iterates over a list and collects the odd numbers in it:        
         (iter (for el in list)
        (if (and (numberp el) (oddp el))
            (collect el)))

That kind of thing can't be done with map in the general case without falling back to the imperative form of loop; a while or for loop. 
You can't do it with #collect.

 (iter (for (key . item) in alist)
        (for i from 0)
        (declare (fixnum i))
        (collect (cons i key)))
This loop takes the keys of an alist and returns a new alist associating the keys with their positions in the original list. 
The compiler declaration for i will appear in the generated code in the appropriate place.

To find the length of the shortest element in a list:
  (iterate (for el in list)
           (minimize (length el)))
           
           
  To return t only if every other element of a list is odd:

  (iterate (for els on list by #'cddr)
           (always (oddp (car els))))         


http://common-lisp.net/project/iterate/doc/index.html


iterate allows you to declare your loop at high level, rather than getting into the low level details of programming your loop.
iterate is written with lisp macros. at parse time, iterate loops are compiled down to the equivalent of efficient while loops, without
iterating over data sets multiple times or a lot of extra bookkeeping. 






### Who this web page is for

The authors of this web page come from a C/C++
and a Lisp background, respectively. The web macro
in those environments have specific connotations
which overlap Ruby's notion of macros, but is not
at all the same.  Accordingly, this web page will
be of most use for people coming from those languages.
If you, the reader, have learned to program primarily
from Ruby, most of the following discussion revolves
around certain aspects of metaprogramming which you
already know.

However, if you are moving from Ruby to languages
in either the Lisp camp or the C/C++ camp, you will 
find some valuable information here.


## Macros and the Ruby metaprogramming model



### Various approaches

* Substitution

 * [REXX](http://en.wikipedia.org/wiki/REXX)

 * M4

 * CPP - Allows (eponymous) preprocessing of
  C and C++ code relieving the burden on compiler and linker.
  CPP trades compile time substitution for run time elimination
  of function calls. Example: min and max are
  may be implemented as macros in C and C++. CPP can be
  used for general-purpose string
  substitution in any text file; it is not limited to C
  programming language source files.

 * TeX - Textual replacement eliminates commonly patterns, and allows
parameterization of structurally repetitive but non-identical construction.

 * [Gema](http://gema.sourceforge.net/new/index.shtml)
 * [Lua macros](http://lua-users.org/wiki/LuaMacros)


* Rewriting - substitution - syntax-based macros
 * Macros which operate on parse trees rather than strings.
 * Parse trees as inputs, parse trees as outputs.
 * Delayed evaluation; call-by-name.
 * Methods which run at parse time, instead of at run time.
 * Because macro are methods, they are Turing complete and have
   the full power of Ruby methods.
 * Because macros are evaluated at parse time, they do not
   have access to the "full" Ruby system.
 * Helps keep things DRY which isn't methods, classes etc.

Example: Looking for a closing parens in strings.
Finding matching parens is easy for a single pair.
With more than a single and nested parens, you end
up writing a parser anyway.

~~~~
* 0th order: (myexpr)
* 1st order: (my(expr))
*
* nth order (my('string('))
            my(/*comment)*/)
            (my("string\")"))
            (my("string\\"))
~~~~

In the 0th order, you assume that the next close paren after an open paren is the matching
paren.

In the 1st order, you allow multiple nested levels of parens, so you have to count the
number of parens you've seen, and only consider a paren to be matching if you've seen the
same number of close parens as open parens.

In the nth order, you allow arbitrary string literals and comments inside your expressions.
Strings and comments can contain open or close parens, which must be ignored. Strings can
contain comment start sequences which must be ignored. Comments can contain quote chars
which must be ignored. Strings can contain escape sequences which must be ignored. Escape
sequences can include escaped quote characters (or backslashes!) which must be ignored.

The combination of all these rules makes a system which is quite difficult to process. Basically, 
you must be able to parse the whole language in order to handle the general case. This is too 
difficult of a problem (and tangential to what you really want to do) 
to handle in order to solve your goal of being able to process your language 
in order to write a textual macro which solves whatever 'business' problem you're trying to solve. 

It's better to have the language parsed for you already (even if it's something easy to 
parse, like lisp) than to try to parse it yourself. That's why syntactical macros are better;
they allow you to operate at the correct level of abstraction; instead of dealing with
strings, you are looking at parse trees, which contain the data you want to know about at the 
right level of abstraction.


when it comes to ruby, it gets even harder. There are some characters in ruby which are 
ambiguous; they can be operators or the beginnings or strings (or string-like things like
regexps) depending on context. / and % are the most notorious examples of these. Consider the 
following, where % might start a string, or be the modulo operator

p%q  #op
p% q  #op
p % q  #op
p %q  #start of string
1 %2  #op
p=1; p %q  #op

this behavior means that in order to figure out how to handle %, you must also keep track of 
what local variables are defined in the current context, and what the type of the last token was.
If the last token was a method name, % _might_ start a string. If it was a value (number, string literal, etc)
it definitely was an operator. % also always starts a string when following operators or things like '(' or '['.


To reiterate, it's better not to have to handle this stuff yourself. if you're using a string-based macro system,
you either have to make do with limited capabilities, or you run smack into all these hard parsing problems, and 
you'll break your pick on it pretty quickly. This stuff makes parsing xml with regular expressions look easy.



## Various methods


### Important background 

* Paul Graham

* [Mirah Language macros](http://www.mirah.org/wiki/Macros)

* Scheme?




## Implementations


### Intro



### Caleb



* [Ruby Macros](http://github.com/coatl/rubymacros) 


* [Arc macros](http://ycombinator.com/arc/tut.txt) about 3/4 down page.


### Reg Braithewaite



 * [Macros, Hygiene, and Call By Name in Ruby](http://weblog.raganwald.com/2008/06/macros-hygiene-and-call-by-name-in-ruby.html)
 * [Rewrite](http://rewrite.rubyforge.org/)
 * This is an insanely great talk: 
[Reg on Programming](http://www.globalnerdy.com/2010/01/25/cusec-2010-keynote-reg-braithwaite-beautiful-failure/).


### Ola Bini 


* [3 Ways to Add Ruby Macros](http://olabini.com/blog/2006/09/three-ways-to-add-ruby-macros/)


##Summary



[Coding horror](http://www.codinghorror.com/blog/2011/07/nobodys-going-to-help-you-and-thats-awesome.html)


### References and required reading

* [Programming Ruby 1.9](http://pragprog.com/book/ruby3/programming-ruby-1-9) 
Chapter 24 on metaprogramming has excellent
examples of how macros are defined and used in Ruby.

* Paul Graham's [On Lisp](http://lib.store.yahoo.net/lib/paulgraham/onlisp.pdf) 
should be required reading for all Rubyists regardless of any interest in 
Ruby macros. It's that important. And it's free to download a PDF file 
of the book. Do all the examples, by hand.

* Peter Seibel's [Practical Common Lisp](http://www.gigamonkeys.com/book/) is available online.

* Ola Bini

* Interesting [RSpec macro thread](http://rubyforge.org/pipermail/rspec-users/2011-August/020463.html)

## Execution - Exercises - Problem solving - Examples




### Example 1 Caleb's Assert macro

* Problem
* Solution
* Code
* Exercise 


Syntactical macros allow examination of macro arguments,
introspection at the level parse tree. 




### Example 2 Assert macro "wrong" with macros instead of lookups

* Problem
* Solution
* Code
* Exercise 


### Example 3

* Problem
* Solution
* Code
* Exercise 

### Example 4

* Problem
* Solution
* Code
* Exercise 

### Example 5

* Problem
* Solution
* Code
* Exercise 

### Example 6

* Problem
* Solution
* Code
* Exercise 

### Example 7

* Problem
* Solution
* Code
* Exercise 

### Example 8

* Problem
* Solution
* Code
* Exercise 


### Example 9

* Problem
* Solution
* Code
* Exercise 


### Example 10

* Problem
* Solution
* Code
* Exercise 

#### About

This micro-project came about as the result of a Google search.
After wading through pages of meaningless search results, 
cloned and swiped web pages, blog posts parroting the 
same old-same old, one of the authors found himself 
emitting Chewbacca-style roars of frustration.  A little
SEO juju and snapped up the exact match domain, to wit:
rubymacros.com, and a vow to set the matter straight once 
and for all, with some links to the best available pages
on the web. Curation doncha know.

## TODO

* Sort out notes on static versus dynamic metaprogramming
* Ruby metaprogramming seems to be a sort of "patterns language" for macros? 
How would each metaprogramming construct in Ruby be implemented in CL?
* Examine the LOOP and iterate libraries in CL. Compare with 
Ruby's each, inject, map, find (array and AR), etc. The iterate 
library may be an add on library.



