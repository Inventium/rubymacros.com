#!/usr/bin/env ruby

class Module

  def rm_attr_reader(name)
    define_method(name) do
      instance_variable_get("@#{name}")
    end
  end

end

