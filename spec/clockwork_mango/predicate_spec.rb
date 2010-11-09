require "spec_helper"

module ClockworkMango
  describe Predicate do
    before :all do
      @time     = Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] })
      @datetime = DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] })
      @date     = Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] })

      @year  = ComparisonPredicate.new(:year, 2008)
      @month = ComparisonPredicate.new(:month, 9)
      @mday  = ComparisonPredicate.new(:mday, 24)

      @hour = ComparisonPredicate.new(:hour, 18)
      @min  = ComparisonPredicate.new(:min, 30)
      @sec  = ComparisonPredicate.new(:sec, 15)

      @yday  = ComparisonPredicate.new(:yday, 268)
      @yweek = ComparisonPredicate.new(:mday, 0)
      @wday  = ComparisonPredicate.new(:wday, 3)
    end

    describe "Predicate" do
      before :all do
        @sep_24 = IntersectionPredicate.new(@year, @mday)
      end

      it "should report the attribute(s) it asserts wrong"
    end

  end # describe Predicate
end # module ClockworkMango
