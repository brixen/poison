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

    def imag(value)
      value + 'i'
    end

    def real(value)
      value.to_f
    end

    def hex(value)
      value.to_i 16
    end

    def int(value)
      value.to_i 10
    end

    def method_missing(sym, *args)
      STDERR.puts "y'all called: #{sym}, #{args.inspect}"
    end

  end
end

require 'poison/bootstrap/parser/ext/parser'
