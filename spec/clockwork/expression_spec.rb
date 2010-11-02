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
  
  describe "Expression" do
    before :all do
      @sep_24 = Clockwork::Intersection.new(@year, @mday)
    end
    
    it "should report the attribute(s) it asserts wrong" do
      
    end
  end
end
