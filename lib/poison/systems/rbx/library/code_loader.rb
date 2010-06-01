module Poison
  class CodeLoader
    def self.execute_script(source)
      compiler = Compiler.new source
      ast = compiler.parse
      p ast
    end
  end
end
