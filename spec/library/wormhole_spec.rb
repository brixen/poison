require 'spec/spec_helper'
require 'poison/bootstrap/library/wormhole'

describe "Object#method_missing" do
  it "enables calling Poison methods transparently from Ruby" do
    1.string.should == "1"
  end

  it "raises a NoMethodError when the Poison method does not exist" do
    lambda { 1.factorial }.should raise_error(NoMethodError)
  end

  it "enables calling Ruby methods transparently from Poison" do
    Poison::CodeLoader.execute("1 to_s").should == "1"
  end

  it "raises a NoMethodError when the Ruby method does not exist" do
    lambda { Poison::CodeLoader.execute("1 factorial") }.should raise_error(NoMethodError)
  end
end
