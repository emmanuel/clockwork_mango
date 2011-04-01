require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Difference do
    let(:time)     { Time.local(2008, 9, 24, 18, 30, 15, 500) }
    let(:datetime) { time.to_datetime }
    let(:date)     { time.to_date }

    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:year_07) { Predicate::Equality.new(:year, 2007) }

    let(:yday)  { Predicate::Equality.new(:yday, 268) }
    let(:yweek) { Predicate::Equality.new(:day, 0) }
    let(:wday)  { Predicate::Equality.new(:wday, 3) }

    subject { Predicate::Difference.new(year_08, year_07) }

    context "when the 1st predicate matches and the 2nd doesn't" do
      it "should match Times " do
        subject.should === time
      end

      it "should match DateTimes" do
        subject.should === datetime
      end

      it "should match Dates" do
        subject.should === date
      end
    end

    context "when the 1st and 2nd predicates both match" do
      it "should not match Dates " do
        subject.should_not === (date - 365)
      end
    end

    context "when neither the 1st nor the 2nd predicate matches" do
      it "should not match Dates" do
        subject.should_not === (date - 365)
      end
    end
  end # describe Predicate::Difference
end # module ClockworkMango
