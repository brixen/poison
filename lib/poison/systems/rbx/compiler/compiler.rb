module Poison
  class Compiler
    def self.treetop_parser
      unless @treetop_parser
        require 'rubygems'
        require 'treetop'
        require 'poison/systems/rbx/compiler/grammar'
        require 'poison/systems/rbx/compiler/node'
        @treetop_parser = PoisonParser
      end

      @treetop_parser
    end

    # Sets the parser machine to use. +parser+ should
    # be :treetop_parser or :pegarus_parser.
    def self.set_parser(parser)
      @parser = send parser
    end

    # Returns the parser that the compiler has been
    # configured to use. Defaults to :treetop_parser.
    def self.get_parser
      @parser ||= treetop_parser
    end

    set_parser :treetop_parser

    def self.parse_file(file, line=1)
      compiler = new IO.read(file), line
      compiler.parse
    end

    attr_accessor :source, :line, :parser

    def initialize(source, line=1)
      @source = source
      @line = line
      @parser = Parser.new self.class.get_parser, source
    end

    def parse
      @parser.parse
    end
  end
end
