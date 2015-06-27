require "pry"

class Author
	attr_accessor :name, :birth_date, :death_date

	def initialize (name ='Unknown Author', birth = nil, death = nil)
		@name = name 
		@birth_date = birth 
		@death_date = death
	end

	def to_s
		ret = "#{@name} "
		ret += ( @birth_date != nil ? ("(#{@birth_date} - ") : "(??? - " )
		ret += ( @death_date != nil ? ("#{@death_date})"):("???)") )
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

class Book
	attr_accessor :title, :author

	def initialize(title='No tittle', author = nil)
		@title = title
		@author = author ? author : Author.new
	end

	def to_s
		"#{@author.name} - #{@title}"
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

if __FILE__ == $0
a = Author.new("Leo Tolstoy", 1828, 1910)
b = Author.new
c = Author.new("Levi Matthew"); c.death_date = 74

bb = Book.new("War and Peace", a)

binding.pry
puts
end