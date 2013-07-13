
## We're gonna talk about Ruby now...

### What Ruby calls macros

From the Pickaxe (4th ed., p. 378), we have macros defined as 
Ruby methods which generate code "behind the scenes" by 
turning small bits of code into larger bits of code.


The simplest Ruby "macro," a sort of string substitution:


<pre class="brush:ruby">
def string_sub
  "String you want to display"
end

string_sub # => "String you want to display"
</pre>

Now, Caleb is giving a me a rash about this, and he's right: this is *not really* 
string substitution, but it *behaves* like string substitution. Is this merely
a semantic quibble? Yes and no, but resolution will have to wait for later.


#### An implementation of `attr_reader` in pure Ruby

The `attr_reader` function should be familiar to everyone with Ruby programming experience. 
Implementing `attr_reader` is a perfect example of what are viewed as macros in 
Ruby, which are implemented using Ruby's metaprogramming capabilities. 

But we're going to call it `rm_attr_reader` to avoid collision with
Ruby's standard library implementation of `attr_reader`. (The `rm_`
*namespaces* our new macros; "rubymacros" after all.) 

<pre class="brush:ruby">
class Module
  # Define our macro here...
  def rm_attr_reader(name)
    define_method(name) do
      instance_variable_get("@#{name}")
    end
  end
end

class Foo
  # And call our macro here...
  rm_attr_reader :bar
  def initialize(arg)
    @bar = arg
  end
end

f = Foo.new "quux"
f.bar # => "quux"
</pre>

You can type all the above into `irb` or put in a file an load it 
into `irb` or however you like to execute your Ruby. 

#### Exercise:

*Write a unit test or spec to verify the behavior of
`rm_attr_reader`, then implement as shown above.*


#### Eval version

That was nice, but kind of complicated, what with the `define_method`
and `instance_variable_get`. We're just trying to define a method and
get the value of an instance variable. Why can't we do that those 
things the normal way?

Let's make it simpler.

Consider a "normal" method with `def` getting a normal instance
variable.

<pre class="brush:ruby">
class Module
  def rm_attr_reader name
    eval "
      def #{name}
        @#{name}
      end
    "
  end
end
</pre>

The eval is now the only unusual contruct in this version.
The drawback with this method is putting everything into a string and
invoking eval. This is bad because 1. calling `eval` is potentially
risky, you will need to watch for code injection; 2. it's kind of ugly. 

#### C Preprocessor (CPP) version

Here's a trick, leveraging the C Preprocessor's macro facility
right in your Ruby code. Check out this example of a text substitution
macro:

<pre class="brush:ruby">
#define RM_ATTR_READER(X)  def X; @##X end

class Foo
  RM_ATTR_READER(bar)
  def initialize(arg)
    @bar = arg
  end 
end

f = Foo.new "quux"
p f.bar
</pre>

One limitation of this technique is that Ruby comments are treated as
preprocessor directives.  For example, `# My Ruby comment` isn't
parseable using CPP.  One could, one supposes, use `c/c++` commenting 
in lieu of Ruby commenting.  Which smacks of jumping from frying 
pan to fire, to stretch a metaphor.

But, our example runs: 

<pre class="brush:bash">
$ gcc -x c -E cpp_attr_reader.rb | ruby
"quux"
</pre>

Nifty!

Ok, maybe not so nifty. As
[Vandervoorde and
Jossutis](http://www.amazon.com/C-Templates-The-Complete-Guide/dp/0201734842)
might say:

<blockquote>
Code is replaced by some "stupid text
replacement mechanism" that has no idea of scope and types.
</blockquote>

So this trick might be cool, or it might be retarded, but I've
(Caleb) seen this (and done it) in the wild.


#### Parse tree substitution

The previous two above, essentially, are variations on string substitution. A
"true" macro (true in the Lisp sense) can't be implemented in Ruby
without extending Ruby syntax, and having (library) code capable of
parsing the extended syntax. The next example uses the rubymacros gem:

<pre class="brush:ruby">
macro rm_attr_reader name
  :(
    def ^name
      ^(RedParse::VarNode["@#{name}"])
    end
  )
end
</pre>

(The syntax highlighter doesn't highlight this correctly because `macro` is 
not a reserved word in Ruby. Try to read it as kind of like a method.
:( ... ) and unary ^ constructs are also part of the new syntactical magic 
that rubymacros adds. You should see them as similar to double-quoted strings
and the string interpolations (#{...}) within them.)

The last three versions of our new version of attr_reader share some common 
characteristics:

* in all cases, an accessor method is defined within a quoted construct.
* somehow that quoted method is interpolated into regular code so it can be 
  executed.
* the quoted method definition contains holes that get filled in by 
  parameters that are passed in at the time of interpolation.
* the quoted code and the values placed in the holes that fill it are data
  structures of some sort -- either strings or parse trees. But they aren't
  code yet... they're things that will turn into code. They're... meta-code.


The advantage of having data structures that represent nascent code is that 
they can be manipulated like any other data before you turn them into code.

The first version is also broadly similar to this approach. But instead of
quoted code with holes in it, it uses magical interpreter methods to
accomplish the same thing. Even with this first version,
the name of the method and the instance variable are represented as strings
which can be manipulated.

### Common Rails "macros"

Rails is rich in macro-like constructions. Consider the `rake routes`
command:

<pre class="brush:bash">
$ rake routes
       foos GET    /foos(.:format) foos#index
            POST   /foos(.:format) foos#create
    new_foo GET    /foos/new(.:format) foos#new
   edit_foo GET    /foos/:id/edit(.:format) foos#edit
        foo GET    /foos/:id(.:format) foos#show
            PUT    /foos/:id(.:format) foos#update
            DELETE /foos/:id(.:format) foos#update
</pre>

We're showing something controlled by a `foo`, whatever that may be.
When you invoke a "route method" using, e.g., `foos_path`, the result is
indistinguishable from a text substitution macro. 

### Generating methods

From Avdi Grimm, a short [screencast on modules and
methods](http://www.youtube.com/watch?v=FlGdAsESNGo).

Paraphrasing, "It's common to refer to class-level methods which
generate other methods and modules as macros."
