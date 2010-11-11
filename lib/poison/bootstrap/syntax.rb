require 'poison/bootstrap/syntax/node'
require 'poison/bootstrap/syntax/value'
require 'poison/bootstrap/syntax/expression'
require 'poison/bootstrap/syntax/operator'
require 'poison/bootstrap/syntax/message'

module Poison
  module Syntax
    class SyntaxError < Exception; end

    def initialize(parse_tree)
      @syntax = parse_tree.node
    end

    def to_sexp
      @syntax.to_sexp
    end

    def graph
      @syntax.graph
    end

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
    end

    class Assign < Node
      def initialize(left, right)
        @left = left
        @right = right
      end

      def to_sexp
        [:assign, @left.to_sexp, @right.to_sexp]
      end
    end

    class Or < BinaryOperator
      def sexp_name
        :or
      end
    end

    class And < BinaryOperator
      def sexp_name
        :and
      end
    end

    class Pipe < BinaryOperator
      def sexp_name
        :pipe
      end
    end

    class Caret < BinaryOperator
      def sexp_name
        :caret
      end
    end

    class Amp < BinaryOperator
      def sexp_name
        :amp
      end
    end

    class Bitl < BinaryOperator
      def sexp_name
        :bitl
      end
    end

    class Bitr < BinaryOperator
      def sexp_name
        :bitr
      end
    end

    class Plus < BinaryOperator
      def sexp_name
        :plus
      end
    end

    class Minus < BinaryOperator
      def sexp_name
        :minus
      end
    end

    class Times < BinaryOperator
      def sexp_name
        :times
      end
    end

    class Div < BinaryOperator
      def sexp_name
        :div
      end
    end

    class Rem < BinaryOperator
      def sexp_name
        :rem
      end
    end

    class Pow < BinaryOperator
      def sexp_name
        :pow
      end
    end


  end
end
