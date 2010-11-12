require 'spec/spec_helper'

describe "The Value node" do
  relates "1" do
    parse do
      [:expr, [:value, [1, nil, nil]]]
    end
  end

  relates "2.4" do
    parse do
      [:expr, [:value, [2.4, nil, nil]]]
    end
  end

  relates "3.2i" do
    parse do
      [:expr, [:value, ["3.2i", nil, nil]]]
    end
  end

  relates "0x42" do
    parse do
      [:expr, [:value, [66, nil, nil]]]
    end
  end

  relates "nil" do
    parse do
      [:expr, [:value, [nil, nil, nil]]]
    end
  end

  relates "true" do
    parse do
      [:expr, [:value, [true, nil, nil]]]
    end
  end

  relates "false" do
    parse do
      [:expr, [:value, [false, nil, nil]]]
    end
  end

  relates '"hello"' do
    parse do
      [:expr, [:value, ["hello", nil, nil]]]
    end
  end

  relates "'world'" do
    parse do
      [:expr, [:value, ["world", nil, nil]]]
    end
  end

  relates '(1, 2, "a")' do
    parse do
      [:expr, [:table,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]],
        [:expr, [:value, ["a", nil, nil]]]
      ]]
    end
  end

  relates '(a="one", b="two")' do
    parse do
      [:expr, [:table,
        [:assign, [:expr,
          [:message, ["a", nil, nil]]], [:expr, [:value, ["one", nil, nil]]]],
        [:assign, [:expr,
          [:message, ["b", nil, nil]]], [:expr, [:value, ["two", nil, nil]]]]
      ]]
    end
  end
end
