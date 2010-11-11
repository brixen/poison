module Poison
  class Parser
    def initialize
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

    def statements(values)
      Syntax::Statements.new values
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

    def path(name)
      "/" + name
    end

    def message(name)
      name
    end

    def method_missing(sym, *args)
      STDERR.puts "y'all called: #{sym}, #{args.inspect}"
    end

  end
end

require 'poison/bootstrap/parser/ext/parser'
