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
    end

    class Literal < Node
      def initialize(value)
        @value = value
      end

      def to_sexp
        [@value, nil, nil]
      end
    end

    class Boolean < Literal
    end

    class Integer < Literal
    end

    class Real < Literal
    end

    class Imaginary < Literal
      def to_sexp
        ["#{@value}i", nil, nil]
      end
    end

    class UnescapedString < Literal
    end

    class EscapedString < Literal
    end

    class NilKind < Literal
      def initialize
        @value = nil
      end
    end
  end
end
