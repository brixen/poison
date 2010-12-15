# A Table object is created using Poison table literals:
#
# Creates a "list" like object:
#    (foo, bar)
#
# Creates a "dictionary" like object:
#    (foo, bar)
#
class Table

  # Create a table containing a list of poison objects
  def self.list
  end

  # Create a table containing assoc key-value objects
  def self.dict
  end

  def initialize(collection)
    @collection = collection
  end

  def pn_at(key)
    @collection[key]
  end

  poison_methods

end
