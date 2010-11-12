module Poison
  class CodeLoader
    # Accepts either a String or a Poison::Syntax node,
    # compiles it, and executes it.
    def self.execute(poison)
      code = Compiler.new.compile poison
      code.call
    end

    # Takes a filename, loads it and executes it.
    def self.execute_file(name)
      source = File.read name
      execute source
    end
  end
end
