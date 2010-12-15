require 'spec/spec_helper'

describe "Table" do
  it "should be created by a _list_ table literal with expressions" do
    table = Poison::CodeLoader.execute "(1, 2, 3)"
    table.should be_kind_of(Table)
  end

  it "should be created by a _hash_ table literal with assignments" do
    table = Poison::CodeLoader.execute "(a = 1, b = 2, c = 3)"
    table.should be_kind_of(Table)
  end
end
