module DiyProf
  class Tracer
    include TimeHelpers

    def initialize(reporter, source_filter: nil)
      @source_filter = source_filter
      @reporter = reporter
      @tracepoints = [:call, :return].collect do |event|
        TracePoint.new(event) do |trace|
          prefix = if trace.defined_class.name
            # regular instance methods
            "#{trace.defined_class.name}#"
          else
            # class methods are defined in singleton superclass, so tidy up the class name
            # here also fall the singleton instance methods, but those don't match the regexp and go through
            trace.defined_class.to_s.sub(/#<Class:(.*)>/,'\1.')
          end
          method_name = "#{prefix}#{trace.method_id}"
          reporter.record(event, method_name, cpu_time) if should_record?(trace.path)
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
      @reporter.result
    end

    def should_record?(location)
      location.match @source_filter || //
    end
  end
end
