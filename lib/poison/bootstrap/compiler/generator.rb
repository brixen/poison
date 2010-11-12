module Poison
  class Compiler
    class Generator < Rubinius::Generator
      def push_pn_true
        push :true
      end

      def pn_send(selector, args=0)
        send :"pn:#{selector}", args
      end
    end
  end
end
