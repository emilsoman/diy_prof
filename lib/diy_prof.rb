require 'diy_prof/version'
require 'diy_prof/time_helpers'
require 'diy_prof/tracer'
require 'diy_prof/dot_reporter'
require 'tempfile'

module DiyProf
  def self.start_profiling(source_filter: nil)
    @tracer = Tracer.new(DotReporter.new, source_filter: source_filter)
    @tracer.enable
  end

  def self.stop_profiling
    @tracer.disable
    @tracer.result
  end

  def self.stop_and_output(dir: nil, format: :dot)
    result = self.stop_profiling
    dir ||= Dir.tmpdir
    filename = Time.now.strftime("diy_prof-%Y%m%d-%H%M%S.#{format}")
    filepath = File.join(dir, filename)

    case format
    when :pdf
      output_pdf(filepath, result)
    else
      # any other format name we just output the dot source
      output_dot(filepath, result)
    end
    filepath
  end

  def self.output_pdf(filepath, data)
    f = Tempfile.open('dot')
    f.write data
    f.close
    cmd     = "dot -Tpdf #{f.path} -o #{filepath}"
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
  end


  def self.output_dot(filepath, data)
    File.open(filepath, 'w') do |f|
      f.puts data
    end
  end
end
