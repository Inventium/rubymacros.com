
# Title: Ruby Macros

<blockquote>
Hey, what are macros anyway? - 
<a href="http://ola-bini.blogspot.com/2006/09/three-ways-to-add-ruby-macros.html?showComment=1159199100000#c8031594432717641283">Chris Richards</a>
</blockquote>

Good question, Mr. Richards, and one without an easy answer.

Perhaps it's easier to answer a related 
question as posed by Ola Bini:
<blockquote>
[What is the purpose of ruby macros?](http://ola-bini.blogspot.com/2006/09/three-ways-to-add-ruby-macros.html)
1.) generate code
2.) Give ruby syntax (eg expressed in AST) a different meaning in a specific context, ie transform a ruby block into another.
</blockquote>

From the Pickaxe (4th ed., p. 378), we have macros defined as 
Ruby methods which generate code "behind the scenes" by 
turning small bits of code into larger bits of code.


## Introduction to the problem


<blockquote>
Defn: macrophobia - an unreasonable fear of 
defining new syntactical constructions.
</blockquote>

In general, macros are used for
* Language extension via syntax or capability.

These goals are accomplished by:
* Textual replacement
* "Method expansion"


Rule of Thumb from Lisp: When you can use
a function, do so. Functions are easier to 
understand.

### What, exactly, is the problem macros solve?



### Various approaches

* Substitution

** REXX 

** M4

** CPP - Allows (eponymous) preprocessing of 
C and C++ code relieving the burden on compiler and linker. 
CPP trades compile time substitution for run time elimination
of function calls. Example: min and max are 
may be implemented as macros in C and C++.

CPP can be used for general-purpose string 
substitution in any text file; it is not limited to C 
programming language source files.

** TeX - Textual replacement eliminates commonly patterns, and allows 
parameterization of structurally repetitive but non-identical construction.



** [Gema](http://gema.sourceforge.net/new/index.shtml)
** [Lua macros](http://lua-users.org/wiki/LuaMacros)
 

* Rewriting - substitution - syntax-based macros


** Macros which operate on parse trees rather than strings.
** Parse trees as inputs, parse trees as outputs.
** Delayed evaluation; call-by-name.
** Methods which run at parse time, instead of at run time. 
** Because macro are methods, they are Turing complete and have 
the full power of Ruby methods.
** Because macros are evaluated at parse time, they do not
have access to the "full" Ruby system.


** Helps keep things DRY which isn't methods, classes etc.

Example: Looking for a closing parens in strings.
Finding matching parens is easy for a single pair.
With more than a single and nested parens, you end
up writing a parser anyway.

* 0th order: (myexpr)
* 1st order: (my(expr))
*
* nth order (my('string('))
            my(/*comment)*/)
            (my("string\")"))
            (my("string\\"))

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




## Various methods


### Important background 

* Paul Graham

* [Mirah Language macros](http://www.mirah.org/wiki/Macros)

* Scheme?




## Implementations


### Intro



### Caleb



* [Ruby Macros](http://github.com/coatl/rubymacros) 





### Reg Braithewaite



 * [Macros, Hygiene, and Call By Name in Ruby](http://weblog.raganwald.com/2008/06/macros-hygiene-and-call-by-name-in-ruby.html)
 * [Rewrite](http://rewrite.rubyforge.org/)
 * This is an insanely great talk: 
[Reg on Programming](http://www.globalnerdy.com/2010/01/25/cusec-2010-keynote-reg-braithwaite-beautiful-failure/).


### Ola Bini 


* [3 Ways to Add Ruby Macros](http://olabini.com/blog/2006/09/three-ways-to-add-ruby-macros/)


##Summary



[Coding horror](http://www.codinghorror.com/blog/2011/07/nobodys-going-to-help-you-and-thats-awesome.html)


### Required reading

* On Lisp
* Ola Bini


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


