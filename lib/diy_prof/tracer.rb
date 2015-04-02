module DiyProf
  class Tracer
    include TimeHelpers

    def initialize
      @tracepoints = [:call, :return].collect do |event|
        TracePoint.new(event) do |trace|
          printf("%-20s:%-20s%-20s\n", cpu_time, event, trace.method_id)
        end
      end
    end
    def enable
      @tracepoints.each(&:enable)
    end

    def disable
      @tracepoints.each(&:disable)
    end
  end
end
