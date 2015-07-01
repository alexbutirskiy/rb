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