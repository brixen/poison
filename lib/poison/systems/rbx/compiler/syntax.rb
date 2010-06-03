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
    end

    class Value < Node
      def to_sexp(sexp)
        exp = [:value]
        [:nil, :true, :false, :hex, :int, :real, :imag, :string].each do |sym|
          m = :"#{sym}_value"
          if respond_to? m
            send(m).to_sexp exp
            break
          end
        end
        sexp << exp
      end
    end

    class Literal < Node
      attr_accessor :value

      def self.from(text)
        node = allocate
        node.value = text
        node
      end

      def to_sexp(sexp)
        sexp << [value, nil, nil]
      end
    end

    class NilKind < Literal
      def to_sexp(sexp)
        sexp << [nil, nil, nil]
      end
    end

    class Boolean < Literal
      def to_sexp(sexp)
        exp = [nil, nil]
        if value == "true"
          exp.unshift true
        elsif value == "false"
          exp.unshift false
        end
        sexp << exp
      end
    end

    class Integer < Literal
      def to_sexp(sexp)
        sexp << [Integer(value), nil, nil]
      end
    end

    class Real < Literal
      def to_sexp(sexp)
        sexp << [value.to_f, nil, nil]
      end
    end

    class Imaginary < Literal
    end

    class String < Literal
    end
  end
end
