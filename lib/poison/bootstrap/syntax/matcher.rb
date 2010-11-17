module Poison
  module Syntax
    class Matcher
      def visit(node)
        return unless node.kind_of? Node

        node.instance_variables.each do |name|
          n = node.instance_variable_get name
          case n
          when Node
            n.visit self
          when Array
            n.each { |x| visit x }
          end
        end
      end
    end

    class NumberMatcher < Matcher
      attr_accessor :value

      def initialize
        @value = nil
      end

      def method_missing(sym, *args)
        node = args.first
        case sym
        when :integer, :real, :imaginary
          @value = node.value
        else
          visit node if node
        end
      end
    end
  end
end
