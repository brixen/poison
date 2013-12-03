module Poison
  class Compiler
    class Generator < Rubinius::ToolSet::Runtime::Generator
      def pn_send(selector, args=0)
        send :"pn:#{selector}", args
      end
    end
  end
end
