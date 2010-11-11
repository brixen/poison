require 'poison/bootstrap/syntax/node'
require 'poison/bootstrap/syntax/value'
require 'poison/bootstrap/syntax/expression'
require 'poison/bootstrap/syntax/operator'
require 'poison/bootstrap/syntax/message'

module Poison
  module Syntax
    class SyntaxError < Exception; end

    def initialize(parse_tree)
      @syntax = parse_tree.node
    end

    def to_sexp
      @syntax.to_sexp
    end

    def graph
      @syntax.graph
    end

    class Script < Node
      attr_accessor :statements

      def initialize(statements)
        @statements = statements
      end

      def to_sexp
        [:script, @statements.to_sexp]
      end
    end

    class Statements < Node
      def initialize(statements)
        @statements = Array(statements)
      end

      def to_sexp
        if @statements.size == 1
          @statements.first.to_sexp
        else
          @statements.map { |s| s.to_sexp }
        end
      end
    end
  end
end
