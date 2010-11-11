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

    class BitLeft < BinaryOperator
      def sexp_name
        :bitl
      end
    end

    class BitRight < BinaryOperator
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
