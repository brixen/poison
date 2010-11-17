class Fixnum
  poison_alias :string, :to_s
end

class Bignum
  poison_alias :string, :to_s
end
