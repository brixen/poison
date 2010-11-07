module Poison
  class Treetop::Runtime::SyntaxNode
    def node
      return unless elements
      all = elements.map { |e| e.node if e }.compact
      return if all.empty?
      return all.first if all.size == 1
      all
    end
  end
end
