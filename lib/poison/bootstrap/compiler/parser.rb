module Poison
  class Parser
    def initialize(machine, source)
      @parser = machine.new
      @source = source
    end

    def parse
      @syntax = Syntax.new @parser.parse(@source)

      unless @syntax
        raise SyntaxError.new(@parser.failure_reason)
      end
      @syntax
    end
  end
end
