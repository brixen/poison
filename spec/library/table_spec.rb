require 'spec/spec_helper'

describe "Table" do
  it "is created by a sequence of values in paretheses" do
    table = Poison::CodeLoader.execute "(1, 2, 3)"
    table.should be_kind_of(Table)
  end

  it "is created by sequence of assignments in parentheses" do
    table = Poison::CodeLoader.execute "(a = 1, b = 2, c = 3)"
    table.should be_kind_of(Table)
  end
end
