module DiyProf
  class Tracer
    include TimeHelpers

    def initialize(clock_type: :cpu)
      @tracepoint = TracePoint.new(:call, :return) do |trace|
        time = clock_type == :wall ? wall_time : cpu_time
        printf("%-20s:%-20s%-20s\n", time, trace.event, trace.method_id)
      end
    end
    def enable
      @tracepoint.enable
    end

    def disable
      @tracepoint.disable
    end
  end
end
