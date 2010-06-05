require 'spec/spec_helper'

describe "The Message node" do
  relates "print" do
    parse do
      [:expr, [:message, [:print, nil, nil]]]
    end
  end
end
