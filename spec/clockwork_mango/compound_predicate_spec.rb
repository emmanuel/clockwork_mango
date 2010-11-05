require "spec_helper"

describe ClockworkMango::CompoundPredicate do
  let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
  let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
  let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

  let(:year_08) { ClockworkMango::ComparisonPredicate.new(:year, 2008) }
  let(:month)   { ClockworkMango::ComparisonPredicate.new(:month, 9) }
  let(:mday)    { ClockworkMango::ComparisonPredicate.new(:mday, 24) }

  let(:hour) { ClockworkMango::ComparisonPredicate.new(:hour, 18) }
  let(:min)  { ClockworkMango::ComparisonPredicate.new(:min, 30) }
  let(:sec)  { ClockworkMango::ComparisonPredicate.new(:sec, 15) }

  let(:yday)  { ClockworkMango::ComparisonPredicate.new(:yday, 268) }
  let(:yweek) { ClockworkMango::ComparisonPredicate.new(:mday, 0) }
  let(:wday)  { ClockworkMango::ComparisonPredicate.new(:wday, 3) }

  describe "IntersectionPredicate" do
    subject { ClockworkMango::IntersectionPredicate.new(year_08, mday) }

    it "should match Times when both expressions match" do
      should === time
    end

    it "should match DateTimes when both expressions match" do
      should === datetime
    end

    it "should match Dates when both expressions match" do
      should === date
    end

    it "should not match Times when one expression does not match" do
      should_not === (time + (1 * 24 * 60 * 60))
    end

    it "should not match Dates when one expression does not match" do
      should_not === (datetime + 1)
    end

    it "should not match Dates when one expression does not match" do
      should_not === (date + 1)
    end
  end

  describe "UnionPredicate" do
    let(:year_06) { ClockworkMango::ComparisonPredicate.new(:year, 2006) }
    let(:time_in_06) { DateTime.civil(2006, 6, 1, 12, 0, 0) }

    subject { ClockworkMango::UnionPredicate.new(year_08, year_06) }

    it "should match Times when either expression matches" do
      should === time
    end

    it "should match DateTimes when either expression matches" do
      should === datetime
    end

    it "should match Dates when either expression matches" do
      should === date
    end

    it "should match DateTimes when either expression matches" do
      should === time_in_06
    end

    it "should not match Times when neither expression matches" do
      should_not === (time + (365 * 24 * 60 * 60))
    end

    it "should not match DateTimes when neither expression matches" do
      should_not === (time_in_06 - (365 * 24 * 60 * 60))
    end
  end

  describe "DifferencePredicate" do
    let(:year_07) { ClockworkMango::ComparisonPredicate.new(:year, 2007) }

    subject { ClockworkMango::DifferencePredicate.new(year_08, year_07) }

    it "should match Times when the 1st expression matches and the 2nd doesn't" do
      should === time
    end

    it "should match DateTimes when the 1st expression matches and the 2nd doesn't" do
      should === datetime
    end

    it "should match Dates when the 1st expression matches and the 2nd doesn't" do
      should === date
    end

    it "should not match Dates when the 1st expression matches and the 2nd does, too" do
      should_not === (date - 365)
    end
  end

end
