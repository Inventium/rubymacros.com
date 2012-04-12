
## From Rails Recipes

From rails recipe, #1:
To model rich many-to-many relationships in Rails, use join models to
leverage

Active Record's has_many :through() macro.


## Macros and the Ruby metaprogramming model



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




### Important background 

* Paul Graham

* [Mirah Language macros](http://www.mirah.org/wiki/Macros)

* Scheme?




## Ruby macro implementations


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


[Coding horror](http://www.codinghorror.com/blog/2011/07/nobodys-going-to-help-you-and-thats-awesome.html)

