module Poison
  class Parser
    def initialize(machine, source)
      @parser = machine.new
      @source = source
    end

    def parse
      begin
        @syntax = @parser.parse @source
      rescue => e
        raise SyntaxError.new(e)
      end

      unless @syntax
        raise SyntaxError.new(@parser.failure_reason)
      end
      @syntax
    end
  end
end
