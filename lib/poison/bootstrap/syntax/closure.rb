module Poison
  module Syntax
    class Closure < Node
      attr_accessor :table, :statements

      def initialize(table, statements)
        @table = table
        @statements = Array(statements)
      end

      def to_sexp
        [:closure,
          table ? @table.to_sexp : nil
          ].concat @statements.map { |s| s.to_sexp }
      end
    end
  end
end
