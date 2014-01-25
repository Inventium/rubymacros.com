
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

* Link out to Metz's "Omega Mess" as and end goal of refactoring
  into macro-like constructions.

A small amount of math: \\(\forall x \in X\\)

Check out Wikipedia page on scope.

* http://www.rubytapas.com/episodes/27-Macros-and-Modules
### Rails helpers for macro examples.

* [Delegate
macro](http://guides.rubyonrails.org/active_support_core_extensions.html#method-delegation).

* Rails routing macros, Agile Rails, p. 310.
* Macros in DSLs, Chapter 15, page 183 of Domain-specific languages.

* associations/builder/has_one.rb



### Macro scoping as an example of de facto dynamic scope

This is worth digging into a bit deeper, check the [scope article on
Wikipedia](http://en.wikipedia.org/wiki/Scope_(computer_science)#Macro_expansion)
