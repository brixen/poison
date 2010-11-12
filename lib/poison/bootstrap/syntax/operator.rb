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

    class Assign < Node
      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_sexp
        [:assign, @name.to_sexp, @value.to_sexp]
      end

      def visit(visitor)
        visitor.assign self
      end
    end

    class Or < BinaryOperator
      def sexp_name
        :or
      end

      def visit(visitor)
        visitor.op_or self
      end
    end

    class And < BinaryOperator
      def sexp_name
        :and
      end

      def visit(visitor)
        visitor.op_and self
      end
    end

    class Pipe < BinaryOperator
      def sexp_name
        :pipe
      end

      def visit(visitor)
        visitor.pipe self
      end
    end

    class Caret < BinaryOperator
      def sexp_name
        :caret
      end

      def visit(visitor)
        visitor.caret self
      end
    end

    class Amp < BinaryOperator
      def sexp_name
        :amp
      end

      def visit(visitor)
        visitor.amp self
      end
    end

    class BitLeft < BinaryOperator
      def sexp_name
        :bitl
      end

      def visit(visitor)
        visitor.bit_left self
      end
    end

    class BitRight < BinaryOperator
      def sexp_name
        :bitr
      end

      def visit(visitor)
        visitor.bit_right self
      end
    end

    class Plus < BinaryOperator
      def sexp_name
        :plus
      end

      def visit(visitor)
        visitor.plus self
      end
    end

    class Minus < BinaryOperator
      def sexp_name
        :minus
      end

      def visit(visitor)
        visitor.minus self
      end
    end

    class Times < BinaryOperator
      def sexp_name
        :times
      end

      def visit(visitor)
        visitor.times self
      end
    end

    class Div < BinaryOperator
      def sexp_name
        :div
      end

      def visit(visitor)
        visitor.div self
      end
    end

    class Rem < BinaryOperator
      def sexp_name
        :rem
      end

      def visit(visitor)
        visitor.rem self
      end
    end

    class Pow < BinaryOperator
      def sexp_name
        :pow
      end

      def visit(visitor)
        visitor.pow self
      end
    end
  end
end
