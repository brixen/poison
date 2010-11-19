class Object
  # Attempts to make calling Ruby methods from Poison and vice-versa
  # transparent.
  #
  # When receiving a "pn:<xyz>" namespaced method, sends :xyz if the object
  # responds to it. Likewise, when receiving a non-"pn:" namespaced method
  # "xyz", sends :"pn:xyz" if the object responds to it.
  #
  # Otherwise, calls super.
  def method_missing(sym, *args)
    # TODO: handle args

    if (name = sym.to_s)[0, 3] == "pn:"
      name = name[3, name.size-3]
      return send(name, *args) if respond_to? name
    else
      name = :"pn:#{sym}"
      return send(name, *args) if respond_to? name
    end

    super
  end
end
