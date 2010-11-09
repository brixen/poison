module Poison
  class Parser
    def initialize
    end

    def parse_string(string)
      parse string
    end

    def parse_file(name)
      string = IO.read name
      parse string
    end

    def method_missing(sym, *args)
      STDERR.puts "y'all called: #{sym}, #{args.join(", ")}"
    end

  end
end

require 'poison/bootstrap/parser/ext/parser'
