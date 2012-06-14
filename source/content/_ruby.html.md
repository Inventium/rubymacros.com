
### What Ruby calls macros

From the Pickaxe (4th ed., p. 378), we have macros defined as 
Ruby methods which generate code "behind the scenes" by 
turning small bits of code into larger bits of code.


The simplest Ruby "macro", a sort of string substitution:


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


#### Eval version

That was nice, but kind of complicated, what with the `define_method`
and all. We can make it simpler, so let's.

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

The drawback with this method is putting everything into a string and
invoking eval. This is bad because 1. calling `eval` is potentially
risky, you will need to watch for code injection; 2. it's kind of ugly. 

#### C Preprocessor (CPP) version

Here's a cool trick, leveraging the C Preprocessor's macro facility
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
in lieue of Ruby commenting.  Which smacks of jumping from frying 
pan to fire, to stretch a metaphor.

But, our example runs: 

<pre class="brush:bash">
$ gcc -x c -E cpp_attr_reader.rb | ruby
"quux"
</pre>

Nifty!

Ok, maybe not so nifty. As Vandervoorde and Jossutis might say:

<blockquote>
Code is replaced by some "stupid text
replacement mechanism" that has no idea of scope and types.
</blockquote>

#### Parse tree substitution

The previous two above, essentially, are variations on string substitution. A
"true" macro (true in the Lisp sense) can't be implemented in Ruby
without extending Ruby syntax, and having (library) code capable of
parsing the extended syntax. The next example uses the rubymacros gem:

<pre class="brush:ruby">
macro rm_attr_reader name
  :(
    def ^name
      ^(RedParse::VarNode["@"+name])
    end
  )
end
</pre>

The first problem is obvious: `macro` is not a reserved word in Ruby,
hence the syntax highlighter doesn't highlight the syntax correctly. The 
:( ... ) and unary ^ constructs are also non-standard.

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

We're showing something controlled by an `foo`, whatever that may be.
When you invoke a "route method" using, e.g., `foos_path`, the result is
indistinguishable from a text substitution macro. 


