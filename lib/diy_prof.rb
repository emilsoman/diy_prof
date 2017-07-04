require 'diy_prof/version'
require 'diy_prof/time_helpers'
require 'diy_prof/tracer'
require 'diy_prof/dot_reporter'
require 'tempfile'

module DiyProf
  def self.start_profiling
    @tracer = Tracer.new(DotReporter.new)
    @tracer.enable
  end

  def self.stop_profiling
    @tracer.disable
    @tracer.result
  end

  def self.stop_and_output(dir: nil)
    result = self.stop_profiling
    dir ||= Dir.tmpdir
    f = Tempfile.open('dot')
    f.write result
    f.close
    filename = Time.now.strftime('diy_prof-%Y%m%d-%H%M%S.pdf')
    filepath = File.join(dir, filename)
    cmd = "dot -Tpdf #{f.path} -o #{filepath}"
    success = system(cmd)
    unless success
      filepath.sub!(/\.pdf/, '.txt')
      File.open(filepath, 'w') do |f|
        f.puts "Failed to create graph. Do you have GraphViz installed and in path?"
        f.puts "http://www.graphviz.org/"
        f.puts ""
        f.puts "On macOS try: brew install graphviz"
        f.puts ""
        f.puts "Failed command:"
        f.puts "#{cmd}"
      end
    end
    f.unlink
    filepath
  end
end
