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
    end

    class Path < Message
      def sexp_name
        :path
      end
    end

    class PathQuery < Message
      def sexp_name
        :path_query
      end
    end

    class Query < Message
      def sexp_name
        :query
      end
    end
  end
end
