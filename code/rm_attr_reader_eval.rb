#!/usr/bin/env ruby

class Module
  def rm_attr_reader name
    eval "
      def #{name}
        @#{name}
      end
    "
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
    puts f.methods.include? :rm_attr_reader
    #expect(f.bar).to eq "quux"
  end
end
