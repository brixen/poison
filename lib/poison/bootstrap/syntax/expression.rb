module Poison
  module Syntax
    class Expression < Node
      attr_accessor :expressions

      def initialize(expressions)
        @expressions = expressions
      end

      def to_sexp
        [:expr].concat @expressions.map { |e| e.to_sexp }
      end

      def visit(visitor)
        visitor.expression self
      end
    end
  end
end
