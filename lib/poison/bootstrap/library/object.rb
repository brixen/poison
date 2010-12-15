class Object
  def poison(name, *args)
    send :"pn:#{name}", *args
  end

  poison_alias :ruby, :send
  poison_alias :inspect, :inspect

  def pn_print
    print self
  end

  def pn_println
    puts self
  end

  poison_methods
end
