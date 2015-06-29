
require "pry"

class Author
	# Author class
	attr_accessor :name, :birth_date, :death_date

	def initialize (name ='Unknown Author', birth = nil, death = nil)
		@name = name 
		@birth_date = birth 
		@death_date = death
	end

	def to_s
		ret = "#{@name} "
		ret += ( @birth_date != nil ? ("(#{@birth_date}") : "(???" )
		ret += ( @death_date != nil ? (" - #{@death_date})"):(")") )
	end

	def ==(arg)
		if arg.class == Author
			@name == arg.name && @birth_date == arg.birth_date && @death_date == arg.death_date
		else
			false
		end
	end

	alias eql? ==
end

#TODO Add type checking
#TODO Add multyple author support
class Book
	attr_accessor :title, :author

	def initialize(title='No Title', author = nil)
		@title = title
		@author = author ? author : Author.new
	end

	def to_s
		"#{@author.name} - \"#{@title}\""
	end

	def ==(arg)
		if arg.class == Book
			@title == arg.title && @author == arg.author
		else
			false
		end
	end

	alias eql? ==

end

class Edition
	attr_accessor :book, :year, :pages

	def initialize( book=nil, year = nil, pages = nil )
		book != nil ? @book = book : @book = Book.new
		@year = year; @pages = pages
	end

	def to_s
		"#{@book.to_s}, #{@year}, #{pages}p."
	end

	def ==(arg)
		if arg.class == Edition
			@book == arg.book && @year == arg.year && @pages == arg.pages
		else
			false
		end
	end

	alias eql? ==

end
