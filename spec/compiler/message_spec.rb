require 'spec/spec_helper'

describe "The Message node" do
  relates "print" do
    parse do
      [:expr, [:message, ["print", nil, nil]]]
    end
  end

  relates <<-ruby do
      "hello" print
    ruby

    parse do
      [:expr, [:value, ["hello", nil, nil]],
        [:message, ["print", nil, nil]]]
    end
  end

  relates <<-ruby do
      1 string print
    ruby

    parse do
      [:expr, [:value, [1, nil, nil]],
        [:message, ["string", nil, nil]],
        [:message, ["print", nil, nil]]]
    end
  end

  relates <<-ruby do
      name string print
    ruby

    parse do
      [:expr, [:message, ["name", nil, nil]],
        [:message, ["string", nil, nil]],
        [:message, ["print", nil, nil]]]
    end
  end
end
