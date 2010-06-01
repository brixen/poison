module Poison
  class SyntaxError < Exception
    def initialize(exc)
      super exc.message
    end
  end

  class Syntax < Node
    class Script < Node
      def to_sexp(sexp=[])
        sexp << :script
        statements.to_sexp sexp
        sexp
      end
    end

    class Statements < Node
      def to_sexp(sexp)
        elements_to_sexp sexp
      end
    end

    class Expression < Node
      def to_sexp(sexp)
        exp = [:expr]
        elements_to_sexp exp
        sexp << exp
      end
    end

    class Boolean < Node
    end

    class NilKind < Node
      def to_sexp(sexp)
        sexp << [:nil]
      end
    end

    class Message < Node
    end

    class Value < Node
      def to_sexp(sexp)
        exp = [:value]
        if respond_to? :int
          int.to_sexp exp
        end
        sexp << exp
      end
    end

    class Immediate < Node
      attr_accessor :value

      def self.from(text)
        node = allocate
        node.value = text
        node
      end
    end

    class Integer < Immediate
      def to_sexp(sexp)
        sexp << [value.to_i, nil, nil]
      end
    end
  end
end
