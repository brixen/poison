require 'spec/spec_helper'

describe "The Plus node" do
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

describe "The Minus node" do
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

describe "The Times node" do
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

describe "The Div node" do
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

describe "The Rem node" do
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

describe "The Pow node" do
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

describe "The Uminus node" do
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

describe "The Uplus node" do
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

describe "The Wavy node" do
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
