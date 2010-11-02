require "spec_helper"

describe Clockwork::Predicate do
  before :all do
    @time     = Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] })
    @datetime = DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] })
    @date     = Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] })

    @year  = Clockwork::ComparisonPredicate.new(:year, 2008)
    @month = Clockwork::ComparisonPredicate.new(:month, 9)
    @mday  = Clockwork::ComparisonPredicate.new(:mday, 24)

    @hour = Clockwork::ComparisonPredicate.new(:hour, 18)
    @min  = Clockwork::ComparisonPredicate.new(:min, 30)
    @sec  = Clockwork::ComparisonPredicate.new(:sec, 15)

    @yday  = Clockwork::ComparisonPredicate.new(:yday, 268)
    @yweek = Clockwork::ComparisonPredicate.new(:mday, 0)
    @wday  = Clockwork::ComparisonPredicate.new(:wday, 3)
  end
  
  describe "Predicate" do
    before :all do
      @sep_24 = Clockwork::IntersectionPredicate.new(@year, @mday)
    end
    
    it "should report the attribute(s) it asserts wrong" do
      
    end
  end
end
