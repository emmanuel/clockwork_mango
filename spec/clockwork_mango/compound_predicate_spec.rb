require "spec_helper"

module ClockworkMango
  describe CompoundPredicate do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    let(:year_08) { EqualityPredicate.new(:year, 2008) }
    let(:month)   { EqualityPredicate.new(:month, 9) }
    let(:mday)    { EqualityPredicate.new(:mday, 24) }

    let(:hour) { EqualityPredicate.new(:hour, 18) }
    let(:min)  { EqualityPredicate.new(:min, 30) }
    let(:sec)  { EqualityPredicate.new(:sec, 15) }

    let(:yday)  { EqualityPredicate.new(:yday, 268) }
    let(:yweek) { EqualityPredicate.new(:mday, 0) }
    let(:wday)  { EqualityPredicate.new(:wday, 3) }

    describe IntersectionPredicate do
      subject { IntersectionPredicate.new(year_08, mday) }

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
    end # describe IntersectionPredicate

    describe UnionPredicate do
      let(:year_06) { EqualityPredicate.new(:year, 2006) }
      let(:time_in_06) { DateTime.civil(2006, 6, 1, 12, 0, 0) }

      subject { UnionPredicate.new(year_08, year_06) }

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
    end # describe UnionPredicate

    describe DifferencePredicate do
      let(:year_07) { EqualityPredicate.new(:year, 2007) }

      subject { DifferencePredicate.new(year_08, year_07) }

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
    end # describe DifferencePredicate

  end # describe CompoundPredicate
end # module ClockworkMango
