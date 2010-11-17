module Poison
  module Syntax
    class Script < Node
      attr_accessor :statements

      def initialize(statements)
        @statements = statements
      end

      def to_sexp
        [:script, @statements.to_sexp]
      end
    end

    class Statements < Node
      attr_accessor :statements

      def initialize(statements)
        @statements = Array(statements)
      end

      def to_sexp
        if @statements.size == 1
          @statements.first.to_sexp
        else
          @statements.map { |s| s.to_sexp }
        end
      end

      def visit(visitor)
        visitor.statements self
      end
    end
  end
end
