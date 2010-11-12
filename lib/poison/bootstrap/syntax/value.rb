module Poison
  module Syntax
    class Value < Node
      attr_accessor :value

      def initialize(value)
        @value = value
      end

      def to_sexp
        [:value, @value.to_sexp]
      end

      def visit(visitor)
        visitor.value self
      end
    end

    class Literal < Node
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

      def visit(visitor)
        visitor.nil_kind self
      end
    end

    class Boolean < Literal
      def visit(visitor)
        visitor.boolean self
      end
    end

    class Integer < Literal
      def visit(visitor)
        visitor.integer self
      end
    end

    class Real < Literal
      def visit(visitor)
        visitor.real self
      end
    end

    class Imaginary < Literal
      def to_sexp
        ["#{@value}i", nil, nil]
      end

      def visit(visitor)
        visitor.imaginary self
      end
    end

    class UnescapedString < Literal
      def visit(visitor)
        visitor.unescaped_string self
      end
    end

    class EscapedString < Literal
      def visit(visitor)
        visitor.escaped_string self
      end
    end

    class Table < Literal
      def initialize(entries)
        @entries = entries.dup
      end

      def to_sexp
        [:table].concat @entries.map { |e| e.to_sexp }
      end

      def visit(visitor)
        visitor.table self
      end
    end
  end
end
