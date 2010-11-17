class String
  def pn_print
    print self
  end

  poison_alias :string, :to_s

  poison_methods
end
