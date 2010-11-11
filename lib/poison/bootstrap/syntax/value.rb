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

    class Boolean < Value
    end

    class Integer < Value
    end

    class Real < Value
    end

    class Imaginary < Value
    end

    class String < Value
    end

    class NilKind < Value
      def initialize
        @value = nil
      end
    end
  end
end
