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