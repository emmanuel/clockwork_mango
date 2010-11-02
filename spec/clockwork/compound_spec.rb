require "spec_helper"

describe Clockwork::Compound do
  before :all do
    @time     = Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] })
    @datetime = DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] })
    @date     = Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] })

    @year  = Clockwork::Assertion.new(:year, 2008)
    @month = Clockwork::Assertion.new(:month, 9)
    @mday  = Clockwork::Assertion.new(:mday, 24)

    @hour = Clockwork::Assertion.new(:hour, 18)
    @min  = Clockwork::Assertion.new(:min, 30)
    @sec  = Clockwork::Assertion.new(:sec, 15)

    @yday  = Clockwork::Assertion.new(:yday, 268)
    @yweek = Clockwork::Assertion.new(:mday, 0)
    @wday  = Clockwork::Assertion.new(:wday, 3)
  end
  
  describe "Intersection" do
    before :all do
      @sep_24 = Clockwork::Intersection.new(@year, @mday)
    end
    
    it "should match Time objects when both expressions match" do
      @sep_24.should === @time
    end
    
    it "should match DateTime objects when both expressions match" do
      @sep_24.should === @datetime
    end
    
    it "should match Date objects when both expressions match" do
      @sep_24.should === @date
    end
    
    it "should not match Date objects when one expression does not match" do
      @sep_24.should_not === (@time + (1 * 24 * 60 * 60))
    end
    
    it "should not match Date objects when one expression does not match" do
      @sep_24.should_not === (@datetime + 1)
    end
    
    it "should not match Date objects when one expression does not match" do
      @sep_24.should_not === (@date + 1)
    end
  end
  
  describe "Union" do
    before :all do
      @year_2006 = Clockwork::Assertion.new(:year, 2006)
      @union = Clockwork::Union.new(@year, @year_2006)
      @time_in_06 = DateTime.civil(2006, 6, 1, 12, 0, 0)
    end
    
    it "should match when either expression matches" do
      @union.should === @time
    end
    
    it "should match when either expression matches" do
      @union.should === @datetime
    end
    
    it "should match when either expression matches" do
      @union.should === @date
    end
    
    it "should match when either expression matches" do
      @union.should === @time_in_06
    end
    
    it "should not match when neither expression matches" do
      @union.should_not === (@time + (365 * 24 * 60 * 60))
    end
    
    it "should not match when neither expression matches" do
      @union.should_not === (@time_in_06 - (365 * 24 * 60 * 60))
    end
  end
  
  describe "Difference" do
    before :all do
      @year_2007 = Clockwork::Assertion.new(:year, 2007)
      @difference = Clockwork::Difference.new(@year, @year_2007)
    end
    
    it "should match when the 1st expression matches and the 2nd doesn't" do
      @difference.should === @time
    end
    
    it "should match when the 1st expression matches and the 2nd doesn't" do
      @difference.should === @datetime
    end
    
    it "should match when the 1st expression matches and the 2nd doesn't" do
      @difference.should === @date
    end
    
    it "should not match when the 1st expression matches and the 2nd does, too" do
      @difference.should_not === (@date - 365)
    end
  end
end
