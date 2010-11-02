require "spec_helper"

describe ClockworkMango::Predicate do
  before :all do
    @time     = Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] })
    @datetime = DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] })
    @date     = Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] })

    @year  = ClockworkMango::ComparisonPredicate.new(:year, 2008)
    @month = ClockworkMango::ComparisonPredicate.new(:month, 9)
    @mday  = ClockworkMango::ComparisonPredicate.new(:mday, 24)

    @hour = ClockworkMango::ComparisonPredicate.new(:hour, 18)
    @min  = ClockworkMango::ComparisonPredicate.new(:min, 30)
    @sec  = ClockworkMango::ComparisonPredicate.new(:sec, 15)

    @yday  = ClockworkMango::ComparisonPredicate.new(:yday, 268)
    @yweek = ClockworkMango::ComparisonPredicate.new(:mday, 0)
    @wday  = ClockworkMango::ComparisonPredicate.new(:wday, 3)
  end

  describe "Predicate" do
    before :all do
      @sep_24 = ClockworkMango::IntersectionPredicate.new(@year, @mday)
    end

    it "should report the attribute(s) it asserts wrong" do
      
    end
  end

end
