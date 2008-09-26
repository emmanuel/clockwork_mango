require File.dirname(__FILE__) + "/spec_helper"

describe Clockwork::Compound do
  before :all do
    @time     = Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] })
    @datetime = DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] })
    @date     = Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] })

    @year_assertion = Clockwork::Assertion.new(:year, 2008)
    @yday_assertion = Clockwork::Assertion.new(:yday, 268)
  end
  
  describe "Intersection" do
    before :all do
      @intersection = Clockwork::Intersection.new(@year_assertion, @yday_assertion)
    end
    
    it "should match when both expressions match" do
      @intersection.should === @time
    end
  end
  
  describe "Union" do
    before :all do
      @union = Clockwork::Union.new(@year_assertion, @yday_assertion)
    end
    
    it "should match when either expression matches" do
      @union.should === @time
    end
  end
  
  describe "Difference" do
    before :all do
      year_assertion2 = Clockwork::Assertion.new(:year, 2007)
      @difference = Clockwork::Difference.new(@year_assertion, year_assertion2)
    end
    
    it "should match when the 1st expression matches and the 2nd doesn't" do
      @difference.should === @time
    end
  end
end
