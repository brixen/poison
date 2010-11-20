module Poison
  module Syntax
    class Closure < Node
      attr_accessor :table, :statements

      def initialize(table, statements)
        @table = table
        @statements = Array(statements)
      end

      def to_sexp
        body = [@table ? @table.to_sexp : nil]
        body.concat @statements.map { |s| s.to_sexp }

        [:closure, body]
      end
    end
  end
end
