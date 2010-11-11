module Poison
  module Syntax
    class UnaryOperator < Node
      def initialize(value)
        @value = value
      end

      def to_sexp
        [sexp_name, @value]
      end
    end

    class BinaryOperator < Node
      def initialize(left, right)
        @left = left
        @right = right
      end

      def to_sexp
        [sexp_name, @left.to_sexp, @right.to_sexp]
      end
    end
  end
end
