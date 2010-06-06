module Poison
  class SyntaxError < Exception
    def initialize(exc)
      if exc.respond_to? :message
        super exc.message
      else
        super exc
      end
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

    class Message < Node
      def value
        text_value.strip
      end

      def to_sexp(sexp)
        sexp << [:message, [value, nil, nil]]
      end
    end

    class Value < Node
      def to_sexp(sexp)
        exp = [:value]
        elements_to_sexp exp
        sexp << exp
      end
    end

    class Literal < Node
    end

    class NilKind < Literal
      def to_sexp(sexp)
        sexp << [nil, nil, nil]
      end
    end

    class Boolean < Literal
      def to_sexp(sexp)
        exp = [nil, nil]
        if text_value == "true"
          exp.unshift true
        elsif text_value == "false"
          exp.unshift false
        end
        sexp << exp
      end
    end

    class Integer < Literal
      def to_sexp(sexp)
        sexp << [Integer(text_value), nil, nil]
      end
    end

    class Real < Literal
      def to_sexp(sexp)
        sexp << [text_value.to_f, nil, nil]
      end
    end

    class Imaginary < Literal
      def to_sexp(sexp)
        sexp << [text_value, nil, nil]
      end
    end

    class String < Literal
      def to_sexp(sexp)
        sexp << [text_value[1..-2], nil, nil]
      end
    end
  end
end
