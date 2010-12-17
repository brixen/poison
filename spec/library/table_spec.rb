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

describe "Table#at" do
  it "can access values by index" do
    table = Poison::CodeLoader.execute "(9, 8, 7)"
    table.poison(:at, 0).should == 9
    table.poison(:at, 1).should == 8
    table.poison(:at, 2).should == 7
  end

  it "can access values by key" do
    table = Poison::CodeLoader.execute "(a = 1, b = 2, c = 3)"
    table.poison(:at, :b).should == 2
  end

  it "can access value by named key or index" do
    table = Poison::CodeLoader.execute "(9, b = 2, 7)"
    table.poison(:at, 0).should == 9
    table.poison(:at, :b).should == 2
    table.poison(:at, 1).should == 2
    table.poison(:at, 2).should == 7
  end

  it "can access value by expression key or index" do
    table = Poison::CodeLoader.execute "('bar' = 90, 'foo' = 2)"
    table.poison(:at, 1).should == 2
    table.poison(:at, "foo").should == 2
  end
end

describe "Table accessor" do
  it "is generated for an assign having a name as left hand side" do
    table = Poison::CodeLoader.execute "(9, foo = 42, 'bar' = 7)"
    table.poison(:foo).should == 42
  end

  it "is not generated for an assign having an expression as left hand side" do
    table = Poison::CodeLoader.execute "(9, foo = 42, 'bar' = 7)"
    table.should_not respond_to("pn:bar")
  end
end
