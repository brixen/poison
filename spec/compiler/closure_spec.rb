require 'spec/spec_helper'

describe "The Closure node" do
  relates ": ." do
    parse do
      [:expr, [:closure, nil, [nil, nil, nil]]]
    end
  end

  relates ": 1." do
    parse do
      [:expr, [:closure, nil, [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates ": (a) ." do
    parse do
      [:expr, [:closure,
        [:table, [:expr, [:message, ["a", nil, nil]]]],
        [nil, nil, nil]]]
    end
  end

  relates ": (a) 1." do
    parse do
      [:expr, [:closure,
        [:table, [:expr, [:message, ["a", nil, nil]]]],
        [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates ": (a, b) ." do
    parse do
      [:expr, [:closure,
        [:table,
          [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:message, ["b", nil, nil]]]],
        [nil, nil, nil]]]
    end
  end

  relates ": (a, b) 1." do
    parse do
      [:expr, [:closure,
        [:table,
          [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:message, ["b", nil, nil]]]],
        [:expr, [:value, [1, nil, nil]]]]]
    end
  end

  relates ": (a, b) 1, 2." do
    parse do
      [:expr, [:closure,
        [:table,
          [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:message, ["b", nil, nil]]]],
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]]]
    end
  end

  relates ": (a, b) (1, 2)." do
    parse do
      [:expr, [:closure,
        [:table,
          [:expr, [:message, ["a", nil, nil]]],
          [:expr, [:message, ["b", nil, nil]]]],
        [:expr,
          [:table,
            [:expr, [:value, [1, nil, nil]]],
            [:expr, [:value, [2, nil, nil]]]]]]]
    end
  end
end
