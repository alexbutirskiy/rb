require 'pry'

puts "Start"

def M
  a=1
  b=2

  return a, b
end

c, d = M()

a="test string"

def a.up
  self.upcase
end

binding.pry

puts "Finish"


