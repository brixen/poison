require 'spec/spec_helper'

describe "The Value node" do
  relates "1" do
    parse do
      [:expr, [:value, [1, nil, nil]]]
    end
  end
end
