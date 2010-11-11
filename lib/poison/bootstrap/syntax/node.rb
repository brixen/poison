module Poison
   module Syntax
    class Node
      def to_sexp
      end

      def graph
        Rubinius::AST::AsciiGrapher.new(self, Node).print
      end
    end
  end
end
