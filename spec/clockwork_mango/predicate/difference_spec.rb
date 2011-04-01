require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Difference do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:year_07) { Predicate::Equality.new(:year, 2007) }

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
