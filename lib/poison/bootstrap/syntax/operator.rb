module Poison
  module Syntax
    class Unary < Node
      attr_accessor :op, :value

      def initialize(op, value)
        @op = op
        @value = value
        @map = {
          :- => :uminus,
          :+ => :uplus,
          :~ => :wavy,
        }
      end

      def sexp_name
        @map[@op]
      end

      def to_sexp
        [sexp_name, @value.to_sexp]
      end

      def visit(visitor)
        visitor.send sexp_name, self
      end
    end

    class Not < Node
      attr_accessor :value

      def initialize(value)
        @value = value
      end

      def to_sexp
        [:not, @value.to_sexp]
      end
    end

    class Binary < Node
      attr_accessor :op, :left, :right

      def initialize(op, left, right)
        @op = op
        @left = left
        @right = right
        @map = {
          :+    => :plus,
          :-    => :minus,
          :*    => :times,
          :/    => :div,
          :%    => :rem,
          :|    => :pipe,
          :^    => :caret,
          :&    => :amp,
          :**   => :pow,
          :>>   => :bitr,
          :<<   => :bitl,
          :"!=" => :neq,
          :==   => :eq,
          :<=>  => :cmp,
          :<=   => :lte,
          :<    => :lt,
          :>=   => :gte,
          :>    => :gt,
        }
      end

      def sexp_name
        @map[@op]
      end

      def to_sexp
        [sexp_name, @left.to_sexp, @right.to_sexp]
      end

      def visit(visitor)
        visitor.send sexp_name, self
      end
    end

    class Assign < Node
      attr_reader :name, :value

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

    class Connective < Node
      attr_accessor :left, :right

      def initialize(left, right)
        @left = left
        @right = right
      end

      def to_sexp
        [sexp_name, @left.to_sexp, @right.to_sexp]
      end

      def visit(visitor)
        visitor.send sexp_name, self
      end
    end

    class Or < Connective
      def sexp_name
        :or
      end
    end

    class And < Connective
      def sexp_name
        :and
      end
    end
  end
end
