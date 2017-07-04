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

DiyProf.start_profiling
main
pdf = DiyProf.stop_and_output(format: :pdf, dir: '.')
system("open #{pdf}")


