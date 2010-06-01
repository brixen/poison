module Poison
  class Treetop::Runtime::SyntaxNode
    def elements_to_sexp(sexp)
      elements.each { |e| e.to_sexp(sexp) unless e.terminal? }
    end

    def to_sexp(sexp)
      elements_to_sexp sexp
    end
  end

  class Node < Treetop::Runtime::SyntaxNode
  end
end
