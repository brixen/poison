class Module
  def poison_alias(to, from)
    alias_method :"pn:#{to}", from
  end
end
