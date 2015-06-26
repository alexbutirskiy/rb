require "pry"
require "time"

class Myclass 
	attr_accessor :title, :author, :price

	def initialize title="Unknown", author="Unknown", price=0.0
		@title = title
		@author = author
		@price = Float(price)
	end

	def title=(v)
		@title = v
	end

	def ==(other)
		if other.class == Myclass
			@author == other.author && @title == other.title && @price == other.price
		else
			false
		end
	end

	alias eql? ==

	def sss a
		self.title= a
	end

	def info arg=0
		puts "This class has been writen by me"
		puts self
		self
	end

	def [](index)
		case index
		when 0, "title"; @title
		when 1, "author"; @author
		when 2, "price"; @price
		else nil
		end
	end

	def to_s
		"Title: #{@title}\tAuthor: #{@author}\tPrice: #{@price}"
	end
end

class Test

end

c = Myclass.new
d = Myclass.new
t = Test.new
binding.pry
puts "Work finished"