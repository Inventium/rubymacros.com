#!/usr/bin/env ruby

class Module
  def rm_attr_reader name
    define_method name do
      instance_variable_get("@#{name}")
    end
  end
end

class Foo
  rm_attr_reader :bar
  def initialize arg
    @bar = arg
  end
end

describe "self" do
  it "gets @bar from Foo" do
    f = Foo.new "quux"
    expect(f.bar).to eq "quux"
  end
end
