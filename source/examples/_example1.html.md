---
example: 1
---

### Example - Caleb's Assert macro

Consider an assert macro which allows inspecting an expression which is
passed to the assert method. When constructing error message, the macro
can retrieve both arguments.  Test::Unit solves by creating various
methods corresponding to various types of conditional operators.  

For example, `assert_equals`, `assert_greater_than`, etc etc etc.
Assert macro gives the value AND the names of the arguments to the
conditional are in the macro.  This allows code to run without
evaluating the assertion.  Thus, error checking can go into code,
without needing to be removing.

This allows implementation of logging which can be switched off at run
time as well.


* Problem
* Solution
* Code
* Exercise 


Syntactical macros allow examination of macro arguments,
introspection at the level parse tree. 
