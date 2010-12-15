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
    #
    # A table is a container with index-access or key-access
    #
    #   foo = ("bar", "baz") # a list
    #   foo at(0)     # => "bar"
    #
    #   foo = (bar = "baz")  # a dict
    #   foo at("bar") # => "baz"
    #
    # From _why's Potion, it's unclear what the behaviour should
    # be for a table created with a mix of assign and values
    #
    #   foo = (bar = "baz", "bat")
    #   foo at(0)     # => nil
    #   foo at('bar') # => "baz"
    #   foo at(1)     # => nil
    #
    # So what we do for Poison is this: if we find any of the
    # table expressions to be an assignment, then the table is
    # backed by a ruby Hash, otherwise its backed by a ruby List.
    #
    def table(node)
      if node.entries.any? { |e| e.kind_of?(Syntax::Assign) }
        # A hash, all entries not being an assign, get a value of nil

        g.push_cpath_top
        g.find_const :Hash
        g.push node.entries.size
        g.send :new_from_literal, 1

        node.entries.each do |entry|
          g.dup
          if entry.kind_of? Syntax::Assign
            # if key is a single name, we use its string value as key
            if  entry.name.expressions.size == 1 &&
                entry.name.expressions.first.kind_of?(Syntax::Message)
              g.push_literal entry.name.expressions.first.name
            else
              entry.name.visit self
            end
            entry.value.visit self
          else
            entry.visit self
            g.push_nil
          end
          g.send :[]=, 2
          g.pop
        end
      else
        # A list
        node.entries.each { |entry| entry.visit self }
        g.make_array node.entries.size
      end

      g.push_cpath_top
      g.find_const :Table
      g.swap
      g.send :new, 1
    end
  end
end
