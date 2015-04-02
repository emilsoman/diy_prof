module DiyProf

  CallInfo = Struct.new(:name, :time)
  MethodInfo = Struct.new(:time, :count)

  class DotLogger
    def initialize
      @call_stack = []
      @calls = {}
      @methods = {}
    end

    def log(event, method_id, time)
      case event
      when :call
        @call_stack << CallInfo.new(method_id, time)
      when :return
        # Return cannot be the first event in the call stack
        return if @call_stack.empty?

        method = @call_stack.pop
        method.time = time - method.time
        log_method(method)
      end
    end

    def result
      dot_notation
    end

    private

    def log_method(method)
      parent = @call_stack.last

      @methods[method.name] ||= MethodInfo.new(0, 0)
      @methods[method.name].time += method.time
      @methods[method.name].count += 1

      if parent = @call_stack.last
        @calls[parent.name] ||= {}
        @calls[parent.name][method.name] ||= 0

        @calls[parent.name][method.name] += 1
      end
    end

    def dot_notation
      dot = %Q(
        digraph G {
          #{graph_nodes}
          #{graph_links}
        }
      )
    end

    def graph_nodes
      nodes = ""
      @methods.each do |name, method_info|
        nodes << "#{name} [label=\"#{name}\\ncalls: #{method_info.count}\\ntime: #{method_info.time}\"];\n"
      end
      nodes
    end

    def graph_links
      links = ""
      @calls.each do |parent, children|
        children.each do |child, count|
          links << "#{parent} -> #{child} [label=\" #{count}\"];\n"
        end
      end
      links
    end
  end
end
