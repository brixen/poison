module Poison
  class SyntaxError < Exception; end

  class Syntax
    def initialize(parse_tree)
      @syntax = parse_tree.node
    end

    def to_sexp
      @syntax.to_sexp
    end

    def graph
      @syntax.graph
    end

    class Node
      def to_sexp
      end

      def graph
        Rubinius::AST::AsciiGrapher.new(self, Node).print
      end
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
        @statements = statements
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

    class BinaryOperator
      def initialize(left, right)
        @left = left
        @right = right
      end

      def to_sexp
        [sexp_name, @left.to_sexp, @right.to_sexp]
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

    class Expression < Node
      attr_accessor :expression

      def initialize(expression)
        @expression = expression
      end

      def to_sexp
        [:expr].concat @expression.map { |e| e.to_sexp }
      end
    end

    class Message < Node
      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def to_sexp
        [:message, [@name, nil, nil]]
      end
    end

    class Value < Node
      attr_accessor :value

      def initialize(value)
        @value = value
      end

      def to_sexp
        [:value, @value.to_sexp]
      end
    end

    class Literal < Node
      attr_accessor :value

      def initialize(value)
        @value = value
      end

      def to_sexp
        [@value, nil, nil]
      end
    end

    class NilKind < Literal
      def initialize
        @value = nil
      end
    end

    class Boolean < Literal
    end

    class Integer < Literal
    end

    class Real < Literal
    end

    class Imaginary < Literal
    end

    class String < Literal
    end
  end
end
