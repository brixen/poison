class String

  def pn_number
    node = Poison::Parser.new.parse self
    visitor = Poison::Syntax::NumberMatcher.new
    node.visit visitor

    visitor.value || 0.0
  end

  def pn_eval
    Poison::CodeLoader.execute self
  end

  poison_alias :string, :to_s
  poison_alias :length, :length

  poison_methods
end
