# Poison Table is inspired by Lua's but not necessarily having the
# same exact behaviour.
#
# A table can be used as a list of objects or as a map of key-values
#
# table objects are created using Poison table literals:
#
# Creates a "list" like object:
#    table = ("foo", "bar")
#    table at(0) #=> "foo"
#    table at(1) #=> "bar"
#
# Creates a "dictionary" like object:
#    table = (foo = "bar")
#    table at(0)   #=> "bar"
#    table foo     #=> "bar"
#
#
class Table

  Slot = Struct.new(:index, :key, :value)

  def initialize
    @ary = Array.new
    @map = Hash.new
  end

  def delete_at(index)
    slot = @ary[index]
    @map.delete @ary[index].key if slot && slot.key
    @ary.delete_at index
  end

  def put_val(index, value)
    delete_at index
    @ary[index] = Slot.new(index, nil, value)
    value
  end

  def key_accessor(key)
    metaclass.send :define_method, "pn:#{key}", lambda { at(key) }
  end

  def put_key(index, key, value)
    delete_at index
    @map[key] = @ary[index] = Slot.new(index, key, value)
    key_accessor key if key.kind_of?(Symbol)
    value
  end

  def at(key)
    return @map[key].value if @map.key?(key)
    @ary[key].value if @ary[key]
  end
  alias_method :pn_at, :at

  poison_methods

end
