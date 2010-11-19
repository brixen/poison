require 'spec/spec_helper'

describe "Object#poison" do
  it "calls a Poison method" do
    1.poison(:string).should == "1"
  end
end

describe "Object#pn:ruby" do
  it "calls a Ruby method" do
    1.send(:"pn:ruby", :to_s).should == "1"
  end

  it "calls a Ruby method with arguments" do
    "abcde".send(:"pn:ruby", :slice, 1, 2).should == "bc"
  end
end
