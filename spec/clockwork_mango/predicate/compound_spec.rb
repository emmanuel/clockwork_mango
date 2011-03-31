require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Compound do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:month)   { Predicate::Equality.new(:month, 9) }
    let(:day)     { Predicate::Equality.new(:day, 24) }

    let(:hour) { Predicate::Equality.new(:hour, 18) }
    let(:min)  { Predicate::Equality.new(:min, 30) }
    let(:sec)  { Predicate::Equality.new(:sec, 15) }

    let(:yday)  { Predicate::Equality.new(:yday, 268) }
    let(:yweek) { Predicate::Equality.new(:day, 0) }
    let(:wday)  { Predicate::Equality.new(:wday, 3) }

    describe Predicate::Intersection do
      subject { Predicate::Intersection.new(year_08, day) }

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
    end # describe Predicate::Intersection

    describe Predicate::Union do
      let(:year_06) { Predicate::Equality.new(:year, 2006) }
      let(:time_in_06) { DateTime.civil(2006, 6, 1, 12, 0, 0) }

      subject { Predicate::Union.new(year_08, year_06) }

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
    end # describe Predicate::Union

    describe Predicate::Difference do
      let(:year_07) { Predicate::Equality.new(:year, 2007) }

      subject { Predicate::Difference.new(year_08, year_07) }

      it "should match Times when the 1st expression matches and the 2nd doesn't" do
        should === time
      end

      it "should match DateTimes when the 1st expression matches and the 2nd doesn't" do
        should === datetime
      end

      it "should match Dates when the 1st expression matches and the 2nd doesn't" do
        should === date
      end

      it "should not match Dates when the 1st expression matches and the 2nd does, too"

      it "should not match Dates when the 1st expression doesn't match and the 2nd one does" do
        should_not === (date - 365)
      end
    end # describe Predicate::Difference

    describe Predicate::Offset do
      let(:predicate) {
        Predicate::Equality.new(:month, 11) &         # November
          Predicate::Equality.new(:wday, 4) &         # Thursday
          Predicate::Equality.new(:wday_in_month, 4)  # Fourth Thursday of the month
      }
      # 2010-11-25 is the 4th Thursday of November in 2010
      let(:matching_date) { DateTime.parse("2010-11-25") }
      let(:unit) { :days }
      let(:value) { 1 }

      subject { Predicate::Offset.new(predicate, unit, value) }

      it "should equal itself initialized with a singular" do
        singular_unit = unit.to_s.chomp("s").to_sym
        subject.should == Predicate::Offset.new(predicate, singular_unit, value)
      end

      context "when initialized with a positive value" do
        let(:value) { 1 }
        let(:offset_date) { matching_date + value }

        it { should be_kind_of(Predicate::Offset) }
        it { should express([:>>, predicate.to_temporal_sexp, unit, value]) }
        it { should === offset_date }
      end

      context "when initialized with a negative value" do
        let(:value) { -1 }
        let(:offset_date) { matching_date + value }

        it { should be_kind_of(Predicate::Offset) }
        it { should express([:>>, predicate.to_temporal_sexp, unit, value]) }
        it { should === offset_date }
      end

      context "when initialized with a zero value" do
        let(:value) { 0 }
        let(:offset_date) { matching_date + value }

        it { should be_kind_of(Predicate::Offset) }
        it { should express([:>>, predicate.to_temporal_sexp, unit, value]) }
        it { should === offset_date }
      end
    end

  end # describe Predicate::Compound::Base
end # module ClockworkMango
