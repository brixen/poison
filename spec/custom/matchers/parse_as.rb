require 'pp'

class ParseAsMatcher
  def initialize(expected)
    @expected = expected
  end

  def matches?(actual)
    @actual = Poison::Compiler.new(actual).parse.to_sexp
    @actual == @expected
  end

  def failure_message
    ["Expected:\n#{@actual.pretty_inspect}\n",
     "to equal:\n#{@expected.pretty_inspect}"]
  end
end

class Object
  def parse_as(sexp)
    ParseAsMatcher.new sexp
  end
end
