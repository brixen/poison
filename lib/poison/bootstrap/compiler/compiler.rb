module Poison
  class Compiler
    attr_reader :g

    def initialize
      @g = Generator.new
    end

    def compile(poison)
      if poison.kind_of? Syntax::Node
        ast = poison
      else
        ast = Parser.new.parse poison
      end

      g.name = :call
      g.file = :"(poison)"
      g.set_line 1

      g.required_args = 0
      g.total_args = 0
      g.splat_index = nil

      g.local_count = 0
      g.local_names = []

      ast.visit self
      g.ret
      g.close

      g.encode
      cm = g.package ::Rubinius::CompiledMethod
      puts cm.decode if $DEBUG

      code = Poison::Code.new
      ss = ::Rubinius::StaticScope.new Object
      ::Rubinius.attach_method g.name, cm, ss, code

      code
    end

    def statements(node)
      node.statements.each { |s| s.visit self }
    end

    def expression(node)
      node.expressions.each { |e| e.visit self }
    end

    def value(node)
      node.value.visit self
    end

    def nil_kind(node)
      g.push :nil
    end

    def true_kind(node)
      g.push :true
    end

    def false_kind(node)
      g.push :false
    end

    def unescaped_string(node)
      g.push_literal node.value
    end

    def escaped_string(node)
      g.push_literal node.value
    end

    def message(node)
      g.pn_send node.name
    end

    def plus(node)
    end

    def integer(node)
      g.push_literal node.value
    end

    def real(node)
      g.push_literal node.value
    end

    def imaginary(node)
      g.push_literal node.value
    end

    # Creates a Table object.
    def table(node)
      g.push_cpath_top
      g.find_const :Table
      g.send :new, 0

      node.entries.each_with_index do |entry, index|
        g.dup
        g.push_literal index

        if entry.kind_of?(Syntax::Assign)
          if entry.name.kind_of?(Syntax::Expression) &&
             entry.name.expressions.first.kind_of?(Syntax::Message)
            g.push_literal entry.name.expressions.first.name.to_sym
          else
            entry.name.visit self
          end
          entry.value.visit self

          g.send :put_key, 3
        else
          entry.visit self
          g.send :put_val, 2
        end
        g.pop
      end
    end
  end
end
