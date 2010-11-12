module Poison
  module Syntax
    class Message < Node
      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def sexp_name
        :message
      end

      def to_sexp
        [sexp_name, [@name, nil, nil]]
      end

      def visit(visitor)
        visitor.message self
      end
    end

    class Path < Message
      def sexp_name
        :path
      end

      def visit(visitor)
        visitor.path self
      end
    end

    class PathQuery < Message
      def sexp_name
        :path_query
      end

      def visit(visitor)
        visitor.path_query self
      end
    end

    class Query < Message
      def sexp_name
        :query
      end

      def visit(visitor)
        visitor.query self
      end
    end
  end
end
