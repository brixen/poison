module Poison
  class CodeLoader
    def self.execute_file(name)
      source = File.read name
      execute_script source
    end

    def self.execute_script(source)
      compiler = Compiler.new source
      ast = compiler.parse

      # just give some output for now
      ast.graph
    end
  end
end
