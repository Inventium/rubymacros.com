# 1 "cpp_attr_reader.rb"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "cpp_attr_reader.rb"



class Foo
  def bar; @bar end
  def initialize(arg)
    @bar = arg
  end
end

f = Foo.new "quux"
f.bar
