$:<< File.join(File.dirname(__FILE__), "../lib")
require 'diy_prof'

### Begin sample program ###
def main
  3.times do
    find_many_square_roots
    find_many_squares
  end
end

def find_many_square_roots
  5000.times{|i| Math.sqrt(i)}
end

def find_many_squares
  5000.times{|i| i**2 }
end
### End sample program ###

tracer = DiyProf::Tracer.new(clock_type: :cpu)
tracer.enable
main
tracer.disable
