
### What Ruby calls macros

From the Pickaxe (4th ed., p. 378), we have macros defined as 
Ruby methods which generate code "behind the scenes" by 
turning small bits of code into larger bits of code.

(Add more bits here, briefly summarizing without going into much
detail.)

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


#### C Preprocessor (CPP) version

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

One limitation of this technique is that Ruby comments are "preprocessed" as 
well... except that outside of serendipitous use of predefined CPP directives,
won't parse. But even if it did parse, the odds of having it do what you want
are pretty low. Like, zero low.

One could, one supposes, use `c/c++` commenting in lieue of Ruby commenting.
Which smacks of jumping from frying pan to fire, to stretch a metaphor.

<pre class="brush:bash">
$ gcc -x c -E cpp_attr_reader.rb | ruby
cpp_attr_reader.rb:5:1: error: pasting "@" and "bar" does not give a valid preprocessing token
"quux"
</pre>

#### Eval version
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

#### Parse subs
<pre class="brush:ruby">
macro rm_attr_reader name
  :(
    def ^name
      ^(RedParse::VarNode["@"+name])
    end
  )
end
</pre>
