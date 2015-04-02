$:<< File.join(File.dirname(__FILE__), "../lib")
require 'diy_prof'
require 'tempfile'

include DiyProf::TimeHelpers

# Method with CPU bound instructions
def cpu_bound_method
  20000.times{|i| Math.sqrt(i)}
end

# Method with IO bound instructions
def io_bound_method
  1000.times do |i|
    Tempfile.create('file') do |f|
      f.puts(i)
    end
  end
end

puts "CPU bound instructions:"
wt1,ct1 = wall_time, cpu_time
cpu_bound_method
wt2, ct2 = wall_time, cpu_time

puts "Wall time = #{wt2 - wt1}"
puts "CPU time = #{ct2 - ct1}"


puts "IO bound instructions:"
wt1,ct1 = wall_time, cpu_time
io_bound_method
wt2, ct2 = wall_time, cpu_time

puts "Wall time = #{wt2 - wt1}"
puts "CPU time = #{ct2 - ct1}"
