
# Macros and the Ruby metaprogramming model



## Various approaches

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
* Solution: Use a class method in a class definition
* Code: From Paolo Perrotta's "Ruby Metaprogramming", p. 241, listed as a spell. More
information on this pattern given on p. 115.
* Exercise 

### Example 4

* Problem
* Solution
* Code
 
~~~~
def some_piece_of_stuff
  { :name => 'foo' }
end
~~~~

* Exercise 

### Example 5

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
* Related links on metaprogramming (move later)
 * http://c2.com/cgi/wiki?PointerMetaprogramming
 * http://c2.com/cgi/wiki?MetaProgramming
 * http://c2.com/cgi/wiki?PointerCastPolymorphism
 * http://c2.com/cgi/wiki?TypingQuadrant
 * http://www.generative-programming.org/
 * http://c2.com/cgi/wiki?GenerativeProgramming
 * Macro style programming, Rails 3 Way, p. 121


