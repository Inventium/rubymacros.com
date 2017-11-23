#!/usr/bin/env ruby

# From https://pragmaticstudio.com/blog/2015/4/14/ruby-macros

# Not sure is the following is a quote from someone else or something
# I wrote up for myself:
# examine the function which is to be a closure. there are arguments
# passed in, local variables, possibly global or class variables,
# lastly, variables which are defined outside the closure in some way,
# but are used within the closure.

class Movie
  def self.has_many(name)
    puts "#{self} has many #{name}"

    def reviews
      # puts "SELECT...#{name}"
      puts "SELECT..."
      puts "Returning reviews..."
      []
    end
  end

  # This gets executed when the class is loaded
  #has_many :reviews
  has_many(:reviews)
end

movie = Movie.new
movie.reviews
