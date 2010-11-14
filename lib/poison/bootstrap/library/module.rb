class Module
  # Adds the "pn:" namespace to the method name before calling
  # Module#alias_method.
  def poison_alias(to, from)
    alias_method :"pn:#{to}", from
  end

  # Processes all the instance methods for a Module and creates alias
  # using the "pn:" naemspace, then removes the original method.
  def poison_methods
    instance_methods(false).each do |m|
      name = m.to_s
      if name[0, 3] == "pn_"
        alias_method :"pn:#{m.to_s[3..-1]}", m
        remove_method m
      end
    end
  end
end
