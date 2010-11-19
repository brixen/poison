class Object
  def poison(name, *args)
    send :"pn:#{name}", *args
  end

  poison_alias :ruby, :send
end
