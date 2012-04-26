
## Party's over

Now that we're through the easy stuff (!), let's take a closer look a
what the concepts really mean, string and parse tree substitution.

#### A tiny treatise on string substitution

Consider, for example, looking for a closing parens in strings.
Finding matching parens is easy for a single pair.
With more than a single and nested parens, you end
up writing a parser anyway.

<pre class="brush:clojure">
 0th order: (myexpr)
 1st order: (my(expr))

 nth order: (my('string('))
             my(/*comment)*/)
            (my("string\")"))
            (my("string\\"))
</pre>


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

<pre class="brush:ruby">
p%q  #op
p% q  #op
p % q  #op
p %q  #start of string
1 %2  #op
p=1; p %q  #op
</pre>

this behavior means that in order to figure out how to handle %, you must also keep track of 
what local variables are defined in the current context, and what the type of the last token was.
If the last token was a method name, % _might_ start a string. If it was a value (number, string literal, etc)
it definitely was an operator. % also always starts a string when following operators or things like '(' or '['.


To reiterate, it's better not to have to handle this stuff yourself. 
If you're using a string-based macro system, you either have to make do 
with limited capabilities, or you run smack into all these hard parsing problems, and 
you'll break your pick on it pretty quickly. This stuff makes parsing xml 
with regular expressions look easy.


