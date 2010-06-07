require 'spec/spec_helper'

describe "The Assign node" do
  relates "a = 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]]
    end
  end

  relates "a ||= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:or, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a &&= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:and, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a |= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:pipe, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a ^= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:caret, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a &= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:amp, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a <<= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:bitl, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a >>= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:bitr, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a += 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:plus, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a -= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:minus, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a *= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:times, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a /= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:div, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a %= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:rem, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates "a **= 1" do
    parse do
      [:assign, [:expr, [:message, ["a", nil, nil]]],
        [:pow, [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:value, [1, nil, nil]]]]]
    end
  end
end
