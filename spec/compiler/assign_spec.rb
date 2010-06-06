require 'spec/spec_helper'

describe "The Assign node" do
  relates "a = 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]]
    end
  end
end
