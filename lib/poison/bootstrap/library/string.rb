class String
  def pn_print
    print self
  end

  alias_method :"pn:print", :pn_print
end
