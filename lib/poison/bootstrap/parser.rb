module Poison
  class Parser
    def initialize
      @error_position = 0
      @statements     = []
      @call_list      = []
      @str1           = ""
      @str2           = ""
    end

    # The #parse method is defined in the parser C extension.

    def parse(string)
      @string = string
      ast = parse_string string
      show_syntax_error unless ast
      ast
    end

    def parse_file(name)
      string = IO.read name
      parse string
    end

    # Parsing callbacks

    def show_syntax_error
      error_line = nil
      count = 0

      @string.each_line do |line|
        count += line.size
        if count > @error_position
          error_line = line
          break
        end
      end

      message = <<-EOM

#{error_line.chomp}
#{" " *(error_line.size - (count - @error_position))}^
EOM
      raise Syntax::SyntaxError, message
    end

    def syntax_error(pos)
      @error_position = pos
    end

    def statement_start(statement)
      @statements = [statement]
    end

    def statement_add(statement)
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
      Syntax::TrueKind.new
    end

    def false_kind
      Syntax::FalseKind.new
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

    def cmp(left, right)
      Syntax::Binary.new :<=>, left, right
    end

    def eq(left, right)
      Syntax::Binary.new :==, left, right
    end

    def neq(left, right)
      Syntax::Binary.new :"!=", left, right
    end

    def gte(left, right)
      Syntax::Binary.new :>=, left, right
    end

    def gt(left, right)
      Syntax::Binary.new :>, left, right
    end

    def lte(left, right)
      Syntax::Binary.new :<=, left, right
    end

    def lt(left, right)
      Syntax::Binary.new :<, left, right
    end

    def pipe(left, right)
      Syntax::Binary.new :|, left, right
    end

    def caret(left, right)
      Syntax::Binary.new :^, left, right
    end

    def amp(left, right)
      Syntax::Binary.new :&, left, right
    end

    def bitl(left, right)
      Syntax::Binary.new :<<, left, right
    end

    def bitr(left, right)
      Syntax::Binary.new :>>, left, right
    end

    def uplus(value)
      Syntax::Unary.new :+, value
    end

    def uminus(value)
      Syntax::Unary.new :-, value
    end

    def wavy(value)
      Syntax::Unary.new :~, value
    end

    def not(value)
      Syntax::Not.new value
    end

    def plus(left, right)
      Syntax::Binary.new :+, left, right
    end

    def minus(left, right)
      Syntax::Binary.new :-, left, right
    end

    def times(left, right)
      Syntax::Binary.new :*, left, right
    end

    def div(left, right)
      Syntax::Binary.new :/, left, right
    end

    def rem(left, right)
      Syntax::Binary.new :%, left, right
    end

    def pow(left, right)
      Syntax::Binary.new :**, left, right
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

    def table(entries)
      Syntax::Table.new entries
    end

    def method_missing(sym, *args)
      STDERR.puts "y'all called: #{sym}, #{args.inspect}"
    end

  end
end

require 'poison/bootstrap/parser/ext/parser'
