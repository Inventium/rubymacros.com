

## Parse tree substitution 

Consider an assert macro which allows inspecting an expression which is
passed to the assert method. When constructing error message, the macro
can retrieve both arguments.  Test::Unit solves by creating various
methods corresponding to various types of conditional operators.  

For example, `assert.equals`, `assert.greater_than`, etc etc etc.
Assert macro gives the value AND the names of the arguments to the
conditional are in the macro.  This allows code to run without
evaluating the assertion.  Thus, error checking can go into code,
without needing to be removing.

This allows implementation of logging which can be switched off at run
time as well.



* Compile regex at parse time. 


iterate:


Common lisp's ITERATE library is a powerful and subtle looping facility. it allows you to write
loops declaratively instead of imperatively and includes many types of subclauses for most or all
of the common tasks that need to be done inside of loops.

examples stolen from: http://common-lisp.net/project/iterate/doc/Introduction.html


<pre class="brush:clojure">
(iter (for i from 1 to 10)
  (collect i)) 
</pre>

This doesn't seem so exciting. Ruby has collect too, and some nice
looping facilities. The ruby equivalent is:

<pre class="brush:ruby">
(1..10).map{|i| i}  # =>[1,2,3,4,5,6,7,8,9,10]
</pre>

But ITERATE has many more capabilities than the actually fairly limited
set of things that ruby's each, map, inject, find, etc can do for you

This one iterates over a list and collects the odd numbers in it:        

    
<pre class="brush:clojure">
(iter (for el in list)
  (if (and (numberp el) (oddp el))
    (collect el)))
</pre>

That kind of thing can't be done with map in the general case without
falling back to the imperative form of loop; a while or for loop.  You
can't do it with #collect.

<pre class="brush:clojure">
 (iter (for (key . item) in alist)
    (for i from 0)
    (declare (fixnum i))
    (collect (cons i key)))
</pre>

This loop takes the keys of an alist and returns a new alist associating 
the keys with their positions in the original list. The compiler declaration 
for i will appear in the generated code in the appropriate place.


To find the length of the shortest element in a list:

<pre class="brush:clojure">
(iterate (for el in list)
  (minimize (length el)))
</pre>

           
To return t only if every other element of a list is odd:

<pre class="brush:clojure">
(iterate (for els on list by #'cddr)
  (always (oddp (car els))))         
</pre>

* http://common-lisp.net/project/iterate/doc/index.html


Iterate allows you to declare your loop at high level, rather than getting 
into the low level details of programming your loop.
Iterate is written with lisp macros. at parse time, iterate loops are 
compiled down to the equivalent of efficient while loops, without
iterating over data sets multiple times or a lot of extra bookkeeping. 



<pre class="brush:ruby">
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
</pre>



