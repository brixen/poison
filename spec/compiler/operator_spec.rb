require 'spec/spec_helper'

describe "The Binary node for '+'" do
  relates "1 + 2" do
    parse do
      [:plus,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a + 1" do
    parse do
      [:plus,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a + b" do
    parse do
      [:plus,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '-'" do
  relates "1 - 2" do
    parse do
      [:minus,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a - 1" do
    parse do
      [:minus,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a - b" do
    parse do
      [:minus,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '*'" do
  relates "1 * 2" do
    parse do
      [:times,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a * 1" do
    parse do
      [:times,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a * b" do
    parse do
      [:times,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '/'" do
  relates "1 / 2" do
    parse do
      [:div,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a / 1" do
    parse do
      [:div,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a / b" do
    parse do
      [:div,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '%'" do
  relates "1 % 2" do
    parse do
      [:rem,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a % 1" do
    parse do
      [:rem,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a % b" do
    parse do
      [:rem,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '**'" do
  relates "1 ** 2" do
    parse do
      [:pow,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a ** 1" do
    parse do
      [:pow,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a ** b" do
    parse do
      [:pow,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '|'" do
  relates "1 | 2" do
    parse do
      [:pipe,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a | 1" do
    parse do
      [:pipe,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a | b" do
    parse do
      [:pipe,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '^'" do
  relates "1 ^ 2" do
    parse do
      [:caret,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a ^ 1" do
    parse do
      [:caret,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a ^ b" do
    parse do
      [:caret,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '&'" do
  relates "1 & 2" do
    parse do
      [:amp,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a & 1" do
    parse do
      [:amp,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a & b" do
    parse do
      [:amp,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '<<'" do
  relates "1 << 2" do
    parse do
      [:bitl,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a << 1" do
    parse do
      [:bitl,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a << b" do
    parse do
      [:bitl,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Binary node for '>>'" do
  relates "1 >> 2" do
    parse do
      [:bitr,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a >> 1" do
    parse do
      [:bitr,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a >> b" do
    parse do
      [:bitr,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Unary node for '-'" do
  relates "-1" do
    parse do
      [:uminus, [:expr, [:value, [1, nil, nil]]]]
    end
  end

  relates "-a" do
    parse do
      [:uminus, [:expr, [:message, ["a", nil, nil]]]]
    end
  end
end

describe "The Unary node for '+'" do
  relates "+1" do
    parse do
      [:uplus, [:expr, [:value, [1, nil, nil]]]]
    end
  end

  relates "+a" do
    parse do
      [:uplus, [:expr, [:message, ["a", nil, nil]]]]
    end
  end
end

describe "The Unary node for '~'" do
  relates "~1" do
    parse do
      [:wavy, [:expr, [:value, [1, nil, nil]]]]
    end
  end

  relates "~a" do
    parse do
      [:wavy, [:expr, [:message, ["a", nil, nil]]]]
    end
  end
end

describe "The Not node" do
  not_one = lambda { [:not, [:expr, [:value, [1, nil, nil]]]] }

  relates "!1" do
    parse &not_one
  end

  relates "not 1" do
    parse &not_one
  end

  not_a = lambda { [:not, [:expr, [:message, ["a", nil, nil]]]] }

  relates "!a" do
    parse &not_a
  end

  relates "not a" do
    parse &not_a
  end
end

describe "The Or node" do
  a_or_b = lambda do
    [:or,
      [:expr, [:message, ["a", nil, nil]]],
      [:expr, [:message, ["b", nil, nil]]]]
  end

  relates "a or b" do
    parse &a_or_b
  end

  relates "a || b" do
    parse &a_or_b
  end

  a_or_1 = lambda do
    [:or,
      [:expr, [:message, ["a", nil, nil]]],
      [:expr, [:value, [1, nil, nil]]]]
  end

  relates "a or 1" do
    parse &a_or_1
  end

  relates "a || 1" do
    parse &a_or_1
  end
end

describe "The And node" do
  a_and_b = lambda do
    [:and,
      [:expr, [:message, ["a", nil, nil]]],
      [:expr, [:message, ["b", nil, nil]]]]
  end

  relates "a and b" do
    parse &a_and_b
  end

  relates "a && b" do
    parse &a_and_b
  end

  a_and_1 = lambda do
    [:and,
      [:expr, [:message, ["a", nil, nil]]],
      [:expr, [:value, [1, nil, nil]]]]
  end

  relates "a and 1" do
    parse &a_and_1
  end

  relates "a && 1" do
    parse &a_and_1
  end
end

describe "The Relational node for '<=>'" do
  relates "1 <=> 2" do
    parse do
      [:cmp,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a <=> 1" do
    parse do
      [:cmp,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a <=> b" do
    parse do
      [:cmp,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Relational node for '=='" do
  relates "1 == 2" do
    parse do
      [:eq,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a == 1" do
    parse do
      [:eq,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a == b" do
    parse do
      [:eq,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Relational node for '!='" do
  relates "1 != 2" do
    parse do
      [:neq,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a != 1" do
    parse do
      [:neq,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a != b" do
    parse do
      [:neq,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Relational node for '>='" do
  relates "1 >= 2" do
    parse do
      [:gte,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a >= 1" do
    parse do
      [:gte,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a >= b" do
    parse do
      [:gte,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Relational node for '>'" do
  relates "1 > 2" do
    parse do
      [:gt,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a > 1" do
    parse do
      [:gt,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a > b" do
    parse do
      [:gt,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Relational node for '<='" do
  relates "1 <= 2" do
    parse do
      [:lte,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a <= 1" do
    parse do
      [:lte,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a <= b" do
    parse do
      [:lte,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end

describe "The Relational node for '<'" do
  relates "1 < 2" do
    parse do
      [:lt,
        [:expr, [:value, [1, nil, nil]]],
        [:expr, [:value, [2, nil, nil]]]
      ]
    end
  end

  relates "a < 1" do
    parse do
      [:lt,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:value, [1, nil, nil]]]
      ]
    end
  end

  relates "a < b" do
    parse do
      [:lt,
        [:expr, [:message, ["a", nil, nil]]],
        [:expr, [:message, ["b", nil, nil]]]
      ]
    end
  end
end
