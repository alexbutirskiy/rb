require 'pry'

class A
  def initialize
    @a = 11
    @@a = 22
    a = 33
    puts 'Init class'
  end
  @a = 1
  @@a = 2
  a = 3
end

module M
  def self.included base
    puts "#{self} included in #{base}"
#    binding.pry
    base.send :prepend, Init
  end

  module Init
    def initialize *args
#      binding.pry
      puts 'Init module'
#      super *args
    end
  end

  def get_a
    binding.pry
    @@a
  end

  def A.get_aa
    @aa
  end

  def get__a
    a
  end

end

class A
  include M
end

a = A.new
#puts A.get_a
#puts a.get_aa
#puts a.get__a
