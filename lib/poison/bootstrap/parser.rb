module Poison
  class Parser
    def initialize
      @statements = []
      @call_list  = []
      @str1       = ""
    end

    # The #parse method is defined in the parser C extension.

    def parse_file(name)
      string = IO.read name
      parse string
    end

    # Parsing callbacks

    def syntax_error
      raise Syntax::SyntaxError
    end

    def statement(statement)
      @statements << statement
    end

    def statements(values)
      Syntax::Statements.new values
    end

    def call_list(expr)
      @call_list = []
      @call_list << expr
    end

    def call_append(expr, value)
      expr << value
    end

    def nil_kind
      Syntax::NilKind.new
    end

    def true_kind
      Syntax::Boolean.new true
    end

    def false_kind
      Syntax::Boolean.new false
    end

    def imag(value)
      Syntax::Imaginary.new value.to_f
    end

    def real(value)
      Syntax::Real.new value.to_f
    end

    def hex(value)
      Syntax::Integer.new value.to_i 16
    end

    def int(value)
      Syntax::Integer.new value.to_i 10
    end

    def value(value)
      Syntax::Value.new value
    end

    def expr(value)
      Syntax::Expression.new value
    end

    def path(name)
      Syntax::Path.new name
    end

    def pathq(name)
      Syntax::PathQuery.new name
    end

    def query(name)
      Syntax::Query.new name
    end

    def message(name)
      if name.kind_of? Syntax::Message
        name
      else
        Syntax::Message.new name
      end
    end

    def assign(name, value)
      Syntax::Assign.new name, value
    end

    def op_or(left, right)
      Syntax::Or.new left, right
    end

    def op_and(left, right)
      Syntax::And.new left, right
    end

    def pipe(left, right)
      Syntax::Pipe.new left, right
    end

    def caret(left, right)
      Syntax::Caret.new left, right
    end

    def amp(left, right)
      Syntax::Amp.new left, right
    end

    def bitl(left, right)
      Syntax::BitLeft.new left, right
    end

    def bitr(left, right)
      Syntax::BitRight.new left, right
    end

    def plus(left, right)
      Syntax::Plus.new left, right
    end

    def minus(left, right)
      Syntax::Minus.new left, right
    end

    def times(left, right)
      Syntax::Times.new left, right
    end

    def div(left, right)
      Syntax::Div.new left, right
    end

    def rem(left, right)
      Syntax::Rem.new left, right
    end

    def pow(left, right)
      Syntax::Pow.new left, right
    end

    def str1(ignored)
      Syntax::UnescapedString.new @str1
    end

    def str1_clear(ignored)
      @str1 = ""
    end

    def str1_add(string)
      @str1 << string
    end

    def str2(ignored)
      Syntax::EscapedString.new @str2
    end

    def str2_clear(ignored)
      @str2 = ""
    end

    def str2_add(string)
      @str2 << string
    end

    def method_missing(sym, *args)
      STDERR.puts "y'all called: #{sym}, #{args.inspect}"
    end

  end
end

require 'poison/bootstrap/parser/ext/parser'
