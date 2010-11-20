require 'spec/spec_helper'

describe "The Closure node" do
  relates ": ." do
    parse do
      [:expr, [:closure, [nil, [nil, nil, nil]]]]
    end
  end

  relates ": 1." do
    parse do
      [:expr, [:closure, [nil, [:expr, [:value, [1, nil, nil]]]]]]
    end
  end
end
