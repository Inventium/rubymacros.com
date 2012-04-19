
#define RM_ATTR_READER(X)  def X; @##X end

class Foo
  RM_ATTR_READER(bar)
  def initialize(arg)
    @bar = arg
  end 
end

f = Foo.new "quux"
p f.bar
