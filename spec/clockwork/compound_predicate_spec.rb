require "spec_helper"

describe Clockwork::CompoundPredicate do
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

  describe "IntersectionPredicate" do
    before :all do
      @sep_24 = Clockwork::IntersectionPredicate.new(@year, @mday)
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

  describe "UnionPredicate" do
    before :all do
      @year_2006 = Clockwork::ComparisonPredicate.new(:year, 2006)
      @union = Clockwork::UnionPredicate.new(@year, @year_2006)
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

  describe "DifferencePredicate" do
    before :all do
      @year_2007 = Clockwork::ComparisonPredicate.new(:year, 2007)
      @difference = Clockwork::DifferencePredicate.new(@year, @year_2007)
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
