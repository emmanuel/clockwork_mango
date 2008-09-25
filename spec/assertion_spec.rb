require File.dirname(__FILE__) + "/spec_helper"

describe Clockwork::Assertion do
  before :all do
    @year  = 2008
    @month = 9
    @mday  = 24
    @hour  = 18
    @min   = 30
    @sec   = 15
    @usec  = 500
    @time  = Time.local(@year, @month, @mday, @hour, @min, @sec, @usec)
    @yday  = 268
    @yweek = 3
    @wday  = 3
  end
  
  it "should match on correct year" do
    Clockwork::Assertion.new(:year, @year).should === @time
  end
  
  it "should not match on wrong year" do
    Clockwork::Assertion.new(:year, @year - 1).should_not === @time
  end
  
  it "should match on correct month" do
    Clockwork::Assertion.new(:month, @month).should === @time
  end
  
  it "should not match on wrong month" do
    Clockwork::Assertion.new(:month, @month - 1).should_not === @time
  end
  
  it "should match on correct mday" do
    Clockwork::Assertion.new(:mday, @mday).should === @time
  end
  
  it "should not match on wrong mday" do
    Clockwork::Assertion.new(:mday, @mday - 1).should_not === @time
  end
  
  it "should match on correct hour" do
    Clockwork::Assertion.new(:hour, @hour).should === @time
  end
  
  it "should not match on wrong hour" do
    Clockwork::Assertion.new(:hour, @hour - 1).should_not === @time
  end
  
  it "should match on correct min" do
    Clockwork::Assertion.new(:min, @min).should === @time
  end
  
  it "should not match on wrong min" do
    Clockwork::Assertion.new(:min, @min - 1).should_not === @time
  end
  
  it "should match on correct sec" do
    Clockwork::Assertion.new(:sec, @sec).should === @time
  end
  
  it "should not match on wrong sec" do
    Clockwork::Assertion.new(:sec, @sec - 1).should_not === @time
  end
  
  it "should match on correct usec" do
    Clockwork::Assertion.new(:usec, @usec).should === @time
  end
  
  it "should not match on wrong usec" do
    Clockwork::Assertion.new(:usec, @usec - 1).should_not === @time
  end
end
