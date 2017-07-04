require 'diy_prof/version'
require 'diy_prof/time_helpers'
require 'diy_prof/tracer'
require 'diy_prof/dot_reporter'

module DiyProf
  def self.start_profiling(source_filter: nil)
    @tracer = Tracer.new(DotReporter.new, source_filter: source_filter)
    @tracer.enable
  end

  def self.stop_profiling
    @tracer.disable
    @tracer.result
  end
end
