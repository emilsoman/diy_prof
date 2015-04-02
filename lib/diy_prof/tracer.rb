module DiyProf
  class Tracer
    include TimeHelpers

    def initialize(logger)
      @logger = logger
      @tracepoints = [:call, :return].collect do |event|
        TracePoint.new(event) do |trace|
          logger.log(event, trace.method_id, cpu_time)
        end
      end
    end
    def enable
      @tracepoints.each(&:enable)
    end

    def disable
      @tracepoints.each(&:disable)
    end

    def result
      @logger.result
    end
  end
end
