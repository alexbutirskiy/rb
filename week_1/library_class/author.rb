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